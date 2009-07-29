From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: add an option to recode pathnames
Date: Wed, 29 Jul 2009 11:59:19 -0700
Message-ID: <20090729185919.GA13518@dcvr.yhbt.net>
References: <ylnfxcfdeyq.fsf@tmsoft-ltd.kiev.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWEN7-00065J-DL
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 20:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZG2S7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 14:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbZG2S7T
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 14:59:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42017 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbZG2S7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 14:59:19 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id BE7421F4EA;
	Wed, 29 Jul 2009 18:59:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ylnfxcfdeyq.fsf@tmsoft-ltd.kiev.ua>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124381>

Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua> wrote:
> Introduce new option 'svn.pathnameenc' that instructs git svn to recode
> pathnames to given encoding.  It's useful for windows users and for those
> who works in non-utf8 locales, since otherwise they'll have corrupted file
> names with non-ascii characters.
> 
> Signed-off-by: Dmitry Statyvka <dstatyvka@tmsoft-ltd.kiev.ua>
> ---
>  git-svn.perl |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index ef1d30d..bdd9af0 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3343,6 +3343,7 @@ sub new {
>  	$self->{absent_dir} = {};
>  	$self->{absent_file} = {};
>  	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
> +	$self->{pathnameencoding} = Git::config('svn.pathnameenc');

Hi Dmitry,

Can we use a more consistent name for the user-visible config option?
"svn.pathnameencoding" would be more consistent with the other
encoding-related config options we have.

I'd also like this option documented in the manpage so more people know
about it.

Otherwise the patch looks fine though a testcase would be helpful, too.

Thanks!

-- 
Eric Wong
