From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Sun, 05 Feb 2012 22:25:23 -0800
Message-ID: <7v8vkga370.fsf@alter.siamese.dyndns.org>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <7vvcnkeu2i.fsf@alter.siamese.dyndns.org>
 <20120206054819.GB10489@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 07:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuI15-0007bx-Av
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab2BFGZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:25:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab2BFGZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:25:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DE239EC;
	Mon,  6 Feb 2012 01:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wg/VnKv/DIa/vZ+oN0s7Nphc2QQ=; b=YIHfgh
	dsiYgBn3o0D0l50Pc0FfsWgzMo0WZCW6+J9//Cq6jBzlcKe3bB6RBYGdYkk9Sk9o
	pGfqT8Jbpl3/dQzfX/Jokx4iMlKeWvFYIRagz2oxS1lK98YAm0bVXR4lIE2Z6w+L
	7ZyBH7VNrKYMWUNkQEZKFL7eSyxEbEyJOA7ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rR9Z7emkaEpd6Gk/c8dHnIDOseWmbUww
	nxeE+w8VYVbs0+aO/zHyW6VKeylJcLnNHnUrbYHhn3cUYPMKb71psbG9oQDVq+Zw
	UWiO0VjZ3tTeodKeRYM1JvnL2yV4w1pjkembebAJfDY0Emz/k2sp1W7aK6mpgGjo
	vn4DLKh9tXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2188339EB;
	Mon,  6 Feb 2012 01:25:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4FE539E0; Mon,  6 Feb 2012
 01:25:24 -0500 (EST)
In-Reply-To: <20120206054819.GB10489@tgrennan-laptop> (Tom Grennan's message
 of "Sun, 5 Feb 2012 21:48:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A807B0E-508B-11E1-9E9C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190026>

Tom Grennan <tmgrennan@gmail.com> writes:

>>I wonder if defaulting to HEAD even makes sense for --points-at. When you
>>are chasing a bug and checked out an old version that originally had
>>problem, "git tag --contains" that defaults to HEAD does have a value. It
>>tells us what releases are potentially contaminated with the buggy commit.
>>
>>But does a similar use case support points-at that defaults to HEAD?
>
> Yes, the usage, "--points-at <object>..." implies that there is no
> default. So, I suppose that NULL more appropriate than "HEAD".

That's a circular logic.

The usage could very well say "--points-at <object>" and forbid missing
<object>.  I think that would make a lot _more_ sense, because I did not
think of offhand any good reason that --points-at should default to HEAD
to support some common usage, and you also seem to be unable to.
