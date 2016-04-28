From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] How to pass Git config command line instructions to Submodule commands?
Date: Thu, 28 Apr 2016 14:05:20 +0200
Message-ID: <FF931AB2-2381-4DF9-AE28-CE30EEC5C352@gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com> <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com> <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com> <20160425212449.GA7636@sigill.intra.peff.net> <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com> <20160428112511.GA11522@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:06:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkiO-0004wI-4d
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 14:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbcD1MGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 08:06:34 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37835 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbcD1MFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 08:05:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id a17so61484988wme.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DaolKYHjXva2HXirJwJn0UPr4CHuSMPeKze1E6Xvk7s=;
        b=uQ5HiG3Ckby0wchHUQkpi12w+rAMbVAGLXXNAYdfSA+fA/Qr7hdR5tdR/F26g0VdSl
         /F0fcwH32KCVFZKwl21uxfYIn/TxuwAobwsGltFaD0YhknTy5uGr63RRWNDDFfSfSWxo
         niOdJ6qdg1wzjJb4qbTByhezdoJNMbqd5cOQ8Pzzdq9dShZVXbW39HWF9nZsZDxD5Lr9
         1Y6AUkQFZh12Gee2WjPuJJS3Mcd4A2L9ReoX4LWvwkjyrxtADJ2TH4r9exr6kHwsXS6D
         Mz0P3tbOIlE0zNQ7oqoi2aVBH5MVGDc+BnNySpjRIkKAKNGzjP6VZufWKVFYSOHsEHN2
         vyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DaolKYHjXva2HXirJwJn0UPr4CHuSMPeKze1E6Xvk7s=;
        b=QvHXCyJWq+JFYYraealEbP1kiWIcQOz//jvtqEXsqOxwUtL3IekI7k1CYB6nUObqhJ
         Er54x9fYnX5Y/MKiqTCJHibIkRLVxl6I2ycipYeWduISDguxu8ravcTjwC+E92cn0del
         VdpL/kvwF1ykxYGSOItHlHcIgz56GRKudqreNfTopoJMM2nt5Ctzap3SSSX2u2XRLksM
         XeNBBQT2574loL7EBvHeegmtisIcMFJtv9dDApiEG2Zn+G9anR4NMdEvASfN7mGb1l/B
         4vssY9cKqw6HlpTO5nlc/CAfXRkzQozgvQOOJS8RR0hKctcnJEayT0x/CmcsJJF0NGEi
         ejtQ==
X-Gm-Message-State: AOPr4FUDemzB5b2uqPQqAZq5+WlncHCypKe6M98IcKFE1k8kfKd5qUGA08L61aP/zwxX/Q==
X-Received: by 10.194.120.135 with SMTP id lc7mr3173979wjb.34.1461845121623;
        Thu, 28 Apr 2016 05:05:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kz1sm9322911wjc.46.2016.04.28.05.05.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 05:05:20 -0700 (PDT)
In-Reply-To: <20160428112511.GA11522@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292870>


> On 28 Apr 2016, at 13:25, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Apr 28, 2016 at 01:06:45PM +0200, Lars Schneider wrote:
> 
>> I got my Git-LFS use case working with the patch below. 
>> For me it was necessary to export GIT_CONFIG_PARAMETERS
>> to make it available to the Git process if the process is 
>> invoked as follows [2]: 
>> 
>> (sanitize_submodule_env; cd "$sm_path" && git <something>")
> 
> Hrm. I'm not sure why you need to export. Or perhaps, I am not sure why
> it ever works in the first place in git-submodule.sh. In this code:
> 
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 2a84d7e..b02f5b9 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -199,7 +199,7 @@ sanitize_submodule_env()
>> {
>> 	sanitized_config=$(git submodule--helper sanitize-config)
>> 	clear_local_git_env
>> -	GIT_CONFIG_PARAMETERS=$sanitized_config
>> +	export GIT_CONFIG_PARAMETERS=$sanitized_config
>> }
> 
> If you already have $GIT_CONFIG_PARAMETERS exported when we enter the
> function, then we should not need to re-export it when changing the
> value in the final line (the export bit is retained by the shell). But
> if you don't have it set already, then $sanitized_config must by
> definition be empty.
> 
> So it should do the right thing without the export.
> 
> At the same time, clear_local_git_env() will call "unset" on
> GIT_CONFIG_PARAMETERS. Which would clear the export bit, meaning the
> final line doesn't ever have any impact on sub-programs, and the whole
> thing is totally broken. But then, why does the test in t5550 pass?
> 
> Confused...

I am no expert in the Submodule code but I think the cloning of
the submodules is not yet guarded with sanitize_submodule_env [3].
That means the submodule is cloned with the GIT_CONFIG_PARAMETERS
of the super project. That might explain why t5550 passes as the 
credential config is only used in that area.

The submodule checkout is guarded with sanitize_submodule_env
and therefore my Git-LFS filter use case is affect.

Does this sound reasonable?

Thanks,
Lars

[3] https://github.com/git/git/blob/3ad15fd5e17bbb73fb1161ff4e9c3ed254d5b243/git-submodule.sh#L704-L711
[4] https://github.com/git/git/blob/3ad15fd5e17bbb73fb1161ff4e9c3ed254d5b243/git-submodule.sh#L811
