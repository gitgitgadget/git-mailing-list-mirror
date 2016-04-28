From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] How to pass Git config command line instructions to Submodule commands?
Date: Thu, 28 Apr 2016 13:06:45 +0200
Message-ID: <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com> <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com> <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com> <20160425212449.GA7636@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:06:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avjmX-00049f-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbcD1LGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 07:06:49 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37154 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcD1LGs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 07:06:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so58981742wme.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aDakm++gIzx1OKaBug0FRw46t2r1l28aOL+1pvjipK0=;
        b=ZBsjUh90kvdYKABdhPFQfRNOO90h9Q4FqgtO1l8bU1DN6AHL/qilaLY2Rxh1+88+fa
         24/wAO6KHemIpGqOFFIWQJmwMaVDpGHGYxyPjeC/wK7wlMJ++aAIBpeRvzoQ1zJJRLsm
         LbuN9kqTtEt9+nZCO7jY6f4wWQtM/RG20rCQWsAvM0foi3l0zmHXrSBcr0NYwjrgQD1Q
         RWLPd9x+s2vfTBTqeZDI08+2GQVoGzRqcMkxotMK+1z9z966YRxshaR8FO1sJH8TKMqy
         riIczM5fnC9vmHjXo4RA81/LM1QjocxijjNzRcPlZ4P9HrHiFwesMW/QYIOtb9abn5wz
         ivvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aDakm++gIzx1OKaBug0FRw46t2r1l28aOL+1pvjipK0=;
        b=LZ2tIt7IZ+4/Yqyg5HHZCSZat3tsbqddjkjSc6N6CPEWE8CYGaX64htRPIwTPhh3/B
         u26f5GVteUqTuAo1juWF7OB2i2ShAFZec6l/2WY36UKNRVWyCGc54JXSidWoBmHaL/JT
         w1GMKAwXo8Mc3BHduA4aDlxZTKmU9cPBjP6M/rjviIHuAXpb+Bpdj6NjGCFzoZI1ZZQ3
         kRtOno2uk4LOqe8NLswKvSutmHBffJh83pCMzPY+2J6pa+4bt7YvDaxGI+JPLurPcRry
         hgcifmGSBaet0xo9CMnBN3Rd0XnPZIEW6utyg35qzChaJq9T+mCBRElc0wNEQ1REIcnJ
         W9lw==
X-Gm-Message-State: AOPr4FWxoAYdfteltZW1yHxB2ldR0GFeRkhhJ5TxVfmc5Y2DaQp//jn1ILzE0xOBizKkUg==
X-Received: by 10.28.88.138 with SMTP id m132mr15714868wmb.7.1461841607005;
        Thu, 28 Apr 2016 04:06:47 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d23sm6603298wmd.1.2016.04.28.04.06.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 04:06:46 -0700 (PDT)
In-Reply-To: <20160425212449.GA7636@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292863>


> On 25 Apr 2016, at 23:24, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Apr 25, 2016 at 01:59:03PM -0700, Jacob Keller wrote:
> 
>>>> However, I noticed that git config command line instructions such as
>>>> "-c filter.lfs.smudge=" are not passed to Git submodule operations. Thus
>>>> this does not work as expected:
>>>> 
>>>>    git -c filter.lfs.smudge= -c filter.lfs.required=false clone --recursive <url> <path>
>>> 
>>> I have cc'd Jacob Keller, who authored origin/jk/submodule-c-credential,
>>> which does work in that area (deciding which config option to pass down
>>> into the submodule commands).
>>> 
>> 
>> This is a tricky question. The problem is that some configurations are
>> obviously not intended to go into the submodules, but determining how
>> is somewhat troublesome. There was some discussion on this previous
>> thread when we added support for credential options to pass through.
> 
> Right. I think it may be reasonable to pass through filter.* in the
> whitelist.  They are not activated without a matching .gitattributes
> entry in the repository (and people would generally configure them in
> their user-level ~/.gitconfig for that reason).
> 
> It does mean that somebody would be stuck who really wanted to run the
> smudge filter in their local repo, but for some reason not in the
> subrepos. I am trying to think of a case in which that might be
> security-relevant if you didn't trust the sub-repos[1]. But I really
> don't see it. The filter is arbitrary code, but that's specified by the
> user; we're just feeding it possibly untrusted blobs.

This looks like a very promising solution and I can't think of a
security problem either (I checked the older thread [1] you 
referenced, too)!

I got my Git-LFS use case working with the patch below. 
For me it was necessary to export GIT_CONFIG_PARAMETERS
to make it available to the Git process if the process is 
invoked as follows [2]: 

(sanitize_submodule_env; cd "$sm_path" && git <something>")


Exporting the variable would not be necessary in this case:

(cd "$sm_path" && sanitize_submodule_env git <something>")

Unfortunately that does not work and I think the reason is that 
clear_local_git_env (invoked by sanitize_submodule_env) clears 
the $GIT_DIR, too.


If there is a reason against exporting GIT_CONFIG_PARAMETERS,
then this would work, too:

(sanitize_submodule_env; cd "$sm_path" && GIT_CONFIG_PARAMETERS=$GIT_CONFIG_PARAMETERS git <something>)


Would the patch below be an acceptable solution?


Thanks,
Lars


[1] http://thread.gmane.org/gmane.comp.version-control.git/264840
[2] https://github.com/git/git/blob/3ad15fd5e17bbb73fb1161ff4e9c3ed254d5b243/git-submodule.sh#L811



diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3bd6883..9231089 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -129,6 +129,8 @@ static int submodule_config_ok(const char *var)
 {
 	if (starts_with(var, "credential."))
 		return 1;
+	if (starts_with(var, "filter."))
+		return 1;
 	return 0;
 }

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a84d7e..b02f5b9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -199,7 +199,7 @@ sanitize_submodule_env()
 {
 	sanitized_config=$(git submodule--helper sanitize-config)
 	clear_local_git_env
-	GIT_CONFIG_PARAMETERS=$sanitized_config
+	export GIT_CONFIG_PARAMETERS=$sanitized_config
 }

 #
