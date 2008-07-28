From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow building without any git installed
Date: Mon, 28 Jul 2008 06:50:00 -0700
Message-ID: <20080728135000.GA3996@spearce.org>
References: <7vsktutrh5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 15:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNT7v-0001Sl-Hf
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 15:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbYG1NuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 09:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbYG1NuB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 09:50:01 -0400
Received: from george.spearce.org ([209.20.77.23]:40163 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYG1NuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 09:50:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B919383A5; Mon, 28 Jul 2008 13:50:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vsktutrh5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90460>

Junio C Hamano <gitster@pobox.com> wrote:
> This is a follow-up patch to 49fa65a (Allow the built-in exec path to be
> relative to the command invocation path, 2008-07-23).  Without specific
> gitexecdir passed from the command line, git-gui's build procedure would
> try to figure out the value for it by running an installed git.

Ack.  I noticed this yesterday while looking at the git Makefile but
forgot to send a patch for it myself.  Thanks Junio.

 
> diff --git a/Makefile b/Makefile
> index 798a2f2..7e30b30 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1067,7 +1067,7 @@ endif
>  
>  all::
>  ifndef NO_TCLTK
> -	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
> +	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
>  	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
>  endif
>  	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all

-- 
Shawn.
