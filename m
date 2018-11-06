Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9887C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbeKGCSF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 21:18:05 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52555 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389227AbeKGCSF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Nov 2018 21:18:05 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 21:18:04 EST
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7867E3704;
        Tue,  6 Nov 2018 11:46:17 -0500 (EST)
Received: from web1 ([10.202.2.211])
  by compute6.internal (MEProxy); Tue, 06 Nov 2018 11:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jpgrayson.net;
         h=message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:date:subject; s=fm1; bh=TgxPzUEMiphTqg49kGu13HV9mJ
        4kjOCi8mAdc6Ob4pw=; b=o9uU6tT02wuDgtS+oz+t/huW7Ve1/pJzyvvwBB1G95
        Cx86HVkPBRUMU0GGt4iQYqSbsKZc+24hQcRJ/TLtbO2TCErdmwvL21hlmk4JkxPk
        8FZeY9Yky0VlzD97V22lyJxy1vpQvIXhezf6gyvtN5BuklSNv+CGf69a9hBy1svR
        WgKxnUkmAXGfrtZKOBGBtpclgtmikOwH+pbcdaPcUGMcPT5gXzJo8b0KNGTmdYjK
        elGrnMEmEeKBzQ169/kBJiTsOrD875kzYRnE9q4A6y+SeMa+GBK8DwXo71YoLzxP
        Ep5ZRAVgshJ8rvFeL0ejM2OBzDJ/E6jNcs4p+ZsUhHWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TgxPzU
        EMiphTqg49kGu13HV9mJ4kjOCi8mAdc6Ob4pw=; b=w+2P5auXrX0PQydi5604ua
        sS1G16HctnvSs36bZUZOHLFyMrz+HHZDoPn0myvY9N4czp4Ilw9lR3CR1WkoGMaY
        YXcgitlBESrV2rQmON80z097zGlxzU5n1II5VElAfaSAqANYVjhOceNY/iSTeN1a
        NfrUsmWajZaoaRkB+vK7YAU+rIx7QG51Af4syweNvePg9G369fSLMVPHIyh5d1W4
        Zr/A7AEyXwrG8/WOkbd5qaDQGx5g6uKj+BSNAjnuRayG1DJUGlMlt1vjOIBuUFcc
        6jlPjujgAT9ug6I5DhqrLrrJ3wqEhhcDuxKC0TD7ROteSp+K/jj8E9100wNge/rA
        ==
X-ME-Sender: <xms:WMXhW0p3QWS842NDkmUcCEpecrwmIrtfgmYfz33VFJj4mNNvkSeKRQ>
X-ME-Proxy: <xmx:WMXhW6soKBfVmIhLpATx4hcDUNK7XLpZpMrnSmG_SXajk1DKtCrBfw>
    <xmx:WMXhW2ZQKs2EUrFazzZ_K2k_tR9BeRUM3qZpAdHDF1Ccm5J7fWryJg>
    <xmx:WMXhW60xN6MZDySXmVbW9_ge1XcZYEi1lW37X7fe_7zYRARB2MbD5w>
    <xmx:WMXhW8XMUwv8pwdpIdwdirLACoSyL40MPb4Wx14dskvx_N3UcapJdQ>
    <xmx:WMXhW1siotKoVVrDb0Iev4LTXImWqPvfm_rIA_FTjb3W3Q22EgWWDA>
    <xmx:WMXhW4QunxmGec4jMExu6lpQrKb4FkV_gRL42PBd6MnKaIcmz4VuYQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id A0E5A9445A; Tue,  6 Nov 2018 11:46:16 -0500 (EST)
Message-Id: <1541522776.3963181.1567641696.46EFA2E6@webmail.messagingengine.com>
From:   Peter Grayson <pete@jpgrayson.net>
To:     git@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-d469da0c
Date:   Tue, 06 Nov 2018 11:46:16 -0500
Subject: [ANNOUNCE] StGit 0.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am pleased to announce the release of Stacked Git 0.19.

The big feature for this release is Python 3 support, but 0.19 also
contains some important bug fixes and more robust test infrastructure.

The full release notes follow.

Cheers,
Pete

----%<----

                       Stacked Git 0.19 released
                       -------------------------

StGit is a Python application providing functionality similar to Quilt
(i.e. pushing/popping patches to/from a stack) on top of Git. These
operations are performed using Git commands, and the patches are stored
as Git commit objects, allowing easy merging of the StGit patches into
other repositories using standard Git functionality.

  Download:         https://github.com/ctmarinas/stgit/archive/v0.19.tar.gz
  Main repository:  https://github.com/ctmarinas/stgit
  Project homepage: http://www.procode.org/stgit/
  Issue tracker:    https://github.com/ctmarinas/stgit/issues

The main changes since release 0.18:

- Python 3 support. StGit supports Python 2.6, 2.7, 3.3, 3.4, 3.5, 3.6,
  and 3.7. PyPy interpreters are also supported.

- Submodules are now ignored when checking if working tree is clean.
  Submodules are also not included by default when refreshing a patch.

- Config booleans are now parsed similarly to git-config.

- contrib/stgit.el is now licenced with GPLv2.

- Repair handling of emails with utf-8 bodies containing latin-1
  characters.  Also correctly decode email headers containing quoted
  encoded words.

- StGit's version is now correct/available in the release archive.

- Add continuous integration (travis-ci) and code coverage (coveralls)
  support.

- Many new test cases were added.
