From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: does index-pack work in place on windows?
Date: Wed, 02 Feb 2011 23:24:56 -0800
Message-ID: <7vk4hhwpfb.fsf@alter.siamese.dyndns.org>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
 <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
 <alpine.LFD.2.00.1102030026430.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 08:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PktZC-0002du-Fd
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 08:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab1BCHZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 02:25:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab1BCHZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 02:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8DE22640;
	Thu,  3 Feb 2011 02:26:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NekrlH0jGE8gknQ43vZJtPa3K1E=; b=ITQRMJ
	HHDCUOoujkem9CEawLy0NCu8YgnTJchWepMXeVg2I8ToJCd8+6Jgrav/l+Csam5U
	zzh2gXKT1nj+mm8H73GllfRwIHzpVj3Oq61bYC0EuIWgYkZv1r0jVpbdg7gY/C7I
	FlQ+8nbaPw5RMw+FWizxgUccNf6k7sU/j+aOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lPYS6mrMpzZ9bc3IyYeRwYCGmVWVtZdR
	FeKah9QaYrKX8NUDeQkgaFq4m/odZ8Jao7W2GbGW4ZF+z7RDLoQBrUvY5PxpRtd9
	1xP6PT0mByG7+HcTIYR/oJOp+scXi3jyzTOFYsEmBFoNF+5nn4pOykVBG/pIxVD/
	sg9K6xRWTkc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D394263C;
	Thu,  3 Feb 2011 02:25:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6083263B; Thu,  3 Feb 2011
 02:25:52 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1102030026430.12104@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 03 Feb 2011 00\:32\:02 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D904AB2C-2F66-11E0-B75F-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165963>

Nicolas Pitre <nico@fluxnic.net> writes:

>> $ git index-pack
>> .git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.pack
>> Unlink of file '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx'
>> failed. Should I try again? (y/n)? n
>> fatal: unable to create
>> '.git/objects/pack/pack-d634271f4d7ca70c00148e967a343c3c46cd7705.idx':
>> File exists
>
> Why would you do such thing in the first place?
>
> If the pack exists along with its index on disk, there is no point 
> recreating it.  Maybe index-pack should just bail out early in that 
> case.

I am trying to see if an index-pack with slight modification would be a
good replacement for verify-pack.
