From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tip of the day: archaeology
Date: Tue, 13 Dec 2005 13:54:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512131351100.4184@g5.osdl.org>
References: <20051209215414.14072.qmail@science.horizon.com>
 <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
 <20051212195319.11d41269.tihirvon@gmail.com> <Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
 <86y82qyrqs.fsf@blue.stonehenge.com> <20051213035842.GF10371@always.joy.eth.net>
 <86d5k1y7dp.fsf@blue.stonehenge.com> <7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
 <7vd5k1bf40.fsf@assigned-by-dhcp.cox.net> <861x0hxfn2.fsf@blue.stonehenge.com>
 <7vpso07l63.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 22:57:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmI8R-0003qZ-Vv
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 22:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVLMV4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 16:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVLMV4B
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 16:56:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030250AbVLMV4A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 16:56:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBDLsjDZ007694
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Dec 2005 13:54:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBDLsil6011904;
	Tue, 13 Dec 2005 13:54:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpso07l63.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13591>



On Tue, 13 Dec 2005, Junio C Hamano wrote:
> 
> *1* Sometimes I wish we had "cvs co -p" equivalent.
> 
> 	$ git cat-blob rev path
> 
> Perhaps?

Isn't "git-ls-tree rev path" good enough? Maybe you want to wrap it with

	#!/bin/sh
	git-ls-tree "$@" |
		while read mode type sha name
		do
			git-cat-file $type $sha
		done

or something? 

		Linus
