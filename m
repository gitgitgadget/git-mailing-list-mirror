Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0481F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfARVAB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:00:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:54841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729553AbfARVAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:00:01 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6eTo-1h7sqd0QE8-00wV7y; Fri, 18
 Jan 2019 21:59:39 +0100
Date:   Fri, 18 Jan 2019 21:59:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Barret Rhoden <brho@google.com>,
        git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
In-Reply-To: <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com> <20190117202919.157326-2-brho@google.com> <87k1j247ui.fsf@evledraar.gmail.com> <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1698155996-1547845179=:41"
X-Provags-ID: V03:K1:HQLhrOeVrBZP8143iHziNVMygja0Wrg2/uEGTDEQ437g9jBn4na
 ttPkH7TJn1o+FACiTf0y1lsXE29waP5VhpXmg+WXMCAaul81ZrDrmEM5m8QsjECzk+53zIw
 MG6GbyKMc1EaUDK7kRTY0Vszh8sbHgiGigrbCJwmSA77TKLzUP+szTat0gXJKNCzr7SPCff
 5zNO3iTPH+Ys1bqMQQqrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RZAYFI4C8n0=:0vcNuNkgurCgHo+IsIOxB5
 Z3R70UEGZDyeJzg9Xca1F1ellJkavaiO3U2MgLxODy8V+OAiRoI2Xy4rJeFADXMDLwAqsCNty
 a8XPBz5jHGVioemsD1CQmyAW2NvHbfpjfOwH5+EiJdBXfsM0VCmK6ZkNa59x4VHQH1bXgwcdd
 HRm8sgpoisaFxKQI5kGr88zB8LreRGQgTgjcVROOpOSwSwgiBXQWrbHHXsfhPy7E1sPDVaHQg
 yXKo0w2LBVYyozyHlnwe5iJoPhazlxgh8wJhRAbpBE1JVDwujdKjqwoy0U4wfZIq31nCemEAX
 dKBukmrZUj3xgMySNYChAzowfCiHa2RtIAjD2GLxTAOcqNhwp6DwtUme+IFrnJJVOdYq3gVSr
 fe6aJrGNJ1vHcaNSBmhhGmrbTwDPYekG5Hi8uUXu4+lpGDbTF0YbHjRtph9FCcXrSfv35OO48
 RsDcJvCby4nCM1CuoMTIsPtNplrEXf79LkeJfbT6O9LQUd4VrINpFlP1vx75T6hq8tKRdl1bm
 CbZ/AzcusDpd1PizzOSVjXZTkvfzqsUdolD8iZtfgqepI9u93uaLpQX0kat7hQ5pJ7p7BpP0j
 MsMu7w0Gf3kzETLihNO7M3jKlHTFVJQftIYxg7IeDLhfs2m+eJUPIJdSlOEfhT2fvBTzQayqN
 csdN/+S2Mj0gjD+Q1nK6rnv76bQCczZnj/mweWmtPxv3H4OkEn1S6bRmhbW6QjrXGe9GOH5hr
 AQ/bfuhuWqPqqdfPRRvax+Q5/ciRtHUzEvgDwhQj7IFltWxZ09Ca2mUaljTuDFoZxDsDpgOHB
 GB5p0heWAH/e2VW4ChpdWh2JJfSQC7V9gf+Yj9S08kvF1lzLPeHm07ZvPauDdvIxjueSwcHfp
 cee98cX+IE40RBe32GZEXoIMA826rQLzSHzDTrDRs/I6YpSpKeJ6sAw/A8Pq2P9gIE9Iwlj/8
 c3KhwVLLQuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1698155996-1547845179=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Thu, Jan 17 2019, Barret Rhoden wrote:
> >
> >> -		die("Could not open skip list: %s", path);
> >> [...]
> >> +		die("Could not open skip list: %s", path);
> >
> > You're just moving this around, but now that this has two uses let's say
> > "Could not open SHA-1 list; %s" or something like that.
> >
> >> +			die("Invalid SHA-1: %s", sb.buf);
> >
> > Unlike Johannes I think it's fine to leave this. This file-format is
> > SHA-1 only now. We can cross the bridge of making it (and others)
> > SHA-256 somehow when we come to that, whether that'll be allowing
> > variable width or a different file.
> 
> I tend to agree.  The Documentation/glossary-contents.txt makes it
> clear that "object name" is the most formal term to use here, with
> synonyms like "object identifier" and much less formal "hash".  For
> now, "SHA-1" is good enough, even though "object name" is acceptable
> if we really want to future-proof.  But I would suspect that people
> would colloquially keep saying Shaah-one even when we start using
> different hash function(s), so such a future-proofing may not be
> worth it ;-)

By that reasoning all the preparatory work for switching to SHA-256 and
making the references in the Git code base less tied to SHA-1 would be
irrelevant now, "because we can cross that bridge when we reach it".

You are suggesting to incur technical debt here. Let's be smarter about
this. We do not *have* to incur said technical debt. Nothing (except
mental laziness) makes use do that.

Instead, we can make our load "when we reach that bridge" a lot lighter
by already doing the right thing.

BTW I totally disagree that the skip list is bound to be SHA-1. It is
bound to be a list of object names, that's what its purpose is, and just
because we happen to not yet support other hash algorithms but SHA-1 does
not mean that the skip list is fixed to SHA-1. It'll always be whatever
hash algorithm is used in the current repository.

So no, introducing mentions of "SHA-1" *now* is not a smart thing to do.

Ciao,
Johannes
--8323328-1698155996-1547845179=:41--
