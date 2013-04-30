From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour
Date: Tue, 30 Apr 2013 12:44:05 -0700
Message-ID: <7vd2tbdcsa.fsf_-_@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
	<7vli8bu3ne.fsf@alter.siamese.dyndns.org>
	<CAEBDL5VspccUmkkYBf17soGTyT3sinjnnNzRB_kytnOr3OBVQw@mail.gmail.com>
	<7va9ogezzx.fsf@alter.siamese.dyndns.org>
	<vpqy5c0oson.fsf@grenoble-inp.fr>
	<CAEBDL5W-xuNhyL81TBGhriAr2jM7CC3FtLhfcbEfEAf9GjCJAQ@mail.gmail.com>
	<CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGTM-0008D9-AH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290Ab3D3ToK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:44:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932553Ab3D3ToH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:44:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57C961B304;
	Tue, 30 Apr 2013 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p6V8+jd9wDX7Pi2OF/UO+yxAsg0=; b=PLWrji
	JDNQEkxWlkeelibgX4vpLnCtcS96u+2h3BiQjPj/Tkhsp8Kx7g4DabfmwJMOf+f7
	ajgA108bg9Z97ci3T03upR9XpFo4wcRGjhythUZskurKSphKtjGixrg+iEtBxCgg
	zCqPHzaeVarD85rEtmdmjpRZXc+gFDcD+0wRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C95pu7Rx00AYuqWmcN9hoaqSDdzETSt0
	kxRldUwqITdzSNJXqqNf9/RJvuLla1OWpKzATVkAYLYx+gZz1emZzsmAWOgg4g+t
	xayVBCO7fldN6TICGtZVzhjI/pA09MDbMRDuAa4WyPRokc34tYtBTM9dtylYUMPO
	WwlCWUpXRnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC2D1B303;
	Tue, 30 Apr 2013 19:44:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5EE31B302;
	Tue, 30 Apr 2013 19:44:06 +0000 (UTC)
In-Reply-To: <CAHQ6N+pDeeZBabiArTXJy9POv10xCBU+=46YdYmW0Ge1qVgUCA@mail.gmail.com>
	(John Tapsell's message of "Tue, 30 Apr 2013 20:31:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51D57F18-B1CE-11E2-8F3C-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222996>

John Tapsell <johnflux@gmail.com> writes:

> Is there no way to fix --cc to work even in the edge cases?

Can you clarify what you mean by "fix" and "edge cases"?
