From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Thu, 9 Jun 2016 13:48:02 +0200
Message-ID: <c4b944c7-d72b-d84b-7c53-79708af250cb@drmicha.warpmail.net>
References: <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net>
 <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
 <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
 <20160607221325.GA21166@sigill.intra.peff.net>
 <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
 <20160607222908.GA25631@sigill.intra.peff.net>
 <CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com>
 <20160608142132.GA32299@LykOS.localdomain>
 <xmqqk2hzldx8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>,
	Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:48:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAyRe-00071y-10
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 13:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcFILsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 07:48:11 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51464 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbcFILsG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2016 07:48:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B907D20767;
	Thu,  9 Jun 2016 07:48:04 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 09 Jun 2016 07:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=y92Y533YCO9YYslVwyEh0bJN13I=; b=kptag/
	dCOoLsHP0wX6LqDKun4XV2m0kSqv5gt5jgvameMJn1wsq/1hEnJ8XBaLE8FGbuIS
	nFqMotex/dFW3zBD/44ZTHMVPa7fpA1ehbdBI89TLgK3tbTfCRL5X7/USLvu8e3c
	Q8eE0IYVQYCK3u1ORgKgOTdTC17MQ4cpp/DbQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=y92Y533YCO9YYsl
	VwyEh0bJN13I=; b=RAwFLcpSfW3Au1sPEloHPYttNbi60z32MHZe7iSXHn13lPt
	VkI4fySxWuD6KUncVVC1juO1ZB2GEamXX1sWqJzUFF46UV4eo6gfJPqGW0Ko1Oki
	SSE4Ef8OIXd0pR/KHv7FtW1TgBY360mfUwfqx+56FgatrNO8Tv9Oojlz6kNU=
X-Sasl-enc: +rVpPs7B0ErysHCRKrvGn+B9tBD7KhZEszEov7ut50+K 1465472884
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id AC253F29FC;
	Thu,  9 Jun 2016 07:48:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqk2hzldx8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296880>

Junio C Hamano venit, vidit, dixit 08.06.2016 20:43:
> Santiago Torres <santiago@nyu.edu> writes:
> 
>> Sorry I'm trying to follow this. Would it be best to then have
>>
>>     verify-tag [--check-name=tagname] (tag-ref|tag-name|sha1)?
>>
>> and
>>
>>     tag -v [--check-name] (tag-name)
>>
>> Or would --format still work better?
> 
> No matter what you do, don't call that "--check-name".  It does not
> tell the users what aspect of that thing is "checked".  Avoid being
> asked "Does this check tagname to make sure it does not have
> non-ASCII letters?", in other words.
> 
> As a longer-term direction, I think the best one is to make what
> peff@ originally suggested, i.e.
> 
>     If we do go with the "print it out and let the caller do their own
>     checks" strategy, I think I'd prefer rather than "--show-tagname" to
>     just respect the "--format" we use for tag-listing. That would let you
>     do:
> 
>       git tag -v --format='%(tag)%n%(tagger)'
> 
>     or similar. In fact you can already do that with a separate step (modulo
>     %n, which we do not seem to understand here)...
> 
> work.
> 
> Thanks.
> 

The extent of this thread shows (again) that assigning trust is an
individual decision, and the base for that decision will be different in
different projects. (While the gpg project keeps emphasizing that, it
doesn't keep gpg users from thinking differently.)

All that git can realistically do is:
A) provide the answer that gpg gives (which depends on the configured
trust model, available keys and the trustdb entries) - this is about
trust in the validity of the signature

B) provide easy access to all data that a project may potentially want
to use for their manual or automatic decision - this is about trust in
the meaning of the signature

We can do better for B), and we will with a for-each-ref'ed "git tag"
that knows format strings.

Nota bene: A) really requires a tightened keyring and trustdb etc.,
something that is usually not found on the user side.

If we want to do all this "in git" we would need a "plug-in"
infrastructure/trust helper that receives the tag object and decides
about the trust (taking project specifics into account) - that is not
that much different from scripting it around git, and could probably be
"monkey patched in" today by specifying a different "gpg".

Michael
