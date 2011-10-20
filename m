From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 21:27:15 -0700
Message-ID: <7vzkgw9tjw.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <20111020025149.GA31549@sigill.intra.peff.net>
 <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 06:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGkDz-0005My-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 06:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1JTE1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 00:27:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab1JTE1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 00:27:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A99B22A5;
	Thu, 20 Oct 2011 00:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SY7gFq/sFadItL8tMYLy2G0V2Y0=; b=LdfqYj
	oucRFnTdTy6pkbmXWMndqg5NUkoaDjnLkLH73UY4NMkFJCTd1RBsf30/CL4lSX2J
	0DqPF3nSCM6GD7UcTlWf/rQSOGzzEmLmPJ4MY44iYlWHSOK+x9Zxr9jcCrDh28tt
	4hnAHJRosBjlrt0b/7KGm8gLyr8mWP1lJzrWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CFhRlaAoouJbzR3EQqUKUmA4Hkwcg7Rc
	Rrl2OpAL6y5isEzfA92VfUkuOw0j1dnhyGF3geYEnyi0vvKZCZA/TYz29r1Ex/aF
	suuGE+6NfS/C2r6tcDA4aM4k9wHpGdtkWOojt6nSwAW1mP6OXKT5TyAB+J1/rYB6
	qQP7CMLDNUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1266422A4;
	Thu, 20 Oct 2011 00:27:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63F4822A2; Thu, 20 Oct 2011
 00:27:17 -0400 (EDT)
In-Reply-To: <CAGZ=bqK2oVPxW3mm-WHMd1+KSiPquympJyhRqLWr1F=G74p+BA@mail.gmail.com> (Kyle
 Moffett's message of "Thu, 20 Oct 2011 00:15:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB229ED6-FAD3-11E0-AC79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184002>

Kyle Moffett <kyle@moffetthome.net> writes:

> Heh, there's one other practical downside I can think of...
>
> If you create a bunch of commits with the same 8-hex-character prefix
> then suddenly the "git describe" logic for using the first 7 commit ID
> characters gets a whole lot less useful.

In the sense that you need to cut and paste a lot more characters, you are
correct that it would make it less useful, but if you are talking about
uniqueness, you are mistaken.

The rule is not "using the first 7 hexdigits", but is "using as many
hexdigits to make assure uniqueness, but use at least 7".
