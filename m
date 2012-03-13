From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 12 Mar 2012 22:45:24 -0700
Message-ID: <7v4nttm4uj.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120313052335.GA16664@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7KYB-0006nr-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758950Ab2CMFp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:45:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822Ab2CMFp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7925E7E61;
	Tue, 13 Mar 2012 01:45:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRUDmmobTxVCRzy823JccIHdWwg=; b=XRFaKL
	nato7UGMnsMtXRc8w5zeDKGKZG2IFdQz0JnG5v5v502sCdGLIh8D+76SPZTdp9Ma
	sjCxJnwPIqBUHnVS6Xn5JwBTWzWyprUlzd5Z9eEwEuWrUVWLCd+3md8I+1LmdP7V
	yJhRj1Ec+az8Til2XBItonZKyVRSYDzKkAXNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udvfYwwSp/myKjcLME/nwl1Ez8ieB+CL
	iLiSuca3x/mP+9HGG3tpgl/w4PwQNmYw0dQZ3ySWSdgmZdrCXTZDR7I+9grFN/M3
	TS0VzMhvi8a1jYHIV1YVLYMqVYvVoC5Wz1cxMWGHZLbVLApVa6Nk1b56eMjdhnBV
	VyiJ2ryhL+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70AA07E60;
	Tue, 13 Mar 2012 01:45:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02E9E7E5D; Tue, 13 Mar 2012
 01:45:25 -0400 (EDT)
In-Reply-To: <20120313052335.GA16664@burratino> (Jonathan Nieder's message of
 "Tue, 13 Mar 2012 00:23:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBA87200-6CCF-11E1-B710-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192980>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I also wonder if it would make sense to change
> ... to ...
> 	* 'mm/push-default-switch-warning' by Matthieu Moy:
> 	  push: start warning upcoming default change for push.default
> which makes the author less distractingly prominent (since they will
> be right there in the log soon later once we hit the commits
> themselves) and makes the start of the list of commits easier to find
> by eye.  This is what I was inarticulately hinting at in my message

Having the author/subsystem attribution on separate lines was a
deliberate design decision made by me, so that (1) cutting and
pasting Linus would prefer to do stays easier, and (2) giving the
credits more prominently in a default format.  There is a paragraph
break before the attribution begins anyway, and I think eyes easily
learn to scan for paragraphs that begin "By " instead of " * ".
