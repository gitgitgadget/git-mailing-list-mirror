From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add 'ls' command
Date: Thu, 02 Dec 2010 11:20:09 -0800
Message-ID: <7vr5e0q8wm.fsf@alter.siamese.dyndns.org>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <1291286420-13591-2-git-send-email-david.barr@cordelta.com>
 <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
 <20101202173722.GE3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:21:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEi7-0000t4-Gf
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab0LBTUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:20:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757456Ab0LBTU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:20:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DBB42987;
	Thu,  2 Dec 2010 14:20:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=plcI+EHPMfvq2kYWau0KRdaFwZ8=; b=yDbjxK
	9Oxz2vulcRSClm1Lao0G2AYq+pKZdu8BrBV67XKB6CyfLZTHNPlscC9VV71pPVFJ
	4GfXj0qaNIvbChzNfLId6T0DkHkwddcDZjPIWRTmrRXEpSxIRxQboSb3o9rOS6N1
	rUROmugJu5jKQC4tAkBwrQmfR9Eefuoq+sk+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7NObqtQC84lad1d+Scu4yKYDaW9OsbM
	K+Rm7zNeji8Aoaw3CKtrL1JHdtKs/uxaNWC0tgN913P15fOPHqi/37w7mcmBz27B
	TwbVmpv5nGjD30GzLynIxdJRD3kyqeMGMaGexRR3vIo6B+HpDVqnT/Pbcoht9yXe
	Df7cAWpYGCo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DABFC297C;
	Thu,  2 Dec 2010 14:20:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18DB1296F; Thu,  2 Dec 2010
 14:20:31 -0500 (EST)
In-Reply-To: <20101202173722.GE3962@burratino> (Jonathan Nieder's message of
 "Thu\, 2 Dec 2010 11\:37\:22 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FA998E6-FE49-11DF-914A-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162736>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I somewhat agree.  Actually I would go further: the word "index" brings
> to mind .git/index and its in-core counterpart, so at the same time as
> documenting it better, we might look into making it more self-
> explanatory.  Maybe a syntax like
>
> 	ls current "path/to/entry"
>
> would make it clearer that this is about directory entries in
> fast-import's active commit and not necessarily the usual index file?

I think that explains the feature better.  I was wondering if the stream
somehow wanted to access the state the index of the repository happens to
be.

> I am not sure what syntax other vcs-es use for tree-ishes.  To avoid
> name clashes (what if 'current' is the low-level name of a tree-ish?),
> an alternative might be
>
> 	ls-tree :11 "path/to/historical/entry"
> 	ls "path/to/current/entry"

Is it an option to use "ls" for both cases and treat one-arg and two-arg
cases differently?
