Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25DB20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbdCIBJm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:09:42 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34192 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754641AbdCIBJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:09:42 -0500
Received: by mail-pf0-f180.google.com with SMTP id v190so21634489pfb.1
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BuSdc2ewe/NMzqq2tXTJEKgKWEecBfirA4C3lMb1GoE=;
        b=bTAsfNNxF0KRjdu1sXofQ9a+BtKY6wwSjrO34L8k+kr1b9EPChmTDcdTQ0sAWTM37d
         QkbKildBgUvWN6mY94fNcMM72TyIQ6XOFuYTLkzdg0hKluRyETuhy01LC6UEN+bpQHrg
         21aekQi1teC9vtaEu0tFdazF0FY6K0/e3tDoWNr0qPtLYQlacA0kt4yQKcIf/ZFaM/hU
         TTjtGMkuvJT0vrjytucPkdKkE0dr2naDYdYOZAMa/CZRDuy/JRsLFHiAagPuW58596vU
         zT1W6mV+SXdY8U5L0WENg2FNPTgIfeVpKjV9cTBokhQSLDS5kZKfzmCHv3C/LgSsTAz5
         svSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BuSdc2ewe/NMzqq2tXTJEKgKWEecBfirA4C3lMb1GoE=;
        b=miDo135N/OaZnXV7zoEU1eU7djeypflrRYVJt4hO0/uUVgmVkZm7dXuokBKuOLK8/j
         7i1Q8K39gdhbu24xT9EHlTMM0BJFRRC50qVuv2Z6ZJ/jR4CeOYDIQ+OaoQH5vwLlmS8f
         OG0Dx1kNEabQNCZHMNLhav9sAwv0ssAPZgKmbLIldB5rskKd1fprrQIBj0MbLsy0hA7c
         /sfxeLq4ARzpQQ2tNO7nKSLvwSJqK8jvoFiVaW/iiBAsxsHmA+5zDiBcUeCD4Nag8OFk
         k1G77bgYGWl/vKLSGkiq5CbbfrXNcxkljoVhpZzkfzJWKxLTBCFUfL927QbvpHpH1pGO
         YAVQ==
X-Gm-Message-State: AMke39m5SvuQ+xS276WO9ijqRYsDkPB4CzP8osxSaAzE03m2sTYPEsjqpywfSwBedwSbfFgy
X-Received: by 10.98.27.204 with SMTP id b195mr10417065pfb.154.1489019941058;
        Wed, 08 Mar 2017 16:39:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cdd8:47c3:cffc:85d3])
        by smtp.gmail.com with ESMTPSA id q194sm8292658pfq.43.2017.03.08.16.38.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 16:38:59 -0800 (PST)
Date:   Wed, 8 Mar 2017 16:38:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/2] submodule--helper.c: remove duplicate code
Message-ID: <20170309003858.GB153031@google.com>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
 <20170309000352.18330-1-me@vtolstov.org>
 <20170309000352.18330-3-me@vtolstov.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309000352.18330-3-me@vtolstov.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Valery Tolstov wrote:
> Remove code fragment from module_clone that duplicates functionality
> of connect_work_tree_and_git_dir in dir.c
> 
> Signed-off-by: Valery Tolstov <me@vtolstov.org>

Patch looks good all the tests pass when running this on top of
Stefan's checkout series 'origin/sb/checkout-recurse-submodules'.
There is still one more bit of cleanup that you can do.

> ---
>  builtin/submodule--helper.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 899dc334e..405cbea07 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -579,7 +579,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	const char *name = NULL, *url = NULL, *depth = NULL;
>  	int quiet = 0;
>  	int progress = 0;
> -	FILE *submodule_dot_git;
>  	char *p, *path = NULL, *sm_gitdir;
>  	struct strbuf rel_path = STRBUF_INIT;

rel_path is no longer used so it and the call to strbuf_release() to
free its memory can be removed.

-- 
Brandon Williams
