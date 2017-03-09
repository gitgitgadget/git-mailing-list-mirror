Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEFC202C1
	for <e@80x24.org>; Thu,  9 Mar 2017 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbdCIXnW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 18:43:22 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36648 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbdCIXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 18:43:21 -0500
Received: by mail-pg0-f51.google.com with SMTP id g2so14469393pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+UbeTnTBP5+kJ6HObis536DBrUCqvXPIlYZ1QemgP8=;
        b=c2gvzBV/BUq0ckbrq+1/osPzx+ohgBglFQnYteQvu9dJ9vja0FUrDt/edbniCM4ogc
         Qg5YBnycvfUDCiBxTU15+vh1FwxLgNTpfPCf20SG42U8M1iy/IOvWBSr1ytaOJEvvBNV
         WTKlfbWCAkHl3hY6qrTAMHEPyHMNl/FfuXR/UBTKbvrAYITyFea0M8y7Z+fHzVydpIsj
         eyMq86S8RuN6qzOH7bIYvhstqyMkLDEYSUJWR9hKOq1JAeRw4kV4EFVF4CsHtiZSTv56
         8xmgkkloWI6X/k+cJLUId+jTcDKYS/qsFIuQcQviiPuzU9cqkbcmEFPTAbrlGuojtym2
         f6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+UbeTnTBP5+kJ6HObis536DBrUCqvXPIlYZ1QemgP8=;
        b=qp+3Q3xamVmce5lY835bH8VUhFJmT/rSyThC2Puhf/i08fyysvm1Hc6AjCkepqTkO4
         J9bee7pgium5bP3L7LSSgCrutGxe4uBBi5Qy3afANIt8HOwuaA7Y9bEtaNTcMLGQoJd6
         10MrxVVYp8wQRTYqV+/tjNpNgxn6b9hl+uAsPyJZYB3GLkkeWPscODu2u0IGxqIiQmUE
         QOnXREZDiOUUR2c28dBjH/wbpsoAKMB2UsL771lQrqkLUGm5HZkVnPbaWLuwRUVKWY1x
         LYUiDnK38lkBDa6L0gbKoNQHo5WijGejawSykgy7Wr1tBQCbPNDTeeEraupCchGD3tCS
         rP1A==
X-Gm-Message-State: AMke39ky65I+FQeWVWzdTrwllpkycU6x30h4IH6f1l0waEoeqdRBPP2MNRTGE6xn2yUr1S/1
X-Received: by 10.99.123.27 with SMTP id w27mr16837965pgc.155.1489103000065;
        Thu, 09 Mar 2017 15:43:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id 187sm14524948pff.17.2017.03.09.15.43.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 15:43:18 -0800 (PST)
Date:   Thu, 9 Mar 2017 15:43:17 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 12/17] update submodules: add submodule_move_head
Message-ID: <20170309234317.GF52558@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
 <20170309221543.15897-13-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309221543.15897-13-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Stefan Beller wrote:
> +/**
> + * Moves a submodule at a given path from a given head to another new head.
> + * For edge cases (a submodule coming into existence or removing a submodule)
> + * pass NULL for old or new respectively.
> + */
> +int submodule_move_head(const char *path,
> +			 const char *old,
> +			 const char *new,
> +			 unsigned flags)
> +{
> +	int ret = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const struct submodule *sub;
> +
> +	sub = submodule_from_path(null_sha1, path);
> +
> +	if (!sub)
> +		die("BUG: could not get submodule information for '%s'", path);
> +
> +	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
> +		/* Check if the submodule has a dirty index. */
> +		if (submodule_has_dirty_index(sub))
> +			return error(_("submodule '%s' has dirty index"), path);
> +	}
> +
> +	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
> +		if (old) {
> +			if (!submodule_uses_gitfile(path))
> +				absorb_git_dir_into_superproject("", path,
> +					ABSORB_GITDIR_RECURSE_SUBMODULES);
> +		} else {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "%s/modules/%s",
> +				    get_git_common_dir(), sub->name);
> +			connect_work_tree_and_git_dir(path, sb.buf);
> +			strbuf_release(&sb);
> +
> +			/* make sure the index is clean as well */
> +			submodule_reset_index(path);
> +		}
> +	}
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);

Missed this one too.  Same question as the other spot.


-- 
Brandon Williams
