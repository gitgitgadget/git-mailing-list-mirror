From: Junio C Hamano <gitster@pobox.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 03 Oct 2012 11:53:35 -0700
Message-ID: <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJU4v-0004iQ-03
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab2JCSxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:53:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab2JCSxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:53:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9468E9494;
	Wed,  3 Oct 2012 14:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l1Tchhu2IZ6SD1idBJFLhrdDE+M=; b=t6FoJi
	3p9JmiJS/Wyp37kxK12+tO+4Y9wP4dYqODR8I4QPsH+cBJ54qwfxds/1zd/TLY4C
	8B37fbVc04eFotpCMvVs32alaGvxMC10g6EXwPuNpWZ+/YEu9/JGB/G1PUTrbufN
	jZVORcPbtAFam27+Ojp3BIdc0lfYihEXQkZjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vxFMPacR7Re6KznfH5x3LuIQM7ssRGgp
	qPIgLnav4SNgFKFJNEzzxDBEfg9kmC2MCQN8LsoTqQuro3X0DwJYvYLGn3AH5UiN
	cQ8T2Gb7JWk9mk8G1NkTyVCK2+buOQFjMK4vK+7Gatb2LPs5O727sfOuANqnxRS2
	XrBDrppibYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80579948F;
	Wed,  3 Oct 2012 14:53:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8794948C; Wed,  3 Oct 2012
 14:53:36 -0400 (EDT)
In-Reply-To: <20121003180324.GB27446@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 3 Oct 2012 14:03:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A385ABCC-0D8B-11E2-AD5E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206922>

Jeff King <peff@peff.net> writes:

>> Has there been any work on extending the protocol so that the client
>> tells the server what refs it's interested in?
>
> I don't think so. It would be hard to do in a backwards-compatible way,
> because the advertisement is the first thing the server says, before it
> has negotiated any capabilities with the client at all.

That is being discussed but hasn't surfaced on the list.
