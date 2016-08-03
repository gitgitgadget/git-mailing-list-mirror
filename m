Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C8B1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbcHCNqK (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 09:46:10 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34766 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbcHCNqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 09:46:09 -0400
Received: by mail-qk0-f182.google.com with SMTP id p186so77098456qkd.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 06:46:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=a06nWtDs7LAWwkqp8B2cGJG9BNMk9w729GHvpvnF9RA=;
        b=YRGErkBklO4hJxV9nJ4FHunCA0nyQWP+kUL0n4xB5kYO1ZE64YE1K1bN4sPsScvatr
         NlCkJ41sO/qnICPHZLfj6f5Pr+01NTSZrhnJS9EkY2MHC0/G5a6qvTK+3ayLTDEwovYr
         dqx3cv69DBoTnUN47mqoniNGj0v5bzKUJn11iyk79nYYju1RVE7ubgx5P8vHDbM4miXV
         KeQVydPx8qwQ03r6XoNYeEfxOigKkufXo5opCNScmVxj4TOdlxITAUb72n43cgcpK6JN
         jT8nunUlVq5V2puwx47aJN1pcN2k42HC/dq1TfcttkyK6z1vjGXpYeHhQLmC7T+Insh3
         Iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a06nWtDs7LAWwkqp8B2cGJG9BNMk9w729GHvpvnF9RA=;
        b=GbNiiaB6UEiQ3XBRz6wGdP1NkpbQ+utRhfsNNIK7otO7B+XFybjacEpeNNyahpesRt
         jQgKxekCu5P09PjRw0y5iMdFkrAyJD342akcTXytvuh0CEtXy6CdZ9MiupC6YHdj3bQu
         LiGref0vjTxjnoEyeq3dF82S2n8NHxVboqKd9RApO/DZkUS1dCIclGT2v8/Qs4pPi4G9
         ZHEyyPErldOtJHNJcTwf7Pqmzr6X0ZRKK7av8ni4QMtJzn5euDXextAPkUIGQCTdL4iJ
         FBnY/y8AkgdcYqWM2KcXC4B/uTZZExzNhili5kCGq9kLvux53DlScUouw4onr6gidAGN
         aP6A==
X-Gm-Message-State: AEkoousdOu/lWnH0Mm1TEXD+C9n2yicEMkC/pk3fnniBiF11tDQoKuQNYmn598850vkH12OUpmrFPJ06c6EbSg==
X-Received: by 10.55.31.198 with SMTP id n67mr67518qkh.238.1470231967448; Wed,
 03 Aug 2016 06:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.45.67 with HTTP; Wed, 3 Aug 2016 06:46:06 -0700 (PDT)
From:	"jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:	Wed, 3 Aug 2016 09:46:06 -0400
Message-ID: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
Subject: Making file permissions match
To:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I'm working with some Windows programmers that don't believe in file
permissions They keep sending me zip files of their source tree.  I
have my copy of the tree in git on Linux with all of the correct file
permissions.

So I unzip the archive they send me and to see what they changed. I
unzip it on top of my git tree. But now all of the file permissions
don't match. The code deltas are there but there is also all of this
noise from the file permissions.

Is there an easy way to deal with this? I want to keep the code deltas
and ignore the permission changes. Since there are about 100K files
this is too much to do manually.

-- 
Jon Smirl
jonsmirl@gmail.com
