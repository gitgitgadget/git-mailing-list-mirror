Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBAC1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdFSTVp (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:21:45 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35457 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdFSTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:21:43 -0400
Received: by mail-pf0-f180.google.com with SMTP id l89so58171080pfi.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G8xfoADM1qrVDvXUxEdb0WPwga/GTPb1hxpR3lTiFQY=;
        b=K5zQz0p8kBxDWe2d+cMWB4DuzJmcnE0PPl6+LcAMElCEnhleq6uDJwBOy6gzsyqt0e
         K8Vf6CQU6SzIyylURzhNEjL+9zmt7eXOXy+VHHPgSlvrnyMdUzWDcaUUi4C1e9Hst0gE
         8n12rxVtf0QG/8cl72zSBox54ypcxftv0ZMt9LEDifwbdK5FQ/liTcULmFp9sYrg0BVJ
         zpRjobvhyJNgTT5yHD3iZoq1XBiQSchAjz5IjmAMvU1XuWJNUjMIvp5gha5WiTShDQZ0
         N+kBGy7vRfbUMPQHst/vP9D1zflhlgpGM5WN659GQOf6FSmsb61oZkZ4WO0O9E47isxP
         7geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G8xfoADM1qrVDvXUxEdb0WPwga/GTPb1hxpR3lTiFQY=;
        b=RUh03vQGy/XAiyud254+ZykywQE7By07m36qrZ62z9mZVuK+9fIC54ZF7F3dkBeDKG
         0khORDeyMUCbcdMYYSeWxyFErdr7Hh36tvkXSMvepHQTXLFQ5vd5QNLJqRjqjjfO5LsZ
         sXII13SFxHz8s7oIrvRml63NMi8rF3/txaTQguJD5OF+FlFQgoLQA+ePdA1/d9mJ2vXO
         IsCcvQQzSpGSGXythAvRFOXYiUBKIVAf8N+z72grg7MZK949rdCsZbE3AykIQxoKGSfI
         JQv6ZbrcLusVrDDmgfVKDUNX4PJHGDLe0KGFdWKVlcf2SQpTphOEZuoyt7KO6AzWH/kD
         g5zQ==
X-Gm-Message-State: AKS2vOw9jOdlLlymO6PIJHI1/dwXSIceQXHWhXGKzwmOAo9kP/WHo9Xx
        YooxXYWsi5q9FfVvkZPMgiVEioRBtNAX
X-Received: by 10.99.186.81 with SMTP id l17mr8354852pgu.87.1497900097180;
 Mon, 19 Jun 2017 12:21:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 12:21:36 -0700 (PDT)
In-Reply-To: <0092CDD27C5F9D418B0F3E9B5D05BE0801028B70@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
 <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>
 <CAGZ79kbMOdkKiVsvxk4UeKKPicyi958LpomeY=ypXT0_=5d8BQ@mail.gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE0801028B70@SBS2011.opfingen.plc2.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 12:21:36 -0700
Message-ID: <CAGZ79kYB__LOK5MhK_OrXYL1xYgYW0Hk5XfjYfRWAcH_AJ78uQ@mail.gmail.com>
Subject: Re: Restoring detached HEADs after Git operations
To:     Patrick Lehmann <Patrick.Lehmann@plc2.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:09 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello Stefan,
>
> the use case is as follows:
>
> The projects consists of circa 18 IP cores. Each IP core is represented b=
y a Git repository. Think of an IP core as of a lonestanding DLL or SO file=
 project. Each IP core references 2 submodules, which bring the verificatio=
n environments for testing the IP core standalone.

So phrased differently: You are using submodules to avoid "DLL hell"
(sharing a lib, with ease of versioning as the submodules in the different =
IP
cores may be pointing at different versions).

>
> These 18 IP cores are grouped to bigger IP cores, referencing the low-lev=
el IP cores and each again the 2 verification submodules. Finally, the main=
 project references the bigger IP cores and again the 2 verification cores.
>
> TOPLEVEL
>   o- IP1
>        o- UVVM
>        o- VUnit
>   o- IP2
>        o- UVVM
>        o- VUnit
>   o- IP3
>        o- UVVM
>        o- VUnit
>   o- IP4
>        o- UVVM
>        o- VUnit
>        o- IP5
>            o- UVVM
>            o- VUnit
>        o- IP6
>            o- UVVM
>            o- VUnit
>        o- IP7
>            o- UVVM
>            o- VUnit
>   o- IP8
>        o- UVVM
>        o- VUnit
>        o- IP9
>            o- UVVM
>            o- VUnit
>        o- IP10
>            o- UVVM
>            o- VUnit
>   o- IP11
>        o- UVVM
>        o- VUnit
>        o- IP9
>            o- UVVM
>            o- VUnit
>        o- IP12
>            o- UVVM
>            o- VUnit
>    o- UVVM
>    o- VUnit
>
> That's the simplified structure. I can't write more, because it's a close=
d source project. You can find other usecases e.g. in my other open source =
projects. E.g. The PoC-Library or The PicoBlaze-Library and the correspondi=
ng PoC-Examples repository.
>
> Example: PoC
> Pile of Cores includes 4 Git submodules and is itself an IP core library.
> So PoC-Examples again references PoC. This looks like this tree:
>
> PoC-Examples
>   |- lib/
>        o- PoC
>             |- lib
>                 o- Cocotb
>                 o- OSVVM
>                 o- VUnit
>                      o- .... OSVVM
>                 o- UVVM
>
> The library VUnit itself already includes OSVVM as a library.
>
> ----------------------
> Forcast:
> I'll write a new question / idea about multiple equal submodules and the =
memory footprint soon...
> Here is my original question posted on StackOverflow: https://stackoverfl=
ow.com/questions/44585425/how-to-reduce-the-memory-footprint-for-multiple-s=
ubmodules-of-the-same-source
> ----------------------
>
> Do you need more use cases?
>

Well this use case points out a different issue than I hoped for. ;)
From the stackoverflow post and from looking at the layout here,
one of the major questions is how to deduplicate the submodule
object store for example.

By use case I rather meant a sales pitch for your initial email:

    I use this bash script because it fits in my workflow because
    I need branches instead of detached HEADS, because $REASONS

and I'd be interested in these $REASONS, which I assumed to be
* easier to work with branches than detached HEADS (it aids the workflow)
* we're not challenging the underlying mental model of tracking sha1s in
  the superproject rather than branches.

At least I gave these reasons in the "reattach HEAD" stuff that I wrote,
but maybe there are others? (I know the code base of submodules very
well, but I do not work with submodules on a day-to-day basis myself...)
