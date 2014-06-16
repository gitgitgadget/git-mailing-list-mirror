From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Mon, 16 Jun 2014 11:21:38 +0200
Message-ID: <539EB722.8@drmicha.warpmail.net>
References: <cover.1402063795.git.git@drmicha.warpmail.net>	<cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>	<20140613080229.GJ7908@sigill.intra.peff.net>	<539ACA8A.90108@drmicha.warpmail.net>	<20140613110901.GB14066@sigill.intra.peff.net> <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 11:21:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwT6z-0005qw-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 11:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbaFPJVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 05:21:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59676 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754733AbaFPJVx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 05:21:53 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EF52520E32
	for <git@vger.kernel.org>; Mon, 16 Jun 2014 05:21:51 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 16 Jun 2014 05:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LZ3flZtJVKx2SAyQNf9Jl1
	cVUeQ=; b=OGMhT0LVemnzjSrG+yVyH3E1fvcnYXtP8y4aGm5CnfkDrHOVvg0jbv
	CXjw1uxjoaA1ITb7+3csDkG4kMsF+CGcKa44rIqUvoCnBLTnPZWLAc8nB4h5m+jw
	cALhS/O15cYVn3gYfUE7nvUXaXdKeyXEZp5LbrsW8TA4R/oJnCadI=
X-Sasl-enc: +DNKlus1ybFp7oiDKd5dBAEC7jYQDO5KkcUDp8sFDJrc 1402910511
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 635F1C007AD;
	Mon, 16 Jun 2014 05:21:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqbntw4u4d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251709>

Junio C Hamano venit, vidit, dixit 13.06.2014 19:06:
> Jeff King <peff@peff.net> writes:
> 
>> I realize this isn't really your itch to scratch. It's just that when I
>> see a description like "verify a commit", I wonder what exactly "verify"
>> means.
> 
> I think that is an important point.  If a tool only verifies the
> signature of the commit when conceivably other aspect of it could
> also be verified but we cannot decide how or we decide we should not
> dictate one-way-fits-all, using a generic name "verify-commit" or
> "verify" without marking that it is currently only on the signature
> clearly somewhere might close the door to the future.
> 
>     git verify <object>::
>         Verify whatever we currently deem is appropriate for the
>         given type of object.
> 
>     git verify --gpg-signature::
> 	Verify the GPG signature for a signed tag, a signed commit,
>         or a merge with signed tags.
> 
>     git verify --commit-author <committish>::
> 	Verify the GPG signer matches the "author " header of the
> 	commit.
> 
> and more, perhaps?
> 

So what does that mean? And what does it mean for verify-tag, which does
nothing but checking the return code from gpg, just like the proposed
verify-commit?

As pointed out, strict verification is a matter of policy, very much
like accepting certain ref updates etc. is. Do we want a signature
verification hook?

We currently don't have a scriptable commit signature verification in
the same way we have one for tag signatures. That's the gap that I
wanted to fill in in response to a blog post about commit signatures in
git. But it's not my itch, I don't use signatures.

Michael
