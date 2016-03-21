From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 13:52:16 -0700
Message-ID: <xmqqfuvjlfjz.fsf@gitster.mtv.corp.google.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:52:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6oK-0000yt-5l
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbcCUUwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:52:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751100AbcCUUwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:52:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67EE84DDCA;
	Mon, 21 Mar 2016 16:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+3o96y7DtNeOLNU7XESNdyidGA=; b=iu6NMQ
	Py0HsEAegj01GCrLzrp5S8nUFhGE641tWRGSPdFUFAUlI1b7GyTarEuUw8h5ruya
	Fyls1YEJjT4XWLjDwNUhzSHbxu28QWacjnwrSk8vnKk1vAi8rTaIaSL5wgN1zGMe
	dUbgUk74zYQGqteunARk1vHKBbMP+g8TUO4lU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cK0/SJN4TRvDuCCxml4FHyfdJCqdVYha
	yqX9oCE81dx3WgSsInQ+dtOL+gauHpDlVq0S+m6Bqkh6IQ/e++TeylfGwK4R9ep0
	9Zi/PYbq6kf0O4S9dfonHypI4Zq29D6q/ZlTFx6+c1EetrAV9AQ/a6HZKaJRNO7c
	KiOS2i3cbjg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FE294DDC9;
	Mon, 21 Mar 2016 16:52:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C720C4DDC8;
	Mon, 21 Mar 2016 16:52:17 -0400 (EDT)
In-Reply-To: <20160321202810.GD32071@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 21 Mar 2016 16:28:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC718AA0-EFA6-11E5-B485-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289461>

Jeff King <peff@peff.net> writes:

> The message from checking is looking only at your local
> refs/remotes/fvwmorg/master branch, which is essentially a cache of what
> is in the actual remote repository.

Saying "cache of what is ..." would further confuse people, I am
afraid.  We just keep a record of what we last observed and we do
not actively go out and update the remote tracking branch without
being told by the end user.  "cache of what we saw there when we
contacted them the last time" is OK ;-).

>
> We never contact other repositories unless explicitly asked to by
> fetch, pull, push, etc. If you want to have the most up-to-date value
> without merging, you can just "git fetch" to update the tracking
> branches.
>
> -Peff
