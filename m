Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_SPF_TEMPERROR
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA3C208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 10:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHGND6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 09:03:58 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39751 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeHGND6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 09:03:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id q8-v6so17672588wmq.4
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hFVyoaJ7QFSo6e45YFOHe0w6cxlYmm+7Rj0Ll9/79SE=;
        b=bzRmhC4Yj9QMRcsj5u799G4ttN/LluizKoOyly3zScOMjVRP9XOEpltyzz4fkNLpXt
         ixqP/qZPR9f/hq8KA03LkGEXUJ6JxRUUBVkjq/nikSpJ09e1mte8AE9WDXSJUzaqik7C
         oZE/pFH2za5vWQoh9tWA4eqPgmKa1rmsQEEY8rZJSrTPSv1E3VIamV7Q4lOE7XUaaYx/
         Gda7fh5CK++Ft4GlKl5G97r2yb51GqtP1Tlc/pfJZcoxYRNFulY76MSFjXPPOwJegK8z
         NYeK6kfd/MDUmsSiFIhXKTSrkO4K6of0+LkmBPRRuipZA1rb18a7dLi3YZnHzOGg9uf4
         HY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=hFVyoaJ7QFSo6e45YFOHe0w6cxlYmm+7Rj0Ll9/79SE=;
        b=KqtoMftbDSAa8bR7j5TyIdFY1OPj08UcekgbjrL+QGCH9Bfl/JgyQdiIzlgLBwZ3cM
         y4pAQlgeM4WEMkLsSF8l+Vn6j2DWEkybeOtt6R/DlLz4PicEMPdP0Nj8R3zC5McNe6n/
         WDuOapD5AyaQyHIKgGoCepbkLHr2piSNJybvJNTVhcNgqZOtAblFiGbest/rkJTt4a2T
         /2uOyUOSrcnWSglyhMAYfMSB+VpV3JBf96yU5zmfnNJvsKYTNA6KrlIBWxqyhsqaTa6b
         LCz8f2NFH3dEvH7OFYJ3i0X0NnpuOK843XqhtA5ShfSxo06wCc6WJmNVzMJjyoIphlD3
         gIeA==
X-Gm-Message-State: AOUpUlEPh/HHedgjRAENev1ErZ2zuUel2Ao6FZRinhcMeK7mg/ZJXNQ2
        Nt92SOkvQ6+18FsMmj9WIVM=
X-Google-Smtp-Source: AA+uWPxFkCgrE6TTNl/RO/it1pNon93OjuU21gGpfaAxYDIL2Hr8UU8aI/vt2wqaGW3W9+Ndq0sRyA==
X-Received: by 2002:a1c:acc3:: with SMTP id v186-v6mr1357565wme.69.1533639012043;
        Tue, 07 Aug 2018 03:50:12 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egd2.neoplus.adsl.tpnet.pl. [83.21.67.2])
        by smtp.gmail.com with ESMTPSA id z141-v6sm2296825wmc.3.2018.08.07.03.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 03:50:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 07 Aug 2018 12:50:06 +0200
In-Reply-To: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 02 Aug 2018 16:02:36 -0700")
Message-ID: <86effapi1t.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>   (merged to 'next' on 2018-08-02 at 0ee624e329)
>  + commit-graph: close_commit_graph before shallow walk
>  + commit-graph: not compatible with uninitialized repo
>  + commit-graph: not compatible with grafts
>  + commit-graph: not compatible with replace objects
>  + test-repository: properly init repo
>  + commit-graph: update design document
>  + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>  + refs.c: migrate internal ref iteration to pass thru repository argument
>
>  The recently introduced commit-graph auxiliary data is incompatible
>  with mechanisms such as replace & grafts that "breaks" immutable
>  nature of the object reference relationship.  Disable optimizations
>  based on its use (and updating existing commit-graph) when these
>  incompatible features are in use in the repository.
>
>  Will merge to 'master'.

Derrick wrote that he will be sending v2 of this patch series in a few
weeks, among others to make it use commit-graph feature if replace
objects are present but not used (as some git hosting services do, see
core.useReplaceRefs below).

Also, the test for interaction of commit-graph with the grafts file
feature does not actually test grafts, but replace objects.

> * jk/core-use-replace-refs (2018-07-18) 3 commits
>   (merged to 'next' on 2018-08-02 at 90fb6b1056)
>  + add core.usereplacerefs config option
>  + check_replace_refs: rename to read_replace_refs
>  + check_replace_refs: fix outdated comment
>
>  A new configuration variable core.usereplacerefs has been added,
>  primarily to help server installations that want to ignore the
>  replace mechanism altogether.
>
>  Will merge to 'master'.

Nice to have features used in the wild merged into core git.

--=20
Jakub Nar=C4=99bski
