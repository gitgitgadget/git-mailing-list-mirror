Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA6920A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeLJLD0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 06:03:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45232 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeLJLDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 06:03:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so9969923wru.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=22hWT0eP9JT3OipbEWPaYZW3zaXOp8hiADx7+fFsF3k=;
        b=OH6bCKB0IgsdwUCxHcDG/lKMl/MGVdG/MbVFtxAq8sDb1AyWrwKPwcOF2lHB/dFBJd
         kZ+PaVUKqCranJ0F9Q8LqHFdZxcUoKIVGM2QNtjbuE1hnilrfww7lVBGHYBayzW4mJ6z
         TzxlKR//0z5dPBW5ynnulNraj+Uu24V0sul3A/3A9yqnAEbZskvZt8RhVn0dsgjnwDLt
         cqDTSq5FJYOs2sG0Jyx32ryQLR0ZqTdAVgI0dUXum8PDTvfJLIFyQhjzYx2tyaHvykF2
         4heiD9bCzFUds5Ff7nOjeW+9A/20/+VjTo2OD+xkhasTm52X1wM5UMuxuZikV167OaNu
         DV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=22hWT0eP9JT3OipbEWPaYZW3zaXOp8hiADx7+fFsF3k=;
        b=sAMnKCouwvh+Z3LKqW08Ynt2dQEiz6eoC7nBqnSD6xIZNTh5gDGTtyfdGVs9egNkp+
         8QBwKNh4spl11D2r+Xvvjm9gXJGFvS0etj08ovpAj93Jxk3aO+8aUrSR9OXRmu2PjPB8
         EEPwji0j9PG8MTp1UkI3VlyDTbsL7xwcV2U611/uf5AQ856iG31Yovnk8ecptlhjhkkt
         /QiH8zg94W9bGYVMPQx9f4MYev57ADBJSHu1ZmnOScTubrBZn5xgO7pjHE17zY0mwqhL
         4O4kvkUIflGhBxXQstSpNazh+fdBaXQ6lwF3dshzzJVW5PhV900G8za0lTswk07TQrrR
         S5bA==
X-Gm-Message-State: AA+aEWZHR2SZjiwEh8N01jLi1OfcOe/HwH+ai2ZaEjRRYS4xLxuDeoVl
        sUSBLTjN0GLvRHbDeFbVV2E1EtnTsENUodDx0Mrggg==
X-Google-Smtp-Source: AFSGD/XVMr8xsxdJhxYyI+qV8pTQTWX/Odp2dhu6tVAKjgHcGmjexTGku3yY4zIGfLSIN8NzENe6YIBD2x4RNkhSAf4=
X-Received: by 2002:adf:e891:: with SMTP id d17mr10124047wrm.140.1544439803160;
 Mon, 10 Dec 2018 03:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20181203223713.158394-1-sbeller@google.com> <20181203232353.GA157301@google.com>
In-Reply-To: <20181203232353.GA157301@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Dec 2018 12:03:11 +0100
Message-ID: <CAFQ2z_OnekMUu=AomfoBoa=4dYThtEfa4sxf+UkSMAFspxeV3w@mail.gmail.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 12:23 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > When bf1a11f0a1 (sideband: highlight keywords in remote sideband output=
,
> > 2018-08-07) was introduced, it was carefully considered which strings
> > would be highlighted. However 59a255aef0 (sideband: do not read beyond
> > the end of input, 2018-08-18) brought in a regression that the original
> > did not test for. A line containing only the keyword and nothing else
> > ("SUCCESS") should still be colored.

I had intended SUCCESS on a line of its to be highlighted too, and
some earlier versions of my patch did that, but it regressed as the
patch was reworked.  The SUCCESS on a line of its own is a recent
behavior of Gerrit, and is live in Gerrit 2.16.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
