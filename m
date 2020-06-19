Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C8C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A8D20890
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="imHBVofC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392072AbgFSUXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:23:42 -0400
Received: from sonic315-19.consmr.mail.bf2.yahoo.com ([74.6.134.193]:38786
        "EHLO sonic315-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390976AbgFSUXi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 16:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592598217; bh=j6bQv0fckeDsvq6WLW/am5IPbQmZHrEUdWU0dHwSFPM=; h=From:To:Cc:Subject:Date:References:From:Subject; b=imHBVofCdPf0Iw5ZZEz5E4fTXrapuG4tYeItjbP3RCNpv0RxfI4twWWKUvaTmj819JOMWIuISU5XO8/oq9w5mM162zTIUkzmA8fHZ+KLpwgqseGHnxTDUPGuyqHYS7xecb5283pw45s3ie1ul1hIzngQltqERtDH1+JeFuGyaVP2gxVIcYG5tSyM5tSYHp1VGej1sOEPXN91OqBbu6DiakpdIaojybp450snn873hfdnmf/GcLljTkYZP3oNAt9Tb8vI3x9XF34m8eCxT9QVZ9RYvfnFicKcoPwgAU+1gv3rFT1k6O3hm+Had4AlGnszwmB9RHsvIogW9yUZQqCofA==
X-YMail-OSG: yLkjowUVM1nAa60974KsyV.Z5Jt6xbnIK6uvMjpqYqNMEEKLPJWY0Xe7NjJ794t
 cL2lV_QmxMYJoKE2oUR8WB6GahzzpwnYPsmkIBUgK34.TBiVYfyBFfMK2BPP0vznDFvFFXm.6iZC
 DHaRb6HOxMPmbbAiJYTRhNsDS1dAiuEZOfAtBjz2YQy.POyTv.i0cOfjfbivFwARS.4zK4y1QIKJ
 uTo80nqdOm4jv.UETjnlskozDDblXHsSoli2ujnA22K1uPwMwRmEMKyYsfkE0ScdxOMmw083KQ0q
 .1QmGreRXd_VHV8OMtkso76rf.MH579P.2kdWrJ8Ix68gj5BSaMrURMma9uqnQGPeFvyblP0KrIQ
 KFQtILL0EgUGWlnk5STdlNsE.2trp4osZEUIORd19ZRUT.dm2rbt5L4q29AThe4Dv1yKJaWWC7LH
 Zu60UNSLMUrjRiOoexnNStuTf45ZvsmrVHILQhVgFX2N3fVRrkPtViMvZC5Fz7L8sxVDGBb6OQJz
 irf_IYWkhR.4MCH1NsOi1mS6bQLp.Ywa7iNzl3DpQHvm574rrSEQjrEemztiSJ2lCxmQsSLnrZJ.
 MA8qhUea2QY3QiQjJT3Nz6BekCcT1PznwW5KdSzgdyDJaW.k.S67UHTzKk9f6_Cvic2rOJPNHKfp
 ZQqXfCjuNj.felqExAxEEbf_HKcbMLrvro9qSIhaw.KM7IFO3_QL1jXHGinot0hfFYM.XQo.DSh2
 utTCipElYVuJ_sR1VUVqPCiBVKTjo0FMyVNc4.4mdspVvSrAriRfINB6Vegm4roUWTfKgA0iFwT4
 gA1rVcLcocUtWBG7zMPBUjVr5DPc0Vwql9wgfbN4STNpoo_m5WkHYqie9RFpFnT_KRZkmPZeuL0x
 DRSdIo7xr0u6coQS5HfGGpFfIcYBJVYnpMjgE2_gN6ADKGuwp11Cjvb0RtldhUv.H6_ax9gquaiz
 ttuDuG5xduWBjZWieQygsYcEWcRRDxkg65jVHpnkoU.4HOqclCYStMVlZh6gb0E.WsDkPtca5pEQ
 CiupaQan6v.SpwiV8xtl5lP4YFBzctTjgFANykaNiA3wpxTjpJ0zLDcBgDecMkk02St68Ny1oqBE
 3ZE4jqrb145ZEhxccU76pJJT.s9W8RpTUBfjpwHFtmALKzpvAvdG98GZQzB6LUBiqMJd6N1r52bl
 LdNsVLtnl5rpJ8BUCeLeSFcJZq0w1KZeS3eNQkwTXroPw7mqAffYkRYSPxakXKS03gN88x7MKOUb
 JytCQKLs_OOfGV3Av9USdGR9i8bEuabB2vDhO0Myp7uLqeoisYstTejT.8SWQAmIJ7ESQBcyDRkU
 25dMxn7khiFLXOUEMQUY5sKaVlTl549fdkKPqICe9Yf2OWkYZ8Wnxq94aEpZ35mdfxvYLlI3JFmd
 Pe2BWqXcE4SKXl7SUrK6UoJWHNnRAj3WNj16fi5Mvcha7K5I-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 20:23:37 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f9cdc319e6c5c02f6098bff69147f340;
          Fri, 19 Jun 2020 20:23:34 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [Patch v2 0/2] Replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 16:23:18 -0400
Message-Id: <20200619202320.4619-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200619202320.4619-1-randall.s.becker.ref@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

The strbuf_write_fd method does not check whether the buffer exceeds
MAX_IO_SIZE on the target platform. This fix replaces the use of that
method with write_in_full, which does. Since this is the only use of
strbuf_write_fd, and since the method was unsafe, it has been removed
from strbuf.c and strbuf.h.

Randall S. Becker (2):
  bugreport.c: replace strbuf_write_fd with write_in_full
  strbuf: remove unreferenced strbuf_write_fd method.

 bugreport.c | 4 +++-
 strbuf.c    | 5 -----
 strbuf.h    | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.21.0

