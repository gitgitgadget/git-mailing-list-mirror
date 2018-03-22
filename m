Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F7B1FAE2
	for <e@80x24.org>; Thu, 22 Mar 2018 17:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeCVREt (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:04:49 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:46909 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeCVREr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:04:47 -0400
Received: by mail-oi0-f53.google.com with SMTP id e123-v6so5749345oih.13
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BVbm0DkbCKZfu1OVBlFnK3JGIVucWzfbCSPOID8Ts4A=;
        b=S+4uoR+jrkgnl6quUmtOG5Pxtzjz5p3s8IRDW9lbneM++zkg3KfRMk4v9yHnXhB2B6
         5jJy5dP6ER7Ah/WwcGRiQI0WYpr6DdbljUrDmVtTAQpvNdoPY5K+icQKVzStKJYC4AZW
         ZwPD7rIpbEl1CzTNP0PQaxaI+QJh8bf4MN5Wou7R/WcgjtoY5boMpuYbSlq4FsRcpJxi
         YRO3G/PEIl/mIqjuJThoPjnmMA6Uz3PUwZqzVcmtbbnSnwzhb3VeyIGtkbDM1kDQeP8q
         oX99RFEiUafgrDxHXTTGTMa+4uyShGZ9baxPFyjew4N19GQJgoUp5JKYYvMMLl9N7Hnd
         e0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BVbm0DkbCKZfu1OVBlFnK3JGIVucWzfbCSPOID8Ts4A=;
        b=ETJRNBokQFo6VUPtDAYlBAVTQ2xu9RdK7eD+AuRLNDkGfS+NnDrr1e37xfCJB2q34O
         62KxyuiqBdKxQCLoDy/086KHC284CzNPAUqGyvoFX2nduS4NJgYSxR2JaIs193Xm/8vQ
         FOD8//nKD+NbWXM+yQWQpRrVJ9YOxR/4ode4blJLq7RyOc/HbyuV6/9h3DUPo5ZIzsvA
         tO0pt/WmICo8FcaD7jcSpUiGgCvnD98D2tqn7n2fZFTe5EkSnvLTKFybio78P4fYyOyC
         HFUY3RqtjChi1BRkOAPL/zmu3xUnNnbujPW0s3e6MlNFasNSkWTd/B+jFYFz0RjV3Fub
         WNgA==
X-Gm-Message-State: AElRT7F1B6qYCxRmd+PVdhj6bNekNUe4b4nJw0LpMZ1+Hy8YePaptLFv
        2gu3HzhQiRcs4GWS+BWCIwxtYeTPrMExvAY/5+k=
X-Google-Smtp-Source: AG47ELt7ochmMC7wzgVb7q59PgmusRPhduGRL4xvnHc5g++3eXXdNSrWU2yvaoPPnbAdrZDiD01giPQ4CrO/iOOi39M=
X-Received: by 10.84.79.7 with SMTP id e7mr15238818oiy.281.1521738286628; Thu,
 22 Mar 2018 10:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 22 Mar 2018 10:04:15 -0700 (PDT)
In-Reply-To: <20180322115247.GB22763@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net> <CACsJy8CieaHxW-EE=3t4tdwAHoEg9+Bw3zpd+ZpROOc2k4Guxg@mail.gmail.com>
 <20180322115247.GB22763@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 18:04:15 +0100
Message-ID: <CACsJy8AJQbUYsy2Bdsy5rFceq5wdTyYUfeW=GZ2XSnqLahCkKw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 12:52 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 22, 2018 at 11:57:27AM +0100, Duy Nguyen wrote:
>
>> On Thu, Mar 22, 2018 at 10:32 AM, Jeff King <peff@peff.net> wrote:
>> > That would still mean you could get into a broken state for serving
>> > fetches, but you could at least get out of it by running "git repack".
>>
>> I was puzzled by this "broken state" statement. But you were right! I
>> focused on the repack case and forgot about fetch/clone case. I will
>> probably just drop this patch for now. Then maybe revisit this some
>> time in fiture when I find out how to deal with this nicely.
>
> Here's a sketch of the "separate array" concept I mentioned before, in
> case that helps. Not tested at all beyond compiling.

Brilliant! Sorry I couldn't read your suggestion carefully this morning.
-- 
Duy
