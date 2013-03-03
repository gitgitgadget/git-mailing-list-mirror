From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Sat, 02 Mar 2013 22:30:24 -0800
Message-ID: <7vppzhc7wf.fsf@alter.siamese.dyndns.org>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch> <CACsJy8CO1i1_QpMbLvfys=wsLDPTK69_9JanQYq2D3-fboK_WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 07:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC2Rh-0000NY-D5
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 07:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab3CCGa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 01:30:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab3CCGa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 01:30:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66E73970B;
	Sun,  3 Mar 2013 01:30:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Atg9W8YG3nsVddYxuhSIk6Ix168=; b=S7L708
	Wp3NRIRHYct++h/X3ebi12wasoRDBWWUoj40mgDwYaud3azNH9hYVP8R65o5Caec
	gD05fvsy/bci9M8Fj+h18g07XvdI/GmG/qt9rW+WnfPQy+cHK6aHyQs/zUNfRMd9
	BIrAqb902zTxjlTCuVM79kfax+SSnugx09wwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GtpImrfyyfyS5J/sKegjWRT6pNLF6T4h
	IewAarxZsKv6TG8g2yezYTfD9SzjB2ker/DSGsOL2k+MGIcsdYpVd/8wI4vhhIpO
	2mdysbRZjED90152isIn3z2tJE1SpZG0vMtpT0+5wkvZhE50tHRZpgzgk5SuPRSj
	eSJLc3G+3zE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D197970A;
	Sun,  3 Mar 2013 01:30:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D73DD9707; Sun,  3 Mar 2013
 01:30:25 -0500 (EST)
In-Reply-To: <CACsJy8CO1i1_QpMbLvfys=wsLDPTK69_9JanQYq2D3-fboK_WA@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 2 Mar 2013 10:50:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D58C88AA-83CB-11E2-A94A-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217337>

Duy Nguyen <pclouds@gmail.com> writes:

> This "return NULL;" means we ignore "!blah" pattern, which is a
> regression, isn't it? Should we treat '!' as literal here?

Probably not.  Can you point to a project everybody has heard of
that keeps track of a path that begins with an exclamation point?

With clarification to the documentation that says "you cannot use !
to negate" and your "die on such an entry", we have been going in
the direction that forbids the use of such an entry, and making it
mean literal exclamation point is going sideways in the middle of
the road.

Besides, if you want to match a path that begins with an exclam, you
can always say "[!]", no?
