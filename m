From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] add is_git_repo (is_git_repository for char*)
Date: Sat, 5 Dec 2015 02:01:37 -0500
Message-ID: <20151205070137.GB21639@sigill.intra.peff.net>
References: <1449252917-3877-1-git-send-email-a.krey@gmx.de>
 <1449252917-3877-2-git-send-email-a.krey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:01:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a56qn-00045t-12
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 08:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbbLEHBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 02:01:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:37689 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbbLEHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 02:01:40 -0500
Received: (qmail 8874 invoked by uid 102); 5 Dec 2015 07:01:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 01:01:40 -0600
Received: (qmail 969 invoked by uid 107); 5 Dec 2015 07:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Dec 2015 02:01:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Dec 2015 02:01:37 -0500
Content-Disposition: inline
In-Reply-To: <1449252917-3877-2-git-send-email-a.krey@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282029>

On Fri, Dec 04, 2015 at 07:15:16PM +0100, Andreas Krey wrote:

> diff --git a/cache.h b/cache.h
> index 6626e97..42ab0c3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -440,6 +440,7 @@ extern const char *get_git_dir(void);
>  extern const char *get_git_common_dir(void);
>  extern int is_git_directory(const char *path);
>  extern int is_git_repository(struct strbuf *sb);
> +extern int is_git_repo(const char *path);

If we have two functions which do the same thing but differ only in
their interface (here strbuf versus a C-string), we should probably give
them related names that indicate the difference.

So "is_git_repository_str()" or something. (though per my previous
email, I think we should have a new name for the first one, too).

-Peff
