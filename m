From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] read-trees: refactor the unpack_trees() part
Date: Mon, 31 Jul 2006 02:48:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607310238170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607302024090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pwydbbr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607310205260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 02:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7LxW-00053O-P1
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWGaAsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWGaAsg
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:48:36 -0400
Received: from mail.gmx.net ([213.165.64.21]:10677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932489AbWGaAsf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 20:48:35 -0400
Received: (qmail invoked by alias); 31 Jul 2006 00:48:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 31 Jul 2006 02:48:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0607310205260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24484>

Hi,

On Mon, 31 Jul 2006, Johannes Schindelin wrote:

> How about this (on top of that patch):
> 
> -- 8< --
> [PATCH 1.5/3] unpack-trees: please C99 standard

Of course, I got bitten by "git-commit" not regarding any 
git-update-index'ed files after starting the editor... This is needed as 
well:

diff --git a/unpack-trees.c b/unpack-trees.c
index 3cb92cb..e595d23 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -381,6 +381,7 @@ int unpack_trees(struct object_list *tre
 	state.refresh_cache = 1;
 
 	o->merge_size = len;
+	memset(&df_conflict_entry, 0, sizeof(df_conflict_entry));
 	o->df_conflict_entry = &df_conflict_entry;
 
 	if (len) {

Sorry for the noise.

Ciao,
Dscho
