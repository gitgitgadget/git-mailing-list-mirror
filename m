From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 13:38:31 -0800
Message-ID: <7vsjiinzc8.fsf@alter.siamese.dyndns.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
 <1328900154.3171.27.camel@i5.mricon.com> <20120210195736.GA5381@thunk.org>
 <7vhayyphlw.fsf@alter.siamese.dyndns.org> <20120210212030.GD5381@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Ryabitsev <icon@mricon.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvyAx-0001hd-G9
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760175Ab2BJVif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:38:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759137Ab2BJVie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:38:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD5D66139;
	Fri, 10 Feb 2012 16:38:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vPfl2650vkjbH7ZR8zWN8dFoAC8=; b=jfqgGK
	GEojtLhff6xET+Nt//v1wgl73/+LWlhjIh9oApOqusXjinWgcxQC3i6r1hyOXTpI
	YM8PQ4EZ6Cs/Fj5zGDKUA33XYcW8JIDPgYwziskmZALHkmFJBHiA3Fkozr95Yics
	n1fVJN2kaQl8Y/38U1S5eTalitYtM5SakHqEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCGeeQ6MDcFJzZjjjL25SIZC9h0xu7Of
	kFwtfILtYVMvWRECc0DYgskQBxegHUX/4BRexkbf97AaSATbKgJiae0tB7NU3aO6
	3/ObTqOqET2HuPzkrWqEhevi+QmF08YdQ2btxiWQ6u+3pPhfB9enKKYSjTk1sNgn
	lVi91lxErp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39256138;
	Fri, 10 Feb 2012 16:38:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B1016137; Fri, 10 Feb 2012
 16:38:33 -0500 (EST)
In-Reply-To: <20120210212030.GD5381@thunk.org> (Ted Ts'o's message of "Fri,
 10 Feb 2012 16:20:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B33A4E-542F-11E1-BB4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190462>

Ted Ts'o <tytso@mit.edu> writes:

> Hmm... good point.  That does make it hard.  I could imagine making it
> work by having separate hierarchies, and then using apache rewrite
> rules so that anything that doesn't begin with vX.Y.Z in the top level
> of software/scm/git/docs/* gets redirected to LATEST/*, where LATEST is
> a symlink that is managed via kup.

We could move vX.Y.Zs out of scm/git/docs/ hierarchy.  The existing links
from external sites rarely point at a documentation page of a specific
version, I suspect.

People can be trained to look at scm/git/old-docs/vX.Y.Z when they want to
see how older command set looked like, even those who know that in olden
days they would have consulted scm/git/docs/vX.Y.Z for that information;
they are much less of a problem than existing pages whose links want to
stay working.
