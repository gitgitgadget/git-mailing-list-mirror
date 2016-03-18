From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 09:37:31 -0700
Message-ID: <xmqqr3f7rbck.fsf@gitster.mtv.corp.google.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
	<CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
	<alpine.DEB.2.20.1603181532040.4690@virtualbox>
	<CA+55aFwbRVG-5AW+NnMOFZ_hU5i+i7f3FxgEt9Qm7B6pEd7x0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio\@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 17:37:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agxPA-0006zX-LD
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 17:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbcCRQhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 12:37:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbcCRQhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 12:37:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C7314D7AB;
	Fri, 18 Mar 2016 12:37:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QUfzvlYHm34wOcBFXSeMDIdGX5E=; b=kYQ3g2
	BRXp8ZixfRp13WhDTSn/zE2e6DId4fTDXXYvbbbiv3Qcg8H72tmMRnRCfZ8VeIcO
	n7FuuN8Icjzd6s6jG+hRuSNZYtB2nBrzb78kvXsjelw2QsTf1HIQqwyvWM7mACdX
	quLBKxzjT8Gb5S07Gt4fpRo7Q2v8SBwdt2yQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dG7xfKHp3NMRcfVwk0/BPnY5JhUN/JRx
	XJLu5i8BkV2hiVRfaITEmXckCc3l+SXycSEAzThKH6cH4JhrpR5UmSi7mxA6eEeU
	Mbs09LUcY04aTbLPByQ/ZIXrHzVR+Si698XOra9tzqpVMIryxuCItPwuCZUw1voN
	Fk+7TaqI0X4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82B9A4D7A8;
	Fri, 18 Mar 2016 12:37:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D57DA4D7A5;
	Fri, 18 Mar 2016 12:37:32 -0400 (EDT)
In-Reply-To: <CA+55aFwbRVG-5AW+NnMOFZ_hU5i+i7f3FxgEt9Qm7B6pEd7x0g@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 18 Mar 2016 08:47:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6B68D68-ED27-11E5-A82D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289231>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's literally just the fact that "git merge" does it with no extra
> flags or checks. I'd like people to have to be aware of what they are
> doing when they merge two different projects, not do it by mistake.
>
> So making it conditional on a flag like "--no-common-root" is what I'd look for.

I think I said essentially the same thing in a separate message; I
am not sure "--no-common-root" is a good name, but I think it is
better to be more explicit than tying this to a strategy.

> I don't think the original "resolve" did it, for example. You can't do
> a three-way merge without a base.

Yes, and that continues to this day:

        # Give up if we are given two or more remotes -- not handling octopus.
        case "$remotes" in
        ?*' '?*)
                exit 2 ;;
        esac

        # Give up if this is a baseless merge.
        if test '' = "$bases"
        then
                exit 2
        fi

This is a tangent but I wonder if we should say why we refuse to
the standard error before calling these two "exit"s.
