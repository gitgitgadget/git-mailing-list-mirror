From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RefTree: Alternate ref backend
Date: Wed, 23 Dec 2015 17:33:00 -0800
Message-ID: <xmqqsi2sbpgz.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
	<56796F37.1000600@alum.mit.edu>
	<CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
	<567985A8.2020301@alum.mit.edu>
	<CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
	<xmqq1taee1w9.fsf@gitster.mtv.corp.google.com>
	<CAJo=hJswuPdLT0KtGdf_=UGxD7-5NjGk2mwFjRU=uYb-Su-y+A@mail.gmail.com>
	<xmqqsi2ucm60.fsf@gitster.mtv.corp.google.com>
	<567A2A44.3050003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 24 02:33:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBumJ-0004Vt-5F
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 02:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbbLXBdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 20:33:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752573AbbLXBdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 20:33:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E474537235;
	Wed, 23 Dec 2015 20:33:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EyqTh6J5wSkVgiv1EtfRW72vM80=; b=a4PSJ3
	Uc3XWMF5A+rStg1zufycinI3pyKJBgWl1t2lYbGoMvMavuf8Usi44tUeJz1o07EE
	g9Ntg/TXGzL8ba9yNIuzVfAO/qs7oTEeXrcE/dcscQTrmoxO7GRQNCyMYQUjK963
	bx0u9KFRHvRAgDqW4y46Hdbtf9JcYBH0pQHUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sAFsKYD/lhCx3EYZlursfdA4HbHpH/OK
	jyHJeRrj9nNcNxDkjjyXPK+SEO/oFV38eSVQmvdhWdCZ+bFoyNiKeChgOPjgsIJ2
	7LQM4LRmGpy8mCy32VdBmDqq/DuyrTKBFfOBD6AO2qIEmd422Q0GjqtRl2PUt1sV
	tWuFowfGEYA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBB7537233;
	Wed, 23 Dec 2015 20:33:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F24B37232;
	Wed, 23 Dec 2015 20:33:02 -0500 (EST)
In-Reply-To: <567A2A44.3050003@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 23 Dec 2015 05:59:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45DEA85A-A9DE-11E5-83C1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282970>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> You are answering "What is 'refs/' good for in the pathnames of files
> that store loose references?" I was asking "What is 'refs/' good for in
> the logical names of references?"
>
> It would have been totally possible to make the full name of a branch
> be, for example, "heads/master" and nevertheless store its loose
> reference in "$GIT_DIR/refs/heads/master". The obvious place to store
> HEAD in such a scheme would have been "$GIT_DIR/refs/HEAD" while still
> calling it "HEAD". This could have avoided the problem that we now have
> with pseudo-references like FETCH_HEAD being stored directly in $GIT_DIR.

I see; OK.
