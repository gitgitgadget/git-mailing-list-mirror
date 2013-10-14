From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] http: enable keepalive on TCP sockets
Date: Mon, 14 Oct 2013 05:27:39 +0000
Message-ID: <20131014052739.GA16129@dcvr.yhbt.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Oct 14 07:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVagy-0001MT-CD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 07:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab3JNF1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 01:27:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48742 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab3JNF1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 01:27:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D758B1F6D0;
	Mon, 14 Oct 2013 05:27:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236093>

Daniel Stenberg <daniel@haxx.se> wrote:
> On Sat, 12 Oct 2013, Eric Wong wrote:
> 
> >This is a follow up to commit
> >e47a8583a20256851e7fc882233e3bd5bf33dc6e (enable SO_KEEPALIVE for
> >connected TCP sockets).
> 
> Just keep in mind that TCP keep-alive is enabled in awkwardly many
> different ways on different systems and this patch only supports one
> of them. Feel free to take inspiration from libcurl's source code
> for doing this. See:
> 
>   https://github.com/bagder/curl/blob/master/lib/connect.c#L108

Thanks.  I think the Linux-specific TCP_KEEP* knobs are overkill for git.
(since this is mainly for non-interactive users, I went at least a day
 before realizing the process was stuck on my machine).
I cannot comment on the knobs for other OSes.
