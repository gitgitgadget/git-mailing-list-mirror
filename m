From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 10:28:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271026020.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>   
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <3516.10.10.10.24.1117213207.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jaroslav Kysela <perex@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 19:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbiZj-0002m6-MZ
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVE0R0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVE0R0v
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:26:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:4529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262523AbVE0R0r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 13:26:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RHQejA023180
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 10:26:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RHQdxP031492;
	Fri, 27 May 2005 10:26:39 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3516.10.10.10.24.1117213207.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Sean wrote:
> >
> > Now, arguably gitweb should ignore whitespace at the beginning, but
> > equally arguably your commits shouldn't have them either...
> 
> Perhaps git should enforce this?  Patch attached.
> 
> Remove leading empty lines from commit messages.
> 
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

I'm not sure.

The thing is, right now git allows binary commit messages if somebody
really wants to. Now, a lot of the _tools_ end up only printing up to the
first '\0' or something, but in general, maybe somebody actually wants to
embed his own strange stuff in there (eg use encryption but still use
standard git tools).

Which makes me worry. So I _do_ do whitespace cleanup in my "apply email 
patches" scripts, but I'm not sure whether the core should care about the 
data that people feed it, even for commit messages.

Opinions?

		Linus
