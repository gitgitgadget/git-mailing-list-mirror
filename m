From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH] builtin/tag.c: Fix a sparse warning
Date: Mon, 13 Feb 2012 11:15:00 -0800
Message-ID: <20120213191459.GA2707@tgrennan-laptop>
References: <4F395569.8030106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:15:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1Mn-0006Cj-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598Ab2BMTPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:15:07 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41934 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab2BMTPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:15:06 -0500
Received: by qadc10 with SMTP id c10so1828632qad.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yhkfh8sRjhEUZjGljggzhA5eHPPxFZpnIyc3ONLs9vo=;
        b=dukJU0P2MwkCRsQ7SaUh9EuLWBHYKX9pEbNJbnoQ8B5gzBboiKWIovxCkhgQVMT7eJ
         q0ZPS8DQt3PIu+dO9gxU3S7UKm21NLZ7ePUpM0pW6WJHwY19/+jFBywuqaVyYFLMzqNI
         58q0iuEMY+p5SLkKgsja/8+c2KsndeEfciBh4=
Received: by 10.229.78.203 with SMTP id m11mr10240768qck.86.1329160505736;
        Mon, 13 Feb 2012 11:15:05 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id eb5sm35919293qab.10.2012.02.13.11.15.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 11:15:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F395569.8030106@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190652>

On Mon, Feb 13, 2012 at 06:24:41PM +0000, Ramsay Jones wrote:
>
>In particular, sparse complains as follows:
>
>        SP builtin/tag.c
>    builtin/tag.c:411:5: warning: symbol 'parse_opt_points_at' was \
>        not declared. Should it be static?
>
>In order to suppress the warning, since the parse_opt_points_at()
>function does not need to be an external symbol, we simply add the
>static modifier to the function definition.
>
>Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Acked-by: Tom Grennan <tmgrennan@gmail.com>

Thanks

>---
>
> builtin/tag.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/builtin/tag.c b/builtin/tag.c
>index 8cfaaf8..fe7e5e5 100644
>--- a/builtin/tag.c
>+++ b/builtin/tag.c
>@@ -408,7 +408,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
> 	return check_refname_format(sb->buf, 0);
> }
> 
>-int parse_opt_points_at(const struct option *opt __attribute__ ((unused)),
>+static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
> 			const char *arg, int unset)
> {
> 	unsigned char sha1[20];
>-- 
>1.7.9
>
>
