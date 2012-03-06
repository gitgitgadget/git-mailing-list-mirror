From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Tue, 06 Mar 2012 10:31:12 -0800
Message-ID: <7vmx7ttwcv.fsf@alter.siamese.dyndns.org>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
 <20120305132913.GA15004@sigill.intra.peff.net>
 <7v8vjf2c8o.fsf@alter.siamese.dyndns.org> <87399mazxs.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>,
	<git@vger.kernel.org>, Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:31:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zAU-0005h3-L6
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780Ab2CFSbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:31:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932616Ab2CFSbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:31:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7823F5019;
	Tue,  6 Mar 2012 13:31:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGM/sLWsJDamh6oEJQ6W3FyWMOE=; b=K4FEoO
	1IaFphzEPjKbr6L4oGMK469pxDYN2c7P6OilK9n0rFlJ22qideshHU2LqKVx1mRZ
	kaYeVoSEZN9ME6FVG3opN0EqPi7A/mG3r5ulFx2uBSQt3K+5oi18Alf9BJBLqs3K
	MZRSq78l7PsK8m+12+J8TVakj38Prtla2iYa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=efW4/X6JKu6sjwif/+8FyIjQz/nwLR2W
	ofttb1f78c2ZUaHHWcRzsATn45y1T2+vqE6IcgTJL9RzUNV/bRLFG6IwIicwNPGS
	dp8CxY1ZNfWCB4vgenFRQoahJ0vM8Yht31gkyukTIVphrkpTa2dbvXm0m06lOLsK
	vHSKSmEHacY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DEA55017;
	Tue,  6 Mar 2012 13:31:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04E585016; Tue,  6 Mar 2012
 13:31:13 -0500 (EST)
In-Reply-To: <87399mazxs.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 09:36:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DE9E8FE-67BA-11E1-9020-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192370>

Thomas Rast <trast@inf.ethz.ch> writes:

>> 	git show -s --format='
>> 		GIT_AUTHOR_NAME=%(sq-begin)%an%(sq-end)
>>                 GIT_AUTHOR_EMAIL=%(sq-begin)%ae%(sq-end)
>>         '
>
> How about something along the lines of %Q(%an) instead?  Though at least
> implementation-wise, it should be possible to make %'%an%' work, too,
> which would be rather cute.

It would be also less error prone from end user's point of view if
your closing token is not ")" (as in %Q(%an)) but percent-something,
e.g. %<%an%>, %`%an%', or %'%an%'.  The way to quote a string that
happens to be the same as closing token you want to put in the
quoted string would be more obvious (e.g. ID=%Q(%ae (%an%29) is a
bit hard to read for ID='gitster@pobox.com (J C H)').

	ID=%'%ae (%an)%'

As I do not expect these things to nest (do we want to be able to
formulate a string that can be eval'ed twice???), using the same
string for both opening and closing token is fine by me.
