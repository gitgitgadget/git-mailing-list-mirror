From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 08:46:19 -0700
Message-ID: <7vhat2toz8.fsf@alter.siamese.dyndns.org>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:46:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFPP-0005NS-8p
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab2GTPqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:46:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab2GTPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:46:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 666C57A7E;
	Fri, 20 Jul 2012 11:46:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHZj0ZpEdWMvrQ4WqzlIieAF7ds=; b=pY83bg
	+Zu4DPqjV+FFmdE417YC/eJP8ash9Epu/E/+6rUCo694iUzVjGUAyvmn4L1e5IXL
	gQyfUZsw/leJfQfzYXVZGcRPUIdYSPjXOyTGCuE3GbgTJU+CWHqus8T9R2B0Gtby
	SMuwn8I8/kahCCmTPR9VBb37G/N+86CvrP60I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B12iea+NZ0P9EMmsRwziVrV7DuxwU3WX
	4Wkq5lL+H0Pe7QH0ukPA1EWSJbWwT7iaOqOwpzN6sWJKA41sI9FkccirnnHQ2HdJ
	d4QpigEfB//3hLl9Qmy672jX4h+yQNeoRy+OjaHQZyNxSqHdWhWoY5GKFmf+LRoN
	LCM/fiiZAQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5316C7A7D;
	Fri, 20 Jul 2012 11:46:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B25CE7A7B; Fri, 20 Jul 2012
 11:46:20 -0400 (EDT)
In-Reply-To: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com> (Thiago
 Farina's message of "Fri, 20 Jul 2012 12:26:09 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D3B33BA-D282-11E1-9EA0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201777>

Thiago Farina <tfransosi@gmail.com> writes:

> How can I push a working branch to github inside it?
>
> E.g:
>
> # On master:
> $ git checkout -b feature-work
>
> # On feature-work
> # vi, hack, commit, ready to push
> $ git push origin master # here I expected it would working pushing my

"git push origin master" is a short-hand for "git push origin
refs/heads/master:refs/heads/master" to update their master branch
with what you have in your master branch. 

See output from

    $ git push --help

for details.

I think you are trying to update, while on your feature-work branch,
their master with your feature-work branch (or more generally, the
current HEAD), so

    $ git push origin HEAD:master

is perhaps what you are looking for?    
