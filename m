Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF031F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbcHLQlu (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:41:50 -0400
Received: from mout.web.de ([212.227.15.3]:64833 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbcHLQlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:41:49 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MevzF-1brgC42FD7-00OZcY; Fri, 12 Aug 2016 18:41:41
 +0200
From:	tboegi@web.de
To:	git@vger.kernel.org
Cc:	peff@peff.net, Johannes.Schindelin@gmx.de,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 0/2] Fix conversion warnings
Date:	Fri, 12 Aug 2016 18:50:58 +0200
Message-Id: <1471020658-20708-1-git-send-email-tboegi@web.de>
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RXb8b2A7RNLy/Z9Bm5/QiiVAFbFPrYU0Uc0BkWCfiGKJ9gbMUoR
 sqcXY2eRzncBe0M/8v1WuTPTYCNVP707CI2idqHBQPSMukbxYq4TM4kpAhBtSz3XrjKrRQs
 x4tVOst6UdKYMk65dkDU/UhM69238d3wVbdn9Irw2HkrkYxjXGGLJ35wLiBqLcVSGh7sPk1
 gZ4R3CaPY+WRH29Qw0F7Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:lyI5zgM2aWY=:v+9c0MgRlhsmT4vcrmTyGn
 AYerFcc/HX87Ae0nadAOtzwJ2ToJsP2ww4BAFvDO1VmeHKMNsMJkpc9WHeydMNJwrvynSuQg8
 tsdefn+VKlik1Rf4K/TNN7W44nF3J7h2QBybhCpoO8+z4Rx3CFL3ZADUd/JJ4Fee7FZYmX1OT
 4jJJsg8YWMlt3r4OxhKa5ddfg2PLVkv44occI/JFdn56KxGTM3PqMUM8XrHzrxh3OzlJu+NG1
 BUlC/F6EuQHPrPHBHJysgcwMyfWh2laX+Q31DcTxKnpeI2BvMo3NcJSgOPRLZ7dudNbKipafP
 vrL+3zncX0NY0tnFd0OAc6UiPErDPD+P7n95yQmMdw1xLlrz83wsO/vVmFTqZHJ0VmaTeshRs
 F/beRnZtvbzcz0ORBXOrcC25BfI6apOS5OualHxd2Y4rk02sMgAzXVisCu1zFrfK1aYSDNqgN
 V+7k5ouWOtGwQo7Bc0g6e6OQvHVNz1wCoWVWu0DKhbcg6h7MzAx/VX3QYFQD5KmtUfng3q6ty
 OT/WzYAssG6cJlbgCUBSw0ZBMKw7On20lHAnsBqx82XX1tceGBdOQkSA3s9HR/YfZd1aAzzFM
 TYX4X/AC+yWPphsBhWu+QRilQdZiu74wMyVUj091cNSz0ddUxkDvBddc7yNeYtKGdCT9cAqcN
 pEeh3oRPQ/VpSl6obxmG+NH8tWoNIFqNk8phUYf8CTRDKSRD+0ite5TOwsAfBtxYdSTlaQhUE
 nevjzYIC3diB10pjDr5XpozD9uCEiHCxVWjqqxhLqQosvY2tXl3QDaj7bcLkLpE4ow3lRJlKC
 tqZpSql
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

conversion warnings in convert.c and t0027
- Fix a raciness in t0027
- Fix an older problem with the conversion warnings when a file
  has CRLF in the index, and is now commited with LF.
- Do not yet rename NNO to something different.
  NNO means Not NOrmalized in the index.
  The files are changed and content with different line endings
  are added on top of the existing version.
  A replacement for commit_chk_wrnNNO will be send after these bugfixes.
  The term commit_chk_wrnNNO could be changed to
  NNO_in_repo_add_file_check_warning.
  Would  NNO_addX__chk_wrn be more readable ?
  Or CRLFindex_add_wrn ?

Changes against v0:
- Added raciness comment from Peff, and removed the removal of a line.
Torsten Bögershausen (2):
  t0027: Correct raciness in NNO test
  convert: missing `LF will be replaced by CRLF

 convert.c            | 97 ++++++++++++++++++++++++++++++----------------------
 t/t0027-auto-crlf.sh | 10 +++---
 2 files changed, 62 insertions(+), 45 deletions(-)

-- 
2.0.0.rc1.6318.g0c2c796

