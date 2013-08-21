From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 12:37:59 +0200
Message-ID: <52149887.9050601@googlemail.com>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <20130821082527.GC2802@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 12:38:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC5np-0000tY-EB
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 12:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab3HUKiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 06:38:02 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:53563 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab3HUKh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 06:37:59 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so141315eaj.13
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=suYwHSsTVHd3Apo6vmtXCChGDy9VEQ65e2vfFFdJWgo=;
        b=jkNngwoN4ok2/fqhNaW8SWO1VgOyZ2DxsArLvPTHExPQDcEq+Ej9qDdZrynZoAJzDo
         yDPrPQrQM2DK5qojOBcuSqifgg7IMyyzDHRRMLwpPBXHlejGRWzzaT07fLkrY+pga1OB
         z+okmNB93TuMbHVA4YIFTe7FGxv9VvoDClu9SFNO1vdMymsinQ/R/QDyWoGXcAtMYdKQ
         r6kAg2b2CvlUSqFG25wZV99WmtRzSuOqkTAnrNbGeXnF8XiFp2qx5oxhCJ8QWqqAkZUU
         Vipzyw0J6JTKffq4Z7W66KI2kwnAXjnY8zLK4J3Mi6DiWy7GHVAzpPRIhHYytNfYN6B9
         KjnA==
X-Received: by 10.14.103.69 with SMTP id e45mr2631607eeg.51.1377081478150;
        Wed, 21 Aug 2013 03:37:58 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm8742805eec.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 03:37:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130821082527.GC2802@elie.Belkin>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232697>

On 08/21/2013 10:25 AM, Jonathan Nieder wrote:
>> +static int delta_base_offset = 0;
> 
> The "= 0" is automatic for statics without an initializer.  The
> prevailing style in git is to leave it out.
> 
> Behavior change: in the script, wasn't the default "true"?
> 

Yes, I was printing out the arguments of shell version and 
of the C version and tried to match the arguments.
I must have missconfigured the test repository where
I run these differential tests. 
Now that I test again, the --delta-base-offset option
shows up as default as it is documented.

Now fixing the rest of your annotations.

Stefan
