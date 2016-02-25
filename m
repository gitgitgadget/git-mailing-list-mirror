From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reflog: weird options
Date: Wed, 24 Feb 2016 16:49:11 -0800
Message-ID: <xmqqbn75r4vs.fsf@gitster.mtv.corp.google.com>
References: <1456358433.18017.35.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:49:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYk7W-0005nq-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121AbcBYAtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:49:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757990AbcBYAtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:49:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B3A848D13;
	Wed, 24 Feb 2016 19:49:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z7iR6YXhN7p9BaWuWYsxUB1+Ryg=; b=KUbkBS
	S8TQxA3UXZKx0HYFUGgwuJjPSizssx5P3eW0cbMhAXQZEsT3cTB596VxLjHUvOsc
	dEWRPgu3+P+1N16oMyApLeaTAjjRjw6Ea+H+59u4iG303WR55MCjsJ8D0FFJDOVS
	HzPi1OYbv911fwggIGFCtTmLC9r1BIO5t+tl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcXgooayhHGenNzjxGfDnjOlbtJzS3mz
	NPDIYI1Ln4W3OOWHsNNjoIcSknBd+7XeLRKC2BFr8F2e9muOOLJogbcE7oVZuP06
	Dh/NhaknKSY/DkF61oz9SEOTbDIu/wrlAgB9cTToZ8MI/A8HWjSx7To5tw5H86We
	sUPD/2+YoK8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01CAA48D12;
	Wed, 24 Feb 2016 19:49:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B3C348D11;
	Wed, 24 Feb 2016 19:49:12 -0500 (EST)
In-Reply-To: <1456358433.18017.35.camel@twopensource.com> (David Turner's
	message of "Wed, 24 Feb 2016 19:00:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 965214FA-DB59-11E5-94D8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287296>

David Turner <dturner@twopensource.com> writes:

> The manual for git reflog says it takes "[log-options]".  And it does,
> sort-of.  For instance, you can give a path, and it will only show you
> reflog entries that touch that path (I'm not sure why you would want to
> do that, but you can!).  But you can also give --merges, which will
> silently give you no reflog entries.  I don't know why.
>
> One useful option that may or may not exist: show the time the reflog
> entry was made.  I'd really like to say, "well, I know it was working
> as-of last Tuesday...".  I know the data is in the reflog, but I don't
> know how to show it.  I can show the committer date, which is usually
> good enough when I'm rewriting a patch series, but that is not quite
> the same thing.
>  
> I know I could fix these issues, but unfortunately I don't have the
> time right now. It might make a good starter project for someone new to
> git development!

I think somebody who is fairly new to the project was already
looking into it.  The hacky way the feature to show "reflog" entries
was implemented (i.e. done by tweawking the "git log" machinery,
even though the entries that comes out of the "log" and "reflog" are
quite different things, as you observed by the lack of "time the
reflog entry was created") shows up as these inconsistencies and
"Huh?"s.
