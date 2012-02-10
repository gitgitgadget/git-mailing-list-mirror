From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 12:18:35 -0800
Message-ID: <7vhayyphlw.fsf@alter.siamese.dyndns.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
 <1328900154.3171.27.camel@i5.mricon.com> <20120210195736.GA5381@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Ryabitsev <icon@mricon.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvwvb-0005zy-Uz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760099Ab2BJUSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:18:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab2BJUSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:18:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C926CEA;
	Fri, 10 Feb 2012 15:18:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v/JUpfwIgpQWVSBbrO0s+63AG6w=; b=a3xqWG
	0stdjALNLkkCUJGW/EZ2+q6BfluPk5GfCO84wInWYsQJtR1lPcaW0XAkrfu+s6W1
	xWNyWZ61AA2LkCfv5uX5ct4odVCAx+Sjpt4TV5Avjn7pH9Hk//+3wg1BWq6dwthl
	/Rlni4879ODujOZfJ7C4Wr5/iSx4bwX0whflY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lF3e0+ZQ/+rHQQupc+3ApfRLZ0BYjvY5
	tePBmd1jf3c0UKcLj/9G0r5accbiXZOO3jL2lqLHSpA3BB7ikn7t80O/QYr4wUTK
	UkrXV6MwLAnmqiEVdBEmw3k1a8oMcjsfgWJwRNXld8IIjXUVT3IrsJKdZMUczFPU
	UGxVFl4RqUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B0AF6CE9;
	Fri, 10 Feb 2012 15:18:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E021F6CE4; Fri, 10 Feb 2012
 15:18:36 -0500 (EST)
In-Reply-To: <20120210195736.GA5381@thunk.org> (Ted Ts'o's message of "Fri,
 10 Feb 2012 14:57:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69E03700-5424-11E1-A83D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190447>

Ted Ts'o <tytso@mit.edu> writes:

> How about this as something *way* simpler?  Define a way of marking
> the top of a particular directory hierarchy as a tree.  Then the
> *only* way of updating that tree is all or nothing.  That is, someone
> submits a signed tarball; then after the signed tarball has its
> signature checked, it gets unpacked into a dir.new, and then we rename
> dir to dir.old, rename dir.new to dir, and then dir.old gets removed.
>
> That way there's no conflicts between directories that are managed via
> the kup-servers PUT and DELETE commands, and those where they get
> uploaded as a single tarball to create or replace a specific directory
> hierarcy, or which can be deleted only as a entire directory hierarcy.
>
> What do you think?

That would not work very well without changing the historical directory
structure (which I think was the point of this discussion "please keep
these stale links alive").

The toplevel index.html in the pub/software/scm/git/docs/ directory and
its pointees were the set of docs for the latest version, and older
versions were rooted at pub/software/scm/git/docs/vX.Y.Z/.  Links that
point at software/scm/git/docs/git-cat-file.html still need to work, and
the path needs to be updatable without having to include the preformatted
documentation for all the historical versions in the same tarball.
