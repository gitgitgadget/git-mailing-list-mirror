Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981501F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeCYRTs (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:19:48 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50679 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753812AbeCYRTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:19:47 -0400
Received: by mail-wm0-f51.google.com with SMTP id i75so11357120wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NiraSuS5nPOgrWiAVAr7y2/SnrukNzlUuo/IT275PbE=;
        b=Wh7G7FMlc1YKudFq7lAXixGG83ZCwlMddRy0EM+wpAG2JruQaMhQEx0JFE8xmDx+DF
         9hHWs9sPnJNQt2o2DfoAZtwXV1bszCLRs6CkFtXCCp3Gre2VuKgkR4aHcdF/eS8KEamC
         fYZEDvMb72COwF3K9DkB3MeIDKlT2T1GqBz0KxP52l4yk+U0rN3sVIeLgUfoqLkrYiT7
         L95A30sQrKE65EwZjM67+4aEYoLCdsaFhPPy1H661D+qxyVVfFo3Re+dLE1SezzXzr9M
         9AfeZX0fsU/DC+GvjdzPjI9FUw07pMUZipcZpKl2aXLPtmpc0MRxTJ/pDNO5gYqdUReZ
         VbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NiraSuS5nPOgrWiAVAr7y2/SnrukNzlUuo/IT275PbE=;
        b=XkrfHRLATnOGd1qetqIrtCIjyaHp1Za4PdjwICmmedX1AhSLkbAiErKuVleQYWYEIu
         IW/gm1AgdxrqASEX1htw1GgXi/eNreOg7XIpdHc/JUtQJYcd1X5xDXCh5b+y81DvwEWo
         8KNe9msFVfS9ifi0c+tkG4cHvxqkSMIglCosTHEvV3Q0B/bdYY/DHjzMZ4enaMmyTBKX
         EHx96lEzlOcIExyIqXrSf1s0uMBIhXdmzl8toIgwAqqREeg31P8sv6uwKl0M7zulSZPR
         tI1pGLNwm/K4fDFM/UuTtoKg9NSI7cyIKtIfmLeG0dNwywtjySFDt/TEe/rpmoSXUrqp
         Vg0Q==
X-Gm-Message-State: AElRT7Ft7VfrUOkgwQ09PuWvjGq8DmFoLQRGr81N2xtMRf9B66bNZiny
        AXgFsrhp5lPXPWoVNaNrvc4=
X-Google-Smtp-Source: AIpwx48U7wVk0Ip2uEgtM4P7Dh1B4Ji3mNE/E6CGtv20kvqiWacVXAeXU1NcBt+IjnH2dbrrnSpgTg==
X-Received: by 10.28.74.91 with SMTP id x88mr1269201wma.53.1521998386483;
        Sun, 25 Mar 2018 10:19:46 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p19sm23238029wrb.75.2018.03.25.10.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 10:19:45 -0700 (PDT)
Date:   Sun, 25 Mar 2018 18:23:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
Message-ID: <20180325172309.GC10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net>
 <20180324173707.17699-2-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324173707.17699-2-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Joel Teichroeb wrote:
> ---
> [...]
> +
> +static const char *ref_stash = "refs/stash";
> +static int quiet;
> +static char stash_index_path[PATH_MAX];
> +
> +struct stash_info {
> +	struct object_id w_commit;
> +	struct object_id b_commit;
> +	struct object_id i_commit;
> +	struct object_id u_commit;
> +	struct object_id w_tree;
> +	struct object_id b_tree;
> +	struct object_id i_tree;
> +	struct object_id u_tree;
> +	const char *message;
> +	const char *revision;
> +	int is_stash_ref;
> +	int has_u;
> +	const char *patch;
> +};
> +
> +static int get_stash_info(struct stash_info *info, const char *commit)
> +{
> +	struct strbuf w_commit_rev = STRBUF_INIT;
> +	struct strbuf b_commit_rev = STRBUF_INIT;
> +	struct strbuf w_tree_rev = STRBUF_INIT;
> +	struct strbuf b_tree_rev = STRBUF_INIT;
> +	struct strbuf i_tree_rev = STRBUF_INIT;
> +	struct strbuf u_tree_rev = STRBUF_INIT;
> +	struct strbuf commit_buf = STRBUF_INIT;
> +	struct strbuf symbolic = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +	const char *revision = commit;
> +	char *end_of_rev;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	info->is_stash_ref = 0;
> +
> +	if (commit == NULL) {
> +		strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
> +		revision = commit_buf.buf;

Before setting up the revisions here, as is done below, we used to
check if a stash even exists, if no commit was given.  So in a
repository with no stashes we would die with "No stash entries found",
while now we die with "error: refs/stash@{0} is not a valid
reference".  I think the error message we had previously was slightly
nicer, and we should try to keep it.

> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
> +		revision = commit_buf.buf;
> +	}
> +	info->revision = revision;
> +
> +	strbuf_addf(&w_commit_rev, "%s", revision);
> +	strbuf_addf(&b_commit_rev, "%s^1", revision);
> +	strbuf_addf(&w_tree_rev, "%s:", revision);
> +	strbuf_addf(&b_tree_rev, "%s^1:", revision);
> +	strbuf_addf(&i_tree_rev, "%s^2:", revision);
> +
> +	ret = !get_oid(w_commit_rev.buf, &info->w_commit) &&
> +		!get_oid(b_commit_rev.buf, &info->b_commit) &&
> +		!get_oid(w_tree_rev.buf, &info->w_tree) &&
> +		!get_oid(b_tree_rev.buf, &info->b_tree) &&
> +		!get_oid(i_tree_rev.buf, &info->i_tree);
> +
> +	strbuf_release(&w_commit_rev);
> +	strbuf_release(&b_commit_rev);
> +	strbuf_release(&w_tree_rev);
> +	strbuf_release(&b_tree_rev);
> +	strbuf_release(&i_tree_rev);
> +
> +	if (!ret)
> +		return error(_("%s is not a valid reference"), revision);

We used to distinguish between "not a valid reference" and "not a
stash-like commit" here.  I think just doing the first 'get_oid'
before the others, and returning the error if that fails, and then
doing the rest and returning the "not a stash-like commit" if one of
the other 'get_oid' calls fails would work, although I did not test it.

> +
> +	strbuf_addf(&u_tree_rev, "%s^3:", revision);
> +
> +	info->has_u = !get_oid(u_tree_rev.buf, &info->u_tree);
> +
> +	strbuf_release(&u_tree_rev);
> +
> +	end_of_rev = strchrnul(revision, '@');
> +	strbuf_add(&symbolic, revision, end_of_rev - revision);
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "rev-parse", "--symbolic-full-name", NULL);
> +	argv_array_pushf(&cp.args, "%s", symbolic.buf);
> +	strbuf_release(&symbolic);
> +	pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +
> +	if (out.len - 1 == strlen(ref_stash))
> +		info->is_stash_ref = !strncmp(out.buf, ref_stash, out.len - 1);
> +	strbuf_release(&out);
> +
> +	return 0;
> +}
> +
> [...]
