Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FD21707
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rogers.com header.i=@rogers.com header.b="UnF3Eo13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbgFSQMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:12:23 -0400
Received: from sonic317-29.consmr.mail.bf2.yahoo.com ([74.6.129.84]:45372 "EHLO
        sonic317-29.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391236AbgFSPFF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1592579103; bh=S+y8Ip+GJsCWieSP/M6MbAzkxaU4fT+o2NoQs6+AJLA=; h=From:To:Cc:Subject:Date:References:From:Subject; b=UnF3Eo13EVc/tVkTFkb66n4YSGpK497c4nwvicFsE/1Rxf/u/bVUEPeNhk+iOiktEDwlJkufBVcTLvDf3eiQGsnO7rKVzwvykF9at3XR7Up5fhBbL9g8TuQGR4e86jOe2EcQB7OF8v7GkYVhxZAM0oqpjgj6RKLmWA/5wKlR4rKzm/9d1EYcnO46inp+acHJdece+gYDsZ85xuLOF3lIk1ZOAfTAFlh2SEenrvjG9APKWlyKjYs77V6xiwIH82y3uxgDe4nIRaPWe8FfAxivZM7fb935CExSNMODmKBf8kUmmfya1HYAqPQMRt4Z3ftW5KULLDkFf/ec8NWUTIc4Hg==
X-YMail-OSG: wJ_7IW8VM1nsmEAKK4MCts7LGaoMlNLiwlitlbb3tqiA69q.CuwTKQvu5P6h1BV
 XxdshvJOFA8O38rE5.UKzxgQ60LQz16KTm1vbkhj.Tq0V5.KV.VMrU67q3xXKq3IBLb96LdNIoAm
 0SRxH0IUcyWKc8YR6mLyL7WE.IzF8uXarwaG5RhB7tw7Oscgot2R68poFKvuNki1V2VFdNr6R2dD
 zAuUl86Q7wouF2_FRIuDwZwkjj2L6Us6kla2gcmcTF9G3oMD0fgH61p.1059XFqsZ7_XUUzEKrnr
 dcxcOXJpwcRf7j.5FdiNMLQ389mrN77wzId3D0Od.ik1NUrDdLCCr5f7nKDFjuG0E9Ei8coPZW_E
 oDxCclWxV9GodMAN4t8IHhp3zDXQqgj4_IUZPmdaIfjJJ02aQb4CUea3AgqJQHp3WNALrkmx_8jb
 EWGDwMvH3HEVgLzSSm47CbqVQgYpPHRRFOUIDapc0g5.UJBmfiCbibrCGgZ45b_9XondDKyvhGEU
 OC_zFttENBdGPJ4HEgismS3Hzj4PU9.YkKAZbaAnunkYuQS04zdQvpfF.tIuCOkJMvpFhRgsQsTr
 roPoHsHyVm9RnHdwV5k31LBiDi.xo1DQyv5SC1UzoRllPRfm_niSaDVQanteCv63PwXYomwOx.ZQ
 3gLlRdtWUvc7BDoBQyaRpsmgcww8Z5E.VsCpWQMqyE2AuC3jU9deYYow_6ce.tS1s8Ztr3Q5_FWV
 0YkTR7JQRMBR6UqyFACVfV.rZrwnq9N.RCDZB_ufOm6zLfdgnU3cxNks45j9XmF265ie347FNhgR
 EZG1zf_qGy3LX39.sYqOnm0ZUL3gJWqzyeTvFBmae9TWUgBI2_MqD7UruRHjX6VdtiGmJX6ZJvEh
 _S3.3OfBU2.oNMnqUBEqmRhh6zdE__j5N7WAvD8NVKg8KnaYNp04NcApvrKPc4TrC2KvuwmDfsqb
 uduJCO3G9Oddyax7.mqJVc6wXKmk_IQp6QvgctlUf93yk9NbmM1MJOc9C2cccajGjjaVJkzKH1Ld
 yc2zxFlwkVPdvxsTLqQlmOxNQAXrsj2SIi591KpInJ5hTHBVv23rE.Q.6fhZ8onET2C7MyC7NZh4
 nUXO9ld3oX39y7hdL67yYslOvdKG6rOWUAsgxXot.XTzfbJ2R8_em6jwwM.722OohZXscMlPmdSG
 f_VkwN98IjwvlIlS.asfIOGdZGL.k7ySInfPsvC8.aDFcnYNbvb9GD4yZBJQ8xJF01TMmEvHBgd4
 K0tRytxaEuNL5WgV1UHb.lXuFyGPXeH7VHXbQiF8spwPlpJEuKD6WQl9ZqYFfKaCmEF6nyZpFVBk
 LeFmyX7KAS5ayqoek5SA6aNXK5Bguqeh9iqTqpXroit4ki322uGPmJzlFy5A6I1tBPaAfsQzGBiW
 kAWwfKPFbVarW6kuupTfg3Qsezv.A1MIQeNsCCDFO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jun 2020 15:05:03 +0000
Received: by smtp414.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a3a454d2fd8d91b05ef2f93e2ccfa888;
          Fri, 19 Jun 2020 15:04:58 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 0/3] Replace strbuf_write_fd with write_in_full
Date:   Fri, 19 Jun 2020 11:04:42 -0400
Message-Id: <20200619150445.4380-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200619150445.4380-1-randall.s.becker.ref@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

The strbuf_write_fd method does not check whether the buffer exceeds
MAX_IO_SIZE on the target platform. This fix replaces the use of that
method with write_in_full, which does. Since this is the only use of
strbuf_write_fd, and since the method was unsafe, it has been removed
from strbuf.c and strbuf.h.

Randall S. Becker (3):
  bugreport.c: replace strbuf_write_fd with write_in_full
  strbuf.c: remove unreferenced strbuf_write_fd method.
  strbuf.h: remove declaration of deprecated strbuf_write_fd method.

 bugreport.c | 5 ++++-
 strbuf.c    | 5 -----
 strbuf.h    | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.21.0

