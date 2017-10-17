Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6421FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756213AbdJQVoS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:44:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:50574 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbdJQVoR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:44:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id q42so3118074wrb.7
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FPKQLi4DsHOXipXRCnogrSeCW8m1pMvrRFCro6s/s0Y=;
        b=Tw2PDaX3H7VjJfzuQ7iLhpGODqwRhA9cYlyHhmJHF48ZlilR4T7PZGOL3KI4PZSflQ
         EmkGOmnMRue+gxUu20luxoLroc2j7jdJrANoC70IKbSY/Oq5UwTd4VR6n0rzO/1O2gdK
         IkiW7eFBiEbQBbOwELDt4nmWizKpjJtKEskUjvEMWXpVVkS7lH3fvGXvp4hLnbxRD3hD
         CXMpKWod7S5/MZFQn5u+k/aPcltg3BmkjpbhahVa/hDyKXC7HytLfsbxXAS6iDkSEuDU
         s0Mx536gHAXNS4AiSzvwUwzy5e8lIDnCRm9rAegCdgZ6vW3xzIjmMP5FeADSaFTrNLyE
         c6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPKQLi4DsHOXipXRCnogrSeCW8m1pMvrRFCro6s/s0Y=;
        b=FyRkvnR1Xa3XMGI56cAbQ23eJoKz3nn9oy3XQUGkWNG3Dm1j6Ggu0f88YsU/Vbdecj
         0Rui5hHXo2Y2eBae0BIHqrBGP4taIOrnyAZ3pKtVl196q9rIWHnqimfxNi9wTcMm1OBG
         tD8ubVTNfnwQ4x39yMhFTeH4sjYc6YU05d67NbJfKmxoEV3Gup40AzfHadON1LNvZqE/
         xg7nFcLxeqk0fysVhHQ1VLba4LDTp2vg+yYi6qUKus+PNzuXrdNTgze8oVRxCaLZaHYe
         P7noz4e2hxRcpgsfCZJgyHSBIe5t1343FcQw1APROfslgkOqYYtWmTF7VuYJMxxkBVSM
         2Ufg==
X-Gm-Message-State: AMCzsaXu+kmnrG59VRVYWGgV0npaWfGgUChu2ymnUTmes6on0qlpbacX
        AXPH2iKeJjPPkcomzb7SWyU=
X-Google-Smtp-Source: ABhQp+TNPaJ3v8jWylA21TOjiCl4/pkeNzd6Gh7KRKXVtne4O+5Vhb3yMdBANV6iTAClPsbiXjkCNQ==
X-Received: by 10.223.176.16 with SMTP id f16mr5261189wra.123.1508276656087;
        Tue, 17 Oct 2017 14:44:16 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i76sm4836236wmd.2.2017.10.17.14.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 14:44:14 -0700 (PDT)
Date:   Tue, 17 Oct 2017 22:45:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
Message-ID: <20171017214515.GG15399@hank>
References: <20171005200049.GF30301@hank>
 <20171005201029.4173-1-t.gummerer@gmail.com>
 <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17, Jeff King wrote:
> On Thu, Oct 05, 2017 at 09:10:29PM +0100, Thomas Gummerer wrote:
> 
> > Because 'stash push' and 'stash save' are so closely related they share one
> > section in the man page.  Currently 'stash save' comes first, as that
> > was the command that people were historically using.  However this makes
> > the newer, more feature rich git stash push very easy to overlook.
> > Change the order to give the newer interface for creating a stash the
> > more prominent position.
> 
> Seems reasonable, though if we are deprecating "save" should we demote
> it from being in the synopsis entirely?

I saw that as a next step, with the "official" deprecation of "save".
I thought we might want to advertise "push" a bit more before actually
officially deprecating "save" and sending the deprecation notice out
in the release notes.

OTOH, dropping it from the synopsis in the man page probably wouldn't
cause much issue, as "push" directly replaces it, and is easily
visible.  Not sure how slow we want to take the deprecation?

> -Peff
