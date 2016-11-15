Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D24F2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbcKOXoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:44:07 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35503 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbcKOXoG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:44:06 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so38570354pfk.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=heMMv/A07Eykg8hzGh4uIBxEbw9UrNyiUCMDTNvHfew=;
        b=Ja1GBYCjmlpqBYM3s7uvbZxazM80rjLtEmEj/mECLEChGWDLcVaQLqTfoEFHiCC64p
         6PC/uSgKX0/TPnhFg1voK+RmWLIBf7dpyGR/dCnZ+MQ5imNrBU/eafcL+yR3Zf6RQKac
         +DDuvFbTSaQAo0XLFp457DXb1ooaDGmWae4oHDGU6SocZPmH5YhPlJwEng7gJQeCs5SR
         NXeBMTuZ26OdDKukMhhyY7SLPS5Pz+luFcv3BlCiScFWaGivK752IY3dq9YgpFMhwCnB
         b9XrpXIWEVEPH/ltbFeHPTQuLMFWfi1vOYOEUM8TMy23r6VKPneYkhOI9F12zuEyWkHw
         72Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=heMMv/A07Eykg8hzGh4uIBxEbw9UrNyiUCMDTNvHfew=;
        b=XkRO7YSovyUprJqOFumm9Mw36H/EAxkFdvFaaJZ30w0iaiJbAKppwyoyG8n5Qb4NXG
         8PQRNh+DAeh/7KGCt7mcT7cVZY8m9ftnnfh2cIt9Rs2TBtFD1uZ9ru/d3qUfVD1getz3
         0dUlzswKQv4LXO9InrmsfM8WkPbd0Wb6XWMw/rWa/z3o9D/T0kXeejR+gJClbbN1I9V/
         UKYOVRI2PyqEy0Kk/od/pYArlN6n2nvcojoRqqIlnUqXmmz+0ZQKVASorHpv0oT2yV5C
         SC/DF61yMkcVyw+sMeM1HJiuV0up6tZxGIBaKVvueExEGp3iwAUcJtmefUSRS1bMlpNr
         ZXyA==
X-Gm-Message-State: ABUngvdQ/SnqlwcLZ1wVEI9gVqEVw2NeM+6aGwy/CsCVV/dAEbl++e9uiFh8xnxHESQVJCgC
X-Received: by 10.99.124.66 with SMTP id l2mr1466624pgn.116.1479253445450;
        Tue, 15 Nov 2016 15:44:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id l7sm46473349pfg.35.2016.11.15.15.44.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:44:04 -0800 (PST)
Date:   Tue, 15 Nov 2016 15:44:03 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
Message-ID: <20161115234403.GE66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-9-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-9-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> Implement the functionality needed to enable work tree manipulating
> commands to that a deleted submodule should not only affect the index

"to that a deleted"  did you mean "so that a deleted"

> (leaving all the files of the submodule in the work tree) but also to
> remove the work tree of the superproject (including any untracked
> files).
> 
> To do so, we need an equivalent of "rm -rf", which is already found in
> entry.c, so expose that and for clarity add a suffix "_or_dir" to it.
> 
> That will only work properly when the submodule uses a gitfile instead of
> a .git directory and no untracked files are present. Otherwise the removal
> will fail with a warning (which is just what happened until now).

So if a submodule uses a .git directory then it will be ignored during
the checkout?  All other submodules will actually be removed? Couldn't
you end up in an undesirable state with a checkout effecting one
submodule but not another?

> diff --git a/cache.h b/cache.h
> index a50a61a..65c47e4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
>   */
>  void safe_create_dir(const char *dir, int share);
>  
> +void remove_subtree_or_die(const char *path);
> +
>  #endif /* CACHE_H */

Should probably place an explicit 'extern' in the function prototype.

> +int depopulate_submodule(const char *path)
> +{
> +	int ret = 0;
> +	char *dot_git = xstrfmt("%s/.git", path);
> +
> +	/* Is it populated? */
> +	if (!resolve_gitdir(dot_git))
> +		goto out;
> +
> +	/* Does it have a .git directory? */
> +	if (!submodule_uses_gitfile(path)) {
> +		warning(_("cannot remove submodule '%s' because it (or one of "
> +			  "its nested submodules) uses a .git directory"),
> +			  path);
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	remove_subtree_or_die(path);
> +
> +out:
> +	free(dot_git);
> +	return ret;
> +}

-- 
Brandon Williams
