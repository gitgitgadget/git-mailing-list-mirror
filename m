From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:03:09 -0700
Message-ID: <7v4nyoq0o2.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <20111031084048.GA11807__21610.4542407722$1320051469$gmane$org@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-ide-owner@vger.kernel.org Mon Oct 31 23:03:16 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RKzwp-0002lZ-JN
	for lnx-linux-ide@lo.gmane.org; Mon, 31 Oct 2011 23:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab1JaWDO (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Mon, 31 Oct 2011 18:03:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491Ab1JaWDN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2011 18:03:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 199B75BD7;
	Mon, 31 Oct 2011 18:03:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+tZP6SLwTBLK7/FjxyVYpI4ElDQ=; b=hOt9IA
	RxSTDUgfPvxe0oZw1P2vw7BFyYXeL1fNvxm/MsirjqNebHodTRPaGTHCHpsPiVhn
	WKtfNBYNmr5XGrkP+qpYDp0iutvkpAioo511mJInRLhtPghs+XXfXmITAssEXFLD
	5ojBvexMWZW3PDw1mR/DWmTfurUR7UMtGAqlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U9AFMgqpOXTrCi+UXMQhEf+dUlZAiSrj
	3eTx8AR83SWXKz9iCz2u7OIDaZdCmO7tP8eKOGB5gYpDn/QS0JBv3+sX6o049Rk9
	Z9WxikMfGQ96vRae1T8w/3TrKE0iswYKvU5++t3K/FQo0ZXJC0YPA4VU/PulYHvi
	3iWJ3auzMZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1108F5BD6;
	Mon, 31 Oct 2011 18:03:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 890B35BD5; Mon, 31 Oct 2011
 18:03:11 -0400 (EDT)
In-Reply-To: <20111031084048.GA11807__21610.4542407722$1320051469$gmane$org@elte.hu> (Ingo
 Molnar's message of "Mon, 31 Oct 2011 09:40:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB6EE98-040C-11E1-9349-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184525>

Ingo Molnar <mingo@elte.hu> writes:

> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> That said, even the "BEGIN PGP SIGNED MESSAGE" things are a massive 
>> pain in the butt. We need to automate this some sane way, both for 
>> the sender and for the recipient.
>
> The most practical form would be if Git supported such oneliner pull 
> requests:
>
>  git pull git://foo.com bar.branch                           \
>   --pull-sha1 0acf00014bcfd71090c3b0d43c98e970108064e4       \
>   --gpg-by: "Ingo Molnar <mingo@kernel.org>"                 \
>   --gpg-sig: 8a6f134afd1d212fe21345
>
> maintainers could just paste them into a shell and it would abort if 
> it's not trusted. The maintainer verifies the visible, 'Ingo Molnar' 
> bit. The 8a6f134afd1d212fe21345 is a signed-by-Ingo-Molnar version of 
> this content:
>
>     git://foo.com bar.branch 0acf00014bcfd71090c3b0d43c98e970108064e4

As a command line syntax, I think the new "--flag"s should all come
before non flag options to the "pull" subcommand, i.e.

    git pull --sha1 0acf00014bcfd71090c3b0d43c98e970108064e4 \
    	     --gpg-by "Ingo Molnar <mingo@kernel.org>" \
             git://foo.com bar.branch

I do not understand what you meant by that "8a6f13...". When I run

    $ echo "git://foo.com bar.branch 0acf00014bcfd71090c3b0d43c98e970108064e4" |
      gpg -sa

I would get about 20 lines of solid gibberish, nothing close to that
clean and concise 20-or-so character sequence.

In any case, I do not think that "this site, that branch" information is
essential for the purpose of validation. I think I saw Linus responding to
a pull request saying "Your pull request says master but I found nothing
there; I assume you meant for-linus branch" or something similar, and as
long as that matches the expectation of the contributor, especially if you
specify "I want you to get _this_ commit" in your request-pull message, it
should not matter how/where Linus gets the history leading to that commit.

As "git-pull" is still a scripted Porcelain, interested people should be
able to experiment this idea by doing something like this:

 1. The requestor signs the tip commit to be fetched with the version of
    git from the "next" branch, i.e. "git commit -S", and pushes it to his
    publishing location;

 2. Around line 207, "git pull" spawns "git fetch", stops if dry-run. At
    that point, you can:

    - parse FETCH_HEAD and verify the SHA-1 matches what you got from the
      command line;

    - run "git show -s --show-signature FETCH_HEAD" (again, use the
      version of git from the "next" branch) to let GPG parse the
      signature.

    and stop if either test fails.

