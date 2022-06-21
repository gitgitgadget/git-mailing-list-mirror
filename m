Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF096C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354534AbiFUWdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354483AbiFUWdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:33:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E7645B
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:32:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a17so11783056pls.6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mdItY5UNJBaUAjIyvGNWRBjsnnl9aUi+3+57kq4Gf18=;
        b=Gs9ofhfyrnkLjbLCZ0isAEdqmiL6N+Ny2nvh+xKbOoys3sKU639cRBTN5FEUJxOPMp
         3ueGKBXB+kVhePQa/Jn3YhsdWEflnkRmtRP3Zo3V9ZL+SbhzT6KiGUylWGNXyZikAUqe
         iv5z+DeK43Z/8PQ0xsPkv1AKoMXApOzAe+290buD7XdNEeQWSU7gxzkAYs6lIDRAHacG
         LOlDK8O2yJzZyKZbqaczQFBikpAS+u48jkCbQ8A9WqOA6aNG2pRWFQdvNWY9susvld1W
         Ebo4VkysywFxlhPGl0n/b7BaXY+F7c03dD1U1Lawer4jnuBX8491A0QyrBHS0i+FQkPe
         FGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mdItY5UNJBaUAjIyvGNWRBjsnnl9aUi+3+57kq4Gf18=;
        b=uPRkDt5T+n9eJFNxXyTT+Dn3wLfvVngLY0gU4vopaWiYGCvyciShU83Oac6ISzQsTk
         mtZOq15rWAfAraAveYkjwpw9AdYlRMUAubGDk6oKglEkWEZaSmExRIy9IcXrxHQdFQ4/
         5rZAsp+kkk1ZoWN2vl/hjauDtms5lnN5g2Qd/5/BLIs7YldcFTDeQ+YBY84HAVHRDoqo
         V1eCNUGsjdgXfX6W7BiiXmtslKSZc3k75/uXcnXn6gwOzH0yCY1EMqmN/iT7uSqy55GX
         GeDwXKOB7I4GXcu/2tLqb6U7Un+tYatPlsD5sxeIW023t2Mgve0UaOBdqD1Wkva6kTwK
         inKA==
X-Gm-Message-State: AJIora/zWWHsLrzhQOj3CmTLypXM2u1wY8gLiW70ZPVv8aL3iM48nu37
        PhZ4MU2/nkweyvXHpREG8s2p
X-Google-Smtp-Source: AGRyM1uSeGIUe8S7JUQRz2c3nexsR4CaCx1k1ut7a0vbT2K1T9OCyQ06GlsVCELjyI0KLm2b84OB4A==
X-Received: by 2002:a17:90b:224e:b0:1e6:8ae1:8e1a with SMTP id hk14-20020a17090b224e00b001e68ae18e1amr189736pjb.59.1655850776043;
        Tue, 21 Jun 2022 15:32:56 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709026e0100b0016160b3331bsm11162185plk.305.2022.06.21.15.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 15:32:55 -0700 (PDT)
Message-ID: <01b39c63-5652-4293-0424-ff99b6f9f7d2@github.com>
Date:   Tue, 21 Jun 2022 15:32:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v3 5/7] mv: use flags mode for update_mode
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-6-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220619032549.156335-6-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> As suggested by Derrick [1],
> move the in-line definition of "enum update_mode" to the top
> of the file and make it use "flags" mode (each state is a different
> bit in the word).
> 

This message doesn't quite cover all of what's done in the commit. In
addition to moving the enum definition, you introduce a 'SKIP_WORKTREE_DIR'
flag and change the flag assignments to '|=' (additive) from '=' (single
assignment). If those changes belong in this commit (not a later one), they
should be explained in the message here.

> [1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index abb90d3266..7ce7992d6c 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -19,6 +19,14 @@ static const char * const builtin_mv_usage[] = {
>  	NULL
>  };
>  
> +enum update_mode {
> +	BOTH = 0,

I know this comes from the original inline enum, but I don't see 'BOTH' used
anywhere. The name itself is somewhat confusing (I have no idea what "both"
is referring to - possibly "both" 'WORKING_DIRECTORY' and 'INDEX'??), so
would you mind removing it in the next re-roll? 

> +	WORKING_DIRECTORY = (1 << 1),
> +	INDEX = (1 << 2),
> +	SPARSE = (1 << 3),
> +	SKIP_WORKTREE_DIR = (1 << 4),

You're not introducing any assignment of 'SKIP_WORKTREE_DIR' in this commit
(looks like that's done in the next one, patch [6/7]), so you should
probably 'SKIP_WORKTREE_DIR' and its corresponding usage in that patch
instead of this one.

> +};

When the update modes were mutually-exclusive, it made sense for them to be
represented by an enum. Now that they're flags that can be combined, should
they instead be pre-processor '#define' values (e.g., like the 'RESET_*'
modes in 'reset.h' or 'CE_*' flags in 'cache.h')? I don't actually know what
the standard is, since I also see one or two examples of using enums as
flags (e.g., 'commit_graph_split_flags' in 'commit-graph.h'). Maybe another
contributor could clarify? 

> +
>  #define DUP_BASENAME 1
>  #define KEEP_TRAILING_SLASH 2
>  
> @@ -129,7 +137,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
> -	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
> +	enum update_mode *modes;
>  	struct stat st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>  	struct lock_file lock_file = LOCK_INIT;
> @@ -191,7 +199,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			pos = cache_name_pos(src, length);
>  			if (pos < 0) {
>  				/* only error if existence is expected. */
> -				if (modes[i] != SPARSE)
> +				if (!(modes[i] & SPARSE))
>  					bad = _("bad source");
>  				goto act_on_entry;
>  			}
> @@ -207,14 +215,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			}
>  			/* Check if dst exists in index */
>  			if (cache_name_pos(dst, strlen(dst)) < 0) {
> -				modes[i] = SPARSE;
> +				modes[i] |= SPARSE;
>  				goto act_on_entry;
>  			}
>  			if (!force) {
>  				bad = _("destination exists");
>  				goto act_on_entry;
>  			}
> -			modes[i] = SPARSE;
> +			modes[i] |= SPARSE;
>  			goto act_on_entry;
>  		}
>  		if (!strncmp(src, dst, length) &&
> @@ -242,7 +250,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			}
>  
>  			/* last - first >= 1 */
> -			modes[i] = WORKING_DIRECTORY;
> +			modes[i] |= WORKING_DIRECTORY;
>  			n = argc + last - first;
>  			REALLOC_ARRAY(source, n);
>  			REALLOC_ARRAY(destination, n);
> @@ -258,7 +266,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				source[argc + j] = path;
>  				destination[argc + j] =
>  					prefix_path(dst, dst_len, path + length + 1);
> -				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
> +				memset(modes + argc + j, 0, sizeof(enum update_mode));

One benefit of using '#define' values would be that 'modes' would just be an
array of unsigned ints, so you could just assign '0' rather than using
memset. In terms of the implementation as-is, though, I think what you have
is correct.

> +				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
>  				submodule_gitfile[argc + j] = NULL;
>  			}
>  			argc += last - first;
> @@ -355,7 +364,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			printf(_("Renaming %s to %s\n"), src, dst);
>  		if (show_only)
>  			continue;
> -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
> +		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +			rename(src, dst) < 0) {

Nit: could you align 'rename' with the line above it (per the highlighted
section in the CodingGuidelines [1])? As far as I can tell, the "align with
tabs and spaces" approach is what's *intended* to be used in 'mv.c'
(although it's admittedly pretty inconsistent).

[1] https://github.com/git/git/blob/master/Documentation/CodingGuidelines#L371-L383 

>  			if (ignore_errors)
>  				continue;
>  			die_errno(_("renaming '%s' failed"), src);
> @@ -369,7 +379,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  							      1);
>  		}
>  
> -		if (mode == WORKING_DIRECTORY)
> +		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
>  			continue;
>  
>  		pos = cache_name_pos(src, strlen(src));

