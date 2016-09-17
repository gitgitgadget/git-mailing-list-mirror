Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADF31FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbcIQTXp (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 15:23:45 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48665 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbcIQTXo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 15:23:44 -0400
Received: from PhilipOakley ([92.22.56.161])
        by smtp.talktalk.net with SMTP
        id lLDBbwaXL0KuvlLDBbgbdp; Sat, 17 Sep 2016 20:23:42 +0100
X-Originating-IP: [92.22.56.161]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=jHxjN4OXtc1iyzOC0JcFMQ==:117
 a=jHxjN4OXtc1iyzOC0JcFMQ==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=dR93qLnKvFpa2NLYlOAA:9 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <FD07B781038A4C878F6D0152A4ECE580@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <3C23ED270E0C486EB2063BC5AEC25678@PhilipOakley> <CAPc5daUN7s+asu=drJRp=d1a5VRvG_EFNTsTqaQB+NZGDrzRmw@mail.gmail.com> <CAPc5daUsRtR0=C8D=gqTtk=2erqX1DHsYNbQzmyAyw+prCBrfQ@mail.gmail.com> <CAPc5daUdM4wwY7C_YKx0DkW3kty+VewksMMXG39bBr1K-JxBag@mail.gmail.com>
Subject: Re: Finding a commit based on the diff index line?
Date:   Sat, 17 Sep 2016 20:23:42 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfK3N1SWUgKAv8tzvzDRRTppiK1WfrkLI224DwVtDx4MePRVcB4CcIRPnMQIUNFUOcFbovdXZEr22AOV1QpVEABxNdDMLz3/XzmRO4+MEc+71kp/ZYHLi
 qp5fkkY36Zb2rWVKp85DNFf7vYVeCB6qsQ9wxpd5+1yHwGQ+WWVDZwxIzcpDiGXSaeuDIRgQqmysMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano
> Sent: Saturday, September 17, 2016 5:30 PM
>
> Does it count as simple to use pager's search feature in
> "log --raw" output piped to it?
>
> Pardon typos & html; typed on a phone
>

The `log --raw` looks useful, though I think (IIUC) I also have a problem 
that (obviously?) these commits are not linked behind any existing ref 
(except maybe the reflogs which I'm not up to speed on).

I had somehow hoped for some neat magic command or rev specifier that took 
the revs as alternates to the `-- <paths>` in rev-parse or some such....

It's tricky curating old mistakes ;-)

Thanks for the pointer.

> On Sep 17, 2016 07:33, "Philip Oakley" <philipoakley@iee.org> wrote:
>
> > Hi,
> >
> > I'm curating some of my old patch series (i.e. doing some tidying up) 
> > and
> > I'm trying to determine the commits that generated some of my patches so
> > that I can see if I still have them after they were rebased (a 'name 
> > that
> > dangling branch' problem).
> >
> > Is there an easy way of finding the commit sha1 that contains the given 
> > diff
> > index line.
> >
> > For example.
> > index fa05269..57033dd 100755
> > or
> > index 8ebcded..d9ab360 100644
> >
> > which both should get back to Jeff King's 36d6792 (t0006: test various 
> > date
> > formats, 2016-06-20).
> >
> > It feels like it is something that should already possible without a
> > mini-script. We have the rev range which should limit the range to a 
> > single
> > commit, though if random blob revs were given the commit range would be
> > 'scattered'.
> >
> >
> > Is there a simple quick way of achieving this?
> >
> > --
> > Philip

