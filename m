Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA7120248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfCUJmg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:42:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfCUJmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:42:36 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so4694117iop.3
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JAJho/1lAqZsCXSCrspjG/559xtl+lmldvSxsZk0fjY=;
        b=kaLJuAD7WktrjmqPCGKHPmw9q3/Lh+ddq2U6G7K+CoREB4KsQzjZWYgKeWIfLcNRnt
         /Ckn92OF/ykiMp0tet+7mZD+VlPyq06BO4WiBUbocJIuiaroZDgAkDp68QdR1ix+d9xx
         Fwf/+FeiX0U/GiKPaLCNpnomu2xMFD1b7C/sOPIeCOEdRzKnKUso5I/HB4smuGzH/kNA
         Zh9RR4ak+ipWlfbo4Y3mO41Y6a3hmwV59d37KqRoV6D2n+N0jfcA7hcJXRXgHn6Ft2tq
         78GJQMzO2kwH4BiQxBB5VwdWJr9aP0VVHDTeNcHQhMhveiH1i0VqzLCG8I8OUL8QtqBa
         Lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JAJho/1lAqZsCXSCrspjG/559xtl+lmldvSxsZk0fjY=;
        b=nP8gPEAxU3N68zqVL4lem5k8JQ/5gcieq8KLzr5CCsGeONQRLLhJg62XfaGXmPpQyw
         EruShoy/QzoDqunEgRxEFLTDYXYFJNFgZZ1y6xnaf2b4Vh3tXvrom1RZAeGmbfAiPU0i
         xvAzG6wnDlF+A5oxNWq9JrRsadjrkTlE543+bScDyA0oijxLw6XsajdcVBzt2xXaU0jN
         aG8ayPv3TRWo3SgTcolv8HZPake2jmFSyx6ph5t1QmbDLhwT0jYEZhRXWNzeCxpvFgYe
         IQfsjlr3YuWHKerKwkbDhZ6IWHztTmaaVpXmUyHK3MOvDX+SKmMxNykr5BYoxunII0Ce
         Hl0g==
X-Gm-Message-State: APjAAAU6fhpusGbpf/sESlcYllpdcBVyrWB4COk2RUUgsuJrwmIByUTZ
        wHpLUnOEmemg8Mnl7XVMoEshDhRhc8fsLomsTvEYokyc
X-Google-Smtp-Source: APXvYqyY/ZwXok3TAh0zsEZ2j4Dv9LKfN0Y4BTNiECM9sSxYLhj9QAfIxnmIr5n4s3rUMtasvO3eeUX0jX9lnEZKBxY=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr1990237iom.118.1553161355426;
 Thu, 21 Mar 2019 02:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190320102906.12917-1-pclouds@gmail.com> <xmqqh8bwsrnj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8bwsrnj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 16:42:09 +0700
Message-ID: <CACsJy8CbpQs6_vH9P2T_BY8F3RHv0Y1M8NL-q0HNj7xOz4Wcjg@mail.gmail.com>
Subject: Re: [PATCH] commit: improve error message in "-a <paths>" case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 12:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > I did something stupid today and got
> >
> >     $ git commit -a --fixup=3D @^
> >     fatal: Paths with -a does not make sense.
> >
> > which didn't make any sense (at least for the first few seconds).
> >
> > Include the first path(spec) in the error message to help spot the
> > problem quicker. Now it shows
> >
> >     fatal: paths '@^ ...' with -a does not make sense
> >
> > which should ring some bell because @^ should clearly not be considered
> > a path.
>
> Makes sort of sense.  Would it break to blindly use argv[0] if the
> user had an explicit double-dash "--" disambiguator?

Good point. I didn't think of this.

$ ./git commit -a --fixup=3D @^ -- foo
fatal: paths '@^ ...' with -a does not make sense

so on the bright side the error message still reports the right thing.

But parseopt I think does something wrong because @^ should not be
considered a path at all. There should be some other error message
about unrecognized option "@^". I checked argv, argv[0] is "@^",
argv[1] is "foo" and "--" stripped.

This I think is a separate bug. Will look into it when I have more
time (and tagging #leftovers in case people look for something fun and
small to do)
--=20
Duy
