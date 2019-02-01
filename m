Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C2B1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBAWyL (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:54:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37178 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfBAWyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:54:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so8769173wrt.4
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=g67urDzYO0ltV8T/0568DCkZ701wdH8o+YE9yu2j4bo=;
        b=DBVzyoAvcB6ipFQj8/INHcb6t2QbsONDWeccOhLP8wLLUeo3GNLd5HrKXPNqBSqR2f
         F9/xgv9/+VL6owhKV87db9cTdW7Kd8YVVI86Lu90WYCFV/rZCZa409LhPDCs4XsQg3yX
         jTXQIWASPVnHM0BPNBTWpt0HGho7wK7sIOgGZ/JN9K3s9IBqUKcgoWeJUvlyyaVN9zn3
         q8gu0WNnV1Y6KPBLcgyom6FNsANEhUetq+mjOBV9N/yeo6I6jJanxRDSc7Bgogy6l2pK
         BWz0Dp1WKWJF4NgJchhvUMAUUo8rBERUVBJLgyWmj/DAlD2pukMLQD2fs9jLQwyhM/s5
         3e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=g67urDzYO0ltV8T/0568DCkZ701wdH8o+YE9yu2j4bo=;
        b=HCJdpkKNsMY1ipaVsmtUKM2xbH0p4gcfHbTN1itSn+oapOvPmA46jjWFTvvcvoFbYb
         R7vLAEoM15DQrTTg/yHIpKPD6lASPL74+CNkcEkeZNCjXrjtJg0oMRjvhX13vTIFRoR2
         bZcpmg5LdXcqGC3Dn0jpzQDJvnigtOouMmiA6CRl8dllHbDMPWtOdpcKdgpNKhsKC680
         Yn7XCPcCGYKkeu6VG8rex/Odq8uxp2cCP6y5Owr8U36pOpeoangrRawQ13vgs3cTBO0A
         W4ej27K/C19EybsxwjpqW9kEiQ4V80eW2m48klnL4A06XU+oVfX7gr7MK1y6dM5U3Ow7
         bXpQ==
X-Gm-Message-State: AJcUukcgK/jWIILc/SgTpaVFdG8piOLMDkryKgO6V6WhfEwe2RCoPa54
        dloZNj62Wrpc+j+j4exAhzw=
X-Google-Smtp-Source: ALg8bN44FrCMuJ2e6OFE5iFt3QQ1p0QWBxu4+/fCL8zxB3NcI+R162voGdUn9uWTe/g3xDm70Ay7xQ==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr42266183wrn.142.1549061649066;
        Fri, 01 Feb 2019 14:54:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m15sm12615070wrr.95.2019.02.01.14.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 14:54:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v7 1/3] ref-filter: add worktreepath atom
Date:   Fri, 01 Feb 2019 14:31:32 -0800
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
        <20190201220420.36216-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-2-nbelakovski@gmail.com>
Message-ID: <xmqqr2crw25r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

> +static void lazy_init_worktree_map(void)
> +{
> +	if (ref_to_worktree_map.worktrees)
> +		return;
> +
> +	ref_to_worktree_map.worktrees = get_worktrees(0);
> +	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
> +	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
> +}
> +
> +static char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
> +{
> +	struct hashmap_entry entry;
> +	struct ref_to_worktree_entry *lookup_result;
> +
> +	lazy_init_worktree_map();
> +
> +	hashmap_entry_init(&entry, strhash(ref->refname));
> +	lookup_result = hashmap_get(&(ref_to_worktree_map.map), &entry, ref->refname);
> +
> +	if (lookup_result)
> +		return xstrdup(lookup_result->wt->path);
> +	else
> +		return xstrdup("");
> +}

Makes more sense than the previous round; much simpler to have
lazy-init in this function.

Thanks.
