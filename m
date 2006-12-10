X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff_tree_sha1(): avoid rereading trees if possible
Date: Sun, 10 Dec 2006 23:49:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612102347480.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100055160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekk5xpc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:50:18 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, torvalds@osdl.org,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekk5xpc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33949>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXUj-00049P-BR for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762364AbWLJWuA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762358AbWLJWt7
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:49:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:48674 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1762254AbWLJWt6
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:49:58 -0500
Received: (qmail invoked by alias); 10 Dec 2006 22:49:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 10 Dec 2006 23:49:57 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 9 Dec 2006, Junio C Hamano wrote:

> I think this is overkill that only helps a very narrow "empty tree" 
> special case that [PATCH 2/3] addresses, and can be easily and 
> incorrectly abused.  We do not want people to expect that reading many 
> trees from different revisions as "struct tree" objects and keeping all 
> of them in memory would magically speed up diff-tree, for example.
> 
> I'd prefer write_sha1_file() approach in Shawn's patch for its 
> simplicity at least for now.

Okay, after thinking about it, I agree. merge-recursive is really the only 
user for such a diff. So, I do not think EMPTY_TREE would be useful.

Ciao,
Dscho
