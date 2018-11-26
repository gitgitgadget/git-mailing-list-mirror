Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C7A1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeK0Gym (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:54:42 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45571 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK0Gyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:54:41 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so16935015edb.12
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjaYMFNG7QZrveYNvpZ7QELiNbSVwY58fhMJo/pq+Rc=;
        b=qbTBvfzvcHDmx5t25h2MQrF+jAatJlOBmfVT3N1nf3O4szqOQS0DbZAIIdimoyMRmm
         RjNLbN5Zc8jNqR/wz+8I37sFf9dTPAzX5/BXHQwhzhZfZEaa9lYSO5lL9cd9RsGTtDCx
         vGP2DetDiDWeUkfhxW+yTxAnIjCzyuFtk5YSSiXAe2mnvM5PA7r3jfRB9wx2rfXh7Eh3
         2DqOuGv4Mri/VSTVxUcxgSohs2mQF5scnUd/S7iySMK801Bz5z4R20JIvio8vD00C+N/
         DhRhjyt1VdlHDao+xSP9lIoumUopiAZvmck9V0Yzn9K+x/Z8zFLsux5OzhxgkYYeqkFi
         Tc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjaYMFNG7QZrveYNvpZ7QELiNbSVwY58fhMJo/pq+Rc=;
        b=FqJKLw0crvOORo+oSbSn+KPcbeZD+nz90dZX7+QCt4UZve+rmuGgW8V0xuiFtDNFZ7
         9b/cNc1H5LW8nlHi43W9SoHLdl5uvvYPg5fGkoMBUwdOmjml9mFtXZiXnWXC5s+db7pl
         K2YMWy+4K4pol6NBawtVl12dWNcs1Q22VvY0ON5rqQG18oWs4FSdWxajU0l+oZS+eFaA
         ypcBf1WidvdX4QDpIqed3FnzaTWu9scGJGmLD3wg2okpnHSTtNNn3+5XlvodKY1UU97Y
         yzsefJ8+Us5FB3nS92mFWoxQcF4etSIPEXsoqadoUpiFLPNmwyqAbCqMJ7zD3eWbHN4E
         hqXA==
X-Gm-Message-State: AA+aEWZALiLS20kP8Z0wqWM7GGpffkIhC3TYsL8bZeEpkmW3JwNq/K8r
        qwfy36YNUzXHPcRUkpjkwiebA2hXRukimdG0qRL46w==
X-Google-Smtp-Source: AFSGD/XMGGLUvMVF4pryeB33CwVDiatEIC9wXI5ctWxZ72UWNI6kszF6Rfyds1C5EApQOZGQ2kV39PnRTO3/lMzMg94=
X-Received: by 2002:a50:addd:: with SMTP id b29mr12590524edd.215.1543262368058;
 Mon, 26 Nov 2018 11:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com> <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com> <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com> <20181120060920.GA144753@google.com>
 <20181120061221.GC144753@google.com> <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
In-Reply-To: <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 11:59:16 -0800
Message-ID: <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ieot: default to not writing IEOT section
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +static int record_ieot(void)
> > +{
> > +     int val;
> > +
>
> Initialize stack val to zero to ensure proper default.

I don't think that is needed here, as we only use `val` when
we first write to it via git_config_get_bool.

Did you spot this via code review and thought of
defensive programming or is there a tool that
has a false positive here?

>
> > +     if (!git_config_get_bool("index.recordoffsettable", &val))
> > +             return val;
> > +     return 0;
> > +}
