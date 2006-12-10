X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 11:09:33 +0100
Message-ID: <200612101109.34267.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612091437.01183.jnareb@gmail.com> <46a038f90612092007w4637637aya1a01ec18ff16f6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 10:07:38 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jEIV2g5xUL0JtIX1V46My8CD/ayg189PkAJ6+H8F3s54z5FxKoi2mdCPlRxJeWJxPtCUhRDiAcVh4YQk0MihwdBmFjW3knbnBhiF45ArMs8yz7uzKlRJ3uEjpqp5V54+IcVGhdqRcL5G7lM/gQdU13L0B19BZL5avmSUUUqURRo=
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90612092007w4637637aya1a01ec18ff16f6f@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33874>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtLak-0007tY-BS for gcvg-git@gmane.org; Sun, 10 Dec
 2006 11:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760617AbWLJKHU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 05:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760612AbWLJKHU
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 05:07:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:3282 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760615AbWLJKHS (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 05:07:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1077584uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 02:07:17 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr8070095ugh.1165745237372; Sun, 10
 Dec 2006 02:07:17 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id y1sm4331435uge.2006.12.10.02.07.16; Sun, 10 Dec
 2006 02:07:17 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 12/10/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> Sending Last-Modified: should be easy; sending ETag needs some consensus
>> on the contents: mainly about validation. Responding to If-Modified-Since:
>> and If-None-Match: should cut at least _some_ of the page generating time.
>> If ETag can be calculated on URL alone, then we can cut If-None-Match:
>> just at beginning of script.
> 
> Indeed. Let me add myself to the pileup agreeing that a combination of
> setting Last-Modified and checking for If-Modified-Since for
> ref-centric pages (log, shortlog, RSS, and summary) is the smartest
> scheme. I got locked into thinking ETags.

Sometimes it is easier to use ETags, sometimes it is easier to use
Last-Modified:. Usually you can check ETag earlier (after calling
git-rev-list) than Last-Modified (after parsing first commit). But
some pages doesn't have natural ETag...

Besides, because ETag is HTTP/1.1 we should provide and validate
both.

P.S. Any hints to how to do this with CGI Perl module?
-- 
Jakub Narebski
