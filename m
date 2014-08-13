From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 1/4] fast-import.c: replace `git_config()` with `git_config_get_*()`
 family
Date: Wed, 13 Aug 2014 17:41:35 +0530
Message-ID: <53EB55F7.9060508@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com> <vpqppg4vdii.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 14:11:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHXP9-0001VK-VA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 14:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbaHMMLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 08:11:44 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33219 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMMLm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 08:11:42 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so14310224pdb.19
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qrDykS1sdiIsYke0rw0BhrUvMYqF1oi86eAEgAN32lM=;
        b=ZsD4fYOsnnjMCitZ/SfaVKUnam2AHrqBIkdZWTwWMGxPwFAHCo6/3MYAq/UAIiev86
         bF5YXfevBbNtrOrzalvER0hdKxSxlgFXoUsixsw3WlwuGMpD6r4LsNsybX3Fbl9Y2S5V
         7ThuY1f8SWs1XB0rQLKJQrYOhQ2AfBmwN4jRF7ntp9pl7jOBFLBsi/hNHTuY29ysNtqD
         ueWLIQZMLHg/gEOGD1dBYzPOIO04NvKu/HyO6WHnsUzAiDHtKfI4rDtulo0coL0CorDb
         Mi64IBHaie4lEL9mSbhX93FgbWbQUV2ajRaE+nOLE0JWoz0Z0jPDV/Sk4YbdPJJGTV0Y
         623Q==
X-Received: by 10.69.19.193 with SMTP id gw1mr3709395pbd.106.1407931902203;
        Wed, 13 Aug 2014 05:11:42 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.107])
        by mx.google.com with ESMTPSA id am3sm1956192pbd.18.2014.08.13.05.11.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 05:11:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqppg4vdii.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255204>

>>  		if (pack_idx_opts.version > 2)
>> -			die("bad pack.indexversion=%"PRIu32,
>> -			    pack_idx_opts.version);
>> -		return 0;
>> +			die("bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
> 
> One more opportunity for git_die_config()?
>

Yup, I had thought of changing that and above to git_die_config(), but didn't do
it, will send a revised patch.


> Not that it's terribly important, but I think it's good that your
> refactoring also brings a few end-users benefits. It will help you show

I have been rewriting callers and the law of diminishing returns kicked in. I had
rewritten some other call sites but I didn't see them bringing any benefits (cleaner
control flow, less lines, bugs eliminated), so I left them out.

> off when you tell your friends what you did this summer (not "I did
> useless code churn" ;-) ), and helps everybody see the benefits of your
> GSoC ;-).
>
