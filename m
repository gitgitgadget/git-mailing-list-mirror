From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Tue, 02 Apr 2013 12:09:17 -0700
Message-ID: <7vr4isda1u.fsf@alter.siamese.dyndns.org>
References: <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com>
 <51597A37.1010301@web.de>
 <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
 <20130402185426.GG28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6ac-0002F5-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761559Ab3DBTJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:09:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761146Ab3DBTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:09:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 136E812078;
	Tue,  2 Apr 2013 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AoRwB0Z88V5xrZfACNvb6SdVj2M=; b=Co0vYm
	4kXnI9YkF0LPlZgj3xYZcSMPT3DQV6Ggd+hxPtLCnA9IJeV0WQCmRMSGZkUZteK3
	Gaslpu1trNLkpdJUUR4uBSS09w3C/fkvYhUlKjYdM92aEykH7S9TDNAFjJNSRdKj
	MAvZOtiCnZxnTKDzgLTnhtFN12Hl8CaJG/lys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5d63bi8RgFOdmU+vusT5k+Qmgr+y18T
	dc83KOIuHYR5O4OqjASCoDewAVD1sik7Z22+j3lM94Urb5b7M4BdzN4UGqykFu5x
	HhCra5SDNXThhwit6xc4c+F9Tv+Buz64fhN6NRqMHHqbL+N3Tc9AD9i7wgC0616t
	QBZAWc2jJms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A8D112077;
	Tue,  2 Apr 2013 19:09:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B09C12076; Tue,  2 Apr
 2013 19:09:20 +0000 (UTC)
In-Reply-To: <20130402185426.GG28148@google.com> (Jonathan Nieder's message
 of "Tue, 2 Apr 2013 11:54:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2A76C44-9BC8-11E2-BBFF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219851>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ..., but it might make sense to start respecting a .motd file to allow
> the following in a hypothetical world where everyone who clones git
> uses the same scripts Junio does:
>
> 	$ git clone git://repo.or.cz/git.git
> 	Cloning into 'git'...
> 	remote: Counting objects: 151283, done.
> 	remote: Compressing objects: 100% (38546/38546), done.
> 	remote: Total 151283 (delta 111004), reused 151073 (delta 110797)
> 	Receiving objects: 100% (151283/151283), 36.39 MiB | 7.66 MiB/s, done.
> 	Resolving deltas: 100% (111004/111004), done.
>
> 	Don't forget to "git clone -b todo git://repo.or.cz/git.git git/Meta"
> 	for maintenance scripts.
> 	$
>
> That would allow you to include an arbitrary setup script (including
> cloning dependencies as well as running "autoreconf" or whatever) and
> give people cloning a quick reminder to inspect it if paranoid and
> then run it.

I do not think motd is a good fit for the above; the message will
disappear any time once you are done cloning.  Depending on how
common the use of Meta/ should be, it is more appropriate to have
such an instruction in README or some other places as tracked
contents.

I do not know if the above is related to the problem Ram is trying
to solve or a totally orthogonal issue, though.
