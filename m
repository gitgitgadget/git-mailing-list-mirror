From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] work-trees are allowed inside a git-dir
Date: Fri, 27 Jul 2007 17:48:23 -0700
Message-ID: <7vabthwdyg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271957250.14781@racer.site>
	<7vejity3h8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280122160.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 02:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaTs-0007yJ-97
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 02:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938341AbXG1AsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 20:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938335AbXG1AsY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 20:48:24 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61250 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938332AbXG1AsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 20:48:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728004824.OWAL1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 20:48:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UooP1X00Q1kojtg0000000; Fri, 27 Jul 2007 20:48:24 -0400
In-Reply-To: <Pine.LNX.4.64.0707280122160.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 28 Jul 2007 01:38:25 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53981>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > It is allowed to call
>> >
>> > 	$ git --git-dir=../ --work-tree=. bla
>> >
>> > when you really want to.  In this case, you are both in the git directory
>> > and in the working tree.
> ...
> There are files in that directory (and all of its subdirectories) of a 
> certain type, which are the only ones which are human generated, and 
> therefore precious.  I like to add them, and inspect them, with
>
> 	git --git-dir=$HOME/x.git add
>
> and
>
> 	git --git-dir=$HOME/x.git diff

I understand the --git-dir=$HOME/x.git to keep track of
something in $HOME/foo/bar example.

But that is not the issue you described in the original message.
I was asking about this (which is the way I read your original
message):

    $ GIT_DIR=$HOME/x.git git init
    $ mkdir $HOME/x.git/workroot
    $ cd $HOME/x.git/workroot
    $ git --git-dir=../ --work-tree=. 

That is, $HOME/x.git/ is the GIT_DIR that has HEAD, index and
refs/, and you are keeping track of contents whose rootlevel is
at $HOME/x.git/workroot
