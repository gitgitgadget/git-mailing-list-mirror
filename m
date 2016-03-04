From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH] stripspace: add --line-count flag
Date: Sat, 5 Mar 2016 00:26:21 +0530
Message-ID: <56D9DA55.6040309@gmail.com>
References: <1457116723-20206-1-git-send-email-tigerkid001@gmail.com>
 <56D9D750.1030703@gmail.com> <xmqqk2liyt7j.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:56:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abutq-0003f6-6w
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759401AbcCDS4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 13:56:25 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33714 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcCDS4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:56:25 -0500
Received: by mail-pa0-f54.google.com with SMTP id fl4so39240907pad.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2016 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+S94nsYSv29Ouu7nCjfZ3w5QwC3bHXTfXY0wOXuBbIE=;
        b=sY5eM4ccoa5vHDd9B6jUUtahnEo8mnvYfm54a+6uLGASIrT5wMoJpc1uONUnIV48Dp
         DPZFyQ26KsZ4SNpOKUnrRzrjA5zBrKCFkXfgf2xhbIpauE0Gudh/cYunMVDgXefDdf+p
         LQA39OKRdx2m2kI5COVu9Te2gWyX2t12EOzvFAEz9nsZLY8bIAkhasAuy9P6lc9SxcqS
         cSCHkHB+kc2t3cTQxssOk5Tp89AUnx5i1CAy7/P1GPizAcRdg1YtCwRjaR6On8e6cazy
         iS11IICLYl/zduQbLtxb7Yyva2MKJv67CO59yd0mMhVspSnGEMepPcMl1cA+cBYvF72p
         XNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+S94nsYSv29Ouu7nCjfZ3w5QwC3bHXTfXY0wOXuBbIE=;
        b=ID2wqX26MFjhQN6z7irKceyl9I1bkkFBXt/CiBOr7vwzVGaSs1ArqbMCPV8g3RxXj5
         lskTaldl5i6uFqURQKYkBurlg238ogwE4R/Mb37/6facn9C1TP7IEBvyWow1y4Jb9UT0
         z9ANSCpxNmUfqDMbXx4iwoJq7dXFkWkqGHrf4vyXTlev/vlDowDDx2hQGem4UKSDNkmi
         ghMoJaiC4s/BYvoCBh1MMFKYpgNqg3Z/zUV3hk3qSI7QdV1nK2fTnjHJIpojKIXTSpft
         3H4SI13eJh0mXk3V6it8vx2+24649uzqu/t1oYTIgHCMrgrfWiTWeoZQwXWukSmK7+zb
         iw8w==
X-Gm-Message-State: AD7BkJJNgsWgEfTV7H1s9GjiOkZKqI1Udbh/kKtzLlEdKqNJvSw15YWPdSRpxwAUoKjq1Q==
X-Received: by 10.66.90.226 with SMTP id bz2mr14436577pab.31.1457117784527;
        Fri, 04 Mar 2016 10:56:24 -0800 (PST)
Received: from [192.168.1.10] ([182.69.45.48])
        by smtp.gmail.com with ESMTPSA id l14sm7200372pfi.23.2016.03.04.10.56.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Mar 2016 10:56:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqk2liyt7j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288271>



On Saturday 05 March 2016 12:19 AM, Junio C Hamano wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
>
>> This is my first attempt at the small project listed here: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27.
>> Comments?
> Isn't that page somewhat stale?
>
> http://git.661346.n2.nabble.com/PATCH-0-3-stripspace-Implement-and-use-count-lines-option-tt7641360.html#none
Oh, I should've checked first. My bad, I was just looking to get familiar with the codebase.


Thanks

Sidhant Sharma [:tk]
