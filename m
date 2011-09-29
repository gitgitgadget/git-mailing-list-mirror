From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 14:54:55 -0700
Message-ID: <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
 <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
 <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 23:55:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9OZO-0006bs-1j
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1I2Vy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 17:54:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab1I2Vy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 17:54:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0D962291;
	Thu, 29 Sep 2011 17:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQ/1EyesFPrDW0GCE65zwCv+KGI=; b=BWKu/f
	5+qCg4TE7m3iR0r1OhNgo9cZKNOC/26SOyvptSMFAmulxbnkSPimJ/womEmEIsyc
	dk+4849nobqtlEI/BFOtsFgfRzgw7VqZLjpDjFevgwHXj4rRn6/8LbHED3ntZED9
	2oHwZZT4SAcA1uTeXROZhOB9OSj1aqnVzzRHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d7Xu7SFMke4+mA4ItFON8S5HnctsfQfZ
	Ru49Tiw2ghr6IjnxSykryhJjhVd2crlX1kXYZHYx0bXhc6Ys3dI7awgOAns8zgoe
	CzITuqWkYeHNX15ZOET72JURhVG2vbU1JYkEa+KfQmtsGkK1QO0UIUPC8CbTVS+K
	ASvRvO1xiV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D603B2290;
	Thu, 29 Sep 2011 17:54:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C3E2228F; Thu, 29 Sep 2011
 17:54:56 -0400 (EDT)
In-Reply-To: <7vd3ejrqin.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 29 Sep 2011 14:24:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABB9B668-EAE5-11E0-8A7A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182444>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> I think a user looking for this functionality -- either a new git user
>> or a user who seldom uses the "create secondary root commit" command
>> -- would first try 'git help init'.  It seems logical to me that I
>> should be able to do this:
>>
>>   cd my-git-repo
>>   git init --root=<newbranch> .
>>
>> This feels natural to me for this operation.
>
> Hmm, this does not feel very natural to me; unless "git init --root=work"
> uses 'work' branch instead of 'master' when creating a new repository,
> that is. But it is attractive that init is much less often used than
> checkout/commit and everybody knows it is somewhat a _special_ operation.
>
>>> That leaves "Hidden History" the only useful use case. IOW, the answer to
>>> the first question above is not "Separate or Hidden History", but is
>>> "Hidden History and nothing else".
>>
>> I think you're saying that the "hidden history" scenario is more
>> special than the "separate history" one because of these reasons:
>
> Not at all.
>
> I am saying that "separate history" has no place in git workflow, if these
> multiple roots _originate_ in the same single repository with a working
> tree. And all of "git checkout --orphan", "git commit --root" and your
> "git init --root" are solutions to make multiple roots _originate_ in the
> same single repository with a working tree.
>
> I have no trouble in a single repository with multiple roots if that is
> done in a distribution point, which by definition does not need and
> typically does not have any working tree. Options to "checkout/commit"
> would not help as they need a working tree.
>
> The way to do it is to work in multiple repositories, one for each of
> these roots, and push into a single repository from them.
>
>>> And a half of the the answer to the second question is "checkout --orphan"
>>> (and the other half would be "filter-branch"). "checkout --orphan" does
>>> have major safety advantage than introducing "commit --no-parent", as Peff
>>> pointed out earlier (to which I agreed).
>>
>> The thing I don't understand about "checkout --orphan" is exactly what
>> you're getting when you do this.  I assume you get a populated index
>> and a non-existent HEAD. This seems a lot like "git init" to me,
>> especially in the non-existent HEAD area.
>
> It is "HEAD pointing at a branch that does not yet exist", but I find it
> strangely attractive ;-)
>
>> I didn't think git init would be much use for this scenario before,
>> but now I've changed my mind.
>>
>>   git init --root=<newbranch> --keep-index
>>
>> Again, this avoids complicating the common commands.  But maybe it
>> does overload init with extra baggage.
>
> I do not think you would even need --keep-index there (running "git init"
> in an existing repository to see what it does. It does not touch the index
> nor HEAD).
>
> I am not sure if "--root" is the right name but if "git init --root=work"
> that is run to create (not re-init) a new repository points HEAD at a yet
> to be created 'work' branch instead of 'master', I think it would be a
> reasonable alternative.
>
> By the way, why did you drop the mailing list?
