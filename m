From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: update obsolete code.
Date: Mon, 17 Dec 2012 12:29:45 -0800
Message-ID: <7v6240l8w6.fsf@alter.siamese.dyndns.org>
References: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com>
 <7vtxrlnuqr.fsf@alter.siamese.dyndns.org> <50CF4E05.7050103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:30:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkhKD-0004RF-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2LQU3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:29:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab2LQU3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 15:29:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF38A403;
	Mon, 17 Dec 2012 15:29:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aScuUePj/wVlPsswDjSo3TBRx4M=; b=oYtFCl
	dYiF8Zuxy/7LSN05HOcSVD2D+qsUNY0UvmoyK7T+tMeszUM6+iBqsW12ksbBrbzq
	7cnpA0wUecy1JzyeH86THAxYPwtXWS+L0OP6zyA/tCLAeO8ZOKx3IsX2jT+ONTO7
	0P3T0oiRkZSdOc05QaFtqoAjd04Et+uRPOBLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgjdjaIDpabHWLqblxIiERxzYridTqep
	mipZ3ZSzo6hZfrQrLOzFNFNVmbzRhJCsXFsoBI5iat0A9fA2V6zAhedjLea9kEoI
	L/I4igZyoLD8ij8J2bPHQNhD0ovxRWc1Qz9ga8yEMDaTMldvwj+zhRKHyayrcPSO
	Df0ZNd13Yzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9791BA402;
	Mon, 17 Dec 2012 15:29:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14331A401; Mon, 17 Dec 2012
 15:29:46 -0500 (EST)
In-Reply-To: <50CF4E05.7050103@gmail.com> (Manlio Perillo's message of "Mon,
 17 Dec 2012 17:53:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FC4E120-4888-11E2-86DB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211700>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> By the way, IMHO there should be an option for adding a slash to
> directory names in ls-tree.

I am not sure about that; ls-tree is meant to be used by scripts
that are capable of doing that kind of thing themselves.

If we were to add an option to add a slash, I think it should be
modeled after "ls -F", whose output is meant for humans and no sane
scripts would read from it.  It is very likely that such an option
should add @ at the end of the name for a symbolic link, so it won't
be useful for your patch.
