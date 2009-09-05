From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking branch for a rebase
Date: Sat, 05 Sep 2009 10:59:26 -0700
Message-ID: <7v4orh1ddt.fsf@alter.siamese.dyndns.org>
References: <20090904135414.GA3728@honk.padd.com>
 <4AA124DD.1030208@drmicha.warpmail.net>
 <20090904181846.GC19093@coredump.intra.peff.net>
 <20090904185949.GA21583@atjola.homenet>
 <20090905061250.GA29863@coredump.intra.peff.net>
 <20090905140127.GA29037@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjzYD-0000pX-TX
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 19:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZIER7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2009 13:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZIER7l
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 13:59:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZIER7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 13:59:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40F3145637;
	Sat,  5 Sep 2009 13:59:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZO4pIj/hbj2y
	6eATAk/fvSQJiC0=; b=sd7pNRBdsUjDy1+sMPtWKcPxM41jPn0MbPNrl/0ijJu3
	idWo3Q2tqPKY75srHsPGwBuQvDBeEeOMOd8N507GkNhL+prmup7jKz1xf5Y60r15
	wFSTKfesexN2X4icvp8D6cQXMgecX6h7O2wigcAovCEgSxYrpXc+80n7MCih6QU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A5UYPS
	x0RNTd07Vno2mbTB6fpMutu+Um5UBuCYQ/RKYWiGLZQQmhMXOk+7GlfpcdxCCE/W
	SCA6Dvn18XQiwgyyacBbtl2nNLQboQ8tjKB/fhwVqXMk5GYIcUVFNa+HPH8WsFrR
	oJypCP79SnnCbGJy5wxPPC37z/l3WD2YmJDHI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F240C45636;
	Sat,  5 Sep 2009 13:59:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2227345631; Sat,  5 Sep 2009
 13:59:27 -0400 (EDT)
In-Reply-To: <20090905140127.GA29037@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Sat\, 5 Sep 2009 16\:01\:27
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E09C863C-9A45-11DE-85B4-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127825>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> For me, the confusion would arise from the fact that "git rebase"
> (without args) would seem like a "pull --rebase" without the fetch, b=
ut
> isn't.

It is true that one popular way to explain 'git pull' is:

    'git pull' is 'git fetch' followed by 'git merge'.

These three command names in the sentence merely refer to the concepts =
of
what they do.

It is left up to the readers to extend the concepts to concrete command
line to suit the needs for their situation.  For example you would
restate the above general explanation into this form:

       'git pull git.git master' is 'git fetch git.git master' followed=
 by
       'git merge FETCH_HEAD'

when updating your tree with the master branch of upstream git.git
repository.

Don't confuse the general concept with concrete syntax.

    'git pull --rebase' is 'git fetch' followed by 'git rebase'

is exactly the same deal.
