From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] rebase: don't invoke the pager for each commit summary
Date: Sat, 30 Jan 2010 17:46:13 +0100
Message-ID: <201001301746.13620.markus.heidelberg@web.de>
References: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.1001301746200.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbGSh-00060r-Nd
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 17:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953Ab0A3QqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 11:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398Ab0A3QqO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 11:46:14 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51451 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab0A3QqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 11:46:13 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DFDC7145E0DFF;
	Sat, 30 Jan 2010 17:46:12 +0100 (CET)
Received: from [91.19.0.24] (helo=pluto.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NbGSa-0000yD-00; Sat, 30 Jan 2010 17:46:12 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.30-gentoo-r8; KDE/4.3.3; i686; ; )
In-Reply-To: <alpine.DEB.1.00.1001301746200.4985@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18uHSsAKqHnaiBtqO54HlSzaEH1ev0WEIGmDgpX
	Dgpsqnoa4oMoBE3TUUKAWKGXK02BPdFRY4MP8kxY/s3Wlo8bjg
	k6myI2IZ3Uq9tlVUeTTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138483>

Johannes Schindelin, 2010-01-30:
> Hi,
> 
> On Sat, 30 Jan 2010, Markus Heidelberg wrote:
> 
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index b5d9178..fb4fef7 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -86,7 +86,7 @@ continue_merge () {
> >  		fi
> >  	fi
> >  	test -z "$GIT_QUIET" &&
> > -	git log --format=%s -1 "$cmt"
> > +	GIT_PAGER='' git log --format=%s -1 "$cmt"
> 
> Would it not be better 'git --no-pager log [...]'?

That was my initial fix, but then I found this in line 519:

        GIT_PAGER='' git diff --stat --summary "$mb" "$onto"

and decided to keep consistency.

Don't know.

Markus
