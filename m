Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F811FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 23:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbcHWXam (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 19:30:42 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37810 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbcHWXak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 19:30:40 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so5411895ith.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gc0I919N+rIAs8m+qHTZDHSqGRgPbZBD/QsMb0Lp/BU=;
        b=Io5c9h5PNw4poSbOrcoiX5wfE6SausHk+I1PEW0vzKUYKQ7xDSnrbLsSrb1tevNpH3
         lB1m+WIVZXXbQdBO7bXhE/CKZV5NqEZ+0T83oUvSODzLT/UuL+6qhhOjjdyAWTCd81EA
         OGkYccb+3XaNZBMFYnlwbInyO09wsngmXBS8o4pTGwM20G6PYR5XI6OBmFrB2pC/ro/R
         HcC0holNQStVl0uNQXi88N4xi4Qye2ftWYLD1XBVm7ZaYyFmJfJXOSICl2/kONK9rACf
         I6jN8gp0WdYeeY6pbZOCzUJnOtH4hPmDlTokoaSoZmq3uDZG93rQzMJAuTs35W3vACQT
         zivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gc0I919N+rIAs8m+qHTZDHSqGRgPbZBD/QsMb0Lp/BU=;
        b=XAAljxchVkZsN2Gh0okdNx5wbddzOqFrkAi20IqL/PtEepLZOJzjdAd9+U7ljS90/f
         yPLPmzs7ofUv8ZQmPdp3PTyHMuUhboCcwCknIynjSpDlhWZ4nmIpOBDv3KgsBiyKeDwu
         a3k0SO2VPK2HnWzua0r7HwTn5iJBzFU05qnf0jPMxTO3y2fgE/olz0kylpJIVMbagLCU
         U3azRt/BlJFFNRVsz97IuRIuX658GgqT52d3n2sBgmXAfXFr6hMGopAWaFsOQyqBVI3H
         qKEp0IA6PWzke2lOo7JY9NcbdLT2xH7zUAb8tNx3H0bNJ8cAlbP5LMm5CSpdSVGD/rnJ
         ywZA==
X-Gm-Message-State: AEkoouseQPoXLa+yswIPwovghwDP7qact4+jWu3CN2oedsI/7lMdFXHzaQfxg5r24nPQqx9f99fZwm5ztlNtKtQ6
X-Received: by 10.107.131.38 with SMTP id f38mr583935iod.173.1471995039403;
 Tue, 23 Aug 2016 16:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 23 Aug 2016 16:30:38 -0700 (PDT)
In-Reply-To: <20160823203819.2dfa513c@labs-064.localdomain>
References: <20160823203446.40abfd37@labs-064.localdomain> <20160823203819.2dfa513c@labs-064.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Aug 2016 16:30:38 -0700
Message-ID: <CAGZ79kZ7LHx6sWdMWzv3d1SgS_PPBdVu07tGWhz14tWmAb2eJw@mail.gmail.com>
Subject: Re: Getting "The following submodule paths contain changes that can
 not be found on any remote" when they are in the remote
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 11:38 AM, Leandro Lucarella
<leandro.lucarella@sociomantic.com> wrote:
> On Tue, 23 Aug 2016 20:34:46 +0200
> Leandro Lucarella <leandro.lucarella@sociomantic.com> wrote:
>> This even happens after doing a:
>>
>> git submodule deinit <module>
>> rm -fr <module>
>> rm -fr .git/modules/<module>
>> git submodule update --init
>
> One more thing, doing a clean new clone seems to work, but I have this
> issue in many many repos, which are old clones, from before Git had the
> ability to check for submodules. Could it be some incompatibility in
> old clones with this? Is there anything I can look for in the .git/
> directory or elsewhere to fix them?

Check if push.recurseSubmodules is set?

>
> Thanks again!
>
> --
> Leandro Lucarella
> Technical Development Lead
> Sociomantic Labs GmbH <http://www.sociomantic.com>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
