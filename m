From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 09:14:38 -0700
Message-ID: <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
 <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
 <4DECE147.3060808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:15:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcSB-0000h1-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab1FFQOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:14:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab1FFQOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:14:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 543945656;
	Mon,  6 Jun 2011 12:17:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VKkgIxN2WIHt+BkmyuOqedCICmw=; b=O2Eu8/
	L1UoreTkGKYXsk25MYk2QiCL40tk3HqzhPkLCFHrmzlB1/WPSVAtnjzdwKkgXMea
	3J5beVH7WUYoro9CIof3aHMIMdxF3xCKTMaoeOoVrznryGSdvlGHvpr4JgnrvLJQ
	txkdSYN1K5VTaq4eUcVvDR8HzeYHLZvQOU6i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzVC99ZS+rHpbd8x4Z8uPjVsAQaDMJEC
	aRiIVoTq5O6rKvRnQamkKLWfkcuNjlBMdcgZhmbmgpoJXGqAQSqmjdcxBL0J3wcb
	5iHXyXr7/Xt5+r0Xv05h9QC46OlKWmdGGu4jb2e2mr85/6G5/spww+RgKRRUGd9H
	h2ziEWw72sE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8CFB5651;
	Mon,  6 Jun 2011 12:16:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35EFD564C; Mon,  6 Jun 2011
 12:16:50 -0400 (EDT)
In-Reply-To: <4DECE147.3060808@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 06 Jun 2011 16:16:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66E11168-9058-11E0-B5AD-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175134>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> That is why I asked what the user experience of "git show NEXT" as opposed
>> to "git show INDEX" should look like. So what should it look like during a
>> "pull" that did not finish?
>
> If NEXT is to mean the result of a commit in the current state, and the
> current state would or should not allow a commit, then trying to access
> that pseudo-commit should error out with a helpful message.

What "helpful message"? I asked for the user experience, not handwaving.

Do you mean to say that the error message would teach the user that the
current state is not something you can create a commit? What message would
that give the end user?  I am hoping the following is not what will happen:

  Q. I tried "git show NEXT" because I wanted to see what the next commit
     would look like, but I got an error, saying NEXT is not known as I
     haven't resolved a conflict.

  A. Yes, the message is correct.

  Q. But then how can I see what the next commit would look like?

  A. You would say "git diff HEAD NEXT".

  Q. Ah, that is the same as I always do before making a commit to see what
     I have added so far look sane. Thanks.

     ...after 2 minutes...

  Q. Sorry, it does not work. I get the same error, that says NEXT is not
     known yet.

  A. Ok, you would say "git diff HEAD" the old fashioned way. The person
     who thought NEXT would be useful didn't think things through.

  Q. Now I am seeing a diff between the conflicted state and the previous
     commit, I think I can get to where I want to go from here. Thanks.


> Another option is to make NEXT/INDEX mean a tree (:0:). I have not
> thought this through (and have not made a suggestion, accordingly) but I
> do see a problem in the UI. (I don't think we need to change the
> existing ui in that respect but can amend and improve it.)
>
> Anyway, it's rc phase :)

Rc or not rc, just repeating a fuzzy and uncooked "idea" around phoney
ref-looking names that will end up confusing the users, and selling that
as if it is a logical conclusion to "we want to give an easier to
understand UI", without presenting a solid user experience design that is
convincing enough that the "idea" will reduce confusion will not get us
anywhere, especially when it is sprinkled with ad hominem attack at me.
