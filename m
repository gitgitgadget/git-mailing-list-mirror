Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6891F1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 12:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeCQMRO (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 08:17:14 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:39317 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCQMRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 08:17:13 -0400
Received: by mail-qk0-f175.google.com with SMTP id j73so6417321qke.6
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 05:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8Wt+ZyxR0XOLCuhZpp2FkFTToQDwZPiDeu1qTO0BonE=;
        b=jyENZHSggHtdU64g+9bf5xReMD24nHBVm1zW0e0Q0GSvlMIZuWgxzd9WFoncE2b70E
         bZpPgcQJEZO2jFy8U1F4datuS4TDIswwDKGpZo0UVW+5Yi3zqPklUB31+7oNsnlo3+Ij
         FEQzc6ikwMP3TzpBv33iQxSU4SoEWq9F+CfEyi/8brqMcfnWeBCrVKRjD79w8LequfSs
         bg5anOOAX8Sfchov6Waz3kdi8w82NIZyDFGLWXMYNmp23IQrgSt/9VNvZOa38+N1+8EL
         2Hm00+DPCtbGgI5WPS0Pix+uqMMpXPLjXlLiCRzSTAstEa1fqfa9lbndK4rMJGFQI2jh
         6vTg==
X-Gm-Message-State: AElRT7GE7+5yP0N3PRvG3BLx6mCR1r60JzXAX2nxTXDgDP5F8Rpnp06p
        9ExDrq7LG3kSXeGQYpJBTal+Bj8Z6VkadSp34pz6WeIU
X-Google-Smtp-Source: AG47ELswpXhG+mEiJXisvhTnSRNJDEkIjK53n9tEXY0Oerr3MaQS3wlqGLApn8chSXGKj3WYuOClFvlohdFDLe9iCgg=
X-Received: by 10.55.148.1 with SMTP id w1mr7667136qkd.354.1521289032491; Sat,
 17 Mar 2018 05:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.71 with HTTP; Sat, 17 Mar 2018 05:17:12 -0700 (PDT)
From:   Michal Novotny <clime@redhat.com>
Date:   Sat, 17 Mar 2018 13:17:12 +0100
Message-ID: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
Subject: get commit ID from a tree object ID
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

let's say I have made an annotated tag on a certain treeish:

$ git tag -a -m msg tagname HEAD:

Now, I can try to see the content of the tag:

$ git tag -v tagname
object 42a1c36553a50ceae2f75ffc4b1446c6c393eae7
type tree
tag tagname
tagger clime <clime@redhat.com> 1521288727 +0100

msg
error: no signature found


Can I use that object ID 42a1c36553a50ceae2f75ffc4b1446c6c393eae7 to
get back to a particular commit from which the tag was created? The
reason is that I would eventually like to checkout that commit.

Thank you
clime
