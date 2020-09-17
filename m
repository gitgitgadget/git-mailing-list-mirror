Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C0C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E9C2222D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIQPmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:42:06 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgIQPSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:18:17 -0400
X-Greylist: delayed 3443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:18:16 EDT
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAwTn-1kC0qg21kH-00BIrC; Thu, 17 Sep 2020 17:17:31 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id CBED81E01E7;
        Thu, 17 Sep 2020 15:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BQNVAL1tWjxv; Thu, 17 Sep 2020 17:17:30 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 9D3A11E01E6;
        Thu, 17 Sep 2020 17:17:30 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 6EC298051A; Thu, 17 Sep 2020 17:17:30 +0200 (CEST)
Date:   Thu, 17 Sep 2020 17:17:30 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917151730.GG8079@pflmari>
References: <20200916200203.GA37225@coredump.intra.peff.net>
 <20200917132047.GA14771@pflmari>
 <20200917133153.GA3038002@coredump.intra.peff.net>
 <20200917133525.GE8079@pflmari>
 <20200917145142.GA3076467@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917145142.GA3076467@coredump.intra.peff.net>
X-Provags-ID: V03:K1:DO4V57CqCubE5cfmp18dyYjBt7lZVi7sh03SXQ0+Y+Fpj2vx2yH
 1sjUApU3iPrphhQS4CDlR5tAzqv02EY6g7a/lAwRS+Ck3xdEK79swkByxHnNTqZj2FqA8IC
 Jnlif5fCdIUDwEsj97jgf7mVqJAV8cq5JII/KEmQuH9LXqfoUrncezwn6AKlB5WpcBao/9o
 MvNN++Pq+FT9a08CaScbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AuVVpBDKJnY=:RKllhnkZ2pd1X9XcZhLXhr
 63haEmsOapDRPiEvYNxBXF4ENwGJMflYtGoqN2yoGfzF+tPl5KouqZ3BdiSPGnzpN/S+fnubf
 MCcFbI6fp/NsxvQzSPCCFCVhLbYsOOMWtwfOhXZpGX6JUkeKHbs2rJV8bcb8ddTsbNfIAJeqa
 JhRuCi6BlXT5lzzgDRovXVP7PECBSTx8mHXI2n95IC8tiutcrdLVHLg45Z37BEuH6Hn7jhkH8
 D3Ki84HdEgZKmzqWfny6/2zbCrnYkGABvMCmUxrpo+YFOsvWVPgIADBT33LU7xM70RORAGvim
 iqND0bXNJe0/dkWZgU5b9kn85K+NWUzl4BJsgscD4i7sLYg3v8N5Zfs6aKjVcP0/lkUNu1VzG
 CsZjrt3V/G/hhSdWBEWzEIuFuWr6Q+Ke+cswu3KvyxEFq4eSxeImaEbbt3G6GCkJorcXFQ4mw
 cxERnfKuxQ7/TQtNqbOyLliZuBxUNGFYZf6KCEVoYopKBQG3K97yYetkH06I+ZwWRwro091NT
 ybVjLwxzr9sre+qbvcHP3I1YEs5vxQrib3x80OMAi35RZh3/r9ns57+StY5j5oE0JWtVSa4ik
 wFV9Iegf9AfbrSgRlrrLxiNtG2oQDSnExYUnDFA9LTLoow7RKMGrGTrHp3XmqvadeOdmxxHsx
 ylDBkRZ7TfxQaicqbC3swkBJHAR43+4hAiBOIi1egSdoiWcyV+pfUUH099or360PZSuTCmXGk
 NUQooS2o9/uHD2+5REUNZLm0cEUEQ0AQdrdqlYm6sJ5zRtnKHLINQ1385Qcpdy4n0iED4ld1B
 iLs1aj0cyuo2noPC3JOTE9J12otYanzhsXToMxIUX5AS5lLW3rFOznWwcoc5QWA1OxIcBQWBn
 m/TiAYjma9Ru5EBIfziw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Thu, Sep 17, 2020 16:51:42 +0200:
> No problem, and no rush. I just wanted to make sure those bits didn't
> get overlooked.

I'll try and do my best :)


