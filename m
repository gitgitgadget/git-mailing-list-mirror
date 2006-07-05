From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Experimental "git prune"
Date: Wed, 5 Jul 2006 09:57:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607050956240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0607041539550.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 05 09:58:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy2Go-0004kc-Hk
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 09:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWGEH57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 03:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWGEH57
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 03:57:59 -0400
Received: from mail.gmx.net ([213.165.64.21]:57475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932375AbWGEH57 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 03:57:59 -0400
Received: (qmail invoked by alias); 05 Jul 2006 07:57:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 05 Jul 2006 09:57:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607041539550.12404@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23341>

Hi,

On Tue, 4 Jul 2006, Linus Torvalds wrote:

> static void process_tag(struct tag *tag, struct object_array *p, const char *name)
> {
> 	struct object *obj = &tag->object;
> 	struct name_path me;

AFAICS this variable is set, but not used:

> 
> 	if (obj->flags & SEEN)
> 		return;
> 	obj->flags |= SEEN;
> 
> 	me.up = NULL;
> 	me.elem = "tag:/";
> 	me.elem_len = 5;
> 
> 	if (parse_tag(tag) < 0)
> 		die("bad tag object %s", sha1_to_hex(obj->sha1));
> 	add_object(tag->tagged, p, NULL, name);
> }

As for the rest, I like it.

Ciao,
Dscho
