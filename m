From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 14:40:31 -0700
Message-ID: <7vvcyb6xww.fsf@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <20110418211102.GA13566@sigill.intra.peff.net>
 <20110418211849.GB13566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBwBc-0007A2-Lh
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab1DRVko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:40:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1DRVkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:40:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0F7F4A2B;
	Mon, 18 Apr 2011 17:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dxtoBEy5iJl4DgF1D0fEAzJZXt4=; b=L/ZHcn
	mVkcV52G19xvDEv7lw5H0CDWu+S9O3bnsN52lyZ+u0op9h99evQ4+nKC5nx83+Eb
	pnasSTz+KccC15Ps18vULWkh7GpoacnYI0+wbeNSUUpx97CqRV08n5RbIFY/Aej7
	vm4eEiONCobJVEJ8m5u4VdJX4Bk69FOSfsp4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x278vwkTTaOTLJIGKktCHSuVst2SJ6Yy
	vxRWpsstRFaWBiAaxKcRJ+Dk6tQ/itvUxBsi39crHrcXwEPb3zXjpVr8dLTCVvzE
	SHVSAdHaZdGaVuqiWl6867GEFgi7K8xfVqFPONtaTfWiX6oL17ORSPhghX8S9Jah
	gfdaXuFt1Jw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD044A29;
	Mon, 18 Apr 2011 17:42:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 921684A26; Mon, 18 Apr 2011
 17:42:34 -0400 (EDT)
In-Reply-To: <20110418211849.GB13566@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Apr 2011 17:18:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7CDE304-6A04-11E0-8866-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171761>

Jeff King <peff@peff.net> writes:

> And here's the fix.

I was tempted to suggest the change in your patch.

With ebec842 (run-command: prettify -D_FORTIFY_SOURCE workaround,
2011-03-16) reverted, I still don't get complaints from -D_FORTIFY_SOURCE
for run-command.c (but I do get "ignoring return value of 'fwrite' from
many places).  Perhaps the kinds of checks done by versions of gcc you,
Jonathan and I use are different.

I'd rather revert it for now; I don't want to see patch ping-pong at this
late in the pre-release cycle.
