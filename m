From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Elegant subdirectory checkout of remote-tracking branch?
Date: Fri, 01 Mar 2013 10:05:27 -0800
Message-ID: <7vwqtrf120.fsf@alter.siamese.dyndns.org>
References: <20130301152253.GA9312@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Mar 01 19:06:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBULJ-0000OP-9c
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 19:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3CASFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 13:05:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab3CASF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 13:05:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AD86B6DA;
	Fri,  1 Mar 2013 13:05:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zo+BRcAo99lHmeMWLdU/nqylZOM=; b=XyElPi
	YSAV6p7dxhmM6k6iM/ShDkgdW9fD8cAH9IshsfK/i9kVrra9MguaYlSDCLmx5W/p
	ikwc8C4nVySbqJK0FwQSJscR4IJkdWGLQ7hLHHgQ33mlj2atbc1etknYsQc9xdIb
	ZPsGMlTD7juMUf6WUdzB3U2fsbH5k9cvOT5P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YxC7m7nvYblRbTxmywcUBly8yrd7IWga
	bzUuNx61NEWRuULf6RzQjw4s6qYTq+OLLAUGg8dM36nBhKBH0tstjMS+o1dw8Qnv
	fY5vVVfz8h72IMv5zrpD4KdGGpvxlyovS7tRpjlQ16BFO+hqgDP5AKRyMcxfn1SA
	0VsqtzhyHCc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FE19B6D9;
	Fri,  1 Mar 2013 13:05:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B57CDB6D8; Fri,  1 Mar 2013
 13:05:28 -0500 (EST)
In-Reply-To: <20130301152253.GA9312@odin.tremily.us> (W. Trevor King's
 message of "Fri, 01 Mar 2013 10:22:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9990B768-829A-11E2-B37B-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217286>

"W. Trevor King" <wking@tremily.us> writes:

> Any suggestions for an elegant solution would be appreciated :).

My Meta checkout is not a submodule of anything.  It is a totally
independent repository and is not linked with git.git in any way.
It started as an independent repository, and it still is.

That it has been pushed to the same repository at k.org was a mere
historical accident (I only had that repository writable there when
I started); it not even a recommended practice to publish unrelated
histories in a single repository. You are seeing 'todo' in some of
my public mirrors only due to historical inertia.

Just treat the git.git primary directory and the Meta directory as
what they are: two checkouts of two totally independent projects,
one of which happens to be designed to be checked out at a fixed
location relative to the other.  When running "pull --ff-only", do
so in both independently.

That is what I do in my secondary repositories.

> Once we figure something out, I can write it up and stick it in
> howto/maintain-git.txt.

You are free to write and do whatever suites yourself, but a
description of a workflow that is not what I use does not belong to
the howto/maintain-git.txt document ;-)
