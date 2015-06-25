From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Thu, 25 Jun 2015 13:24:49 -0700
Message-ID: <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 22:24:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Dhg-0005IV-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbbFYUYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:24:52 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35328 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbFYUYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:24:51 -0400
Received: by iebrt9 with SMTP id rt9so62478313ieb.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q4b9BDabqx6PZoUEdV65U5UIKV9buOc1SfTa2oj9LxY=;
        b=KeXatMx3vu2Zx5UL6dTaIOSmadzouUSak/r21fvFiMd8k7SsrMKKZHZFAMrd4Pged4
         YYu/vAPuwY3j7Qow2Au1cTLS+GzPEMvpF53x6NQEJkNbJiyYOrk0gdFU4rLBzFaieKHm
         HhubSr7IXlGVLoOGohuhSeHa2jWy9RxFJsmZ+P348COdvmFYYT9UjRoDRoTIggylGYwt
         WxbYTUR/Bz8Nv66ZX/lGpwZsqG3P8alYnH2oNZOq4Yct5i93bKxBrBkDYoYKglNRuxGZ
         Pi3uIo++57G5s/50JEHO927XxNd2DjYOsCA1UTaXFhaKUoBeAB4+i58TQ0uYWtFbLRbq
         eifg==
X-Received: by 10.50.13.34 with SMTP id e2mr6469411igc.23.1435263891053;
        Thu, 25 Jun 2015 13:24:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id u38sm20263602ioi.0.2015.06.25.13.24.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 13:24:50 -0700 (PDT)
In-Reply-To: <20150625201309.5026A384E81@gemini.denx.de> (Wolfgang Denk's
	message of "Thu, 25 Jun 2015 22:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272722>

Wolfgang Denk <wd@denx.de> writes:

> Dear Junio,
>
> thanks for the fast replies.
>
> In message <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com> you wrote:
>> 
>> > Question is: how can we fix that?
>> 
>> It could be that 4d0d8975 is buggy and barking at a non breakage.
>> 
>> If there is no message in the tag, i.e.
>> 
>>     -- 8< --
>>     object 84ef51a632063e8cb57b2e9a4252497512831ffe
>>     type commit
>>     tag LABEL_2006_03_12_0025
>>     tagger Wolfgang Denk <wd@pollux.denx.de> 1142119613 +0100
>>     -- >8 --
>
> It seems recent tools cannot create such tags any more?

Yeah, we append an extra blank line after the last header even when
there is no message.  But I do not think that means what you have 
above is invalid.
