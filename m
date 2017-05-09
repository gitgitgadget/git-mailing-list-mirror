Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CFF41FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbdEIMya (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:54:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:64631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbdEIMy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:54:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3li-1dQHzr1xDu-00IGyy; Tue, 09
 May 2017 14:54:21 +0200
Date:   Tue, 9 May 2017 14:54:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 3/6] completion: mark bash script as LF-only
In-Reply-To: <cover.1494334366.git.johannes.schindelin@gmx.de>
Message-ID: <c5bf4bad101cceec942d88c884b237e3e2e9f3da.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FMdJcIpCx0woVPOPqRi/MYuLa8ZtGh7rmBD4XuOg1fPqAdFtITZ
 1D97BIuF9Q/5fDYZZz4cWF2a6FQT+EFoQDg9frPm7jcLE3BE/rcAquG6dJiBkS/HmD3d2Oz
 HMkASI2QxTLDpPiqzw/MIan6A1pbbKv6v2ab29yKXAQFGS2be6mO0kESIg2qXEPfoUXpS0o
 WI5evnME67qIMdoqs3PdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a0KbRXwRG7U=:4Hvh9zHgGPrFN1/QkXquJ4
 zdbTveugfiY6Ec67fOLc4rJWfm2n/0TGM5lQJwtWuMgs7+YyX8EScYfC1MjLoIplf8XP3cifT
 oYde7jmME56Z/MdUW//I0OcR1nakJhcMeSnROucjUsgvUFrWHZoNP94TQuxbWr0XHR6mMivm7
 pZlhf8o9pMwi4KLvEtEkfWpPj9GnluQddGHjjgDx6JNf1/w3r70bpTO8TSrNUOY22C33nf8p/
 JspYTXJ/qCsg2r+dLsInEMK7DC7H/v9hLcfwhei1uqYUVtOBMCjwhimw+Czt8FJi09LGgsUH9
 7opKiOId/mLhYYWBQnPC6U+Air84PBFAZeV+geZ7s+gbntWhknvLvi08/n5f83fF5Em38RrHL
 1D/FDq/Pl1ASCKV6YZrPbMZn6/M9N5UoMgrKmuxJ3O/bfJYx7SfH3JtdwUFPKTcIsfasoBCAO
 /Dr9Ljq42x0kIbOfC8+wR4ckvZNxiQalui1Dk9B+M7OHRlE13Ut6rCDhyUM8YP7Z3aDlmWv8D
 F2y0G7+kDwy/eFV1iNxSDmJiICuJX9HPmh7NGskiFwLzepDUZQAzQLKrPS1LsmPHO/gQG2dtf
 Ao9AR5N3o/PaUeXhq+alPjpGwrL2UIG+b74WERm9EWTX/gcuAPITh3U8WSrxb48TBeNbIioH/
 xrgPg8O0s/lWRgtsso9qBCbwappbqBRWuyFFCTBTAJ4F1c4ndoLa2KSQTV9DxkIOHDcRNMh9S
 C/KEekDiSNqKg07NzcJhPR5hUbq0+usBgRLOKzZICymF20lbIanhJM7QJevsypvecYIw0c73o
 WeNXF0j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this change, the completion script does not work, as Bash expects
its scripts to have line feeds as end-of-line markers (this is
particularly prominent in quoted multi-line strings, where carriage
returns would slip into the strings as verbatim characters otherwise).

This change is required to let t9902-completion pass when Git's source
code is checked out with `core.autocrlf = true`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/completion/.gitattributes

diff --git a/contrib/completion/.gitattributes b/contrib/completion/.gitattributes
new file mode 100644
index 00000000000..19116944c15
--- /dev/null
+++ b/contrib/completion/.gitattributes
@@ -0,0 +1 @@
+*.bash eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


