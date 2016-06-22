Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF1D20189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbcFVRBD (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:01:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753080AbcFVRBA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:01:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91EF523DE4;
	Wed, 22 Jun 2016 13:00:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TRby4ZQfWGq1mKqzL5VD8f5H/XI=; b=n6kLyo
	wa7klJ9DTy8YRNlgha6TYLHv7rDRjRy6sUFAIu5uf2/UYy3bm73/HV1JFFowlQqy
	Q2vvVnlRh11ZkZFG39HZYX2Q9c3U/Djeb8EjabqHp7yCm6/gzLcOGtgnKP7JWIgW
	3wTy9ZLEZfNW9nRrX9J2+1xylguoYNs97L6S4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWrt6Dhw9ktMpklQaQSW35mO/5+yNTWE
	VB6hoer1NyVO+uu5I/52xRwiTrCKdCjF4Oz/ZZcyUIcOA7QaIE4gib8CMJO7kbbD
	JUKOWU1CyEhJxuvhYTxEVivPl8G0H7JI4np3T1Oj+6ZbET/DVI6qosh8KJMFdbK+
	Sh6DwRIvHEc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89AEF23DE2;
	Wed, 22 Jun 2016 13:00:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2E6623DDF;
	Wed, 22 Jun 2016 13:00:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
	<20160622024151.GA20206@google.com>
Date:	Wed, 22 Jun 2016 10:00:56 -0700
In-Reply-To: <20160622024151.GA20206@google.com> (Jonathan Nieder's message of
	"Tue, 21 Jun 2016 19:41:52 -0700")
Message-ID: <xmqq60t1noon.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4702F20-389A-11E6-83BC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> http://git-htmldocs.googlecode.com/git/git.html says
>
>  There was no service found for the uri requested.
>
> Link to the HTML documentation on repo.or.cz instead.

http://thread.gmane.org/gmane.comp.version-control.git/296483/focus=296575

Peff suggested to use the github pages that are connected to the
"git" org, and helped its initial set-up.  When I update the
prebuilt docs, in addition to the listed locations, I also push to
the gh-pages branch of https://github.com/git/htmldocs repository
and the result appears in https://git.github.io/htmldocs/git.html

Even though we do have index.html -> git.html, gh-pages does not
seem to let you follow it, so you need to start from git.html, and I
suspect that it is why the below says "I wasn't able to find it" for
(5).

So perhaps list both?  I do not know how beefy repo.or.cz is, or how
well connected it is to the rest of the world, but if I have to pick
only one, I'd feel safer if we didn't have to exploit the "blob_plain/:"
backdoor.

Thanks.

> I'd rather use an up-to-date https link for the rendered
> documentation, but I wasn't able to find one.  According to the 'todo'
> branch, prebuilt documentation is pushed to
>
>  1. https://kernel.googlesource.com/pub/scm/git/git-htmldocs
>  2. git://repo.or.cz/git-htmldocs
>  3. somewhere on git.sourceforge.jp and git.sourceforge.net?
>  4. https://github.com/gitster/git-htmldocs
>  5. https://github.com/git/htmldocs
>
> Of these, (1) and (4) don't provide a raw view with content-type
> text/html.  (5) might be available as HTML through Jekyll, but I
> wasn't able to find it --- e.g., https://git.github.io/htmldocs does
> not show those pages.  I wasn't able to find (3) at all.  That leaves
> (2).
>
> Reported-by: Andrea Stacchiotti <andreastacchiotti@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Andrea,
>
> Andrea Stacchiotti wrote[1]:
>
>> In the git manual (`man git`), the documentation link:
>> > http://git-htmldocs.googlecode.com/git/git.html
>> is broken.
>
> Thanks for reporting.  How about this patch?
>
> Thanks,
> Jonathan
>
> [1] http://bugs.debian.org/827844
>
> -- >8 --
> Subject: doc: git-htmldocs.googlecode.com is no more
>
>  Documentation/git.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 5490d3c..de923db 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -31,8 +31,8 @@ page to learn what commands Git offers.  You can learn more about
>  individual Git commands with "git help command".  linkgit:gitcli[7]
>  manual page gives you an overview of the command-line command syntax.
>  
> -Formatted and hyperlinked version of the latest Git documentation
> -can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
> +A formatted and hyperlinked copy of the latest Git documentation
> +can be viewed at `http://repo.or.cz/git-htmldocs.git/blob_plain/:/git.html`.
>  
>  ifdef::stalenotes[]
>  [NOTE]
