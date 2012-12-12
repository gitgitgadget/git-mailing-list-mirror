From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 14:43:16 -0800
Message-ID: <7vhanq3n97.fsf@alter.siamese.dyndns.org>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <20121212063208.GA18322@sigill.intra.peff.net>
 <7vpq2f5ffu.fsf@alter.siamese.dyndns.org>
 <CAH5451nVqnS0UFBVDW5=Xmaj_6geiw7D7J4mR7922U+074W2qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Eric S. Raymond" <esr@thyrsus.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiv1d-0006TW-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab2LLWnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:43:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2LLWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:43:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04810A863;
	Wed, 12 Dec 2012 17:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lVUx2BTs+yq2xv4UM1gL+7r5IgY=; b=Tuq95T
	F1vFxN3E5sn5bUvKsL58npZwElBYUXdBn2Kuk/Mdfw5LWpBayRTkr17T7bzIR7y/
	sTOsPCOChg7FGdXEBNO6KRG2e42J2KJFuTyku3ri8vukqGV1GE+AyuumKpEtq6pu
	AEvQjj7Lq3jQASckZZBWa6QJRBz7RB8jVtHn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXDsGWQC7NBiceVgsnoB85tkYH6srC0z
	bYGqExat+Nzm/bkaBHvt4UJ68/BpS19QMZr81s1j1ZwVIGscTnW3X2EKHkhYjcox
	1a7RCDDjcOccKEzf+EuO2v6IRppFUR/hu6sDwZ9idmrPir8Qwct6YPGE3pUruIK0
	FQEF5ywzVuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E120FA862;
	Wed, 12 Dec 2012 17:43:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33BD6A85D; Wed, 12 Dec 2012
 17:43:18 -0500 (EST)
Importance: high
In-Reply-To: <CAH5451nVqnS0UFBVDW5=Xmaj_6geiw7D7J4mR7922U+074W2qQ@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 13 Dec 2012 09:21:55 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52C00D64-44AD-11E2-BB22-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211405>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 13 December 2012 04:49, Junio C Hamano <gitster@pobox.com> wrote:
>> "bisect" with "<used-to-be, now-is> vs
>> <good, bad>" issue unsettled
>
> Would you want to see this issue resolved in-script before a porting
> attempt was started?

Honestly, I do not care too much either way, but for the people who
want to work either on the rewrite-to-C or on the semantics issue,
it would be easier to manage it that way.

And that "issue resolved in-script" does not have to be "implemented
in-script".  The resolution could be to declare that it is not worth
it and a promise to call the two states <good, bad> and with no
other names.  It would give a semantics for the rewriters-to-C can
start working on that is stable enough ;-).
