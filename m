Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C70520401
	for <e@80x24.org>; Wed, 21 Jun 2017 16:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbdFUQwy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:52:54 -0400
Received: from server.croesch.de ([46.163.72.134]:33880 "EHLO
        server.croesch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFUQwy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:52:54 -0400
X-Greylist: delayed 1271 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jun 2017 12:52:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=croesch.de; s=cr1;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:From:To; bh=AFMY6z6jXTpvraddEitH+pYqnNN6j4Ixcrw165W2c00=;
        b=W0oeKU5bmlYu4K1ODM3jeSr5jY73zRQ4a4xisIeWCUI0OIA2Nb5MUx/KF7qPe74xxX9+DIE1RDh145TRjqS4szSGCl2xSkkup259WdKikfZWys2X3Q3ePYJ02UGSnNasXgLzaPhajdJ/L+Q1OSywayTiNlEdPybWszo0A494jK7glyTq538rPy4VMdcDTWlzvvbGQUXpkJO+ABBRBNL4/yA28KMViakkLhgrNmzZCmf/mdsk6fvXVsywtpMP8m0BEc2RsXE9ozSNMZrk5/RVjwvloJ4e1gr6DVyePs5UayBiydfqG/EEM+Su4hPCxR2xo3EatyjwXrtRi4AXwBABKg==;
Received: by lvps46-163-72-134.dedicated.hosteurope.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (envelope-from <christian@croesch.de>)
        id 1dNiXe-0002ba-92
        for git@vger.kernel.org; Wed, 21 Jun 2017 18:31:42 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Christian_R=c3=b6sch?= <christian@croesch.de>
Subject: git add -p does not work with custom comment char currently
Message-ID: <89d4e348-167e-b201-d243-63b1156b9ed0@croesch.de>
Date:   Wed, 21 Jun 2017 18:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

my ~/.gitconfig contains

[core]
    commentchar =3D $

as far as I can see with 2.13.0 and 2.13.1.516.g05ec6e1 (built from
source) if I do

$ git add -p

and edit the hunk manually the comment char is not parsed correctly:

Stage this hunk [y,n,q,a,d,/,s,e,?]? e
warning: recount: unexpected line: $ Manual hunk edit mode -- see bottom
for a quick guide.

error: corrupt patch at line 6
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]=
? n


As far as I can tell this is a bug but it would be nice if you could let
me know if it works for you with a custom comment char.


Thanks in advance,
Christian

