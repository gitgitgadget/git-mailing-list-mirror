From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 13:04:43 -0700
Message-ID: <7v7hoxpm3o.fsf@alter.siamese.dyndns.org>
References: <20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com>
 <20100326230537.GC10910@spearce.org>
 <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
 <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
 <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org>
 <alpine.LFD.2.00.1003262125120.694@xanadu.home>
 <20100327013443.GE10910@spearce.org>
 <7vvdci2vk8.fsf@alter.siamese.dyndns.org>
 <20100327192018.GG10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 21:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvcGB-0005MT-LU
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0C0UFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 16:05:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab0C0UFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 16:05:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC5AA5CE7;
	Sat, 27 Mar 2010 16:05:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Kj1bp3N4cy03/UQjphpuPth2Qs=; b=drA+Vn
	KWgtZXslDMjj6C8G5dbVNoMoTt5dYmrhSrYr9iyecDvB0So2W1eda9h1OuZnmOFi
	u/Sg6A7EuhkOLy3WstqgBKJNTF8ak21xRBuzQxKVRh3DggagE84vAiEncjswqJmp
	0F0RoTunZ5fryTLevK2V7odDhKFx9oGLTbApI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0qavBpvsQ3anhDNA1uO9JNIgt07XUPM
	6hPfLuST25SwbMCQn/75vhciDtI+98JMAt/j4KfeUhE4ZG1WyCaEpsrmH2xpMTCd
	lzuP1AThaUj+ENOoessQSXdVSSC3+Wd114dY6I9+sFK07UMshYANqbbDdgo9+DtR
	P02x92pqY24=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F9E1A5CE2;
	Sat, 27 Mar 2010 16:04:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61384A5CE0; Sat, 27 Mar
 2010 16:04:45 -0400 (EDT)
In-Reply-To: <20100327192018.GG10910@spearce.org> (Shawn O. Pearce's message
 of "Sat\, 27 Mar 2010 12\:20\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0250B63C-39DC-11DF-B474-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143353>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> JGit currently has the leading '0' be a "hard stop".  Because this is
> the fsck code running inside of the receive-pack service, validating
> what the user sent is isn't malformed.  Its clearly malformed.

The "complain loudly to let the user know about the need to fix the
corrupt repository" comment was meant for the "git fsck" equivalent of
jgit (if there such a thing).

I think "hard stop to prevent corruption from getting propagated" is
actually something we should do in receive-pack in the reference
implementation if we don't do so already.
