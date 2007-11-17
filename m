From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn's dcommit must use subversion's config
Date: Sat, 17 Nov 2007 13:22:41 -0800
Message-ID: <20071117212241.GA22835@soma>
References: <200711140352.02978.voxus@onphp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Konstantin V. Arkhipov" <voxus@onphp.org>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItV80-00044G-MA
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbXKQVWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXKQVWn
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:22:43 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33683 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbXKQVWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:22:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A24BB7DC0FE;
	Sat, 17 Nov 2007 13:22:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200711140352.02978.voxus@onphp.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65311>

"Konstantin V. Arkhipov" <voxus@onphp.org> wrote:
> When doing dcommit git-svn must use subversion's config or newly created
> files will not include svn's properties
> (defined in [auto-props] with 'enable-auto-props = yes').
> 
> Signed-off-by: Konstantin V. Arkhipov <voxus@onphp.org>

> ---
> --- git-svn	2007-11-02 18:41:32.000000000 +0300
> +++ git-svn	2007-11-12 19:35:44.000000000 +0300

Thanks Konstantin,

I needed to add '.perl' to the filenames above to get the patch to
apply.  But otherwise,

Acked-by: Eric Wong <normalperson@yhbt.net>

> @@ -406,6 +406,9 @@ sub cmd_dcommit {
>  			my %ed_opts = ( r => $last_rev,
>  			                log => get_commit_entry($d)->{log},
>  			                ra => Git::SVN::Ra->new($gs->full_url),
> +			                config => SVN::Core::config_get_config(
> +			                        $Git::SVN::Ra::config_dir
> +			                ),
>  			                tree_a => "$d~1",
>  			                tree_b => $d,
>  			                editor_cb => sub {

-- 
Eric Wong
