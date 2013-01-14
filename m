From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Announcing git-reparent
Date: Mon, 14 Jan 2013 00:05:50 -0800
Message-ID: <7v7gngfau9.fsf@alter.siamese.dyndns.org>
References: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
 <20130114071608.GL3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 09:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuf3d-0003aW-TM
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 09:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab3ANIFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 03:05:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab3ANIFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 03:05:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDBC99E11;
	Mon, 14 Jan 2013 03:05:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/WlQ52IEpNojd6LONSLByBs2+w=; b=ikBJF4
	f83oYMJ1ZHi4hY9GKumEnvAJRfWaPhK6wd7WxBZZ7XVyAE+XV67tfNS+Z1SvpYg2
	xGQCJH/3TCB7g7aGUmZAmILquSEW9geRYikvAwPmNEQ1g9hZ2U2BpEe2CdxhMAtY
	XMjJp3sGfzr+fomGj6GTE7Vlc24YFHBhxKXPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=robFfxKk7OtAebNJEMmEKC+IHS9Psm7m
	AXJULid82vU1iIf/qOUCKMKeMo+NwaceazHHC02Pe1jDMgQaOtm+WS6DJVbpB63g
	HPatm719KIpqO67/nDTWNhpsHia3jQgq7GDgmk9hn/Y1NRnjTqblrcrFhg/r0nLd
	hhQC2DNMHa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B28D69E10;
	Mon, 14 Jan 2013 03:05:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 480059E0F; Mon, 14 Jan 2013
 03:05:52 -0500 (EST)
In-Reply-To: <20130114071608.GL3125@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 13 Jan 2013 23:16:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36EDDB6A-5E21-11E2-9BD1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213471>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Mark,
>
> Mark Lodato wrote:
>
>> Create a new commit object that has the same tree and commit message as HEAD
>> but with a different set of parents.  If ``--no-reset`` is given, the full
>> object id of this commit is printed and the program exits
>
> I've been wishing for something like this for a long time.  I used to
> fake it using "cat-file commit", sed, and "hash-object -w" when
> stitching together poorly imported history using "git replace".
>
> Thanks for writing it.
>
> Ciao,
> Jonathan

The scriptq is simple enough, and from a cursory look, it may be
fine to throw it in contrib/ after some minor style fixes and such,
if many find it useful.
