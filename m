Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0675F20248
	for <e@80x24.org>; Sun, 21 Apr 2019 11:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDULIL (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 07:08:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45819 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfDULIL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 07:08:11 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CAB14210A8
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 07:08:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 07:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jWF1bf
        0Q714hwPos+xTtf6m3n8car2sCgDG3vd2I9iE=; b=BgIcEagzLKjX6akF1F3IU7
        ZMxEtVMmuQP3LkeYjOg9BWwDxSPmKWZNcEViIVJMH1QUKTVV2bEbsPJHYOaWkWof
        gB0d2K8fy4gl+Ibjlur0VVouci9qAYej9ZqWqUsAJRBqbFOVlcbVJ8fqIjxLGdV+
        ND5mBsXzEv0onRBagRHsFYNuGxqcnMWV3PdRuIcVrmeldAduKJGaJ48iGZhaRUhP
        4e1tkaW7mgqRIVCw8yC+cxNdigs6EOwztuNtqDyn7ig4V6Bx8osB6f+A7QIgNCmv
        +Xx0BekX6c0Q0z9JPgrdaUCmQyQh53iSQldzAuxhncS0p6dtixbtKGcY3VeFeXiQ
        ==
X-ME-Sender: <xms:GU-8XGottzdZci0SLL95ZvUrn-OHojRVGoqXaAsRYGxy6Aq2MB5wVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvuffkffgfgggtgfesthekredttd
    efjeenucfhrhhomheptehnughrvgifucflrghnkhgvuceofhhlohhsshesrghpjhgrnhhk
    vgdrnhgvtheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrrhgtrdhinhhfoh
    dpshhtrggtkhhovhgvrhhflhhofidrtghomhenucfkphepieejrddvgeehrddvvdeirdef
    feenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesrghpjhgrnhhkvgdrnhgvth
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:GU-8XLIx8XqW7rzOpSSZ4JxT1N-E0_tatmsj4a68IfUx4J-xjh_19A>
    <xmx:GU-8XJMfWtCgs7JuF359axFhdZD176cdOqINtveGSZMIatmalr5QNg>
    <xmx:GU-8XIrP61FRs1GmONknGeSczNg3xl-xx6q1sRSCB0b4hpf4mdjhzA>
    <xmx:GU-8XFVgIujmCnnkGyzOSJ32WCO1ta-As0CHEP1_PNwv--1MrlP_Ww>
Received: from angharad.local (cpe-67-245-226-33.nyc.res.rr.com [67.245.226.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56455E415C
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 07:08:09 -0400 (EDT)
From:   Andrew Janke <floss@apjanke.net>
Openpgp: preference=signencrypt
Autocrypt: addr=floss@apjanke.net; prefer-encrypt=mutual;
 keydata= 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
To:     git@vger.kernel.org
Subject: gettext, multiple Preferred languages, and English
Message-ID: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
Date:   Sun, 21 Apr 2019 07:08:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Git folks,

This is a follow-up to https://marc.info/?l=git&m=154757938429747&w=2.

With the current git 2.21.0, some users, including myself, are still
having problems with git selecting the "wrong" language for localization.

This happens on macOS in the situation where:
* The user has multiple Preferred languages defined in Language & Region
system preferences
* English is set as the Primary language
* Another language, for which git has a .po translation file defined, is
set as another Preferred language, for example, Spanish
* Environment variable $LANG is unset
* git was built with gettext support enabled

In this situation, when git is run, it will use the translations from
the secondary Preferred language instead of displaying messages in
English, the Primary language.

I've seen this situation with other gettext-enabled applications before.
I believe what's happening is that when selecting the language to use,
gettext goes through the Preferred languages in order, looking for a .po
translation file for each. It does not find one for English, but it does
find one for Spanish, so it uses that, instead of falling back to the
non-translated message strings.

Some examples of this happening in the wild:
-
https://stackoverflow.com/questions/55145901/force-git-to-use-the-default-system-language/55160216
- https://github.com/Homebrew/homebrew-core/issues/37331
- https://github.com/Homebrew/homebrew-core/issues/31980

I think an easy fix for this would be to add an "en.po" translation
file, so that when gettext does its translation selection, it finds that
first for when English is the Primary language (or a Preferred language
earlier in the order than other languages), and uses it. This .po file
would be an "identity" translation where the translated strings are all
just the same as the original strings. I don't think it would even have
to be actively maintained, because for new message strings that aren't
included in the .po file, it would fall back to the non-translated input
strings, which are in English anyway, which is the desired behavior.

This would be a convenience for git users, because it would "just work"
without any modifications to the configure/build process, or requiring
users to force a $LANG setting.

Would you consider adding this?

I've put together a patch that does this:
https://github.com/apjanke/git/tree/english-dummy-translation
https://github.com/apjanke/git/commit/7e6704167018e1d47399af04230521927991811b
Not attaching a patch because it's kind of a large file. I have tested
it locally and it fixes the language selection problem for me. I'm not
sure if the appropriate thing to do is make a PR for this to the
git-l10n/git-po GitHub repo or not.

Cheers,
Andrew Janke
