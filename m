From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 07 Jun 2016 15:21:48 -0700
Message-ID: <xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
References: <20160607195608.16643-1-santiago@nyu.edu>
	<xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
	<20160607211707.GA7981@sigill.intra.peff.net>
	<xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
	<20160607215536.GA20768@sigill.intra.peff.net>
	<xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
	<20160607220743.GA21043@sigill.intra.peff.net>
	<CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
	<20160607221325.GA21166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: santiago@nyu.edu, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:23:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPNq-00008X-FG
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbcFGWVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:21:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753554AbcFGWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:21:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE41323CA0;
	Tue,  7 Jun 2016 18:21:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsPIQkK8ePVOk9IXR+Q/vPX+waU=; b=eANspm
	gW0AEGaonSyK1qn8pbAdbpeNXW/yAGBztZ2TEdH8Iu/wyhrzycofuDx3/V51PZEy
	8Mz/cRm9balNxVqnSIJYyM7TYzkn6C/vg8dXOJnYzvzSHWxHUnfLWApxj+aHkXmP
	8qeA7xVWiItM7aDCch1w07EpuNZsAxWfb3zLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Esnl92aDeNUTCZ6SVXuooWmztqxdCiG0
	6ah72iTPR2aGNE4f0JWn0SDJaYEPSQpR4Oxw5IIrd1QrwZMjaj4Whles5GUK+F16
	GtnbPhARPGPan1K69vv3D/zhDe+pdADlmhl1zPDa47ACd/l3MD7CxSdJwCvtUbz0
	LtuBhz+BC3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5EA323C9F;
	Tue,  7 Jun 2016 18:21:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F8B823C9E;
	Tue,  7 Jun 2016 18:21:50 -0400 (EDT)
In-Reply-To: <20160607221325.GA21166@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 18:13:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AD9FA60-2CFE-11E6-9FA9-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296738>

Jeff King <peff@peff.net> writes:

> If you are suggesting that you can do the whole thing today by parsing
> the tag object yourself, then sure, I agree. I thought the point of the
> exercise was to make that less painful for the callers.

Yes, and I somehow thought everybody agreed that --show-tag-name was
striking the balance at about the right level for ease-of-use and
simplicity?
