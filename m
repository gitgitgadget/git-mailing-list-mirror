Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A2B208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeHFTOQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 6 Aug 2018 15:14:16 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41296 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeHFTOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:14:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w76H4EAb053724
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Aug 2018 13:04:15 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Duy Nguyen'" <pclouds@gmail.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Stefan Beller'" <sbeller@google.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>,
        "'Han-Wen Nienhuys'" <hanwen@google.com>
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com> <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com> <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com> <87zhxzsb2p.fsf@evledraar.gmail.com> <20180806170211.GD19053@sigill.intra.peff.net>
In-Reply-To: <20180806170211.GD19053@sigill.intra.peff.net>
Subject: RE: [PATCH] Makefile: enable DEVELOPER by default
Date:   Mon, 6 Aug 2018 13:04:09 -0400
Message-ID: <001101d42da7$8128a560$8379f020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHcHQgNlToVxohtCSKuj/FaLNrO4gKynkmJAzrMNb8BurMUxgJD1Su/Afe4naYCYOK5uKQw8DoQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 6, 2018 1:02 PM, Peff wrote:
> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>; Duy Nguyen
> <pclouds@gmail.com>; Jonathan Nieder <jrnieder@gmail.com>; Stefan
> Beller <sbeller@google.com>; Git Mailing List <git@vger.kernel.org>; git-
> packagers@googlegroups.com; Han-Wen Nienhuys <hanwen@google.com>
> Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
> 
> On Mon, Aug 06, 2018 at 06:40:14PM +0200, Ævar Arnfjörð Bjarmason
> wrote:
> 
> > Responding to the thread in general, perhaps people would like this
> > more if we turned DEVELOPER=1 DEVOPTS=no-error on by default?
> >
> > That's basically why I added it in 99f763baf5 ("Makefile: add a
> > DEVOPTS to suppress -Werror under DEVELOPER", 2018-04-14), because I
> > wanted the abilty to have verbose informative output without the build
> > dying on some older systems / compilers.
> >
> > It's fine and understandable if you're someone who's just building a
> > package on some older system if you get a bunch of compiler warnings,
> > but more annoying if you have to dig into how to disable a default
> > -Werror.
> 
> I had the impression that DEVELOPER=1 was allowed to set flags that old
> versions might not even know about. Hence they might actually barf, even
> without -Werror. Maybe that's better since the introduction of the detect-
> compiler script, though.
> 
> I do think we may have a skewed view of the population on this list.
> We're developers ourselves, and we interact with new developers that we
> want to help.  But there are masses of people[1] building Git who are _not_
> developers, and want the default to be as robust as possible.
> They're probably not going to show up in this thread.
> 
> -Peff
> 
> [1] I actually wonder how large that mass is. Clearly there are many
>     orders of magnitude more users than there are developers. But I have
>     no idea what percentage of them build from source versus using
>     somebody else's binary package.

One? 😉

Jokingly,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



