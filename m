From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 17 Feb 2012 11:26:38 -0800
Message-ID: <7vd39dtg5t.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4F3E9F86.3070802@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 17 20:26:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyTSB-0003gZ-8Z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab2BQT0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:26:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2BQT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 14:26:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC3B86CAE;
	Fri, 17 Feb 2012 14:26:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NnbRpkI/EHrWAQ+IJOweZVYJP58=; b=S4N5NV
	+aJLpJ8Koe32s5O5ucwLa8G3qQFqggti7rX1FVBLJHC+me4aX+mlhGLfLgzf3GpO
	ceIzHI/02qYxdVLev/+lVZscCbY4QEis7jIY+DbiKDcGo2sz6nSDYUMx/9pzhM+b
	ldmTXsaJ9wa78kv62OSIpP5/2ItqBWSGv9MyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geh2+HhyeVC2I70upLe9kIDf0wPIAr0i
	XeBcBn93h4O5mQI9KosyCfpzPqksAqJYBhtqE7JCIKpbz4eJh7lA+xkohDfOnpxe
	ZJRaWn1gpGqGB6Q26WLUzO/3uZUjmbqPXKMMHBcucmIPcOWJpTvr1GIi4K/OHCtD
	gfK5+/frJmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A499E6CAD;
	Fri, 17 Feb 2012 14:26:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EAA46CAC; Fri, 17 Feb 2012
 14:26:40 -0500 (EST)
In-Reply-To: <4F3E9F86.3070802@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 17 Feb 2012 19:42:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51119790-599D-11E1-ABA7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190975>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was just alerted by Scott Chacon's blog [1] to the fact that one can
> set GIT_INDEX_FILE to an arbitrary filename, thereby causing the index
> to be read/written from that file instead of $GIT_DIR/index.

That's very old fashioned.  For almost five years, the preferred way to
say that has been "git read-tree --index-output=file" ;-)

But what you outlined should work.
