From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Use compat/regex on Cygwin
Date: Tue, 16 Jul 2013 19:24:01 -0400
Message-ID: <51E5D611.7000300@gmail.com>
References: <1373897453-18799-1-git-send-email-mlevedahl@gmail.com> <51E5BE08.9060304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 01:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzEbL-000669-DR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 01:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933865Ab3GPXYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 19:24:06 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:53290 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933472Ab3GPXYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 19:24:04 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so778272qeb.33
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sNXiFXOZGtS/Bnly6vQ3mWQbUfSXYqS6rBU6hej/eGs=;
        b=W0R9hHCee43Inw6jSmdvtmMHWOasH08c0ZFBeQpkg2F5GbC5HS6W9ivo4Gd0bOG7TE
         XY4ovyQAymAD5w6FuJb4/WqbnRqYEf+h5MNIenZDohKHmmfXQN+qh3Lxhi1swo2vgsCh
         pyKaNm7U4RVhy/RyRN/W9wliBn7uNHHqfaB98YCJePhjBpk/FZXWG/Zv4Vu+b92rRrxi
         0mNbb/Nd1uRdmPu5W9WwiuA+dWAF+xCHqkWH8D/KSSHq34oDwPGrzqXAblKspXhuzrnv
         cIgc7lIDMpTJTXcG8l56+eq9Kscq/LuciUKatLOIiLZardrnTGM+SdDI8yKLQap1RutJ
         wliQ==
X-Received: by 10.229.127.134 with SMTP id g6mr1246398qcs.82.1374017043976;
        Tue, 16 Jul 2013 16:24:03 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm5090295qeo.3.2013.07.16.16.24.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 16:24:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E5BE08.9060304@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230596>

On 07/16/2013 05:41 PM, Ramsay Jones wrote:
> Mark Levedahl wrote:
>> Cygwin's regex library does not pass git's tests, so don't use it. This
>> fixes failures in t4018 and t4034.
> Hmm, these tests have always passed for me on cygwin. So, this is
> presumably a regression in the new-lib regex library versions used
> by cygwin 1.5 and cygwin 1.7.
>
> ATB,
> Ramsay Jones
>
>
>
Yes, cygwin 1.7 now uses the newlib regex functions, and those are not 
quite up to snuff. Another case for calling 1.5 a separate platform 
altogether.

Mark
