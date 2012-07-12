From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I append authentication with "git push" ?
Date: Thu, 12 Jul 2012 10:22:18 -0700
Message-ID: <7vpq80c2t1.fsf@alter.siamese.dyndns.org>
References: <20120712134844.2d1c4378@shiva.selfip.org>
 <CACnwZYfbbZJV--aaOVH+af+Hxibg7XWvb909kZYWgKXVHexfDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bakshi" <joydeep.bakshi@infoservices.in>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpN5u-0005SR-5y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407Ab2GLRWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:22:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161288Ab2GLRWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:22:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 314088D6D;
	Thu, 12 Jul 2012 13:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbsVEAbvFr7/r96ZLClyyNytGVc=; b=Amkmsh
	ndz+507dclF4eocCYnNdNlSZwGcceqpB9Ev4yBAshPHj9fpB5k7q0t8whydoIlUe
	9jBWVpLJ4nhG8SmYXAxwPOPR+odqRPvdYv3gq/duxZsu3Cevgk8bqsnRy719xMeq
	cVWVpuZKP1GoAfCPblHJydb5dNMBaKsPwYozs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k+9Yzq1LuMNQeEfRsALcjVlQV1yCgbAH
	8kGHWUk+AIs0cC7ivdUch89ixHpNaYZjeYDHUv1E/drWHZXj0lfvYD1xggg91WzT
	0c9nTobCuIbElk5oQeBI1pllGv4rPe7ZVMH3kgTbkwbzwXaRXWKqIUViuamompF8
	otA/1ZihcIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2857C8D6C;
	Thu, 12 Jul 2012 13:22:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1C5D8D67; Thu, 12 Jul 2012
 13:22:19 -0400 (EDT)
In-Reply-To: <CACnwZYfbbZJV--aaOVH+af+Hxibg7XWvb909kZYWgKXVHexfDw@mail.gmail.com> (Thiago
 Farina's message of "Thu, 12 Jul 2012 12:04:27 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 228EF446-CC46-11E1-B992-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201368>

Thiago Farina <tfransosi@gmail.com> writes:

> On Thu, Jul 12, 2012 at 5:18 AM, J. Bakshi
> <joydeep.bakshi@infoservices.in> wrote:
>> Or any repo wise configuration file where I can save the info, so that
>> it doesn't ask the credential before every push ?
>>
> I'd like to know how to do that too.
>
> It's a pain to have to type username and password every time I need to
> push to github. (Linux here btw).

I never type either when pushing to github, and I've been pushing
there at least twice a day for quite some time (Linux here btw).

I have these in .git/config:

        [remote "github2"]
                url = https://github.com/git/git
                fetch = +refs/heads/*:refs/remotes/github2/*
                pushurl = github.com:git/git.git
                push = refs/heads/maint:refs/heads/maint
                push = refs/heads/master:refs/heads/master
                push = refs/heads/next:refs/heads/next
                push = +refs/heads/pu:refs/heads/pu

        [remote "github"]
                url = https://github.com/gitster/git
                pushurl = github.com:gitster/git.git
                mirror

and then this in $HOME/.ssh/config:

        Host github.com
                User git
                IdentityFile ~/.ssh/github
