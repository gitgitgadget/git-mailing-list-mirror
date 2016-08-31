Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463DC1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965220AbcHaRFM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 31 Aug 2016 13:05:12 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:32816 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964922AbcHaRFI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:05:08 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 36197B00563
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 17:05:10 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git <git@vger.kernel.org>
Subject: Request for advice: visual diffing kicad EDA schematics
Date:   Wed, 31 Aug 2016 19:05:05 +0200
Message-ID: <1557694.5M8WYtoMm1@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.23.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I would like to be able to visually see the differences between two versions 
of schematic sheets of a kicad project.

Kicad file format is ascii based, which allows to generate text diff between 
versions of schematic files. However, except for adding and removing 
components, when the modified lines refer to drawing primitives, it isn't 
obvious what has changed.

Schematic file format differs from text picture formats (e.g. svg, pnm) in that 
the schematics is made of an assembly of lines, texts and references to 
electronic parts whose symbols are stored in external library files. Hopefully, 
for each project, Kicad stores a local cache library of all the parts used in 
the project, so the project directory is self contained.

But of course, to be able to plot a schematic sheet, you need the schematic 
sheet file and the project cache library at the same version, which defeats the 
custom diff mechanics of git that can be used for plain pictures.

My questions:
 * Does this sound familiar to any body ?
 * Is there some hook in git to deal with this or will I have to roll my own 
utility? In which case, would you advise to use git porcelain or libgit binded 
to a favorite script language?

Thanks in advance for all information.

Jean-Noël
