Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDE51F405
	for <e@80x24.org>; Thu,  9 Aug 2018 20:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeHIW1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:27:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51079 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeHIW1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:27:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1422937wmc.0
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/nJJNdvvgtBI7kRbb5sRmfW6WZpke1idmlzixUJRmE=;
        b=N8Da4oiFtGz+K2dT0KK4AEy+RyzmJ4Hzf31bVGOEIIsLnvQenFcs2KCS6K2BiChfVV
         noIkWMRun83LS59b+8ZkGH1ZWn8GAQ7BvDn4aXk/19lzVHpacdH6FeGUbzgnW8eqhZh3
         mTh/H65W8lFu33zUV+C26Xv1O5IylTHPW5jdfWFzqW750Qqlp6O3Ajx76r2GKuI/Sxeq
         5IKUseLJnyPomkWYE/9LeW+OnPsQ3MOpPNWkjMJQ4u7+ecwuVOZyj7dezm21x7xX08g3
         ve+5piEmicSymW8YSs4Eg04LSWNKkc/58YBv7sYADgyr0X4xxo7y1YpH4vOUk1Dk40RG
         JLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/nJJNdvvgtBI7kRbb5sRmfW6WZpke1idmlzixUJRmE=;
        b=RdKkY5WPpJog8PObg2NG7yh19rHZrkrF5N9tpA8CAgf0aCpPSVCFFrB6Zvl2lmhV/d
         b1R645xWns7aUljDsjXgBnzcKPovzx6NBmZNOCZdxKFnwbEPEx3QuoB2+znSpIzwcrye
         EYYRmms3kA76oBryURWaxmC5+SdaJp0FedUVSlQf4uDYWR0vajWbn6CNMI+gaAk9vKE3
         jnwri9OwgC5J7TDuWfO6qfOaNU4hw7dGVfxtm1+Bm3+q+/kb8DRJO3o3ijcbo74rLpHH
         4+zYa+aSFjzijtIvCULcVW+W0CcXYeM78Ft8jx6K0nGae+82lfKgdEKkOaP4EVxZbDrR
         M41g==
X-Gm-Message-State: AOUpUlE5BqyYYesbRylbeHPCPI+HPfX5dsQ4oiYQOmlWXqyLPFGLliVc
        Dguta21G8qUSQ7/xB6FxUE2fVRwL
X-Google-Smtp-Source: AA+uWPwBuHETM7bFNfM0jazJWmeY9irj1WFibAmbecXnjapjItjKqjQsGIM2pELCV9fFIph413M+1g==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196-v6mr2612190wmd.114.1533844871133;
        Thu, 09 Aug 2018 13:01:11 -0700 (PDT)
Received: from [192.168.0.137] (5-13-191-27.residential.rdsnet.ro. [5.13.191.27])
        by smtp.gmail.com with ESMTPSA id c13-v6sm6538540wrt.24.2018.08.09.13.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:01:10 -0700 (PDT)
Subject: Re: [GSoC][PATCH v7 05/26] stash: convert apply to builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
 <xmqqa7pwfw84.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <1ba17df0-e6da-3358-622b-c19092c20eb0@gmail.com>
Date:   Thu, 9 Aug 2018 23:01:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqa7pwfw84.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 08.08.2018 23:18, Junio C Hamano wrote:
> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
> 
>> From: Joel Teichroeb <joel@teichroeb.net>
>>
>> Add a builtin helper for performing stash commands. Converting
>> all at once proved hard to review, so starting with just apply
>> lets conversion get started without the other commands being
>> finished.
>>
>> The helper is being implemented as a drop in replacement for
>> stash so that when it is complete it can simply be renamed and
>> the shell script deleted.
>>
>> Delete the contents of the apply_stash shell function and replace
>> it with a call to stash--helper apply until pop is also
>> converted.
>>
>> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
>> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> 
> Good to see that the right way to forward a patch from another
> person is used, but is this a GSoC project?

Yes, it is. I forgot to add the [GSoC] tag in the last series of patches.

>> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
>> new file mode 100644
>> index 000000000..ef6a9d30d
>> --- /dev/null
>> +++ b/builtin/stash--helper.c
>> @@ -0,0 +1,452 @@
>> +#include "builtin.h"
>> +#include "config.h"
>> +#include "parse-options.h"
>> +#include "refs.h"
>> +#include "lockfile.h"
>> +#include "cache-tree.h"
>> +#include "unpack-trees.h"
>> +#include "merge-recursive.h"
>> +#include "argv-array.h"
>> +#include "run-command.h"
>> +#include "dir.h"
>> +#include "rerere.h"
> 
> Wow, "apply" is a biggie, as you'd pretty much have to do
> everything, like merging and updating the index and asking rerere to
> auto-resolve.  Quite a many include files.
> 
>> +static const char * const git_stash_helper_usage[] = {
>> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
>> +	NULL
>> +};
>> +
>> +static const char * const git_stash_helper_apply_usage[] = {
>> +	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
>> +	NULL
>> +};
>> + ...
>> +static void assert_stash_like(struct stash_info *info, const char * revision)
> 
> This inherits an unfortunate name from the scripted version (it does
> more than asserting), but it is OK to keep the original name,
> especially in this early step in the series.
> 
> Lose the SP in "* revision"; the asterisk sticks to the variable/parameter name.

Will do so.

>> +{
>> +	if (get_oidf(&info->b_commit, "%s^1", revision) ||
>> +	    get_oidf(&info->w_tree, "%s:", revision) ||
>> +	    get_oidf(&info->b_tree, "%s^1:", revision) ||
>> +	    get_oidf(&info->i_tree, "%s^2:", revision)) {
>> +		free_stash_info(info);
>> +		error(_("'%s' is not a stash-like commit"), revision);
>> +		exit(128);
>> +	}
>> +}
> 
>> +static int reset_tree(struct object_id *i_tree, int update, int reset)
>> +{
>> ...
>> +}
> 
> Kind-a surprising that there is no helper function to do this
> already.  The implementation looked OK, though.
> 
>> +static int apply_cached(struct strbuf *out)
>> +{
>> +	struct child_process cp = CHILD_PROCESS_INIT;
>> +
>> +	/*
>> +	 * Apply currently only reads either from stdin or a file, thus
>> +	 * apply_all_patches would have to be updated to optionally take a
>> +	 * buffer.
>> +	 */
>> +	cp.git_cmd = 1;
>> +	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
>> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
>> +}
> 
> Applying and updating the index is more resource intensive than
> spawning a process, and not having to worry about the process dying
> is a benefit, so overall, making this into an internal call would be
> a lot lower priority, I would guess.

Indeed. In the last but one patch [1], I tried to convert all of the 
"apply" processes. At the moment, `apply_all_patches()` cannot take a 
buffer. A solution for this was to write the buffer into a file and pass 
the name of that file to the function. Of course, this might not be a 
bright idea and for this reason I am not sure if that patch is worth.

[1]
https://public-inbox.org/git/56500d98f9d5daaa5f21a43767885baede86e3a0.1533753605.git.ungureanupaulsebastian@gmail.com/

>> +static int reset_head(const char *prefix)
>> +{
> 
> This is resetting the index to the HEAD, right?  reset_head sounds
> as if it takes a commit-ish and moves HEAD there.
> 

Yes, it resets the index to the HEAD.

Best,
Paul
