From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript
 a feature
Date: Fri, 27 Nov 2009 10:29:27 -0800
Message-ID: <7veinjn7nc.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <200911262224.36371.jnareb@gmail.com>
 <7vy6lsy9mi.fsf@alter.siamese.dyndns.org>
 <200911271641.40947.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5bF-0007Lr-3T
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbZK0S3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbZK0S3c
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:29:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZK0S3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:29:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 001EF833C4;
	Fri, 27 Nov 2009 13:29:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dME0TrEfbw6kkpn8E6SNFrVvuFY=; b=l/u+wLtQJv4maFNFMcjigBm
	iA+ahpWBaGMS87SJoN29T+aehK9K7Qz5oBu32cV1bwnSVOtp8xDR1AZcFGjfDPC9
	aszqjlLug5KTEBvPiq1jHud2lD6QcQXhgCEteqOdIH1UAECHHyz4D7XmDcwo17MD
	pWfBiFPN9yyskwt9JQ1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NGp0exkP6DHnEKbXA2RsajO8SvSNYKDcaI3OcNov8NoxG72yR
	DEQ3lO9f/ywcmecIQ1bw2pi2+HFKSG0Q26Zn6DTB1V+xkK4l8cTzDghrCihSoJwv
	Z+dPHOQDTt5mn+L+8bCh6Aro57S7kFZk7/fAVBNd54AFCa8Sd3d0SorJP8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B02C4833C1;
	Fri, 27 Nov 2009 13:29:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8ADD833C0; Fri, 27 Nov
 2009 13:29:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF3D57D0-DB82-11DE-A374-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133921>

Jakub Narebski <jnareb@gmail.com> writes:

> Would turning
>
>   "blame"
>
> link ito pair of links
>
>   "blame (incremental)"
>
> be a good solution?  I'm trying to come up with good naming for extra link
> to 'blame_incremental' action...

I had to step back a bit and ask myself what we are trying to achieve
here.  When the current blame and incremental one are both working
perfectly and well, will there be a reason for the end users to choose
between them when they click?

My answer is no.  If the incremental one gives nicer user experience in
all cases, it will be shown without the non-incremental one; if the
incremental one makes the server or network load too heavy, a site owner
may decide to show only the non-incremental one.

That makes my addLinks suggestion a change that would help _only_ while we
are working kinks out of the incremental one.

Let's not waste too much effort doing that.  Sorry for suggesting.

Letting the site owner choose if the site wants to set the "incremental if
possible" boolean would be more than adequate, I think.
