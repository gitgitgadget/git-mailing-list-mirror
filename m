From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Sat, 25 Jan 2014 22:37:21 +0000
Message-ID: <20140125223721.GA2684@dcvr.yhbt.net>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
X-From: git-owner@vger.kernel.org Sat Jan 25 23:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7BrJ-000454-9S
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 23:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaAYWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 17:37:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54074 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbaAYWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 17:37:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C431FB96;
	Sat, 25 Jan 2014 22:37:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241077>

Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru> wrote:
> Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
> ---
>  git-send-email.perl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Some documentation references to .mailrc and its format would be nice.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
>  use Error qw(:try);
>  use Git;
> +use File::HomeDir;

We should probably avoid a new dependency and also remain consistent
with the rest of git handles home directories.

Unfortunately, expand_user_path()/git_config_pathname() isn't currently
exposed to scripters right now...
