X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 11:52:47 -0800
Message-ID: <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<200612141136.59041.andyparkins@gmail.com>
	<20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
	<20061214120518.GL1747@spearce.org>
	<Pine.LNX.4.64.0612141251520.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 19:53:02 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612141251520.18171@xanadu.home> (Nicolas Pitre's
	message of "Thu, 14 Dec 2006 13:06:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34388>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuwdS-0005i6-EM for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750957AbWLNTwv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWLNTwv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:52:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64921 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750957AbWLNTwv (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 14:52:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214195248.NODL15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 14:52:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yjsz1V0081kojtg0000000; Thu, 14 Dec 2006
 14:52:59 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> I'd say screw that.  The solution should really be this patch:
>
> diff --git a/environment.c b/environment.c
> index 84d870c..98275b2 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -15,7 +15,7 @@ int use_legacy_headers = 1;
>  int trust_executable_bit = 1;
>  int assume_unchanged;
>  int prefer_symlink_refs;
> -int log_all_ref_updates;
> +int log_all_ref_updates = 1;
>  int warn_ambiguous_refs = 1;
>  int repository_format_version;
>  char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
>

That changes what the command does to existing repositories,
which is somewhat impolite.

I am not opposed too much to an updated version of the tool that
sets the configuration on by default for newly created
repositories, though.

