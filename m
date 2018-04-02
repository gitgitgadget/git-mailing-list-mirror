Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455AF1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 01:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeDBBun (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 21:50:43 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35229 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeDBBum (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 21:50:42 -0400
Received: by mail-pf0-f181.google.com with SMTP id u86so8507930pfd.2
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ueel1QVngjAcCRhZBayp8luGsNQN3sKxuPGJVYAlMTM=;
        b=E83He6nnJvOj+NvlHnyy2T1INKkQqKrOK1wHaytS5Xwia44cHJ3gKSt6iMPgeX7tCo
         jMHjzGPnueS23jBqnLMtr9hWBKjHGtb8BYZ1iQE/45bfvbcCDhf5ys1y/Z1AAM7eyM0N
         hNI2q3+RA8ofVweW0JD9Xs71gyf0UZJc7/Xjc/PSWYqAx+sX0lzKQ8C3caEToj3WHmPW
         hPwDq6da2iD9BgMOzSBi5gBXq++Co6uPEzIS/0IZz/e0y/COgPgFf1PFTIPx4Xb8DKbm
         BP5EyIHZVbdnOQ/7ukRxfe2jtdrGG7GXQ1iRDuQcmMbhOMW+xXwG6BQ0nSQ4UVPk76OE
         C7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ueel1QVngjAcCRhZBayp8luGsNQN3sKxuPGJVYAlMTM=;
        b=MH772EI0WjU4c9B2biQy65EJ3ksS8dC7xKnAbVr+BHSnFVyU0lEzymu6FRsSHK63mW
         ktc1uqcV0CghMsZC/41S0fhi//t1iVMidZwyt+dxjA5aMjV2S4/5aOIx0zVAKs47dqai
         MXW5doNvBcUT54eEHb0iLeuZ5O0UnrCU3kYo5OYMTtvo3v7LbUlcpdRQfTLAn2DJkpda
         2m74UgZgH3zZf61OYZTNVRrsRUzWYKQIHixk/OKDjhP0ndTdwxIs80ON+5sYEYMzJwh/
         BZEk75nxk6MNoXmxkeLkmQHcLC7EIDw9NUwu8MBWXItlmIKwSnPrdNw1teuYkZlPnrDC
         FNhA==
X-Gm-Message-State: AElRT7FSL2CdvxBk01vnyCQKNxPQ4qOVAvyywdFdFx790I8ZpDRJgZFA
        ak4jm5LknWb5PThtNDVf6LaK
X-Google-Smtp-Source: AIpwx48DRVdtVUAvJTFnfxJ7k1AG1wgbeTEwH/cX+TyVvw/IeW16LYjRU9/8JGfE/zSrT3ci+h7Ptw==
X-Received: by 10.101.68.201 with SMTP id g9mr5095445pgs.263.1522633841850;
        Sun, 01 Apr 2018 18:50:41 -0700 (PDT)
Received: from HP ([144.48.7.118])
        by smtp.gmail.com with ESMTPSA id n8sm24580664pff.131.2018.04.01.18.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Apr 2018 18:50:41 -0700 (PDT)
Date:   Mon, 2 Apr 2018 09:50:35 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC] git clone add option to track all remote branches
Message-ID: <20180402015035.mzgye6apwn3igch5@HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: OOOOPQ
X-Organization: http://fastdrivers.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am writing to ask that whether or not you think will be appropriate to add
an option to "git clone" so that whenever a repo is cloned, branches are
created automatically to track corresponding remote branches. (or is there any
equivelant option?)

You can obviously do this by a bash command like this

    git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done

but it will be better if we can have an option in "git clone".

Regards,
Yubin
