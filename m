Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76401F453
	for <e@80x24.org>; Sat, 16 Feb 2019 08:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBPI0k (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 03:26:40 -0500
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:46769
        "EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbfBPI0k (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Feb 2019 03:26:40 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id uvIxg7EOA3XF8uvIzg43AQ; Sat, 16 Feb 2019 01:26:39 -0700
Date:   Sat, 16 Feb 2019 10:26:35 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Max Kirillov' <max@max630.net>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Message-ID: <20190216082635.GH3064@jessie.local>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
 <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
 <20190215130213.GK1622@szeder.dev>
 <20190215203726.GG3064@jessie.local>
 <002a01d4c573$4784e670$d68eb350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002a01d4c573$4784e670$d68eb350$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfGGcLj6+xkJGHWoWT5jpUZejiNa1ZP9Cb2Ep8siaptTp1WiAv1p2AwdOca/8RUD2J2Qz3w7Zmh8MkvIg7TtrXibBMniWs7kiNSTBknEwHkdByDQopyzu
 LrzNmbybn2niLxvS67pB/NhfGNfxLFBnhPd9GKvsZoZf3x2U4pXxa8eD5+bWQJntiH/XzrVh60eXCUiO14zxYhXsldlk7mqV9M+uBAkZd4ZhWFu9FU/ZXfaS
 D4K7dWb1ZRjtGBF0LrIvjk65o37/6DRBp9bv3rUjIjuYmaz4f3ZsQ9i0A2/vHQOAiHEKek72B+2L7MgRlY9FxFKsRJk0FDeF6SnQRIRyhiw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 04:13:15PM -0500, Randall S. Becker wrote:
> Sadly, the fix does not change the results. In fact, it
> makes the hang far more likely. Subtest 6,7,8 fails here,
> at close()

Correct, I did not expect it to help, it was for the other
issue.

As for the hang issue, from your another message it seems to
me that perl waiting correctly, there are really child
process which do not exit.

What you could try is
https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
(I'm not sure it would not conflict by now), this would
remove dependency between tests. If it helps it would be
very valuable information.
