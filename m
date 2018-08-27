Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3F31F404
	for <e@80x24.org>; Mon, 27 Aug 2018 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeH0R5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 13:57:34 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34804 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0R5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 13:57:34 -0400
Received: by mail-lj1-f182.google.com with SMTP id f8-v6so12511137ljk.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Uux+gHp+zVog6mMu+JPj+I+D8vR7zFiZr/P+jscVyRM=;
        b=u+pBdL2MVviRdmPoAJ7jK6rNrlDgDyORLYg0V8vcd99tQJu7WYMUkkvWIB0wgGFRFt
         WmNYYqJ/pvYAqRYVvV/B8azis2WL7FaDpMzyBwhVOgcBgorRVDPr9BGmtdbbpr9x3EPA
         tNPYSORL30a6dPZiCG5/N6NjIRnfMBpJq+IXVlAAKYCY+Il6moc2zVOFPbYozk+Wxmh7
         uReCBS6pT4JSBfLIFVqqiy860fZ7ePef7l9hluXX03bOdN8d4hRycy7hktcsIQrYYTD5
         KF21v4C0me1rFsozwMmPXTLPAs7ECSZXhZM5GIUXD5G5jkq72xDrL/tSkCJGqd+iwQcw
         JYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Uux+gHp+zVog6mMu+JPj+I+D8vR7zFiZr/P+jscVyRM=;
        b=GeV6yd/08Xf1Atoc23oqWryyJ6HHrVO5JVkbaBvNgFaR7YrD+hMNtGSMlD/pUq84YJ
         deAt3OMPHLumE4T6kGzKjZ1gMd8/H+tZEvqLF2Wwewrricgt9o5wEFx8pDA9yif+Gkfn
         6ambnOPA3sdXndkf1OGBsgdD6I/C3yg6/MZqeNkfbsEW6hwxRbBNoAQo2H4EzEmJaQf7
         6FzvIjPrvPYEcG2wt8oHoJmIX4sFEwEJ3IwDSJL9hSzJGowpcdZY2s9SPg2L1fA6yT2+
         5yDBNN05ZNNraIFWMl/baqqlaIQLjGBHGgXy03fh4MTXlxziU/vdsD81Icsx5QARt7bj
         jlcg==
X-Gm-Message-State: APzg51BRQ7FAxzzAdvMdsWoSw/3/EVXVeuNxuSAVPpNfKwVn5/W7qNHi
        58hZA5l84Ha9C0woB+gchSg5UsMxasZJvMz08wSAEw==
X-Google-Smtp-Source: ANB0VdYXPIyQg+LnIOM+PHWiNGnIHujhhjm3sycLYFIIZch8KeUXFChmzezZSNOZA8NEAskvqid2sAVG4DUG0wof4Oo=
X-Received: by 2002:a2e:8807:: with SMTP id x7-v6mr8574137ljh.98.1535379044624;
 Mon, 27 Aug 2018 07:10:44 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 27 Aug 2018 09:10:33 -0500
X-Google-Sender-Auth: C72-lzFVfdeatT6P7zUENii5i80
Message-ID: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
Subject: Automatic core.autocrlf?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there an 'auto' setting for the 'core.autocrlf' config? Reason I
ask is, I want that setting to be 'input' on linux but 'true' on
Windows. I have a global .gitconfig that I sync across different
platforms with Google Drive, and I hate to manage 2 copies of it on
each platform (linux and Windows). If there's some way to make the
line ending configuration the same between both, that would be
awesome.

Note that I do rely mostly on git attributes files for this, however
not all upstream repositories have one, and I don't always have
permission to create one there. In those cases, when it falls back to
configuration for line ending management, I want it to be
automatically configured based on the host platform.

Any advice is appreciated here. Unfortunately Google isn't much help
on this topic, Stack Overflow is a swamp full of different information
and none of it seems authoritative.
