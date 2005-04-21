From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 11:21:20 +0200
Message-ID: <20050421092120.GA20626@elte.hu>
References: <20050417194818.GG1461@pasky.ji.cz> <20050420100824.GB25477@elte.hu> <20050421.034227.104037433.oandrieu@nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:18:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOXoR-0005bE-DD
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 11:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDUJVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 05:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDUJVt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 05:21:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21909 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261223AbVDUJVp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 05:21:45 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id A51E431F3F3;
	Thu, 21 Apr 2005 11:20:39 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 836D81FC2; Thu, 21 Apr 2005 11:21:24 +0200 (CEST)
To: Olivier Andrieu <oandrieu@nerim.net>
Content-Disposition: inline
In-Reply-To: <20050421.034227.104037433.oandrieu@nerim.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Olivier Andrieu <oandrieu@nerim.net> wrote:

> There, here's a tarball :
>   http://oandrieu.nerim.net/monotone-viz/git-viz-0.1.tar.gz

i'm trying to build it under Fedora Core 4 (devel), and there are two 
problems:

 - the build scripts seem to assume that "." is in PATH (or that the 
   needed viz_style.ml/etc. scripts are in the PATH).

adding "." to the PATH worked around this issue, a number of files built 
fine, but then it hit the next problem:

 ocamlopt.opt  -I /usr/lib/ocaml/lablgtk2 -I glib -I crypto -pp  -c viz_style.ml
 sh: - : invalid option
 Usage:  sh [GNU long option] [option] ...
         sh [GNU long option] [option] script-file ...
 GNU long options:
 [...]
 Preprocessor error
 make: *** [viz_style.cmx] Error 2

i've straced the build, and the bug comes from ocamlopt.opt executing:

  sh -c "-c 'viz_style.ml'"

which confuses the shell.

i've got ocaml-3.08.3-1, lablgtk-2.4.0-2 installed.

	Ingo
