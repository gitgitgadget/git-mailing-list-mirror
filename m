Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E74C202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbdJRN52 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 09:57:28 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:53086 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbdJRN51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 09:57:27 -0400
Received: by mail-yw0-f178.google.com with SMTP id w2so591692ywa.9
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CkzShQ3PFQ43SYkpRKLORiccudQgmymlX6Nsp0dBNC8=;
        b=BieZ3pm1TJvN7AvKfWcF046TO/ot3rXjWxSWdDDiXa7c/VzDoOMGStgZqPHgCnQXQE
         4bUtgMmV+6KW8/3mTLPrT9CJoglP1NpzHFXrQL8FZgRkWSisbvDg+zIhXDYxrnFpCqnY
         FwZadUeAdrz/ZeQCj/1XAC8DXQeM7+PnXkDUIbqeCObnAIJwiZtbN1kEMKEMdky1z/lk
         6ZTtrCVThFzmcY9WDJiriT7gf1YPuothEJn82NhgWScaHLJhgm/r8wpphSXe5LmX22NU
         vZcxdFDPXr4GfNdwDFhdxL5Uxmk0PuDpwgcA4lgVqwLDFll4jkqJCyborCQ2N4I1xa6H
         FbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CkzShQ3PFQ43SYkpRKLORiccudQgmymlX6Nsp0dBNC8=;
        b=gdK8gJShs+1JxgVqZV3vKxkX96doTLo+l2NWyNOv5zTmzrcgpe4XP/IwVIyDFXA/da
         RjgRmRZ5icSBnVnJ+Sev+W/Pi3wROMsd1wSM3gIypCKhZ31n8YejDk/x7OkEc/lqYIzD
         mQdfAeZNdguENuB5ZZorR+cKbe7DrJkYhFs0ld8IsWbUL7K9an29Q9oYIbfIOJENORrJ
         QCOCo9c0U2SmWxECJnVppMmVv+9I9r1uDTMG0SartIT5wNzgV6PZuQYCB3D3N0PJCKAP
         Ymfk61qhSI3/Qyi4t0ysi+TiSslra0HOykx1JVtyd3WlS/Xe7eGh8VzBELCv/AP2Ci8c
         66Kw==
X-Gm-Message-State: AMCzsaWuLIJnnaeYhGdXa+uZG9bgPn+9FyRoU+HtX4GZ8DzZSWDPLbwT
        S5F8qeyxeGP0PqE3Scv1wPEAgTnSUzXxnYfINhddDg==
X-Google-Smtp-Source: ABhQp+SOenK1PhmgmcRAGfDg+gDk2Jt4vhXjPJWvvFNxQFnt+6kcAUmkBreQmp4cJrPGigYkpP+UIciKDy8nk82yENk=
X-Received: by 10.129.167.66 with SMTP id e63mr1460812ywh.294.1508335046877;
 Wed, 18 Oct 2017 06:57:26 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Wed, 18 Oct 2017 06:57:26 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 18 Oct 2017 08:57:26 -0500
X-Google-Sender-Auth: A40W16DGTLgG_Y3x2sYf3h6vmuw
Message-ID: <CAHd499BYsDwHRttBKxSbJS452-+VYPLnJ38z5yyHv=KkvHV0UA@mail.gmail.com>
Subject: Multiple ways to undo changes to a file in the tip commit
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose the tip commit of my branch contains changes to multiple
files. If I want to revert all changes in one file from that commit, I
have two options that I know of:

$ git reset @^ -- foo.txt
$ git commit --amend --no-edit
$ git checkout -- foo.txt

Or:

$ git checkout @^ -- foo.txt
$ git commit --amend --no-edit

For simpler steps, I normally use the latter option. However, is there
value in the former option (using reset)? When would you use one or
the other?

Disclaimer: I just typed up the above commands, I might have some
details wrong, but hopefully you get the gist of it.

Thanks in advance.
