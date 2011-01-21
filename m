From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Fri, 21 Jan 2011 09:37:33 -0800
Message-ID: <7vk4hyp38i.fsf@alter.siamese.dyndns.org>
References: <ih1449$ul6$1@dough.gmane.org>
 <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net>
 <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
 <20110120215456.GB11468@sigill.intra.peff.net>
 <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Stephen Kelly <steveire@gmail.com>,
	KDE PIM <kde-pim@kde.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 18:37:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgKvr-0006Cx-HE
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 18:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab1AURht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 12:37:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab1AURht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 12:37:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE0842B7D;
	Fri, 21 Jan 2011 12:38:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+W+86Mk9IN34V2VEddZgzQYrrx0=; b=RvzlTc
	Y7ORFILklOXR0cKonCyG6nhSWtTgeAtjSg2zhKwtB0Xm+G81yctTkRVYv2rUTSU1
	Y+wzid1FsHUn16oLGBXhpYUFr9NfXeIkrhQpoQTOUmUklX3NZNcMb0y/AZqFcCRO
	YISI9yvlqcNwBLpNKzorWwP9qtnBKbtCb656E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YjUfTFMfeCTGibbGojTyS5jnPrxOwhj9
	TYwRBP54vKgsw0vlmvGHOL2b55D7JoqxnI6f2gb33/U1sJS4JGD1SDQlxJAV4WVr
	HOMvn95dZ7OgBnilLpwiWI1HSeKiUaCXJdwQXmyVw7G2DDCkSCZA/GSJPrn8+kFs
	4UC8SBpOtVM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E38C2B7C;
	Fri, 21 Jan 2011 12:38:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A15852B79; Fri, 21 Jan 2011
 12:38:22 -0500 (EST)
In-Reply-To: <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
 (Felipe Contreras's message of "Fri\, 21 Jan 2011 01\:52\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42E25E9A-2585-11E0-8820-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165385>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I don't fully understand the issue, so excuse me if this is totally
> wrong, but wouldn't a rule like 'you can't create a branch for which
> there's already a symbolic ref' do the trick?

But whose symbolic ref are you checking against?  Your own, or ones in
somebody else's repository that you haven't recently updated from?
