From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 04 Jun 2013 10:35:49 -0700
Message-ID: <7vbo7l93t6.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujv9K-0004Uh-FF
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab3FDRfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:35:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953Ab3FDRfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:35:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C320225ED2;
	Tue,  4 Jun 2013 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DNh7Uett71FeK90wNzpVbzs68Eo=; b=DvZwWf
	dS7INXO4r7EUqO4geYoNdIyhd2BlbDbPmk3icc1UTazr0cKinY7pTKeSiXaGYLM2
	WMRuio2asZ/mT5RbwB9mSUAMYemiVPqUsyYUJ+LIPDm7WSc3GeQwJx1GK/OLgtN0
	5deTwA+XssHn2rG6fYoCnij45AmeVzbWG9/yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+Q3/K1WsVK01wOj/pZLmnFYP2DZVZOL
	pm8BanRv9QlBVd2TpAUfeaaekjvXzbPkNitLT5QDMEAsJEseO7+EeY0M4Zsh8hNU
	nf6pbELi6YRRhMOjvavDiIoy15NNsQBczdhOsnLFN1moi18W7ZVW70GBOVIBOBqu
	tiU+kylyq4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5B5A25ED1;
	Tue,  4 Jun 2013 17:35:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBF7725ECE;
	Tue,  4 Jun 2013 17:35:51 +0000 (UTC)
In-Reply-To: <CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 4 Jun 2013 12:10:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33A6FE74-CD3D-11E2-9313-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226383>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I think just "Skip commits that are or become empty" without saying
>> "Instead of failing," is fine, too.
>
> I think "Instead of failing" makes perfect sense, because it's not our
> job to describe what other options do,...
> ...
> simply explain what this option
> do.

Which means "Skip commits" and nothing else.  Saying "Instead of
failing" explains what would happen if you ran the command without
any option, which is entirely irrelevant, just like the case when
you ran the command without an unrelated option --allow-empty.

We share the same "the --skip-empty option does not have anything to
do with the --allow-empty option, and we do not have to say anything
about what happens when the command is run with that unrelated
option".

But we are viewing it from a different angle.
