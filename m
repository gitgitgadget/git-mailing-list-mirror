Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E031F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBFK7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:59:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38425 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfBFK7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:59:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so2734977pgc.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 02:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gImO1DLPQyeF7zsCyCu7jJlv0GiDLMYvRsiVh9F/idc=;
        b=VxBMQTvkS/ByfCcXw/4L+v1OIJIJl1xEqDte4R8ym7TGYMmG4CmYJIOyyBm2S5u/J/
         z/MGSdwtT9JeBeJMHbt00ePe+Fdv2AqKHG+bbpaWvQiOt5f0b/az/ET4Qk1EIHoUQwCP
         BVQ/wV1x3u7G7MiUm0P4NPwb9Msj44yqjNJSfG1e4NJuwIYVat0/o3sFs5G+qQ2BsQRk
         Wo8aSzKCCUIqSb2gssazUrCR5vqMLQtu/4iN2vNonqgJkISd/Nhfoaux20lSx0mN+biB
         mGCofMobfvbnatRPvVN2Scd5VUaPptYjiuq4dy7ne0RGZ+obG3w/6IsfuEbLfTt8be75
         SBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gImO1DLPQyeF7zsCyCu7jJlv0GiDLMYvRsiVh9F/idc=;
        b=WHCEDD0HpvTksdiFex/gcQPJMNfPi50dsIOpf7XfZL6bIBmQ+vfg2a/XqgpudlzrR0
         0vGU5WCiRE0cpgxR63ob6u/Lc3qO60NDt3WPn2awkDLJNZF0c3dfx2LAT6l9d5vMSFCl
         De6pCJwF4R6kNcYT0r/a8ME3wWbIlM3ETobyCzaHm5WBpN6K0tAFa3oQyeyXo8fvtyv4
         CRfBdx+F+I1E1ON6NND4FeYOCKQl6If0qvaV63U4Wb2mL3SQtb1rQXvMTfIzuJH90/Sa
         b134KWaYB1IlTyiNWGDiF/OwUvumuOK+3Fbf1CFHIv+3glUQ0ulcdZCETJnAPm+wjYtO
         jhWg==
X-Gm-Message-State: AHQUAuYhazmhXx4CyNUdXF9UHcoakUkZHLWv17+SYfy1l5wDcPSSayrS
        1+hOhHBDdsurjLbaDkqAkLd5VhbV
X-Google-Smtp-Source: AHgI3IbE+vdA0HLlil7q76v9B/yyWAYyiF62Ofo+XatAb+zh0bu22EQtIcaWNlc1RGMdbqj2JOAHuA==
X-Received: by 2002:a63:193:: with SMTP id 141mr9112841pgb.136.1549450791970;
        Wed, 06 Feb 2019 02:59:51 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id o6sm6070904pgp.59.2019.02.06.02.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:59:50 -0800 (PST)
Date:   Wed, 6 Feb 2019 02:59:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 0/3] Teach submodule set-branch subcommand
Message-ID: <cover.1549450636.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there is no way to set the branch of a submodule without
manually manipulating the .gitmodules file. This patchset introduces a
porcelain command that enables this.


Denton Liu (3):
  git-submodule.txt: document default behavior without --branch
  submodule--helper: teach config subcommand --unset
  submodule: teach set-branch subcommand

 Documentation/git-submodule.txt        | 10 ++-
 builtin/submodule--helper.c            | 15 +++--
 contrib/completion/git-completion.bash |  5 +-
 git-submodule.sh                       | 75 +++++++++++++++++++--
 t/t7411-submodule-config.sh            |  9 +++
 t/t7419-submodule-set-branch.sh        | 93 ++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 10 deletions(-)
 create mode 100755 t/t7419-submodule-set-branch.sh

-- 
2.20.1.522.g5f42c252e9

