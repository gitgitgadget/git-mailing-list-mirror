Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8CEC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 03:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiAKDEF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Jan 2022 22:04:05 -0500
Received: from elephants.elehost.com ([216.66.27.132]:65171 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiAKDED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 22:04:03 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20B342YN003210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jan 2022 22:04:02 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com> <Ydzw+RqR6IfbT/oM@nand.local> <010b01d80697$0c848770$258d9650$@nexbridge.com> <Ydzyv8ZCEpDDRBXT@nand.local>
In-Reply-To: <Ydzyv8ZCEpDDRBXT@nand.local>
Subject: RE: [BUG] Re: Git 2.35.0-rc0
Date:   Mon, 10 Jan 2022 22:03:57 -0500
Organization: Nexbridge Inc.
Message-ID: <010c01d80697$e3324320$a996c960$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIzMkomfuhrYaYzn51cwdtqNnfQqQHkNVZQAf1QdqACJzV1/qt2hScw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 10, 2022 10:00 PM, Taylor Blau wrote:
> To: rsbecker@nexbridge.com
> On Mon, Jan 10, 2022 at 09:57:57PM -0500, rsbecker@nexbridge.com
> wrote:
> > > If your system doesn't have a modern-ish zlib, you may try building
> > > with that knob, or upgrading your system's copy of zlib. And if
> > > NonStop doesn't have a modern zlib available at all, we should
> > > modify the NonStop section of config.mak.uname.
> >
> > There is no provision in reftable/block.c to avoid using uncompress2,
> > so the knob will not help. Our zlibc is not that recent (as in it does
> > not have uncompress2) and we cannot make the 2.35.0 timeframe to
> > upgrade it. The current zlib seems to require gcc and is very
> > difficult to port at this stage. This is a blocker situation.
> 
> NO_UNCOMPRESS2 does not avoid calling uncompress2, but instead compiles
> a copy-and-pasted implementation in compat/ so that the function is available.
> 
> Looking through it, I can't imagine that it wouldn't compile just fine even on
> NonStop.
> 
> Have you tried building with NO_UNCOMPRESS2?

I'm starting a build with that now. Will report back tomorrow.
--R

