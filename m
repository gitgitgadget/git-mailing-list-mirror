From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 12:47:15 -0700
Message-ID: <7vd2uvi33w.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin> <20130319034822.GL5062@elie.Belkin>
 <vpq1ubb3o5g.fsf@grenoble-inp.fr> <7v620nl99g.fsf@alter.siamese.dyndns.org>
 <20130319190624.GB3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 20:47:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI2Vl-0002sf-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 20:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab3CSTrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 15:47:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3CSTrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 15:47:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE88A8DB;
	Tue, 19 Mar 2013 15:47:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6YJz93wBjdgADrovL8QpYkCHfg=; b=NHevL/
	Brpf5xkt/HaSOG4AwIGFbh0Yrgk3gHz/QO1wEqJxX/lLdhVRPrZXPg/nWJlVl2sA
	Wvt/l2tDNphVpmLYU4hk4VV2b2vz6TrFsRdxowvgpH5WC62iy4+7SR8lf5mZVHN/
	54J6rI7NRlA2wyNHF5yUJWN7Vxvq1DUwYAfM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=csPY9e12dRq1ktYQrUh2/glN3QYsNPYt
	ILgjad8ZHCPIwPYo9jm+pY4YJdjv1712AXtSJ5dp7BJKrEX4q5h+eQfgn1NBUgHj
	tyhi8dFNMYr3Sm/Ltjm4/Mgl+w0kO3H+ue78FRRPbom5wYpxZ1gR9rMfyTxl6pWg
	PlHKzD3SC9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D05D7A8D9;
	Tue, 19 Mar 2013 15:47:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC23A8D8; Tue, 19 Mar 2013
 15:47:17 -0400 (EDT)
In-Reply-To: <20130319190624.GB3655@google.com> (Jonathan Nieder's message of
 "Tue, 19 Mar 2013 12:06:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDFF1904-90CD-11E2-8C06-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218551>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...  So I
> find myself being trained to ignore the warning.
> ...  Running a full-tree diff which slows down
> the code that decides whether to print a warning is a good way to
> train people regarding how long to expect a plain "git add -u" to
> take.

Ok, fair enough.

Incidentally, I am rebuilding the 'next' by kicking many of the
topics back to 'pu' (essentially, only the ones marked as "Safe" in
the latest issue of "What's cooking" are kept in 'next'), so perhaps
we can rebuild the jc/add-2.0-u-A-sans-pathspec topic with your
series at the bottom, or something?  I do not think I have time to
get around to it myself until later in the evening, though.
