Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A902202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdJBKik (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:38:40 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:45910 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdJBKij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:38:39 -0400
Received: by mail-wm0-f50.google.com with SMTP id q124so9703392wmb.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IbVUzgE2TLGsRYimBjJxDOHcf8M6PT7CcCANGfeRYZw=;
        b=IU80u7VQkO1ZWarjz5+UFGU0dhCgoT+aZSFBmLi4y57isfvbPsse6GA2ePaVK0pSUU
         d08f490aAtao7CMBLkFe3Yd2VAkKqBVuo3xRxKQpqj48lwOPMjrYOSK93VYZK7xzRQ9k
         SipX5eQqmUDqpKZcFfF/ITqEzpsxASuHZ8uJg7pxNl+z+OoWTEzi6YYJodN//OBbbfzJ
         W4acbkLU2yBuF7njVrSlJH8fZIZkq6Rtr+yDSY7Bone9CUii1lt2PVksJtwsFyfk/AYU
         SfXDWOgiRto46yZBdORCo29u0EEjrtj6iwOAciak9cETkbdl1vYbsLURnpzW6JKgRALN
         mAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IbVUzgE2TLGsRYimBjJxDOHcf8M6PT7CcCANGfeRYZw=;
        b=XF1CGdH1xubRCbKQeY/COlWMNIRnaH3RQT5slBXGPiqPdH4aL/sE7w6AnDRyyctBbH
         cenvZmRcL83qbaSg7wfrsOx3tGHy1teVFzjyfjUkvZkCDEsbz5yH/r29drc0D1pwqYOo
         p2a6PZKIL6Jzk73PAmbF5kfQCC3ZlFKTSU9OUwcixTOqCTBGgeDBTdQ5IAin0h1+jWQW
         oDm9qbgxwJWdhe9nxDnUgl4WvDQlUFp3aEHJa75BU5YH8aUs1QjPw5N7ksdSu00oPiCj
         LMo2Pq483Cgrcx1YakPZUnuojZ9kRG3BW5k1kWlU3Xv4qwCLILM29lHxKneohmEOYMfw
         APxg==
X-Gm-Message-State: AMCzsaVILubslJR+Zk86tc84zV7BuWlXsDyiVVMlLaFQbzNgdHtaSKrk
        nyM3atxj05fDIaryNoAFvZOk1YpfUuYTe+vsyCnicNru
X-Google-Smtp-Source: AOwi7QCcMHvbYGHK2qpp+sul8FqWm3v01ZrFfjCASeBzK28Vw9CJjxHW7ToEAyMn3wgcTTDR9rARIuvtZuAspds5qY0=
X-Received: by 10.28.66.202 with SMTP id k71mr10068325wmi.19.1506940718014;
 Mon, 02 Oct 2017 03:38:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.165.129 with HTTP; Mon, 2 Oct 2017 03:38:17 -0700 (PDT)
From:   Tsvi Mostovicz <ttmost@gmail.com>
Date:   Mon, 2 Oct 2017 13:38:17 +0300
Message-ID: <CAB2yay8LLeNbqR4kkTwF1U+oarVDRxgkV4uGXuYcO8mAQmhWQQ@mail.gmail.com>
Subject: git add -p stops working when setting color.ui = always
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When setting "color.ui = always" in the last few versions (not sure
exactly when this started, but definitely exists in 2.14.1 and
2.14.2), git add -p stops working as expected. Instead of prompting
the user, it skips through the prompts and doesn't allow selecting a
hunk.

Don't know why I had color.ui = always set in my .gitconfig.

git version 2.14.2.666.gea220ee40

Thanks,


Tsvi Mostovicz
ttmost@gmail.com
www.linkedin.com/in/tsvim
