From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 21:51:11 +0200
Message-ID: <85odge2r0w.fsf@lola.goethe.zz>
References: <1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp>
	<fbs79k$tac$1@sea.gmane.org> <20070907194115.GA23483@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjrM-0007A9-An
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260AbXIGTvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758221AbXIGTvO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:51:14 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:56582 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507AbXIGTvN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 15:51:13 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 359182CAE19;
	Fri,  7 Sep 2007 21:51:12 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 259D12DABB1;
	Fri,  7 Sep 2007 21:51:12 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id DCCF81C3328;
	Fri,  7 Sep 2007 21:51:11 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 891D11CAD71D; Fri,  7 Sep 2007 21:51:11 +0200 (CEST)
In-Reply-To: <20070907194115.GA23483@artemis.corp> (Pierre Habouzit's message of "Fri\, 07 Sep 2007 21\:41\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4183/Fri Sep  7 21:19:48 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58063>

Pierre Habouzit <madcoder@debian.org> writes:

[bit fields]

>   Really, I feel this is a big lack, for a language that aims at
> simplicity, conciseness _and_ correctness.
>
>   OK, maybe I'm biased, I work with networks protocols all day long, so
> I often need bitfields, but still, a lot of people deal with network
> protocols, it's not a niche.

And strictly speaking, C bitfields are completely useless for that
purpose since the compiler is free to use whatever method he wants for
allocating bit fields.  So if you want to write a portable program,
you are back to making the masks yourself.

Where bit fields work reliably is when you are not interchanging data
with other applications, but just laying out your internals.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
