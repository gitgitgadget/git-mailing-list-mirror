From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow to control where the replace refs are looked for
Date: Fri, 12 Jun 2015 15:36:05 -0700
Message-ID: <xmqqioasblm2.fsf@gitster.dls.corp.google.com>
References: <xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
	<1434058499-15018-1-git-send-email-mh@glandium.org>
	<xmqqmw04blwm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XYb-0008RO-Hr
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbbFLWgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:36:09 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33604 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989AbbFLWgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:36:07 -0400
Received: by iebgx4 with SMTP id gx4so32473554ieb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zolRYy36lJHmwqERW0XwtAuH2dwtwpT/fgap3yjNnr8=;
        b=Eyxx+reQtGoZZSYrqyHP08LxXVYwNZilOPgMwnUwjeNouTBURRKQ4Ey11aOUeVLi7D
         6HbWe23OI+ggvVkrV2LO9YNAreRtNoLN3IMlsxqDl1Tb/wMaallpi5VvzI6eXcL8ZfEX
         cYkTZoPNfXKHnEj9HGotfCTxhyulqfSAjdOnPc+ZQnDmdNmS9gVt5CHFW907a+0X5yoR
         bMpNSX+iD6waUF7oHs5fzNeKDbNOprKygq4F229kOsvWffM9r1z+jfLp+mob+bVL9ykg
         vHOYKD/SqjjtlFcNR5ZcuN7CxNJ4QgeMoWYVqP70XTvtcmOMaWscjTbXSRiOyqTESB6O
         aEAQ==
X-Received: by 10.107.159.77 with SMTP id i74mr21592776ioe.9.1434148566927;
        Fri, 12 Jun 2015 15:36:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id j20sm2087392igt.5.2015.06.12.15.36.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:36:06 -0700 (PDT)
In-Reply-To: <xmqqmw04blwm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Jun 2015 15:29:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271541>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> It can be useful to have grafts or replace refs for specific use-cases while
>> keeping the default "view" of the repository pristine (or with a different
>> set of grafts/replace refs).
>>
>> It is possible to use a different graft file with GIT_GRAFT_FILE, but while
>> replace refs are more powerful, they don't have an equivalent override.
>>
>> Add a GIT_REPLACE_REF_BASE environment variable to control where git is
>> going to look for replace refs.
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>  builtin/replace.c | 6 +++---
>>  cache.h           | 2 ++
>>  environment.c     | 6 ++++++
>>  log-tree.c        | 5 +++--
>>  refs.c            | 3 ++-
>>  5 files changed, 16 insertions(+), 6 deletions(-)
>
> Thanks.
>
> "git am" seems to be seeing a patch based on a stale base.  What
> branch did you base this on?

Ah, no need to resend; the conflict is with recently merged
bc/object-id.

Thanks.
