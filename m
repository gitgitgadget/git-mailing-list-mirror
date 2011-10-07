From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 12:59:33 -0700
Message-ID: <7v1uuovahm.fsf@alter.siamese.dyndns.org>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
 <20111007091636.GA22822@elie.hsd1.il.comcast.net>
 <4E8ECA25.205@drmicha.warpmail.net>
 <20111007100646.GA23193@elie.hsd1.il.comcast.net>
 <4E8EED39.1060607@drmicha.warpmail.net>
 <20111007195023.GA29712@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:59:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGa4-0002MH-IN
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1JGT7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:59:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab1JGT7f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:59:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 039516C60;
	Fri,  7 Oct 2011 15:59:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EyZC+bmS0W9GAY6uuJlgNYmeKrk=; b=eKUQ3d
	cSHgY0wfYC7XvuYneJNBniDMLyVPMnYA/fs8LVSgm3ydHRns57drmcHLKW111OS+
	/+yLBkCdUTLOLEwKgBfk+g9Ix+WN1lY8dDhb7GglCRSG+aNXYP3Rwrtx+tRoc/MI
	UzPrsP44TPp2zQSD1d7WQJscZ9KAEFm4gSI4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IF27XpHlJZDe3wFG36ob1GHjKozzrJVu
	5pK8XmQc+TChRSDeBLZagCTAwsuTbswUf1V3+rZFLQUtg3mDIlEpogFgiadiKb1k
	K4jf2Kz3pF9+ZfN+HA1EaehUU099WRNpi+xkX1gHo0fkidAcOhVKDohnnTaywWk4
	H576JGv1Doo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF40E6C5F;
	Fri,  7 Oct 2011 15:59:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B3A86C5E; Fri,  7 Oct 2011
 15:59:34 -0400 (EDT)
In-Reply-To: <20111007195023.GA29712@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Fri, 7 Oct 2011 14:50:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0D552DC-F11E-11E0-B77E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183102>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I am surprised that you seem to have missed what I meant by "branch
> names are local"....
> This matters, a lot, because there is no easy way to partition a
> namespace of names descriptive for humans without a central authority
> to negotiate conflicts.

I think we are in total agreement.  The branch names are local, but the
users may want to annotate to describe _the history_ they intend to build
on it.

Various ways to convey the description when the end product (i.e. the
history built on it) is shiped were outlined in the series, so that the
shipper can help the receiver understand the history. The information in
the annotation (i.e. the _value_ of branch.$name.description) is something
the shipper wants to share with the receiver, but the mapping between the
local name of the branch the shipper used to build that history (i.e. the
key "$name" in branch.$name.description) is immaterial in the end result.

I do not think there is much more for me to add to this topic, as I think
you covered all the important bases already.
