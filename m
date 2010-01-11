From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to get "pretty" URL aliases working
Date: Sun, 10 Jan 2010 23:59:25 -0800
Message-ID: <7v7hrpvzqa.fsf@alter.siamese.dyndns.org>
References: <4B4ABDB5.9000203@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Nielsen <adam.nielsen@uq.edu.au>
X-From: git-owner@vger.kernel.org Mon Jan 11 09:00:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFBr-0006rH-5r
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab0AKH7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354Ab0AKH7d
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:59:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab0AKH7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:59:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4BF8FC5D;
	Mon, 11 Jan 2010 02:59:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+XRwXn6FVRPQtb5ErVh71XM/Zuk=; b=M2XPRU
	tJPmlF/QuXs9T/sznHEZhuO0hWKp8GgVy6hTRfgZ/bun4ske0wZT2ZSjXPXVhfce
	6glN7nG34boyblNOK2j4xo95nmYMCLOqFySHWJkzuyZwh1Myc2gkgsIscIaeBNSi
	GEoYXYyOL7qKz7qjEO2+mwxQA88ANVQ8NVbfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYYyWTmNaK+dy7L7YnqOgMeacjTUy2pN
	Fgus6xjGnodlaTdyF1c8aI62Mcak5D7TJS71Bzp8ZCnO7wo7ATeza9/2SWyNDUIK
	e7SaUo+ic4ug9OKWm4+3U2BS3CPOrb0j+1B7hXFOPXNHQDQeSaDW5YgG48/dk+IK
	vFS3yCYkRlU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D4BC8FC5C;
	Mon, 11 Jan 2010 02:59:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94D858FC5B; Mon, 11 Jan
 2010 02:59:26 -0500 (EST)
In-Reply-To: <4B4ABDB5.9000203@uq.edu.au> (Adam Nielsen's message of "Mon\,
 11 Jan 2010 15\:57\:09 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E9C064A-FE87-11DE-B4EB-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136614>

Adam Nielsen <adam.nielsen@uq.edu.au> writes:

> I'm attemping to learn Git but I've gotten stuck trying to configure a
> server to host my repositories.
> ...
> [url "ssh://myserver/path/to/repos/"]
>   insteadOf myserver:

url.*.insteadOf is a configuration done on the _client_, i.e. the one that
you run "git clone", "git fetch", "git push", etc. on. 

	$ cat >>$HOME/.gitconfig <<\EOF
        [url "ssh://myserver/path/to/repos/"]
        	insteadOf = myserver://
	EOF
        $ git clone myserver://project.git

In any case, "attempting to learn Git" doesn't mix well with use of
"insteadOf" to me.  If you know /path/to/repos/project.git is what you
want to access, any "attempting to learn Git" person would do more
straight-forward "git clone ssh://myserver/path/to/repos/project.git", or
"git clone myserver:/path/to/repos/project.git" which is even better (it
is shorter to type and is a more natural form to spell ssh transport).

;-)
