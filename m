Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A9C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbiEPSrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiEPSq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:46:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DF33E5EA
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:46:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g3so11493191qtb.7
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WX4fUz98MG2TA6zplxUZlxfmAtEORMbpor+Qsdla6sg=;
        b=GV5oukNA2DEOJAlWkNhosaPt27olXrvWhyNWzftMsdvSFJo3HBhwUWPpP8524cXni4
         FoHHnSX3/JHdCF1p3MS5wRQGRCz+eC7ijlnfXhM3A+ISwcp6Vsm/SFkXLRCjYaFjFOcc
         kRrSL26ed2iyHEr5TSrzPW7oAkGaN5lj67oKfI0xBH7Tk78v5Y/aO4eoIb7/Mp/0MEkb
         LbIkMlllYApuvrYT+uxJxwk87eBXtLy4EADlBQPpjHlvm3bkvWlZ4SGc8dr5ClhQO+dO
         TRH6G2/qoOYmrwRVP9Yfo+MrNOpyXrryj8yBpcHRPt9miHmJg53ODoq/dWmux+4p95g9
         Vxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WX4fUz98MG2TA6zplxUZlxfmAtEORMbpor+Qsdla6sg=;
        b=laddYxAPfXQwusblwt61cF1fNWjVWLWdA5ULsIS1bad5Zkx0hik3BowGBhBXzPBr7p
         6YOq5uw15SvoVyqdc2z8kJfeupQqdve8WbAKh/77fkhQwvYzf8PXKLn0xV6HDBQDCOvA
         8HdFtM0SrEaYb4pUBfPEFOJ++P0CnJpioPVKLpZloxGepWeDdnvcf3+mN+nH6WxySoXp
         tcptR3MsFoLg7ConWZJnb7WSqigVG02YVOv/PaVnCyQf6Je0w9CNcxS2YsC2Stt0sOFc
         O1MoDQeNOTswqbhhYbK0gw8zbMlIkXTlg4/mUjYPwk5RWkchWnA8jkZS99e/VOkW5Nh+
         AzHw==
X-Gm-Message-State: AOAM531n+HhiK2eiyfrjEj1Ok7qLqiXTcRSeOHiKTBJN8jWAMPhdEPaQ
        guh+x9IPhkykIcnAAUj7HKQPreClcMui
X-Google-Smtp-Source: ABdhPJx5RaYUMa+iFVsHoHcXeFxX8f27OXOMDpVzf2bLrgqGq5zz9GrtmoECqTjZqdTRgFokUlHxfA==
X-Received: by 2002:a05:622a:487:b0:2f3:cb77:b19c with SMTP id p7-20020a05622a048700b002f3cb77b19cmr16795632qtx.352.1652726816880;
        Mon, 16 May 2022 11:46:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a208100b0069fc13ce205sm6077504qka.54.2022.05.16.11.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:46:56 -0700 (PDT)
Message-ID: <e5139922-9b74-ebfa-756c-629918e0456b@github.com>
Date:   Mon, 16 May 2022 14:46:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] setup.c: make bare repo discovery optional
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> Add a config variable, `discovery.bare`, that tells Git whether or not
> it should work with the bare repository it has discovered i.e. Git will
> die() if it discovers a bare repository, but it is not allowed by
> `discovery.bare`. This only affects repository discovery, thus it has no
> effect if discovery was not done (e.g. `--git-dir` was passed).

> This config is an enum of:
> 
> - ["always"|(unset)]: always recognize bare repositories (like Git does
>   today)
> - "never": never recognize bare repositories
> 
> More values are expected to be added later, and the default is expected
> to change (i.e. to something other than "always").

I think it is fine to include the "never" option for users to opt-in to
this super-protected state, but I want to make it very clear that we
should never move to it as a new default. This phrasing of 'something
other than "always"' is key, but it might be good to point out that
"never" is very unlikely to be that default.

> WIP setup.c: make discovery.bare die on failure
> 
> Signed-off-by: Glen Choo <chooglen@google.com>

Accidental concatenation of squashed commit?

> diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
> new file mode 100644
> index 00000000000..761cabe6e70
> --- /dev/null
> +++ b/Documentation/config/discovery.txt
> @@ -0,0 +1,24 @@
> +discovery.bare::
> +	Specifies what kinds of directories Git can recognize as a bare
> +	repository when looking for the repository (aka repository
> +	discovery). This has no effect if repository discovery is not
> +	performed e.g. the path to the repository is set via `--git-dir`
> +	(see linkgit:git[1]).

Avoid "e.g." here.

	This has no effect if the repository is specified directly via
	the --git-dir command-line option or the GIT_DIR environment
	variable.

> +This config setting is only respected when specified in a system or global
> +config, not when it is specified in a repository config or via the command
> +line option `-c discovery.bare=<value>`.

We are sprinkling config options that have these same restrictions throughout
the config documentation. It might be time to define a term like "protected
config" at the top of git-config.txt and then refer to that from these other
locations.

> +The currently supported values are `always` (Git always recognizes bare
> +repositories) and `never` (Git never recognizes bare repositories).

This sentence structure is likely to change in the future, and as it stands
will become complicated. A bulleted list will have easier edits in the future.

> +This defaults to `always`, but this default is likely to change.

For now, I would say "but this default may change in the future." instead.

> +If your workflow does not rely on bare repositories, it is recommended that
> +you set this value to `never`. This makes repository discovery easier to
> +reason about and prevents certain types of security and non-security
> +problems, such as:
> +

(You might need a "+" here.)

> +* `git clone`-ing a repository containing a malicious bare repository
> +  inside it.
> +* Git recognizing a directory that isn't meant to be a bare repository,
> +  but happens to look like one.

I think these last bits recommending the 'never' option are a bit
distracting. It doesn't make repository discovery "easier to reason
about" because we still discover the bare repo and die() instead of
skipping it and looking higher for a non-bare repository in the
parent directories. The case of an "accidentally-recognized bare
repo" is so unlikely it is probably not worth mention in these docs.

Instead, I think something like this might be better:

  If you do not use bare repositories in your workflow, then it may
  be beneficial to set `discovery.bare` to `never` in your global
  config. This will protect you from attacks that involve cloning a
  repository that contains a bare repository and running a Git
  command within that directory.

> +static int check_bare_repo_allowed(void)
> +{
> +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
> +		read_very_early_config(discovery_bare_cb, NULL);

This will add the third place where we use read_very_early_config(),
adding to the existing calls in tr2_sysenv_load() and
ensure_valid_ownership(). If I understand it correctly, that means
that every Git execution in a bare repository will now parse the
system and global config three times.

This doesn't count the check for uploadpack.packobjectshook in
upload-pack.c that uses current_config_scope() to restrict its
value to the system and global config.

We are probably at the point where we need to instead create a
configset that stores this "protected config" and allow us to
lookup config keys directly from that configset instead of
iterating through these config files repeatedly.

> +		/* We didn't find a value; use the default. */
> +		if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN)
> +			discovery_bare_config = DISCOVERY_BARE_ALWAYS;

This could also be done in advance of the config parsing
by setting discovery_bare_config = DISCOVERY_BARE_ALWAYS before
calling read_very_early_config(). Avoids an if and a comment
here, which might be nice.

> +	}
> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return 0;
> +	case DISCOVERY_BARE_ALWAYS:
> +		return 1;
> +	default:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
> +	}

You return -1 in discovery_bare_cb when the key matches, but
the value is not understood. Should we check the return value
of read_very_early_config(), too?
> +static const char *discovery_bare_config_to_string(void)
> +{
> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return "never";
> +	case DISCOVERY_BARE_ALWAYS:
> +		return "always";
> +	default:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);

In general, I'm not sure these BUG() statements are helpful,
but they aren't hurting anything. I wonder if it would be
better to use DISCOVERY_BARE_UNKNOWN instead of default,
because then the compiler should notice that the switch needs
updating when a new enum mode is added.

> @@ -1142,7 +1195,8 @@ enum discovery_result {
>  	GIT_DIR_HIT_CEILING = -1,
>  	GIT_DIR_HIT_MOUNT_POINT = -2,
>  	GIT_DIR_INVALID_GITFILE = -3,
> -	GIT_DIR_INVALID_OWNERSHIP = -4
> +	GIT_DIR_INVALID_OWNERSHIP = -4,
> +	GIT_DIR_DISALLOWED_BARE = -5

I think that you can add a comma at the end of this enum to avoid the
changed line the next time the enum needs to be expanded.

>  };
>  
>  /*
> @@ -1239,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		}
>  
>  		if (is_git_directory(dir->buf)) {
> +			if (!check_bare_repo_allowed())
> +				return GIT_DIR_DISALLOWED_BARE;

Won't this fail if someone runs a Git command inside of a .git/
directory for a non-bare repository? I just want to be sure that
we hit this error instead:

	fatal: this operation must be run in a work tree

I see that this error is tested in t0008-ignores.sh, but that's
with the default "always" value. It would be good to explicitly
check that this is the right error when using the "never" config.

Thanks,
-Stolee
