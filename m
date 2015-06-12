From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow to control where the replace refs are looked for
Date: Fri, 12 Jun 2015 15:29:45 -0700
Message-ID: <xmqqmw04blwm.fsf@gitster.dls.corp.google.com>
References: <xmqq1thigtsd.fsf@gitster.dls.corp.google.com>
	<1434058499-15018-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XSS-0005mU-PC
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbbFLW3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:29:49 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33435 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbbFLW3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:29:47 -0400
Received: by igbpi8 with SMTP id pi8so20806690igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gqCVMUiYcaNTq8PhGJ/AZr8qXccKpj4LOXUWcXjd4nU=;
        b=n8cva1YGBpFHZ+/4LzStUPrnTITJWppKfFfWTcOtw6Dm8z/IyYKGaKWHi8iOV7oAww
         /pUUKZmBU4/5Ci8a4Q5J4lB6ETmvpB05DPHOwHv9GEkD5MeEKMOACbJsTLIyiqzp50u1
         0RonsjL/ERDB+QO7i1eOnPtbzJkDp0uxVk4XV0bAhlqSAibZATVAxTFqvMXLyHPCYe3U
         LUmxkT36easiAhdTwsBbWrv8l+xes/dpATx6ys8mwV6uLEpw1dEC7J5pcEIo0kmbzIbY
         ChqIPNnJAwmQoQVf6OYlk86q0a8HWDlZZHJACCXD9JWZgFGye6W0sglsc8lZOeAj+u+Y
         9r3Q==
X-Received: by 10.107.31.134 with SMTP id f128mr21058614iof.19.1434148187239;
        Fri, 12 Jun 2015 15:29:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id b74sm2146194ioe.6.2015.06.12.15.29.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:29:46 -0700 (PDT)
In-Reply-To: <1434058499-15018-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 12 Jun 2015 06:34:59 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271539>

Mike Hommey <mh@glandium.org> writes:

> It can be useful to have grafts or replace refs for specific use-cases while
> keeping the default "view" of the repository pristine (or with a different
> set of grafts/replace refs).
>
> It is possible to use a different graft file with GIT_GRAFT_FILE, but while
> replace refs are more powerful, they don't have an equivalent override.
>
> Add a GIT_REPLACE_REF_BASE environment variable to control where git is
> going to look for replace refs.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  builtin/replace.c | 6 +++---
>  cache.h           | 2 ++
>  environment.c     | 6 ++++++
>  log-tree.c        | 5 +++--
>  refs.c            | 3 ++-
>  5 files changed, 16 insertions(+), 6 deletions(-)

Thanks.

"git am" seems to be seeing a patch based on a stale base.  What
branch did you base this on?
