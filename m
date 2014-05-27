From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9138-git-svn-authors-prog.sh fixups
Date: Tue, 27 May 2014 12:43:06 -0700
Message-ID: <xmqq8upnf1o5.fsf@gitster.dls.corp.google.com>
References: <1401045894-22711-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 21:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNHI-0006tU-9G
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaE0TnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:43:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52437 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbaE0TnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:43:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF5591B844;
	Tue, 27 May 2014 15:43:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21LNukFuhgHdq/FE8PJzw5HkmV0=; b=ZcTIJY
	32VEasgI922FH38CTba6W4JXOeCYSDIqWJ9U49g+3+7U3qyr5nFysBqpx9paTG/c
	m494qDX4jJOjqGqcHY4n3iXy9hZ5QHcStSUT7g2P3paCD8DOXt/bIjRgzYQ+nx4J
	lwoPNDfcPdlr9UX4TlX+Zxk2XMMUhe4l0mviQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yquu+xRNvHqWoB+1uEjtMK6zgvMkJuPa
	Gx+N02WOFO1PYMjBV3r1xzlmzwP55TJ3S9ntp0hiuaFVLmc0YEi43/LWcQKw3hAA
	BfZTtGr/zC8g6t59+ViIfl3BDSfv6agBkFrmACXSb0G6doZQxtkhq63cJ3fiXliX
	yLloW2GvzyE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E39661B843;
	Tue, 27 May 2014 15:43:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 78AFA1B83C;
	Tue, 27 May 2014 15:43:07 -0400 (EDT)
In-Reply-To: <1401045894-22711-1-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Sun, 25 May 2014 12:24:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 205F1938-E5D7-11E3-81F6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250194>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Several fixups of the t9138-git-svn-authors-prog.sh test script to
> follow current recommendations in t/README.
>
>   - Fixed a Perl script with a full "#!/usr/bin/perl" shebang
>     to use write_script() and $PERL_PATH as per t/README.
>
>   - Placed svn-authors data setup inside a test_expect_success.
>
>   - Fixed trailing quotes to use the same indentation throughout.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  t/t9138-git-svn-authors-prog.sh | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
> index 83cc5fc..d54c37a 100755
> --- a/t/t9138-git-svn-authors-prog.sh
> +++ b/t/t9138-git-svn-authors-prog.sh
> @@ -7,40 +7,39 @@ test_description='git svn authors prog tests'
>  
>  . ./lib-git-svn.sh
>  
> -cat > svn-authors-prog <<'EOF'
> -#!/usr/bin/perl
> -$_ = shift;
> -if (s/-sub$//)  {
> -	print "$_ <$_\@sub.example.com>\n";
> -}
> -else {
> -	print "$_ <$_\@example.com>\n";
> -}
> +write_script svn-authors-prog $PERL_PATH <<-\EOF

I think you meant to dq "$PERL_PATH" here.  Other than that, looks
OK to me.

Thanks.
