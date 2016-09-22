Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE781F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 19:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757739AbcIVTsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 15:48:53 -0400
Received: from ikke.info ([178.21.113.177]:56100 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757593AbcIVTsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 15:48:50 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 920D04400AA; Thu, 22 Sep 2016 21:48:48 +0200 (CEST)
Date:   Thu, 22 Sep 2016 21:48:48 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
Message-ID: <20160922194848.GB6641@ikke.info>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de>
 <ns1bln$2ej$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ns1bln$2ej$1@blaine.gmane.org>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 07:33:11PM +0000, Anatoly Borodin wrote:
> Hi Stefan,
> 
> this section was added to the manual in the commit
> cddb42d2c58a9de9b2b5ef68817778e7afaace3e by "Jonathan Nieder"
> <jrnieder@gmail.com> 6 years ago. Maybe he remembers better?
> 

Just to make it clear, this section explicitly talks about 'bugs' with
preserve-merges and interactive rebase.  Without the --preserve-merges
option, those operations works as expected.

The reason, as that section explains, is that it's not possible to store
the merge structure in the flat todo list. I assume this means git
internally remembers where the merge commit was, and then restores it
while rebasing.

Changing the order, or dropping commits might then give unexpected
results.


