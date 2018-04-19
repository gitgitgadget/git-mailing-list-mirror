Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507481F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeDSUzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:55:13 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33805 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSUzM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:55:12 -0400
Received: by mail-ua0-f170.google.com with SMTP id t4so4362884ual.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8v6R/NbKdbm3RWmNeAHfz3Wp/mBeY3ou8RUlmuSUel4=;
        b=Wv1+ELcNIiyPBe5XYoEE4LX0FPHR/of3Tn5OeUxqpqOrRYgixI9Kb82gxVCvMhAadF
         KXBJSn0aC0mo8y2+KMqeziiYzPBKOj5q1GwIdDey46jvgtHenXmbUWlnOtYOl+4ij7UR
         omNmpBv+DREGg7fn6xxgTLVdfEINXZ9OhJAhsLTRwwJS6ePzFDdJ5+nnrlIPMQczhiTG
         qL0wxuTSMv/L2xLcWv+BzDclk3YV7+Eyga7saJp+FIhSaYq8ku7ml10S0coKxJcCwbzN
         47PM3+9JwC50YXd8B7jVyils3h6N/eYkFk44FIcaWNE0bU/4R8s1vwDJNyQd14qCG75+
         pH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8v6R/NbKdbm3RWmNeAHfz3Wp/mBeY3ou8RUlmuSUel4=;
        b=Zlu5w8ep/3L63xtxMLbuQYD9agMq9QiuIdyPPbE6ZFHQVi9ZZsjlfe4LSDRMrQ80Op
         Vx7uPv2u6CTMVOBHp8dSlvGefTScVGZhzD2ru6EJ7HdZLHi/EN3gigVx3QNNjxEG51aL
         SdlrZpX8UtVqxRSfsjb3JO+mNrW7KO3xFvPAvZrJzgKpyvo0MuRWwqkgv+GMDm7F6IpX
         gHHqR0P6zzDqpfjXkYonGDR3Mx92N+UTyGoEeHAVfoj2waH+IzkIkEVDNqo6ZMqLaDmQ
         0uW4/gtllppcZweh3fg7hHKELLxNQMva2gyTyElgqz5wFkgt5TUuwiaagW8I8kRvldl4
         MNUA==
X-Gm-Message-State: ALQs6tDPBWgNBI3ecisDI0czp+KGrtXeeMaG5oXbhAR0Oa/XAAeJv3ur
        AcSPleiUEoQ8aY1fBOyyB+OtNRQzGRa9A/n3EiA=
X-Google-Smtp-Source: AIpwx4/rUaPFnoGsYq85+QN8dJLr8wm98fl04ptcV2TUqzDWosnmgScHbBFoouiNDbFkoUqnGaG2qOcdIl+xsejGTL0=
X-Received: by 10.176.90.38 with SMTP id l35mr5827158uad.79.1524171311884;
 Thu, 19 Apr 2018 13:55:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 13:55:11 -0700 (PDT)
In-Reply-To: <20180419202641.13593-1-szeder.dev@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-33-newren@gmail.com>
 <20180419202641.13593-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 13:55:11 -0700
Message-ID: <CABPp-BH1jf1g3AAtA0qxS8qtrFsZ++PKzeiwsAOn4xV1tizdJw@mail.gmail.com>
Subject: Re: [PATCH v10 32/36] t6046: testcases checking whether updates can
 be skipped in a merge
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 1:26 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Just a couple of minor things:

Sweet, thanks for taking a look; will get these all fixed up.
