Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AE31F453
	for <e@80x24.org>; Sat, 27 Apr 2019 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfD0UVl (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 16:21:41 -0400
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:55482 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbfD0UVl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Apr 2019 16:21:41 -0400
Received: from pps.filterd (m0144081.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RKCV1Z194075
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding;
 s=20180315; bh=Q9U8+opaERDO/MLbDzMSUB+LrF7Mp4nrV3o3FuIaGpI=;
 b=KKqLjPXIJn8HCavvMMDtRjPstBUvKKeLMtG+InH8qvK7A0RrB5B0xqAtklgXw/W4+Xaj
 1O5oa/nmCEDZb3CNG0t0Sp2DXOs97MvHXB8srty7ovMETe8OJDYc13MxXcLR3nqy08XO
 x0zHcGj6w2fwCGd+fsXFdmLbZxjfrZsmF7pCy2B70rCVFh5MxBToUA5mgO/NwmuEBLMK
 n3AwlqbP8d7JENbwmHM88El4Z87eu/2+5nYLH8+PeXJOfr3VI5d1KvL41v6p95a/dNf9
 Jw0t8V+u8yE0kXsbnp8XGKxVe9OxiFipZzKLpuSTeD9WmF1hRqXCE1rS6iPS+FeS5yu4 yg== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2s4jjpy47b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 16:21:39 -0400
Received: by mail-qk1-f200.google.com with SMTP id a12so5895681qkb.3
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9U8+opaERDO/MLbDzMSUB+LrF7Mp4nrV3o3FuIaGpI=;
        b=zq4lTmqcNa6QRGlyVT5KVXPQXs2CqqYsfvi3AU2myXC+zipewIfCgbm5irMyso8eAQ
         ViNvgG8H7PON2pFLtVegU8aplnNMbznchWA2NF60ENZYMVeMODK0aY9glyC+6xZ4BkuQ
         Z51WpswADhmC6cVwEy9DWdhSN5cLY/7kZMOLtz63ZSOX8K/TAkoSx359IWRNQFo+hZoo
         N98XiCkKNmG3wu3hoI73RdsKZHQVpBuwDw0LNAODBlcJXEyg+TiojtppRq3vd6rcI9x5
         AAKrDF8YVBS5sumuiw5WNune3bCKGam0w+cGFjWzX8rrU26RUPucw3xdB5HI01Rm7ktk
         m1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q9U8+opaERDO/MLbDzMSUB+LrF7Mp4nrV3o3FuIaGpI=;
        b=HftErMx4bZhRn8qd1SoP5PIC7DeBrkAww27oEeN2A/gjvIhh8jw4KVSk4ycCaP0PRZ
         tCJtLv2tycybpusyI5Nnf7geJFHheoQNx0bQNohSBsw3YXy9XHkleplktDwOUUm/mPH4
         /u8Xfhw10Q3y8MTVPy1PegRYBUlCEA6/Qw9e01FdwDueOGajr4lfGl+5GhA5Ag7kheie
         lt+tgLANWCue48x25kK3UeOLHply6+oLNOi+ctrBba1/XWB2vBA9VBO5x8PGsXurIuxI
         ZAJeANZBnOgDhdxUfjJOpwG00mjKZF3ZwL7trBfxzuKJA1jl/EzR2SfV1C9VzArkBoOu
         Q0PQ==
X-Gm-Message-State: APjAAAXMf/GgfyKh8TEAZYz0BeFom6tKljVcw2btbp+cxAtxgTAqBUWN
        D0caxVjRqacYt1qCiwbXWZUO1pLVPIDeJ4wu4ooawzOHk+9cxA8q+WZK5YSyq7wgx03e3ogb/Q+
        qOXHfnqI3gek=
X-Received: by 2002:a05:6214:188:: with SMTP id q8mr15633188qvr.105.1556396498667;
        Sat, 27 Apr 2019 13:21:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSpy/NOZOBfmmi9P/hCapGE8teNywefA1CISHYb6nYI+mkOSQ6T8a+RGN+yg+SoKDXoxKa/g==
X-Received: by 2002:a05:6214:188:: with SMTP id q8mr15633184qvr.105.1556396498558;
        Sat, 27 Apr 2019 13:21:38 -0700 (PDT)
Received: from LykOS.localdomain (cpe-68-173-125-182.nyc.res.rr.com. [68.173.125.182])
        by smtp.gmail.com with ESMTPSA id o34sm2901285qtc.80.2019.04.27.13.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 13:21:37 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH 0/2] tag verification: do not mute gpg output
Date:   Sat, 27 Apr 2019 16:21:21 -0400
Message-Id: <20190427202123.15380-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=629 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

The default behavior of the tag verification functions used to quiet
down the gpg output if --format was passed. The rationale for this was
to avoid --format to be litterred by the gpg output. However, this may
be unnecessary because the gpg output is already streamed to stderr and
thus can be easily multiplexed. 

Santiago Torres (2):
  builtin/tag: do not omit -v gpg out for --format
  builtin/verify-tag: do not omit gpg on --format

 builtin/tag.c        | 6 +++---
 builtin/verify-tag.c | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.21.0

