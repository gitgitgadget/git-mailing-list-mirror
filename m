From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 24 Jul 2014 21:29:18 +0530
Message-ID: <53D12D56.2080505@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<xmqqiomnda1y.fsf@gitster.dls.corp.google.com>	<53D12078.2070004@gmail.com> <vpq1ttadauu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XALQa-0007M5-A8
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 17:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbaGXP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 11:59:27 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41223 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759767AbaGXP70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 11:59:26 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so4155117pad.22
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=CI3UuDcB+UJlbOdaqRLgFL8Erh/GNu15lappRlBTS5k=;
        b=rdilLyBTWTy/hwG8SuYeQ7euHju73JxGwsSb9oeYA1n/RR0BfFCNi17Zj0HfZDxTjZ
         cV2Y7Zp3RzeVRj7U0I/rC65xtQSNHC24T+k53L6wE2exfiE1h/lQ3TO/MApvSR7GQXyl
         0RrQDrSzYckURWf1WQm3M3YYh11or2tiIel4DHqCQXQP02eT9YqUPncv7rArn4C3sPzW
         oFNt6oFHtgIS7vt8u+sdV6gpMAhZvQ3SUI4XBuJtxIWzsseAZpJVt0k8YTDd4dTBVapK
         K5pkqtibA4XAsU/tHZ0g2gdr+MmyWctRMWbUKwtoQ3Mu0Opyt5h3NHMz4H2PH094gbm7
         0nUw==
X-Received: by 10.66.117.38 with SMTP id kb6mr11644962pab.37.1406217565851;
        Thu, 24 Jul 2014 08:59:25 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id ml5sm22098768pab.10.2014.07.24.08.59.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 08:59:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpq1ttadauu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254164>



On 7/24/2014 9:09 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> I am attaching the v12 with two new functions git_configset_get_string() &
>> git_configset_get_string_const().
> 
> Didn't you intend to change git_config_get_string to let it die in case
> of error instead of returning an error code?
>

Yup, but it is the part of the new series not the old one.
I sent this revised patch just for solving the constness
debate.
Also, I would need git_die_config() to print a proper
error message which comes in the 7 part series not this one.
