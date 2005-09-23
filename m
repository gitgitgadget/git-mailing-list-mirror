From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: /bin/sh portability question
Date: Fri, 23 Sep 2005 09:50:58 +0200
Message-ID: <20050923075058.GA25473@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 23 09:52:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIiKp-0007eS-B0
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 09:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIWHvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIWHvE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 03:51:04 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:64954 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1750732AbVIWHvD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 03:51:03 -0400
Received: (qmail 230 invoked by uid 5842); 23 Sep 2005 07:50:59 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9160>

Hello,

It seems things are progressing nicely with regard to
Solaris portability.  However, I still have a few problems:

1) Maybe I didn't notice some new configuration option,
   but strcasestr is still not found with a simple "gmake".

2) In many of the shell scripts there is the idiom:

      #!/bin/sh
      
      cmd=
      path=$(dirname $0)
      case "$#" in
      0)      ;;
      *)      cmd="$1"
              shift
 
   When run, this gives the error:

      ./git.sh: syntax error at line 4: `path=$' unexpected

   I think it's because (on my Solaris at least), sh is really 
   sh and is not symlinked to bash, and sh doesn't like that 
   syntax.  Are there any good solutions to this other than
   making the administrators actually change sh to a symlink,
   (which I tried)?

/Peter
