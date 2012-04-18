From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in
 prepare_shell_cmd on Windows
Date: Wed, 18 Apr 2012 09:30:13 -0700
Message-ID: <7vobqpknoq.fsf@alter.siamese.dyndns.org>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <4F8D15B9.70803@viscovery.net> <20120417221449.GC10797@sigill.intra.peff.net>
 <4F8E539F.7030902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	jrnieder@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:30:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKXlx-0005BV-2b
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 18:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab2DRQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 12:30:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2DRQaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 12:30:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1355867BD;
	Wed, 18 Apr 2012 12:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oHty+hlvBQGTI9FaNlOOYIUE/tg=; b=wbiywY
	FhctuoID5kSzTPRfbi1EzufcMlhaOkOaDOiAGKLrxxx1en0klyR3ZShBK0o6o62p
	H5rCrXKOnF9o9AG1UDNPTmCEUV0E2qpMR6IZMGyVXOXuWv9Skal/ENcIZ+Pgr6/A
	3TIaq0cppcy7QAaXIVrHaLBkXBhBcYj7oS61U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IahLv8ZaKyz16klvKeDyuWeM/YUoXApn
	ySv4oZs829pWzOaq7bE0Q3YmZSuNXyHml0k8fuW99X8lYnqJmMiZ8sBc+0QxBstt
	dUenYCMkKXH/QamHkEv0XgvNjyLKQA8x2BZaX4cLjKDqQ1U8D5CcnNaf4h5HpbfT
	Kf/VGDhnBCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D8567BC;
	Wed, 18 Apr 2012 12:30:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B88567BB; Wed, 18 Apr 2012
 12:30:15 -0400 (EDT)
In-Reply-To: <4F8E539F.7030902@viscovery.net> (Johannes Sixt's message of
 "Wed, 18 Apr 2012 07:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C757C590-8973-11E1-887B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195874>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> It sounds like the real problem is not the use of a configurable shell,
>> but rather the use of an absolute path. Should you maybe try to pass the
>> basename of SHELL_PATH? ...
>
> I thought about offering a customization point, but decided that it is not
> worth the hassle...

I think you meant by the above that the installer could offer the user to
choose where to place the shell, and if that is the case, I agree it would
probably not worth it.

There is one thing I am confused about your response, though.  I thought
the suggestion by Peff was to build your binary with "make SHELL_PATH=sh"
(not "make SHELL_PATH=/bin/sh").  I do not know if that works or does not
work (I do not see why not, though), but in either case offering a new
customization point sounds like a separate issue.
