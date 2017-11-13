Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3491F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbdKMRN3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:13:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39755 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbdKMRN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:13:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4524DAAB9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:13:28 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Subject: [RFC 0/3] Add support for --cover-at-tip
To:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Openpgp: preference=signencrypt
Message-ID: <ab9dde24-bd1f-37b6-5fb4-247937e13432@suse.de>
Date:   Mon, 13 Nov 2017 18:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
- Enhance mailinfo to parse patch series id from subject
- Detect cover using mailinfo parsed ids in git am
- Support multiple patch series in a single run

TODO:
- Add doc/comments
- Add tests
- Add a new "seperator" at the end of a cover letter.
  Right now I added a triple dash to all cover letter (manual or cover-at-tip) before shortlog/diff stat
  This allows manually written cover letters to be handle by git am --cover-at-tip without including the shortlog/diffstat but
  breaks compat with older git am as it is seen has a malformed patch. A new separator would solve that.

Note: Cover letter automatically generated with --cover-at-tip ;)

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
Nicolas Morey-Chaisemartin (3):
  mailinfo: extract patch series id
  am: semi working --cover-at-tip
  log: add an option to generate cover letter from a branch tip

 Documentation/git-format-patch.txt |   4 ++
 builtin/am.c                       | 143 ++++++++++++++++++++++++++++++++-----
 builtin/log.c                      |  44 +++++++++---
 mailinfo.c                         |  35 +++++++++
 mailinfo.h                         |   2 +
 5 files changed, 201 insertions(+), 27 deletions(-)

-- 
2.15.0.169.g3d3eebb67.dirty

