Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34C01F404
	for <e@80x24.org>; Wed, 31 Jan 2018 22:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeAaWoe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 17:44:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53347 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeAaWod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 17:44:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so2178939wme.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 14:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDrzFZXEdx7/0hnKY9dM+7NkbKHHNryOlLYyLwcNk70=;
        b=i0RDRZ0xdr3RRuDotTKH9AO1cyhS+Y33MaHJoJZRyR8h+0iM9ZtyBzM3MkwBkbhGe+
         hvBRJzi6Eqcy3CncTMBpvWKrna1594qufoA/UstL0icvXz5jxKuz62pTvxK2Or3yWMde
         SaZaDpY0GOkdQIEtCoxVybqA++PUvW1LuMD13AKtuwyAvNsIgtHiP6Y8TNhr6rQ7DKjj
         TtUpi32iewV/utoE8eIZz+OpFCarmxupLXTveoguRFLPQAjtDAMehyO49LzU0LkoE5+8
         wOhq0Eo9OoX29YU7vaejapuYX2V6x+KMg70V9Ea/meyRvbjsBPZdX5Vux8tGKNPK9nax
         BjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDrzFZXEdx7/0hnKY9dM+7NkbKHHNryOlLYyLwcNk70=;
        b=P6C1WWSUX5snor3QytBUcgKHjh1kpER+3T4AeJCoI1x++4ZwjmmJvEbyGqper1h72j
         PL+AOE80ExJ8KMNRSW+uYJ+i9lMgMQ4VaoFzZy52npkPt/NH+7b66rcsmYuYdFIrhi3I
         cBrS18PQ7TRsUheQ/DpTnjBrSzbyW94YFIzTPI5qqn+/JSFpuVdhSSZdKKlMNZORFJRT
         mzqkUrhLDd1GoDQHkDXWDqaRhstvvyFZNSLQV9LpgpPw570nseO425ncMZkIbbdVztxW
         Q17V6AoWNlJLUnqBPZKB/+oD23X0MJffGWrFYAe61CEGBkenv53sWxW1jkOkgVCHlq9K
         rJXA==
X-Gm-Message-State: AKwxytdJt9uaK5A1zunmN1JLZg43C2VE3+OcaSXdfGl5RGPsmZwbwlfD
        0P2NSUGLAjiMorWC56DCuLGuk1HDuXc=
X-Google-Smtp-Source: AH8x226piRzoxsrmW077IExZXEVs0Zjfl+biP2rPFCI3pAWuroEvQ2odlZWjiwSMTMy3G6RGWPZ4mg==
X-Received: by 10.28.150.86 with SMTP id y83mr17945286wmd.42.1517438672127;
        Wed, 31 Jan 2018 14:44:32 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id x135sm752810wmf.35.2018.01.31.14.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 14:44:31 -0800 (PST)
Subject: Re: [PATCH v2 10/14] commit-graph: add core.commitgraph setting
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-11-git-send-email-dstolee@microsoft.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <b6216601-603b-f1bd-36e6-58e9f84946d4@gmail.com>
Date:   Wed, 31 Jan 2018 23:44:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517348383-112294-11-git-send-email-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On 30/01/2018 22:39, Derrick Stolee wrote:
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e25b2c92b..5b63559a2b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -898,6 +898,9 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>  
> +core.commitgraph::
             ^^^
A small style nitpick - you may want to use "core.commitGraph" 
throughout the series (note capital "G"), making it more readable and 
aligning with the rest of `git config` variable names (using "bumpyCaps" 
as per coding guidelines[1], and as seen a few lines below, at the 
end of this very patch, too, "core.sparseCheckout").

> +	Enable git commit graph feature. Allows reading from .graph files.
> +
>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
> diff --git a/cache.h b/cache.h
> index d8b975a571..e50e447a4f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -825,6 +825,7 @@ extern char *git_replace_ref_base;
>  extern int fsync_object_files;
>  extern int core_preload_index;
>  extern int core_apply_sparse_checkout;
> +extern int core_commitgraph;
                        ^^^
Similar nit here, might be "core_commit_graph" (throughout the 
series) would align better with existing variable names around it 
(note additional underscore between "commit" and "graph"), but also 
with your own naming "scheme" used for cmd_commit_graph(), 
builtin_commit_graph_usage[], construct_commit_graph(), etc.

>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
> diff --git a/config.c b/config.c
> index e617c2018d..99153fcfdb 100644
> --- a/config.c
> +++ b/config.c
> @@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.commitgraph")) {
> +		core_commitgraph = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.sparsecheckout")) {
>  		core_apply_sparse_checkout = git_config_bool(var, value);
>  		return 0;
> diff --git a/environment.c b/environment.c
> index 63ac38a46f..faa4323cc5 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -61,6 +61,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
> +int core_commitgraph;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> 

Thanks, Buga

[1] https://github.com/git/git/blob/master/Documentation/CodingGuidelines

  Externally Visible Names
  
  ...
  
  The section and variable names that consist of multiple words are
  formed by concatenating the words without punctuations (e.g. `-`),
  and are broken using bumpyCaps in documentation as a hint to the
  reader.
