From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: remove tabs from usermap file
Date: Fri, 27 Feb 2009 21:50:54 +0100
Message-ID: <200902272150.55132.simon@lst.de>
References: <20090227185359.GA18102@padd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9hF-0006ob-AP
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbZB0UvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbZB0UvE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:51:04 -0500
Received: from verein.lst.de ([213.95.11.210]:50014 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650AbZB0UvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:51:01 -0500
Received: from rani.localnet (197.80-202-68.nextgentel.com [80.202.68.197])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n1RKotIF009440
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 Feb 2009 21:50:56 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.28-8-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <20090227185359.GA18102@padd.com>
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111713>

On Friday 27 February 2009 19:53:59 Pete Wyckoff wrote:
> Some users have tabs in their names, oddly enough.  This
> causes problems when loading the usercache from disk,
> as split separates the fields on the wrong tabs.  When
> fast-import's parse_ident() tries to parse the committer
> field, it is unhappy about the unbalanced <..> angle brackets.
>
> It is easy enough to convert the tabs to single spaces.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
> Here's another random little fix.  We have a user
> Firstname\tLastname who checked something in recently and
> broke my git-p4 conversion.
>
> I need to send the other acked patch to Junio; will wait
> and give him two if you ack this one.

Looks good to me :-)

Acked-by: Simon Hausmann <simon@lst.de>


Thanks,
Simon

>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 3832f60..342529d 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1142,7 +1142,7 @@ class P4Sync(Command):
>
>          s = ''
>          for (key, val) in self.users.items():
> -            s += "%s\t%s\n" % (key, val)
> +	    s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
>
>          open(self.getUserCacheFilename(), "wb").write(s)
>          self.userMapFromPerforceServer = True
