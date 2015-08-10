From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] Improve guessing of repository names
Date: Mon, 10 Aug 2015 11:07:16 -0700
Message-ID: <xmqqio8nuiej.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1439221705-20336-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrTo-0007K8-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 20:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbbHJSHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 14:07:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34257 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbbHJSHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 14:07:18 -0400
Received: by pawu10 with SMTP id u10so145273663paw.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gNk52NM4Qfqt6PTsbTgEHxw+qAou2EaWNBkGseav7DA=;
        b=tpSNr3tl3FrWVo/x95ZdE8JqK5+npWQ7DYaE75f2f6CsjZS9UIbtCGm08axEAuwfyR
         DqhcQNuhr3K1aI7h+YZvYv5KLf89JLQCbb2vawbZ8ZPwcOtDxLGE8c2919YiihnPZiju
         Z3ZiovEkWkWGQRS6SbuIzLhxM3BpRMD7C7LerVPCx9MLVo0Yr5BMVevlGnUkjOM8B69P
         1ZmVaTAaebFYmNz9OExhw8T4ZhEejF7dFcK6JDLetTiOyamC8q8axSvXarGRgNmpQWkS
         1iHSLy+QCxmz/TtFoiClw2GZTxAoncfi8eo7id7lNuZeF0iEDRdaQTdWxvdy/njAP/Vx
         eY1w==
X-Received: by 10.66.245.142 with SMTP id xo14mr45867426pac.151.1439230038211;
        Mon, 10 Aug 2015 11:07:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id w17sm20685018pbt.17.2015.08.10.11.07.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 11:07:17 -0700 (PDT)
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Mon, 10 Aug 2015 17:48:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275645>

Patrick Steinhardt <ps@pks.im> writes:

> This is version 5 of my patch series which aims to improve
> guessed directory names in several cases.
>
> This version now includes the patches from Jeff which were
> previously a separate patch series. Besides fixing behavior when
> cloning a repository with trailing '.git' suffix they also add a
> new test suite that verifies guessed directory names. I've
> amended 'clone: add tests for output directory' to add additional
> tests (as proposed by Junio).
>
> Changes to my own patches include improved commit messages
> detailing why certain changes are done the way they are done and
> a change to authentication-data-stripping, such that we now strip
> greedily until the last '@' sign in the host part (proposed by
> Junio, as well).
>
> Jeff King (2):
>   clone: add tests for output directory
>   clone: use computed length in guess_dir_name
>
> Patrick Steinhardt (3):
>   clone: do not include authentication data in guessed dir
>   clone: do not use port number as dir name
>   clone: abort if no dir name could be guessed
>
>  builtin/clone.c          |  65 +++++++++++++++++++++++++-----
>  t/t5603-clone-dirname.sh | 103 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 11 deletions(-)
>  create mode 100755 t/t5603-clone-dirname.sh

Looks good.

I'll forge your sign-off for two patches from Peff and queue the
whole thing.

Thanks.
