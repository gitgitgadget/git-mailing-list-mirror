Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5391B1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 06:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfAHGtL (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 01:49:11 -0500
Received: from fallback19.mail.ru ([185.5.136.251]:38404 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfAHGtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 01:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=YxF0Gn6b63LEhVbu81mnHKWmql9jjcHeB9IxvFhyW6Y=;
        b=PSjqpcO4YeS1XsqadnTNFrONJV+tiEZqnpAY+AyYppCQ8X3vjDt6x5jm1Pui4R8B2OmDMTeM9QdNXqVDoEHpqL+ubLddKSXPlS8ompBvqxIHYrWIGAU7GU4BvoiJ/WY5j79z4M9gwVs6hgelxhlUx3x4YkvVWkayuv01YU/gGjA=;
Received: from [10.161.3.161] (port=48328 helo=smtp5.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <andry@inbox.ru>)
        id 1gglCG-00015N-8Z
        for git@vger.kernel.org; Tue, 08 Jan 2019 09:49:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=YxF0Gn6b63LEhVbu81mnHKWmql9jjcHeB9IxvFhyW6Y=;
        b=PSjqpcO4YeS1XsqadnTNFrONJV+tiEZqnpAY+AyYppCQ8X3vjDt6x5jm1Pui4R8B2OmDMTeM9QdNXqVDoEHpqL+ubLddKSXPlS8ompBvqxIHYrWIGAU7GU4BvoiJ/WY5j79z4M9gwVs6hgelxhlUx3x4YkvVWkayuv01YU/gGjA=;
Received: by smtp5.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1gglCE-0003zP-5W
        for git@vger.kernel.org; Tue, 08 Jan 2019 09:49:06 +0300
Date:   Tue, 8 Jan 2019 09:48:56 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <434233338.20190108094856@inbox.ru>
To:     git@vger.kernel.org
Subject: git v2.20.1 hangs on git svn init/fetch (https only)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-77F55803: 3FFC80838138E3AB5A78504BD2AC2941BDD8F2295FF2ADCFAD3BA2C063339939B4C082D6E514704D08FA72C56D1F424C
X-7FA49CB5: 0D63561A33F958A5BF41302D71DF9F500F1623D43D67042D24393A11114634A38941B15DA834481FA18204E546F3947C1E1736EDDE8D4790F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2076EC165927BBF1389733CBF5DBD5E9B5C8C57E37DE458B4DA2F55E57A558BE7B076A6E789B0E975F5C1EE8F4F765FCCFF48519C1EE79E1D81D268191BDAD3DBD4B6F7A4D31EC0B7815B9869FA544D8090A508E0FED62991661749BA6B97735F41620B44FB51B7DB3661434B16C20ACE7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C4F8BEDBF103F002C98CAC70C1A6DA3F4EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CDCDCF839C8780CBD93C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: C4E1A13722825DD95AC38BE660A0BED381110A1D874E6D01A84F32715D18803B8F7C49E9A1935B18D28863E40B4596773DDE9B364B0DF2898A5A4B3F8965010C02DB81B281332CC1AE208404248635DF
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDC7DD61A48F5E676A40D7A526976BA00383B952A004B497518AEE8C2D9A7137C7A
X-7FA49CB5: 0D63561A33F958A5BF53AF3B8ACF56336B9D8DE0AC27BBFA3923B155B767C4568941B15DA834481FA18204E546F3947C6633242DC0339950F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B6F2CC4E8575B0B9FA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2AF38021CC9F462D574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A5480F10D64C9005C82788FFA7C38276F3E87B17EFFC59A50D7A526976BA0038A16D44DA77709E1758EE59803C9A990DFB559BB5D741EB96FE679880309AA8C3B93E98C39DA16A030DA7A0AF5A3A8387
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git folks, i've hitted the issues around "git svn" command.

I've  installed  git  from git-scm.com and found that the git hangs on
almost any  "git  svn"  command. In mine case it is "git svn init" and "git svn
fetch".

Example: git svn init "https://svn.code.sf.net/p/blabla/blabla" --stdlayout

What i've found:
* it does stable reproduce under svn https connection, http does work fine
* version 2.20.0 works fine
* git consumes 1 core and does nothing, even has no network traffic

My specs:
* Windows 7 x64
* git x64 v2.20.1 from git-scm.com

Difference  from  previous  working  version  (see  release notes from
git-scm.com):
* updated git up to v2.20.1
* updated curl up to v7.63.0

