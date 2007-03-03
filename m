From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] .git directory should be ignored
Date: Sat, 03 Mar 2007 14:05:01 -0800
Message-ID: <7vzm6u7zle.fsf@assigned-by-dhcp.cox.net>
References: <15268.1172917083@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, julliard@winehq.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:05:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNcLk-0008JK-PY
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbXCCWFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbXCCWFE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:05:04 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50005 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbXCCWFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:05:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303220502.OHGR3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 17:05:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WN521W0051kojtg0000000; Sat, 03 Mar 2007 17:05:02 -0500
In-Reply-To: <15268.1172917083@localhost> (Xavier Maillard's message of "Sat,
	03 Mar 2007 11:18:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41331>

Xavier Maillard <zedek@gnu.org> writes:

> Add .git to the list of extensions to be ignored
>
> Signed-off-by: Xavier Maillard <zedek@gnu.org>
> ---
>  contrib/emacs/vc-git.el |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
> index a2d3932..3d43ca0 100644
> --- a/contrib/emacs/vc-git.el
> +++ b/contrib/emacs/vc-git.el
> @@ -149,4 +149,7 @@
>  ;;    (and (looking-at "[0-9a-f]+")
>  ;;         (buffer-substring (match-beginning 0) (match-end 0)))))
>  
> +;;;###autoload
> +(add-to-list 'completion-ignored-extensions ".git/")
> +
>  (provide 'vc-git)

I am no Emacs vc expert to judge, but I wonder if it is kosher
to muck with that global variable from a vc backend.

The above does mirror what pcl-cvs does for "CVS/" but I notice
that vc-cvs.el does not do so, neither vc-rcs.el excludes
"RCS/".
