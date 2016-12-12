Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E141FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 10:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbcLLKoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 05:44:08 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36084 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754113AbcLLKoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 05:44:07 -0500
Received: by mail-yw0-f179.google.com with SMTP id a10so61328683ywa.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TE1/uwzOtjD7TjGM3wXViyQyBQSDPX2d3VBGQ4DjIjA=;
        b=HEBihjMO3vKscn+VDLU5l/6YiGB2krOsGOKnA1wR2H/NP3HoyZnsKzLBEmL+Pp+qWo
         o/RQzN7WFewu21vLd5cfBsqbD8dLfAjEe19bUtCHRzwzitP4peV4yivC2kc7dJhy8hUb
         L8NWQq93e0HNDIBOS2Z8Ya2u1xhUPW8WSKhZuUElrI18OvO8wJtoEu3NPDxYUnlrdFvb
         y70BMmRAKgzpSdWup1zCiLPev/REuLyriRgqujFHDTwZAfBtME0ldHoF6KibaZtkFnFi
         Unv1fMoloTAseIt2SFHyHkQ/fP35digLfINOD7PFAFz4YDRaovCtOnYX/tOPDV6gK7AX
         y/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TE1/uwzOtjD7TjGM3wXViyQyBQSDPX2d3VBGQ4DjIjA=;
        b=a768CpXAwu8UTEzFiIhaTm9YtznSRqfJTaIrkePUG+UPvtLw5JliYQKIlL+4f70ZqQ
         HhOj1If7BxPqKNUIXRHy/6SWxBd5UQX9dXgeWCgP9b13mXcEedOPx7E48zu2DzpTijUo
         b637kL4DoxonZXPMFJ/gQB13zljRb/korid644biKq+wUrOYZn+7XrVJ1/wb8I44OE75
         WMjOHd5VcnabdjwjMgKcx3JHDXfnY8c9GlITcKEK8Ig53WGuVNj4wYU6SkhAbJRYmB3y
         FFeunhcUbzjxvewoWPbKi2jHDBbuKI1icqo4bXA+NH3i0+B0v/nUJATsvzGPzEVoMqaT
         FLxA==
X-Gm-Message-State: AKaTC02PPjySSuQpHncvtQFdbSRHycdyaPKrHbKJ9zb/IBXoglNgw03nhZjqQbBM4V9F3WQ2wa4WdLraJWRLSA==
X-Received: by 10.129.55.13 with SMTP id e13mr99729862ywa.344.1481539446550;
 Mon, 12 Dec 2016 02:44:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Mon, 12 Dec 2016 02:43:36 -0800 (PST)
In-Reply-To: <xmqqpol2rn0z.fsf@gitster.mtv.corp.google.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <xmqqpol2rn0z.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 12 Dec 2016 16:13:36 +0530
Message-ID: <CAOLa=ZSuy9NjxaPS4V2LyjPo6Ek3r4gAvXBsW2VZJXgGtSq=kA@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 5:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
>
> Will replace, with the attached stylistic fixes squashed in for
> minor issues that were spotted by my mechanical pre-acceptance
> filter.
>

Thanks for this. Will add it to my local branch too if there's a need
for a re-roll.
