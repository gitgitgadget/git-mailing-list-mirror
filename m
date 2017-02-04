Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C3C1FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 11:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbdBDL5j (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 06:57:39 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:34545 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdBDL5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 06:57:38 -0500
Received: by mail-ot0-f170.google.com with SMTP id f9so32849510otd.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 03:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uJ8zI8kSVefokd16TVp8JB3V9jfLZI3PJfs8mL+LcNY=;
        b=SBHNK51pkUSEjOP3PtvaqQfGJO5agGw7xwN0VC8Cj03oPS96RFsGgWdk9YG3AFmxcH
         ohDtlqksicnTzaGdcAcrmhsCOZpHogU+1w5gcc7M4TDPlx+n1lR8D3pDgF86iWZVURZy
         bmkrRcpTaFTKfGVPXanzIa/1X1OCkWWfXIN6E/SmOWrwS09i/8IP1D8jlQ7T9RLtOyND
         DsACoFaZbiCfs8FvqTugJN/9Z0U7Uf5AgfgWiEykAkTR2pcAwNOvnfRQo2O/l5qYW/WF
         ISK1pOGa6n2kA+mzmrM9uIATeh0yM//5DDeyxqa6hGZzMmVx6pYkhRKnH0P6SKLRKfTx
         gDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uJ8zI8kSVefokd16TVp8JB3V9jfLZI3PJfs8mL+LcNY=;
        b=X82rQHv6T5mooy3WaS/VOfOKgh7vHogLdZ0p6HDCKHEur3RTJNbcpAdl2qctk7YDAN
         VZYlLyC8qh+GYKj3GjzsnfRZxg5I8spwtCW8SsgR5fqMTmAcXrQYycdwRfzDbTqBsDJw
         6ItmY0ejlbgbkFcnglREd3Gcuc1vctPaISRJSO55Rjk0S95kx5twX5Sf+Egl3Q2f98oJ
         mmnUl0jln7yC5mJ4TF4y9L/hY7mLviOHdDJEs1IbRSLWS5NppTOdYnrmLoXCjiYxxbMD
         si1pGQVpmsepyWoURpatRcuUIiTeY8INQfrkWY8a37+TFoX4JTHjnZPbw9DZaD8FSw3J
         8maQ==
X-Gm-Message-State: AMke39melvcYfg23YjsSyAf0gbwLbHJhrvJdxPZ54YafFepcPokwKdhFnqS1bm0I/qdyh3/WcADBHlL+9o6FNA==
X-Received: by 10.157.39.35 with SMTP id r32mr742137ota.199.1486209457664;
 Sat, 04 Feb 2017 03:57:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 4 Feb 2017 03:57:07 -0800 (PST)
In-Reply-To: <xmqqtw8bf7xn.fsf@gitster.mtv.corp.google.com>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox>
 <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
 <alpine.DEB.2.20.1702021043110.3496@virtualbox> <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
 <alpine.DEB.2.20.1702021136210.3496@virtualbox> <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
 <alpine.DEB.2.20.1702021223320.3496@virtualbox> <alpine.DEB.2.20.1702021330040.3496@virtualbox>
 <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com> <CACsJy8Cq8sY1hL75Xs_MMr9r_+jjr7p+58D+0GhT3mgSgiUEtg@mail.gmail.com>
 <xmqqtw8bf7xn.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Feb 2017 18:57:07 +0700
Message-ID: <CACsJy8BeEUzEt25nN7_eddcUN8=SrQrMSHY5duYLxKxTztfq4A@mail.gmail.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2017 at 1:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Even if you think "the right way" is to add to the iterators, I
> suspect that we can still do incremental fixes?  I agree with the
> order of importance Michael listed in his message (i.e. the index
> and the HEAD first, and then other per-worktree hierarchies at lower
> priority), and I suspect you do, too.  I am not sure that is what
> you called "middle ground", but I think such an incremental approach
> is totally fine.

Yeah index should be fixed independently. Sorry that thought did not
occur to me. I counted HEAD as a ref too (i.e. to be managed/iterated
by refs subsystem) but I guess it's special enough to be dealt with
without ref iterator. I will try to fix these two first.

By middle ground, I was thinking that, now that we have ref iterator
interface, we more or less know what the api should look like for a
ref user like rev-list, so perhaps we could add a custom (ugly)
iterator for per-worktree refs (including reflog). The ugliness is
probably buried in refs/files-backend.c again until we clean it up.
-- 
Duy
