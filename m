Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3C61F404
	for <e@80x24.org>; Sat,  8 Sep 2018 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIHXpd (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 19:45:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34609 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbeIHXpd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 19:45:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D926721B4F
        for <git@vger.kernel.org>; Sat,  8 Sep 2018 14:58:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 14:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3YPVDGHaAJwFOhE/5wmd9+MPslF4GN6LPvzfdw0HIlg=; b=AHsAl2MN
        8CCk7ibTgMrw57oZlYoF6fsHNsftfED+iJYyDSwgB6WEYvoYLg1/h0LSPXFP+cp1
        rH1hjkRugSIKtY249go0isTgOjtwtSTnW/Rue1hciC6h2OOG2PXL5jyBw/HNE05J
        m+KTLRllKSsvWb+0Yuxzpb4SxF5JBIFtN+HnXkggOsTWDt9uGjQbZxyDwaoCXNj2
        0gcTmZPOqOcbg1LQE80PitzPJKDFWS5lOV0WIcK3ymd8ekr+nG4HUDf/6t8WvaQl
        OLG7WNXsjK9voe81oCih/f3inZlfROjb91LIsqXuGE16UC/oFn3sR7Wttw9iIEd/
        X5weWLVwTNbU7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=3YPVDGHaAJwFOhE/5wmd9+MPslF4G
        N6LPvzfdw0HIlg=; b=Bjrt59yTaWcHqPKbV2FSFSiM3OuHCpMZBmd1l/YvD46Oc
        rSME8rHf6ny4OCoA6iCZJP4frdnBj41r591/1A5gLmgxByvlT0RoXca7gq5jXWcb
        LfPbCvu4agBotfoXdZUvpevY/OEDrWuFr2wmfpAoVJwiwfJ1cfzq7v6g277m+Z6z
        Jy1sGDoZzzxfcVYI4b0w3UN2MGc/hc3rQxffhv1KN7R7z8Zc7vU6NMaGcfzFZcep
        RsEU9Mvp2sZW1UErQ90W51VjjkD8WV3NYROCoCmCoTICcPkeFQXClAy0LriuAspC
        My48SNLV0TWv71kiNY+0XPQrQck7n3nWceZpHnr1Q==
X-ME-Proxy: <xmx:6BuUWxOq6NTVP0M5VkDinlTEnT-uPozI-KLD9sKXwU7NPJBm7TWdDQ>
    <xmx:6BuUWwHhOQ21WudhYgSzb6kOl_JBotAG_ftdW76aIfoP8mXGS42Yyw>
    <xmx:6BuUW8YmbVojZJiSZzgguZ9rxg9mzp6sWwSxnQk18U-99L3Z2m91jQ>
    <xmx:6BuUWyVahU1BTCixDw7CobV-WxZCLLMrzhOHDu-BWvEzUlO3k4evjQ>
    <xmx:6BuUW15wpuLOo5ztbfAygGADQWqxYhZZ2p8zNKFVKzIz9tiy1QOyJg>
    <xmx:6BuUW3PUxhvr5qpRigK5I3-f3Ft65UeyLE3vUl8ztFtv9iI2l9mpNQ>
X-ME-Sender: <xms:6BuUW6AqjYKa0pKdJSbapzECvfj16nHwHCtveQUs0C8VuztsFpVAMA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 532E010299
        for <git@vger.kernel.org>; Sat,  8 Sep 2018 14:58:48 -0400 (EDT)
To:     git@vger.kernel.org
From:   Stas Bekman <stas@stason.org>
Subject: git silently ignores include directive with single quotes
Organization: Hope, Humanized
Message-ID: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
Date:   Sat, 8 Sep 2018 11:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

One of the windows users discovered this bug, and I was able to
reproduce it on linux.

We are using a custom content filter configuration REPO/.gitconfig which
needs to be enabled inside REPO/.git/config:

This works:

[include]
        path = ../.gitconfig

This doesn’t:

[include]
        path = '../.gitconfig'

Notice the single quotes around the filename. When this is the case git
silently (!) ignores the custom configuration, which is clearly a bug.

I found the easiest to debug this is by using:

git config --list --show-origin

In the former case it shows the custom config, in the latter it does not.

Yet, git gives no indication of any errors, not even with GIT_TRACE and
other debug vars.

The original problem cropped up due to using:

 git config --local include.path '../.gitconfig'

which on linux stripped the single quotes, but on some windows git bash
emulation it kept them.

What am I suggesting is that git:

(1) should complain if it encounters an invalid configuration and not
silently ignore it. It took quite some effort and time to figure the
culprit.

(2) probably allow the quoted location of the file, but it's much less
important, as it's easy to rectify once git gives user #1

I don't have the details about the windows user setup, but I was able to
reproduce this bug with git version 2.17.1 on linux.

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
