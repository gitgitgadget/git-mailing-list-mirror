From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 21:37:49 +0530
Message-ID: <53BD68D5.7000503@gmail.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com> <vpqion68viq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:08:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4uPb-0005OB-R2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 18:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbaGIQH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 12:07:58 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36258 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663AbaGIQH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 12:07:57 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so9529869pab.29
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LUeAZwIWyPOm4cxCX87AGbvQ42djyAOaTBX0GwREcr0=;
        b=t5YGW/VNJTJkAVuWtnndhtNGg7L+ilM31k1MSppob3b7do5tUmfCJ5Yrk2ESjMe/mq
         LT7GMChjiguy2CBIfxwzSr3gqg9A7NYKMoP+aU7aGGS1VFAHwYCIzYR7vGT1p6REa4vy
         g68Evg9TXRaat1FX2jhmJ3qVzUPtTmHYXc+S9ijzu0GixHiDi5ly8xoVKfOynK7X+vAC
         N8vRKpRU9k3pphCokszL0lPOcGwQsPtb6BNwSccyCaf/UneO4x1RS/fQBXC3L+iXpbDL
         FTttMzB9tRzCErknuJwKFLh4PtseQA4r3fFbLMYOQXktGxaQApjSImmUgmdKFo0CTac1
         6K0g==
X-Received: by 10.68.197.195 with SMTP id iw3mr1754958pbc.139.1404922077282;
        Wed, 09 Jul 2014 09:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.219.187])
        by mx.google.com with ESMTPSA id nz7sm28993955pdb.48.2014.07.09.09.07.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 09:07:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqion68viq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253132>

On 7/9/2014 7:49 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
> 
> My opinion on this:
> 
> * It's low priority. I think the order of priority should be (high to
>   low)
> 
>   1) Finish and get the current series into pu (we're almost there, it's
>      not time to back off and restart something new).

Noted. I will send the revised series tomorrow ASAP.

> 
>   2) Work on the other series that uses the new API. We don't need to
>      change _all_ the uses, but we do need a few tens of them to
>      validate the fact that the new API is nice and convenient to use.
> 

Okay, I have updated the series and will send the new one by friday.
Still, I am aiming to rewrite at least half of total calls next weeks
when (1) is in pu.

>   3) Get new actual features for the user (tidy up config files, give
>      error messages based on numbers).
> 
>   You probably won't finish everything, so just think: if the GSoC ends
>   between 1) and 2), how serious is it? if it ends between 2) and 3),
>   how serious? If reverse the order, then the risk of having nothing
>   finished and mergeable at the end is high. If it happens, the
>   community may or may not take over and finish it ...
>

Noted, still I want to add that even when GSoC finishes, I won't leave the
work unfinished. I had said that I wanted to continue being part of the Git
community and I mean that. :)

> * Still, making sure that the (file, line) is doable later without too
>   much change is good. So, if indeed, moving all code to another file is
>   required, then it may make sense to do it now to avoid code move
>   later.
>

Yes, the only problem I see is that the future readers of config.c might
read two versions of the git_config_type helpers and may get confused,
as they have similar names as git_config_*() & git_config_get_*().
That was the reason in the first place that I moved the code into a new file.

>> 1. config-hash.c had to be shifted to config.c entirely.
> 
> Why? I guess one reason is the use of struct cf (are there others?), but

Nope, just for using struct cf. All old API functions raise error by
accessing "cf" globally for the file name and line number.

> moving just
> 
> config_hash_callback
> config_hash_add_value
> git_configset_add_file
> 
> to config.c should do it. Then, config.c could use config-hash.c.
> 
> But a cleaner way would be to allow the callback to receive the
> config_file struct without accessing it as a global variable (currently,
> we have no way to parse two config files in parallel for example).
> 
> In practice, it should be possible to pass a 4th pointer argument to the
> callback, and keep compatibility with 3 arguments callback (having too
> many arguments in not a problem will all ABI I know), but I'm don't
> think this is allowed in theory.
> 
> On overall, I'm not convinced we should move the code. When the argument
> "I need to merge these two things otherwise it doesn't compile" comes in
> a discussion, it usually means there's an architecture issue
> somewhere ;-).
>

I have to decide on what to do next on moving the contents to config.c or not.
Seeing Junio's comments on the topic seems that he wasn't convinced in the
first place that we needed a new file. What should we do, as I am sending the
revised patch tomorrow? The move will be trivial, just cutting and pasting the
contents. Other approaches you mentioned are also doable but, after a certain
amount of retooling. I am open to any method you think would be best.

Cheers,
Tanay Abhra.
