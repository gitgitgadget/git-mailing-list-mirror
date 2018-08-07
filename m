Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721A8208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 04:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeHGHHC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 03:07:02 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41093 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeHGHHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 03:07:02 -0400
Received: by mail-lj1-f180.google.com with SMTP id y17-v6so12338419ljy.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jyC/x6JJ5pXFnRx5Ovvvl6trPELM88XsbILffSTr9Jo=;
        b=mZzxzgwENjtPmKxyjLgiWr2inrizEhtCtVeD3trjIxYhTKy0ics0BUNtvkdzvIqX6l
         vHuN8n/cO1Nhzdcx6Bs9QZMP8ypRhAd8IkopQt3/3J/7Co1jJv8wQVUXbVuRa4UL6vOB
         Id/+Qo6j+j0WrBEXNqzM+KvzsFufek3QOK+voFxquuhSKA8UN4AMl6NtjnbEB1Ow+flx
         aIi41WrOGXgxRDfhR6RMvPZjxTfupZ9xL7TgvptR40yDKs9Bhy85IAQbI0Ow7qY1aBUy
         sIm5+qBWLaLKfySvTA3wPKmzxib6pybuYTTxAU8sY+MZ6nzsgMXgY+zdxc4anZfyWd8L
         ZLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jyC/x6JJ5pXFnRx5Ovvvl6trPELM88XsbILffSTr9Jo=;
        b=rlbSdlRcNS3plC+BWcvnsDHE8Ata52FvO0MTLex3oM2dDdnB8aJT/VCD9itmKR0fOH
         yjIEBgGjeL+PxeQw8z57g8dcD5lKDMule1+iesbsgcMQ6a6vlrNq8o7X3WZc5kPPeTfW
         3jW3/m4NfcTPphoQhGDO0L2VIhyi1WjY8hkdR72/jubpc197vbzZ25NLKHY0SRUGqqBR
         xAhKrc97ndLVNki0bN8F233VxIE2IemAvbXsPz+N5Xc8sGEYnY4oo075m/s3v0BPYuuf
         Re/8cD5Jt3qNpHPr0dWBsRhq0M1WVNmkn3Oe5nPAgcLiNP887Oq43aELDUh9QZagWn52
         vUbg==
X-Gm-Message-State: AOUpUlGPNMThIj7jycNsRsRBjLcqEZcOniiWf6LZMv3TNWCHUHsn78lh
        TFJLDPpdUVpgc0dRr5eqE/3DJj8r+04HJypipcsldkA2
X-Google-Smtp-Source: AAOMgpdyC+3euc/LuM2vOnUMdrDlUgGVs0lzLeYCwaP3BT5GuIWY/DGeqSfn9bqyp1+TJl1lyMVYDFXfFl65qjezyZI=
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr15176836ljc.141.1533617671614;
 Mon, 06 Aug 2018 21:54:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 21:54:31 -0700 (PDT)
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Mon, 6 Aug 2018 21:54:31 -0700
Message-ID: <CA+KyZp5i8KzaAnet1eQovkxS2wLHUfnhZT04GCm2eXSFBqO+Fg@mail.gmail.com>
Subject: Support JSON with --json flag and provide header files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@git

I hear there is a movement underway to have git support JSON for the
purposes of machine readable stdio.

That is all good and well. I want to add to that request. Imagine a
software world were serialized data could be typed. So JSON produced
by C/C++ could be described and the receiving process could have type
information about how the JSON would be deserialized.

How would that work? For every typed language, Git would provide
header files for that language that include type information for each
JSON string that would be produced by git commands.

How could that be accomplished? Someone needs to create a system to
generate type information (header files) for each language based off a
single central format. So we create a JSON format that describes the
JSON data. And from that single format we generate header files for
each typed language.

I hope you see the value in that. There could be a git command that
generates the header files for a given language, given the git
version:

$ git --generate-header-files --language=3Djava > $dir

the above command would generate the right header files for Java given
the git version. Or the headers could be stored on the www and could
be downloadable for each git version. Perhaps Git authors wouldn't do
all this work - perhaps they just author a JSON format that describes
JSON. And the OSS community can write tools that convert the JSON
format into header files for each language. But I would like something
OFFICIAL to take place here.

Hope this makes sense. I am looking forward to a software future where
parsing stdio is easier by using machine readable JSON. Want human
readable output? Use the regular command. Want machine readable
output? use the --json flag.

-alex

--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
