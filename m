From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] test: Old shells and physical paths
Date: Wed, 19 Dec 2012 16:17:59 -0800
Message-ID: <7vmwx97f0o.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 01:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlTqA-0006ix-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 01:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab2LTASF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 19:18:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175Ab2LTASD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 19:18:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F6D6DC4;
	Wed, 19 Dec 2012 19:18:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DezJFLZft+5J/DOxg6j2QkoplC8=; b=fc5921
	0Qa0JRkzSXg7ZiS9A2LQTCawYcT6QckVErmi4Isyciwm1PW/pSIt4IUSVwuRgijl
	xg+6lkzpck++uHs4tjfxVrSHri5sB4vxvsp4aZWw6kv9lQ790ev7hoCXa8jskXgk
	DiKT4vnV8dcGp3qI4yKjJQCahi4DB2fwRIQPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oezxjJJ4G9ObnMj79CrFf+6HghWZlWe+
	jpPncyGi0+OJ2ycPwrjjpRvIr6T3Zw4piXxfWdYCRc+Z9mp1sHTp/IKGfkymeDLn
	OP/eB2PLcvul1sgijgDmLhHpD4P+WydEHlbJmWzg0ZAUaAH90/RUJ/nj7Qy1SQIa
	vJ+k9ecFwW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB666DC2;
	Wed, 19 Dec 2012 19:18:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CACA26DC0; Wed, 19 Dec 2012
 19:18:01 -0500 (EST)
In-Reply-To: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com> (David
 Michael's message of "Wed, 19 Dec 2012 18:22:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B74D3044-4A3A-11E2-B604-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211867>

David Michael <fedora.dm0@gmail.com> writes:

> In working on a port, I have to tolerate an ancient shell.  The "cd"
> and "pwd" commands don't understand the "-P" flag for physical paths,
> as some tests use.  The biggest offender is "cd -P" causing a failure
> in t/test-lib.sh (since 1bd9c64), which is sourced by every test
> script.

Is "here is a nickel, get a better shell" an option?  Running tests
is one thing, but I'd be worried more about scripted Porcelains
broken by a non-POSIX shell if I were you.

> Would it be acceptable to instead force the platform's shell option
> (if it exists) to always use physical paths for the tests and drop the
> "-P" flags?

As a patch to the source files in my tree?  Not likely, even though
I cannot say for sure without looking at how the change would look
like.
