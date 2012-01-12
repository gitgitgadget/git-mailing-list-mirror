From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 19:20:22 -0800
Message-ID: <7v62gh4nex.fsf@alter.siamese.dyndns.org>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
 <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
 <20120112025445.GB25365@sigill.intra.peff.net>
 <7vehv54o6v.fsf@alter.siamese.dyndns.org>
 <20120112031022.GC26363@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlBDM-0005My-Q3
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2ALDUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:20:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab2ALDUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:20:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED799709A;
	Wed, 11 Jan 2012 22:20:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nibjtRwrv1YHkRszZlWsGkxkCG0=; b=XzSTv0
	Jo91MpMlDXmPUOXiuxCyHUJufG0V3B4SHxjXpkeP/vqe83h0cEqa+W4gXaQK02mh
	XlL8zK+30nJKJRNUkb+YdnCvAUYzwH1+gmraAyoN/wYSDTkjcXUmPAVI3yuTw54i
	nIDRUlkPAjCKasWDFG0SRVPufg6RfjfsPnnG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XvnIfepmULidW8oSe7cdL+nhjULdBWpQ
	XgMG/bFFgTAz3HhafY9XOlpZEKwmI5YFozbuNPG2FuJClANouMu02zSVrBXx9Rjl
	cQCycPd+PPVnwTjk7M4t4pyDsLFiuHR+jF1Oz6ksk1injjuw6DOozxAWIDVosuqc
	vJi7u+mFrXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E47787099;
	Wed, 11 Jan 2012 22:20:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75F677098; Wed, 11 Jan 2012
 22:20:23 -0500 (EST)
In-Reply-To: <20120112031022.GC26363@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 11 Jan 2012 22:10:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D591F16-3CCC-11E1-B315-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188427>

Jeff King <peff@peff.net> writes:

> For a maint release, I am OK with that. In the long term, I'd rather my
> patches go onto master (either for 1.7.9 or for later), as I think they
> are the right way to do it.

I would prefer not to use it in 1.7.9, as CMN's patch will make its only
immediate user disappear. I think we are in agreement that the change to
carry context around is a longer term thing, and when we apply it, the
safety we added to "archive" will become simpler.
