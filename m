From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Fri, 29 Jun 2012 13:03:21 -0700
Message-ID: <7v8vf551iu.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
 <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
 <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 22:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkhPm-0001oi-7p
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 22:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab2F2UDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 16:03:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085Ab2F2UDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 16:03:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 572CA979E;
	Fri, 29 Jun 2012 16:03:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDoocOfpVBuPi7nrYUPCPzVpz5g=; b=jG0Ncw
	c4kwDUssZMh+Xcasx2BAsTypF79g9sN4veBWWmzA5+D8rq/mBtKl2HhhS98457iY
	8SINVzzy0jGe++sgu7mOKDmUBHDmtOZp2LL4sBwa750wCxYHZm+ICnqlNYlkZCcF
	1o8L3HsHENn3gjQPDoRXpv0PeNi7+Wk8ftHcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W8A/bUPZpQL0eZo6YvtcAWJ+fYBdjXz1
	Dccwvc98T1k5N1h5HNxMjeuiwfIhvJoaTWZ5u4I42q4UfHhJ1H5RRdM/1NU8hieb
	FCDy91p93ehMbjBWGWfPzIkksaN5tLM3tyUFAxwjSokrr4zwtWYhbbKrqM2rSmui
	j2AXU05C3ik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BBDF979D;
	Fri, 29 Jun 2012 16:03:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FF6979C; Fri, 29 Jun 2012
 16:03:22 -0400 (EDT)
In-Reply-To: <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com> (Richard
 Hartmann's message of "Fri, 29 Jun 2012 10:43:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7ADC7FFE-C225-11E1-8868-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200827>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> Mangling the email I respond to out of order.
>
> On Wed, Jun 27, 2012 at 12:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> but I
>> am not sure if that is too restrictive for people who for some
>> unknown reason want to use these environment variables to create
>> repositories with a strange layout.
>
> This is exactly the point. For vcsh[1] to work, I need to set it up like this:
>
>     richih@titanium  ~ % vcsh enter zsh
>     richih@titanium [zsh] [2] (git)-[master] ~ % echo $GIT_WORK_TREE
>     /home/richih
>     richih@titanium [zsh] [2] (git)-[master] ~ % echo $GIT_DIR
>     /home/richih/.config/vcsh/repo.d/zsh.git
>     richih@titanium [zsh] [2] (git)-[master] ~ %
>
>
>> Declaring that a checked out submodule _must_ have its controlling
>> repository as ".git" at its root level, i.e. it should be accessible
>> without using GIT_WORK_TREE/GIT_DIR at all just like a normal Git
>> repository is, would be a clean way to avoid the issue altogether
>> and it still will allow the top-level superproject to be structured
>> in a funny way to require GIT_WORK_TREE/GIT_DIR to access it,
>
> I fear this would make vcsh unable to support submodules, ever.

Then think of a workable alternative.  As it stands, I would have to
say that what vcsh tries to do with git is broken with respect to
submodules.
