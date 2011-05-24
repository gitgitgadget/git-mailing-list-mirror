From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Tue, 24 May 2011 09:43:06 -0700
Message-ID: <7v7h9g82xx.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <20110523234131.GB10488@sigill.intra.peff.net>
 <7v39k4aeos.fsf@alter.siamese.dyndns.org>
 <4DDB5C0F.1080102@drmicha.warpmail.net>
 <7vsjs48616.fsf@alter.siamese.dyndns.org>
 <4DDBDF0C.2040708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 24 18:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuhY-0001qD-R7
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112Ab1EXQnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:43:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab1EXQnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:43:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD8DB5901;
	Tue, 24 May 2011 12:45:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TZISS0dHo1/w+SeAarXI3DMFuDM=; b=tJQyUT
	3MXJB/is47i1wBW1a7P2RgvxhJPqU57hvL5dseAlhuoTFS9eTtHO0iA1PmCga8mM
	dQV960/aYdo4Jr013H627jCSkvSnPC+MEj4WIlpDtyTlqZE1LellQfuGOmiAq3vb
	o7SYFnjTAvtLleaBoD+ML4Ywpx5BBzCZjKqOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LUDKRgm3d758It4t8zz08GKI2sCpUViJ
	tJupeoj+LcDBPkOx+G8btOjhgTc73exg+odnPosZULa95I7hAFjNuGHpsaBbC1tv
	UxSDEsoEtN9/1V3gk2OBu+qQ81YAx/QR6eLzPlAbA5QQYh+Hd0hbALg9MSCxfob1
	7c7+pb9NiXk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 676165900;
	Tue, 24 May 2011 12:45:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 161BF58FE; Tue, 24 May 2011
 12:45:15 -0400 (EDT)
In-Reply-To: <4DDBDF0C.2040708@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 24 May 2011 18:38:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36D8EA5A-8625-11E0-9413-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174330>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> 	Side note: about getting stuck, will we see an update to the
>> 	diffstat count series by the end of this cycle? I do not mind
>> 	carrying it over to the next cycle at all, but I'd rather see
>> 	something already started gets finished.
>
> Yes, on my list. End of month you said, right?

Yes, but if you post anything on May 31st, it will never have enough time
to land in 'master' before the feature freeze ;-).

> I've simply been drooling too much over vim-fugitive and was wondering
> which aspects would fit into our ui.

Heh.
