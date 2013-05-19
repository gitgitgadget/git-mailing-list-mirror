From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Random thoughts on "upstream"
Date: Sat, 18 May 2013 22:58:57 -0700
Message-ID: <7vmwrr1pem.fsf@alter.siamese.dyndns.org>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 07:59:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdweH-0008Cw-E3
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 07:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab3ESF7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 01:59:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48215 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab3ESF7A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 01:59:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804961BDBA;
	Sun, 19 May 2013 05:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fjQMLqLDbn/sBJ5sT76QLvdg+fE=; b=o4+j/nQ2DCbw34eivq3Q
	xav/Y6Z1fYX78hV2H7BHJIKWYNCHw4ll0C99q87t4nX7bQvJUTLS14wksT7jZEso
	BIJr6803TQ4MOYzfCr5QTlq60/nB2DB8s1eOCOcRIqRRV+rOUmZowGpswagJEZBE
	ucNTsamCFizb7+6KYxeaKYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WmZHkjMgaMs0EhfONenolnrjbajPDZ1Fee6Jr37vwQKUFD
	fROOx5A1YibbW2s6zyBJWc1PYp0ZNTOJmPPh0jeYIX+8Qp+uHRJ7kSL6C42kDSSd
	IbnPTltGnKEWTjdiB3vdwpGaH4F62j4ztVdczJobqjGZ+jn9TfYnhU4GsTzhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 775291BDB9;
	Sun, 19 May 2013 05:58:59 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADAC51BDB8;
	Sun, 19 May 2013 05:58:58 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3284874C-C049-11E2-8C29-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224818>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Having said that I am not sure where your "not overly fond of" comes
>> from, as I do not see a problem with branch.<name>.push.  The only
>> problem I may have with the approach would arise _only_ if we make
>> it the sole way to allow people push to different names, forcing
>> people who want to push N branches to configure it N times.  Other
>> than that, I think it is an acceptable solution to give per-branch
>> control.
>
> It doesn't strike me as being elegant at all.
>
> [branch "hot-branch"]
>     remote = ram
>     push = refs/heads/for-junio/hot-branch
>
> 1.  I git branch -M for-each-ref and push.  Screwed.

-ECANTSEEWHATYOUMEAN.  Your proofreader is screwed ;-)

> 2.  Let's say you give me the thumbs up to write hot-branch to origin.
>  Excitedly, I change the remote to origin.  Now I already have push
> semantics for origin (you obviously want me to write to rr/, so I can
> cooperate with others):
>
> [remote "origin"]
>     push = refs/heads/*:refs/heads/rr/*
>
> Unfortunately, it doesn't kick in unless I change branch.<name>.push.

I thought branch.$name.push is "What ref do I push this out as?"

At this point you have two remotes, me as your upstream, and your
publishing point, and remote.pushdefault set to the latter since
originally you cannot push to 'origin':

    [push]
        default = simple ;# adopt 2.0 default early
    [remote]
        pushdefault = ram

    [remote "ram"}
	url = github.com:ram/something.git
        fetch = +refs/heads/*:refs/remotes/ram/*
        push = +refs/heads/*:refs/heads/*

    [remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*

    # assuming you forked from my master
    [branch "hot-branch"]
        remote = origin
        merge = refs/heads/master
   +    pushremote = origin
   +    push = refs/heads/rr/hot-branch

The above pseudo-diff would be the changes you would be making to
your configuration when you were asked to push your 'hot-branch' to
'origin' as 'rr/hot-branch', I think.

If somebody implements the "push.default = single" (see the original
message you are responding to), then the change might be smaller.

    [push]
   -    default = simple ;# adopt 2.0 default early
   +    default = single

    [remote]
        pushdefault = ram

    [remote "ram"}
	url = github.com:ram/something.git
        fetch = +refs/heads/*:refs/remotes/ram/*
        push = +refs/heads/*:refs/heads/*

    [remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*
   +    push = +refs/heads/*:refs/heads/rr/*

    # assuming you forked from my master
    [branch "hot-branch"]
        remote = origin
        merge = refs/heads/master
   +    pushremote = origin

> I guess what I'm saying is: refspec semantics are inherent
> properties of the remote, not of the local branch.  Since there is
> no intermediate refs/remotes/* sitting between the remote and
> local branches, this is _not_ like branch.<name>.merge at all.

Somewhat true, if you write this with branch.hot-branch.push without
push.default=single implicitly introduces

	refs/heads/hot-branch:refs/heads/rr/hot-branch

refspec to the remote named by branch.hot-branch.pushremote.
