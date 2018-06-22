Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740261F516
	for <e@80x24.org>; Fri, 22 Jun 2018 22:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbeFVWeg (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 18:34:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38669 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933310AbeFVWef (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 18:34:35 -0400
Received: by mail-it0-f66.google.com with SMTP id v83-v6so4960817itc.3
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9Ma5U0w4vrsp0RbQZ2fIR+Om/+RH6aMJjr6wzsXA6Y=;
        b=RvkrGHAeiIKXVBMZo3kSSAhSD2MMDF3O0pQRoDy7+uzAFF55F/NOScVdOTGzSiXcaf
         MJq+D88683WDrC2Z9cSrv7Wsk+N3BGHXtgWb3cEfQrRGRlWuhmCYxpx5u84OFrUHHRgK
         ql0twB3EMkvI/URjAh4aTqZgIeBKFC8duPjHu6V5ZQMiSKKE8pRREbNOhB0HOefrL2oX
         TvSo68yiytkquXBoQuhPN11lDE8Sas3uoRf8N4g/caYQBg2qtiwD5VW7Z/Ga6aWYceil
         NnN/TuxEjOlermi02x+AVn5ir/Nr2NLrUyewUER23OQwVtE9J8VTqYiM+ymsnJJjiYhQ
         2jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9Ma5U0w4vrsp0RbQZ2fIR+Om/+RH6aMJjr6wzsXA6Y=;
        b=oRApmgpbKq+715yFwFL37Ep9+mkT8gajilqw+23d44Mn9DUl06RxbJkNTB2/s75Eva
         Ubzn7UVhSuClaewbMaigvwmQssIz6R4wDqXj2FUc46sE9gBtL743eda1Uq51PbpRZtq1
         EqkDCQOYDwQU9mppdxxgZmlrag9zdLprnXwc/fvp+8FiuVspkZYpNorRe1PmLbywVLWa
         4FsSlMKoegpJB1vTICiHOQK3nG68RqSkv/vYMBkesKLl9+tcGzm/dtykjM7kO+rdbdAq
         MUOCYDT+oIyvoNpT3pbUKfvtl/RooSQsH8fvhGhccZ9sUg+CI3p7h8iG7FwPy3SOv2ZN
         e6iQ==
X-Gm-Message-State: APt69E1woJFdVkdHEwmiTUJQVM2IifKrb7JSHrFmOTil2alp3zJY37tg
        YD048Oyod/ZjQWzaznwNFlHIzg==
X-Google-Smtp-Source: ADUXVKLbhcID1vqRdpP2I+rZXjQX379ZBXUo+YGpIf5dpDaEWU1ImJWaBzFADNCwpYcWeKEAnzvPrw==
X-Received: by 2002:a24:8605:: with SMTP id u5-v6mr1919786itd.152.1529706874958;
        Fri, 22 Jun 2018 15:34:34 -0700 (PDT)
Received: from flurp.local (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o18-v6sm3599338iod.19.2018.06.22.15.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 15:34:34 -0700 (PDT)
Date:   Fri, 22 Jun 2018 18:34:28 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] branch: deprecate "-l" option
Message-ID: <20180622223428.GA23440@flurp.local>
References: <20180622092327.GA8361@sigill.intra.peff.net>
 <20180622092414.GC13573@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622092414.GC13573@sigill.intra.peff.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 05:24:14AM -0400, Jeff King wrote:
> Let's deprecate "-l" in hopes of eventually re-purposing it
> to "--list".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> @@ -36,6 +36,7 @@ static const char * const builtin_branch_usage[] = {
> +static int used_deprecated_reflog_option;
> @@ -573,6 +574,14 @@ static int edit_branch_description(const char *branch_nam> +static int deprecated_reflog_option_cb(const struct option *opt,
> +				       const char *arg, int unset)
> +{
> +	used_deprecated_reflog_option = 1;
> +	*(int *)opt->value = !unset;
> +	return 0;
> +}
> @@ -615,7 +624,13 @@ int cmd_branch(int argc, const char **argv, const char *p> +		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
> +		{
> +			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
> +			N_("deprecated synonym for --create-reflog"),
> +			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
> +			deprecated_reflog_option_cb
> @@ -688,6 +703,11 @@ int cmd_branch(int argc, const char **argv, const char *p> +	if (used_deprecated_reflog_option && !list) {
> +		warning("the '-l' alias for '--create-reflog' is deprecated;");
> +		warning("it will be removed in a future version of Git");
> +	}

I wonder if it would be better and cleaner to limit the visibility of
this change to cmd_branch(), rather than spreading it across a global
variable, a callback function, and cmd_branch(). Perhaps, like this:

--- >8 ---
diff --git a/builtin/branch.c b/builtin/branch.c
index 5217ba3bde..893e5f481a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -584,6 +584,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
+	int deprecated_reflog_option = 0;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -615,7 +616,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
-		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
+		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
+		OPT_HIDDEN_BOOL('l', NULL, &deprecated_reflog_option,
+				N_("deprecated synonym for --create-reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
@@ -688,6 +691,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	if (deprecated_reflog_option && !list) {
+		reflog = 1;
+		warning("the '-l' alias for '--create-reflog' is deprecated;");
+		warning("it will be removed in a future version of Git");
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
--- >8 ---
