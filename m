From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript
 a feature
Date: Mon, 30 Nov 2009 17:18:38 -0800
Message-ID: <7v4oob8pap.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <200911262224.36371.jnareb@gmail.com>
 <7vy6lsy9mi.fsf@alter.siamese.dyndns.org>
 <200911271641.40947.jnareb@gmail.com>
 <7veinjn7nc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 02:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFHOK-0001u2-8f
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 02:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZLABSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 20:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZLABSo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 20:18:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbZLABSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 20:18:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 404D28483F;
	Mon, 30 Nov 2009 20:18:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h+eC9UCOXxIeULKrypVLMRhlnAE=; b=gY++aS
	xFbBw18zsiJrblvbncJVph9HdRjxBNk4a8RFn8kLnSgg5XewzM5/iQgbDOx0Gt1V
	nSoLYMQa58plZs6s8WhsLvaJMGspw6DIrSAMVZflc2J1q6vqATdcjqQV0XjvxkL8
	eMsIzK4M96NsMzjS5uOIxmJ9efOthC+qx6VQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CmNXROTnqeDbyJ3H1xClCPJqw2HaP1Aq
	VzeYVJppxKcfpex3GWCHECPLfumVBKlQdmxBmwkpPgXZtdnU37clwwnSoHTjwvQx
	nce36k2sQrAakTMNvCzfZ/B4auvALwxEP72haOwJt7N26N4S3gDQfoZFN6AElllo
	vts2iU9fKgE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E28C68483E;
	Mon, 30 Nov 2009 20:18:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA0CD8483B; Mon, 30 Nov
 2009 20:18:39 -0500 (EST)
In-Reply-To: <7veinjn7nc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 27 Nov 2009 10\:29\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7824CDEC-DE17-11DE-A3F0-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134161>

Junio C Hamano <gitster@pobox.com> writes:

> I had to step back a bit and ask myself what we are trying to achieve
> here.  When the current blame and incremental one are both working
> perfectly and well, will there be a reason for the end users to choose
> between them when they click?
>
> My answer is no.  If the incremental one gives nicer user experience in
> all cases, it will be shown without the non-incremental one; if the
> incremental one makes the server or network load too heavy, a site owner
> may decide to show only the non-incremental one.
>
> That makes my addLinks suggestion a change that would help _only_ while we
> are working kinks out of the incremental one.
>
> Let's not waste too much effort doing that.  Sorry for suggesting.
>
> Letting the site owner choose if the site wants to set the "incremental if
> possible" boolean would be more than adequate, I think.

Sorry, but I guess I dropped the ball after this message.  If I understand
correctly, the conclusion is that I can apply the patch in this one

    From: Jakub Narebski <jnareb@gmail.com>
    Subject: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
    Date: Thu, 26 Nov 2009 21:12:15 +0100
    Message-ID: <200911262112.16280.jnareb@gmail.com>

and shipping 1.6.6 with it (perhaps setting 'default' to '[0]' instead)
would be both reasonably safe and allows easy experimentation by willing
site owners (or individual gitweb deployment), right?

Please advice if I am mistaken.

Thanks.
