Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4DECA0EC8
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjILCIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjILCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:36 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED2C79B5
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:33:44 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D091A202E9;
        Mon, 11 Sep 2023 18:28:18 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qfpOE-1Oh-00; Tue, 12 Sep 2023 00:28:18 +0200
Date:   Tue, 12 Sep 2023 00:28:18 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Message-ID: <ZP+UgvIon1lrIFa+@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local>
 <xmqq7cowv7pm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq7cowv7pm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 12:19:17PM -0700, Junio C Hamano wrote:
>Yup, that does cross my mind, even though I would have used
>
>	union {
>		void *void_ptr;
>		int *int_ptr;
>	} value;
>
>or something without a rather meaningless 'u'.
>
i'd go the opposite way and make it an anonymous union.
that would require c11, though. imo not exactly an outrageous 
proposition in 2023, but ...

regards
