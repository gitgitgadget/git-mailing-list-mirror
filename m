From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] t3032 - make compatible with systems using \r\n as a
 line ending
Date: Thu, 18 Jul 2013 17:47:10 -0400
Message-ID: <51E8625E.6020808@gmail.com>
References: <51E591FF.7030600@gmail.com> <1374000592-31845-1-git-send-email-mlevedahl@gmail.com> <20130716185933.GO14690@google.com> <51E83FA7.5080706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 23:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzw2h-0002Fw-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153Ab3GRVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:47:14 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:44629 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3GRVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:47:13 -0400
Received: by mail-qe0-f42.google.com with SMTP id s14so2085170qeb.29
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=R2OrTNFWeZhc4UObZ7N4DzpN6b78APgPZhfxlWLAwA8=;
        b=d2oUQi+C2LEsQSE3OSsCIgZ3PF9fCfWiTKShsvVFvRo5cxAiiERcy0hY9AybcFEn7P
         B0mQIIukwZmmAuZV+Yu/EcZniVJo0qSvo1Jn/LiJMCwjQnZg68eq8Ws07DVuMeqCcWcr
         O+d+rqaAWVR39cbWzcJgSXMtTciFuAgH8EE3dxJIZMvsjTDDK00UU1QkbPIJWPSIFlg5
         Zn3Xk9uuwQKSDtjbAV0bRdobTYCW0p5+aACg9qU4aihdHE/8A+xeRrsy0h8vOJNrCWNn
         4h7w2PuYbalcmDlNRcRd+rTGIFo3alNuY8m40JTNFL4zWUKCPXMBHOjmQGlhpezhSnrW
         UlTw==
X-Received: by 10.229.124.68 with SMTP id t4mr3373185qcr.93.1374184033157;
        Thu, 18 Jul 2013 14:47:13 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm16013470qeo.3.2013.07.18.14.47.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:47:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E83FA7.5080706@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230753>

On 07/18/2013 03:19 PM, Ramsay Jones wrote:
> Jonathan Nieder wrote:
>> Mark Levedahl wrote:
>>
>>> Subtests 6, 7, and 9 rely test that merge-recursive correctly
>>> ignores whitespace when so directed. Change the particular whitespace
>>> sequences to be ones that are not known line endings so the whitespace
>>> is not changed when being extracted by line oriented grep.
>> merge-recursive needs to be able to deal with \r at EOL, too, so if at
>> all possible I would prefer to see the test fixed to pass on Cygwin
>> some other way.
> Maybe use -U/--binary option to grep? Indeed, if you look at the top of
> that test file, you will see:
>
>      test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
>      test_have_prereq MINGW && export GREP_OPTIONS=-U
>
> which may explain why it works for me on MinGW, but not why it works on
> cygwin 1.5.
>
> ATB,
> Ramsay Jones
>
>
>
>
>
Thanks, hadn't noticed that, it leads to a much better patch.

Mark
