From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 23:57:52 +1200
Message-ID: <46EFBD40.1070102@vilain.net>
References: <20070918072627.GB3506@coredump.intra.peff.net> <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se> <20070918103051.GA22239@coredump.intra.peff.net> <Pine.LNX.4.64.0709181217200.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbhU-00006D-Rd
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbXIRL5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbXIRL5D
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:57:03 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43666 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbXIRL5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:57:00 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 4F6BF23C266; Tue, 18 Sep 2007 23:56:59 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5322B2050FC;
	Tue, 18 Sep 2007 23:56:49 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0709181217200.28586@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58587>

Johannes Schindelin wrote:
>> I think he means a dump that you can meaningfully edit with sed or a 
>> text editor. And even nicer, one that could be fed back into 
>> git-fast-import. So you could do something like:
>>
>> git-fast-export A..B >dump
>> vi dump
>> git-fast-import <dump
>>
>> to rewrite history in a very flexible way.
>>     
>
> Exactly what I meant.  Some people seem to have problems with 
> filter-branch, but somehow no proper bug report, let alone fix, evolved 
> from that.
>
> I guess these people are more comfortable with what you just described.
>   

Guilty. my own filter-branch supports things like custom re-ordering of
commits prior to rewriting (eg, if you need to refer to one commit to
another in a commit message, you better make sure it happens in the
right order).

I personally want to be able to dump patches, including merges, to
git-format-patch format, in such a way that all other information (eg,
committer, date, etc) is preserved. And probably using something akin to
Message-Id: headers for a "patch UUID" which is what you need when
you're working with piles of patches like that.

Sam.
