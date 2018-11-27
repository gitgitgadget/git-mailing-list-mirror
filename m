Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD711F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeK1GuC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:50:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45732 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK1GuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:50:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so20047694edb.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9S5NWCRLI7faxUx8j6A9m69JwdSGYXPkzb4550wjG34=;
        b=sV391vmmPScQMWYqnZRsqWGC6z2fKHgQ9+9a/yiOCGNOe65RY2DPAR02xNw5fMrzJn
         7g9hFMk3O40Kk6aEuuwmhJGgJl1xwuZszTb4fd1GxqXPD3IqhkTC72xsJgZTtiRnvwSC
         MrXvQbwZ3Xmjxa+kBAw7/zrgrGec6sFVJdKX9mGuBisVRbaRPLZ73lHpXf/mHN9hg4UY
         YiFmwa0wKSDgPs4E30/jw1onnwtyC/5VNSPgJV9D6TxU46dtGiLOVHdKUrA3LikZ+YWE
         MZ6CwRjIDh3cwSF+KWHze1rju4RmVD8/+HjWkgxSRryTolfww8ZQKahxBkjDesLTWbgC
         9/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9S5NWCRLI7faxUx8j6A9m69JwdSGYXPkzb4550wjG34=;
        b=tLi/huLdjOKuIdzD2GX316H4KF3OrgcgDtA3JcxZHMuQa8QORYCHuCEdPC5By9lbfY
         0E57D6QVpEWr9HFXCiUyWxYiwJnB8OZuRcA8vVmTf9YvBeHNiQjA64yg63tMIUWDY69o
         QZIWbm5dumli1C5b/jbsdfQDzA5/mxgdtPX1Kng54l+yvSkQUbWmLYcRa0v/JKCMdfD4
         nwRYbhzvXFvRDtMZYNajZb32HbHCSmyfwBEWVmF7hXdSqf4GvewKRXCavEVivojZLAX6
         mOf9hqYJbSgr8XeDezNfCPTRVUOLMzI0IAMgijE1ugFL0sgyTlx3tpvvBEdxDtxAfm3E
         JWeQ==
X-Gm-Message-State: AGRZ1gJUfkEeG4Ekyn+h5wXLndDoicalgu2q4AAllz2JSRZlR8FUJ9xP
        dLoCHRuqjk0BZqibkF0Xs6T76nc2ckV3ghnv+JrryDxS6PsqaQ==
X-Google-Smtp-Source: AJdET5f1qCmddRq25z8WHeEvcaujynoBR+gKCtmp9PYyQq0mlrwuqJufvnnxoYKDUWaWvQCtRjufmomZRirPDB901mI=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1-v6mr24355646eji.67.1543348261692;
 Tue, 27 Nov 2018 11:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-4-pclouds@gmail.com>
In-Reply-To: <20181127165211.24763-4-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Nov 2018 11:50:50 -0800
Message-ID: <CAGZ79ka5bYyz4nyzUFqwNzwDpkt6n6vCr-kEbG9xwJmcJyXsPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] checkout: move 'confict_style' to checkout_opts
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 8:53 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>

The last patches seemed self explanatory after the first RFC
and their commit message. This one is harder to reason about,
as --conflict is documented as "The same as --merge option
above, but ..." and --merge is "When switching branches, ..."
so ... ah my mind wandered off, expecting this to be a preparation
for the separate commands already, but this is just about ensuring
everything is in opts such that the split can be done later?
