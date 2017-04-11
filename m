Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C60C20970
	for <e@80x24.org>; Tue, 11 Apr 2017 12:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbdDKMhc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 11 Apr 2017 08:37:32 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:41221 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbdDKMha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:37:30 -0400
Received: from [10.1.0.219] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 57B14301D07;
        Tue, 11 Apr 2017 14:37:28 +0200 (CEST)
To:     avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        jacob.keller@gmail.com (Jacob Keller)
Cc:     peff@peff.net (Jeff King), matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git), gitster@pobox.com (Junio C Hamano)
In-Reply-To: <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Tue, 11 Apr 2017 14:37:27 +0200
Message-ID: <1n4bmi7.103j47p12fejszM%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjör? Bjarmason <avarab@gmail.com> wrote:

> Does this proposal require that all the things that can update a ref
> be hooked to maintain these lease values?

It is true that the proposal relies on people using git push and git
pull, not some lower level approximation such as git fetch + git
update-ref. Whether that's a valid assumption, I'm not sure yet. It does
mean that there are GUI tools that will break the feature; e.g. SmartGit
does use fetch + update-ref when you tell it to pull.

In general, I'm not too concerned with my proposal not supporting
certain edge-cases such as the one you described later in your mail. I
think it's fine if you have to fall back to using --force-with-lease
with explicit arguments in these cases. The suggestion is really only to
make the common case easier, which (for me) is working with a tracking
branch, and using push and pull with no arguments.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
