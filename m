Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7B61F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGKS4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:18:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:18:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so156959pfe.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzD/OjUfW8hKk0q0f1A+w2i/cRvc85u9eD3CjG67Zmg=;
        b=VT/TMoarzyka/oI4olgAr4WdrPhsaqbcAgaU9F4/RnKiZ1VuGyImcURbzBDV4bhMC9
         S3yI4u5Csy9jQUjizxEuMvI73AQI581ouyw4k65Vmxd6GpsHf53fkNNvlOc7/BPxIxoX
         8brBXwGgloGIj+3Ux3hBTpBQZUDIJ0pkSQ359C0GvcqS9Pcbm5jQj5rb90NvmDIeDVFt
         bWj/NoJsfrsTumQFlC9u0ujKeaLyadJ9zXbyBZXUIGMwLlDt3OnaCaG2WP18uvWs/Dax
         /hSNTXgDy2Z4iap/C4tj7DmH9YmFsR4gd6scPdVZmugcp6+8RHX1o0/Wa/MaMeeNU8ur
         lTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzD/OjUfW8hKk0q0f1A+w2i/cRvc85u9eD3CjG67Zmg=;
        b=q2ZqT9U9gSWV+EmHnvilyQpW2+BfmA5BgBLJmfCYNh/kZNAqixKpBJ7TfauXH1pK/o
         O9zyunxURLEOHEd0SrxApqdpVpdM3d4buQ0ksQCl03espZyDTeql4n9mKhEOCTSdHjgB
         BpnBwwZVcPur9WNSHXxlSJG3X1dumvJZNovqb3sbENysC81yq/cyrdUB88i3Jutz83zv
         Js+viNQOZbnTtZVetzA2tDz4WcFJv70ECcLy7l5IvuhEPkkT28Ka6jPVSdKzpmbwGjJ6
         fpLgLXgRzuyhH83YKH7FWc6hznFRAPl3xsFk9W4ZIV6mKp0H+TOnzhu5A1FmZXe9VOhL
         3GMg==
X-Gm-Message-State: AHQUAuaklAUUV24vRRtCEwTGnhAjeXod9sjltHCqle02dhW5v3gCXfQC
        2Ug2ytMrBD6v6jL8AlghLynAGRrB
X-Google-Smtp-Source: AHgI3IZ/yaW/oklodZmb846Uoe5iLG2BBlKQdSQhSdSmZFxhyMp2XCWlleP/nrnxL97xE8Aa19Xt5Q==
X-Received: by 2002:a62:3888:: with SMTP id f130mr15115665pfa.132.1549534734909;
        Thu, 07 Feb 2019 02:18:54 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c13sm13218311pfe.93.2019.02.07.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:18:53 -0800 (PST)
Date:   Thu, 7 Feb 2019 02:18:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 0/3] Teach submodule set-branch subcommand
Message-ID: <cover.1549534460.git.liu.denton@gmail.com>
References: <cover.1549521103.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549521103.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I rebased the changes onto the latest 'next' because if this branch gets
merged into 'next', there'll be merge conflicts from
'dl/complete-submodule-absorbgitdirs'.

Currently, there is no way to set the branch of a submodule without
manually manipulating the .gitmodules file. This patchset introduces a
porcelain command that enables this.

Changes since v1:
	* Fixed incorrect usage of OPT_CMDMODE

Changes since v2:
	* Corrected missing argument for -b/--branch in git-submodule.txt
	* Rebased onto latest next


Denton Liu (3):
  git-submodule.txt: "--branch <branch>" option defaults to 'master'
  submodule--helper: teach config subcommand --unset
  submodule: teach set-branch subcommand

 Documentation/git-submodule.txt        | 14 +++-
 builtin/submodule--helper.c            | 18 +++--
 contrib/completion/git-completion.bash |  5 +-
 git-submodule.sh                       | 75 +++++++++++++++++++--
 t/t7411-submodule-config.sh            |  9 +++
 t/t7419-submodule-set-branch.sh        | 93 ++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 14 deletions(-)
 create mode 100755 t/t7419-submodule-set-branch.sh

-- 
2.20.1.522.g5f42c252e9

