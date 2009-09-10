From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 11:29:54 -0700
Message-ID: <7vzl92bql9.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <4AA8CA88.9060802@drmicha.warpmail.net>
 <200909101218.06789.johan@herland.net>
 <20090910111156.GA2910@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MloPY-0007S1-Gd
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbZIJSaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZIJSaN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:30:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbZIJSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:30:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC9EC4B120;
	Thu, 10 Sep 2009 14:30:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VVMFjXvXcKN7ndksyhOXqjjpeIg=; b=MA/REg
	QnB5ahJeo1ROJWY8+AINPKNQo70gBCIrEXZne+MmT51B71u2ewesZnafP0mK/7QP
	tsnkpCtXW3S+izoKC1DixI3tlFD74KiZpfmB6faFDccyHE+UYKp5bWjE2SdMfEBz
	fqGEdG6k/X7Cd2PDT64jydJct1SxokYzYSy7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WNpqd4AznPsZQX8g6QITHh2c7AEI3rvQ
	UBp/AZB3+HCVVLECZF3Y43pF2xpiIb8MZTEr98QosJ9u+faUhYGXlzIl58E7MixR
	xrugRURL+9ZTbHhY5o3wBNls/3S1MjzZTfny0/bdSFxbQlhAF4oBlfNtf1Ya/jJD
	/2zTQUlYUvs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A60A4B11F;
	Thu, 10 Sep 2009 14:30:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25EFB4B116; Thu, 10 Sep 2009
 14:29:55 -0400 (EDT)
In-Reply-To: <20090910111156.GA2910@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 10 Sep 2009 07\:11\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F711D8AE-9E37-11DE-9BBB-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128131>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 10, 2009 at 12:18:06PM +0200, Johan Herland wrote:
>
>> > > A special shortcut '@{tracked}' refers to the branch tracked by the
>> > > current branch.
>> >
>> > Sorry, I didn't know the name of the long form was up for discussion.
>> > But it should certainly coincide with the key which for-each-ref
>> > uses, shouldn't it? I don't care whether tracked or upstream, but
>> > for-each-ref's "upstream" has set the precedent.
>> 
>> ...and 'git branch --track' set an even earlier precedent...
>
> FWIW, that came about from this discussion:
>
>   http://article.gmane.org/gmane.comp.version-control.git/115765

After re-reading the discussion in the thread that contains the quoted
article, it sounds like we may want to fix "branch --track X Y".  X does
not "track" Y in the same sense as origin/master "tracks" master at
origin.  Rather, X builds on Y.
