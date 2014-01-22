From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add cross-references between docs for for-each-ref and show-ref
Date: Wed, 22 Jan 2014 07:58:46 -0800
Message-ID: <xmqqbnz4ypmx.fsf@gitster.dls.corp.google.com>
References: <1390389800-26769-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:58:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W60Ce-0003vR-15
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbaAVP6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 10:58:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbaAVP6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:58:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE69162E62;
	Wed, 22 Jan 2014 10:58:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0NBXwsFBHF+HYVuPEGaXJQexHXY=; b=n9bW2K
	vmJ+Rxlw9lutGlgfMgBnGHQyKN5c5jExVL3mI242yKNI4siz15CRLq7OUGHod+6y
	UuOmM/L6Q1qcPOwP0hZ5nXdza1AnKD8RgljoH9aZUiW2bhC/ODFmF7Sjv6y5ObhI
	exjz5XYHXm+999EUU2h1H6nf44bzW9qKXwID0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uP/VayA/t757MjbeRLbl2b5RbDPE2ql3
	/Q1r7v/B5M/JbRjVppjIz7xtkM+BYyDlZ6ICJ1hP9d66dM3P+EtUQW5gU+l5CNK3
	0uPy7m28fLKwXm2CVg0EWtYw7VCRETIeT6hnMDnPKzRT+EapQjQTAJ7naQYL7hlc
	dl1uH0xqDA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A122362E61;
	Wed, 22 Jan 2014 10:58:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A481962E60;
	Wed, 22 Jan 2014 10:58:48 -0500 (EST)
In-Reply-To: <1390389800-26769-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 22 Jan 2014 12:23:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14A68F4C-837E-11E3-A758-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240834>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Add cross-references between the manpages for git-for-each-ref(1) and
> git-show-ref(1).
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> There is a lot of overlap between the functionality of these two
> commands.

Two differences I most often use (i.e. take advantage of) are:

 - The former is about showing 0 or more matching refs, and not
   matching anything is a perfectly normal condition, i.e.

   $ git for-each-ref refs/heads/no-such

   exits with status 0.  The latter can be used with --verify to
   check if one ref exists, on the other hand.

 - The former takes the match-from-left-to-right pattern (similar to
   the usual pathspec match), while the latter matches from the
   tail.

   $ git for-each-ref refs/heads/*  ;# only one-level names
   $ git for-each-ref refs/heads/** ;# catches both master and mh/path-max
   $ git show-ref master ;# refs/heads/master, refs/remotes/origin/master,...
