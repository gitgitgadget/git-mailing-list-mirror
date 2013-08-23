From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/2] fix t3010 failure when core.ignorecase=true
Date: Fri, 23 Aug 2013 17:04:42 -0400
Message-ID: <CAPig+cSYPLNcMUtJTH08BAipfLOn_662k2DBwPzs2Z5dhwUhng@mail.gmail.com>
References: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
	<xmqqob8onmw9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 23:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCyXI-0002sk-PZ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 23:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab3HWVEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 17:04:45 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:55392 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab3HWVEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 17:04:44 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so849872lbd.24
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DPaNhS1ACiH3LYNB2zaSK0qK02zIpA2tHJgWHOTKYHY=;
        b=ialgl7IXSbnDpK5AyqARicQc1CQBnwQ/zQ8O5aqILQdo+RNwlyohMErtmAQjDItckW
         wEmLJYphO+SZ68F4LvSPWczfLYSQMEZBZHsMwEEV9fDT1fm3ZBYiDZFXoqc1/QPwGfPE
         bJI4JhakDkTyEDzVWYv9CQ2FR+idUyLcf761D0dRd0+uzhUIwYxzan61dAGacXiRtd6A
         WlWcd1gImvuJgmeShoBaUZNvFxd1W8eN6TxKeZ/6vu5SLzBUS5iIaCuTHJycySsAuJLW
         +TWGmWImSWPids7LX0X829T0vjflfQ4nGoy2wD9N8WoGrw12bXQ5j/IjWx0h7yZoc6g/
         2Mfw==
X-Received: by 10.152.20.36 with SMTP id k4mr1026677lae.33.1377291882982; Fri,
 23 Aug 2013 14:04:42 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 23 Aug 2013 14:04:42 -0700 (PDT)
In-Reply-To: <xmqqob8onmw9.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: xqlLpRLJbG-sUYGsVPQNsZxM1Xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232838>

On Fri, Aug 23, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Recent mailing list discussion [2][3] suggests that changes at a more
>> fundamental level (if they pan out) would be a more appropriate approach
>> to resolving this bug.  Such an approach would (happily) make patch 2/2
>> unnecessary, however, I'm posting this series for posterity since it was
>> already written before [2][3].
>
> Fair enough.
>
> In the meantime, given the reaction from Peff, I am tempted to
> squash your "work around in the caller side" as a fix to 2eac2a4c
> (ls-files -k: a directory only can be killed if the index has a
> non-directory, 2013-08-15) and squash in the patch to run "ls-files
> -k" with "-c core.ignorecase=true" to 3c568751 (t3010: update to
> demonstrate "ls-files -k" optimization pitfalls, 2013-08-15). That
> way, the eventual fix of not adding '/' at the end do not have to
> revert the changes to the caller, and the tests added to t3010 by
> the latter will be "optimization pitfalls" as before.

That sounds like a reasonable interim solution.
