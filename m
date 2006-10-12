From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 08:58:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610120854440.3952@g5.osdl.org>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 18:01:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY2xe-0002Tu-Jq
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWJLP7D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 11:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWJLP7B
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 11:59:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422727AbWJLP7A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 11:59:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9CFwtaX028772
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Oct 2006 08:58:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9CFws6Z032573;
	Thu, 12 Oct 2006 08:58:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.465 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28786>



On Thu, 12 Oct 2006, Junio C Hamano wrote:
> +
> +SYNOPSIS
> +--------
> +'git-pickaxe' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] <file> [<rev>]

Btw, could we please get rid of this horrible command line syntax.

Pretty much _every_ other git command takes the form

	git cmd [<rev>] [--] <path>

but for some reason annotate and blame (and now pickaxe) do it the wrong 
way around, and do

	git cmd [--] <path> [<rev>]

which is just irritating to somebody who has grown very used to being able 
to specify revisions first.

(I'd actually also like to have a range-modifier, so that I could do

	git annotate --since=2.weeks.ago v2.6.18.. <path>

that didn't go back beyond a certain point, so the command line syntax 
actually _does_ matter - even if we don't support that now, having the 
regular command line syntax means that we -could- support it some day).

		Linus
