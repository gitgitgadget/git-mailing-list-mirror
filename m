From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch
 in "heads" view
Date: Thu, 16 Feb 2012 12:29:12 -0800
Message-ID: <7vr4xuy12f.fsf@alter.siamese.dyndns.org>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
 <1329320203-20272-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rajesh boyapati <boyapatisrajesh@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry7xC-00046g-BH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2BPU3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:29:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab2BPU3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:29:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7516336;
	Thu, 16 Feb 2012 15:29:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vs10ChVJiQKjw2Gx0y7iHsZ2vnU=; b=tyXrYX
	dBv0/WMcsFpYvzmwIwob39wm2imOdP2deYPWozIB0HlKCYHPGS3rp3B2FSIA3hfr
	5HBnj7+dCXvLkjUjJ9kEfoNPwOWfcT4rPps99FFSm6Xf7MC7UvxYQRi1TxHuIeT7
	uFQSLbpZQuH2h6oOt3bTEqIlatMbQP7bPK3fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xb+3fJJNYk+/K/KdPH2zS5chCWKlFtLz
	5fDI4qITynGl6wUYiSVX8QGaRkrisY7+I+6TvCaYZs4WWQQVJGRzRl6ZBfz/dulC
	VgEVoEJgLghSD4BIF0sNisFjQAdtAgzxjpfKLkKmdhOu80XwbH47TIdqLqyFYgb8
	7ESmwgUU5XI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16626335;
	Thu, 16 Feb 2012 15:29:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25BBF6333; Thu, 16 Feb 2012
 15:29:15 -0500 (EST)
In-Reply-To: <1329320203-20272-2-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 15 Feb 2012 16:36:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4BFD9BE-58DC-11E1-A1DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190907>

Jakub Narebski <jnareb@gmail.com> writes:

> Gitweb has problems if HEAD points to an unborn branch, with no
> commits on it yet, but there are other branches present (so it is not
> newly initialized repository).

It would be more readable if you rephrase the vague "has problems" with a
concrete description of what the problem is.

Also, drop the " (so it is ...)"  part, which does not add much useful
information.  Your next paragraph describes how a repository can come to
this state anyway.

> This can happen if non-bare repository (with default 'master' branch)
> is updated not via committing but by other means like push to it, or
> Gerrit.  It can happen also just after running "git checkout --orphan
> <new branch>" but before creating any new commit on this branch.
>
> This commit adds test and fixes the issue of being on unborn branch
> (of HEAD not pointing to a commit) in "heads" view, and also in
> "summary" view -- which includes "heads" excerpt as subview.

The reader has not seen anything more than "has problems" at this point,
so "fixes the issue of ..." is not very helpful.  You could have just said
"adds tests and fixes it", if you said that the unspecified "problems"
apear in "heads" and "summary" view at the beginning of the log message.

Thanks.
