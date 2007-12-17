From: Geert Bosch <bosch@adacore.com>
Subject: "Argument list too long" in git remote update (Was: Git and GCC)
Date: Mon, 17 Dec 2007 17:15:06 -0500
Message-ID: <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> 	 <2007-12-05-21-23-14+trackit+sam@rfc1149.net> 	 <1196891451.10408.54.camel@brick> <jeeje0ogvk.fsf@sykes.suse.de> 	 <1196897840.10408.57.camel@brick> 	 <38a0d8450712130640p1b5d74d6nfa124ad0b0110d64@mail.gmail.com> <1197572755.898.15.camel@brick>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OFU-0002gG-1e
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbXLQWPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbXLQWPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:15:16 -0500
Received: from rock.gnat.com ([205.232.38.15]:58408 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbXLQWPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:15:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id ADBC62A962A;
	Mon, 17 Dec 2007 17:15:13 -0500 (EST)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WPqm+l-D2OjU; Mon, 17 Dec 2007 17:15:13 -0500 (EST)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 659672A962D;
	Mon, 17 Dec 2007 17:15:11 -0500 (EST)
In-Reply-To: <1197572755.898.15.camel@brick>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68635>

		
On Dec 13, 2007, at 14:05, Harvey Harrison wrote:
> After the discussions lately regarding the gcc svn mirror.  I'm coming
> up with a recipe to set up your own git-svn mirror.  Suggestions on  
> the
> following.
>
> // Create directory and initialize git
> mkdir gcc
> cd gcc
> git init
> // add the remote site that currently mirrors gcc
> // I have chosen the name gcc.gnu.org *1* as my local name to refer to
> // this choose something else if you like
> git remote add gcc.gnu.org git://git.infradead.org/gcc.git
> // fetching someone else's remote branches is not a standard thing  
> to do
> // so we'll need to edit our .git/config file
> // you should have a section that looks like:
> [remote "gcc.gnu.org"]
>        url = git://git.infradead.org/gcc.git
>        fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> // infradead's mirror puts the gcc svn branches in its own namespace
> // refs/remotes/gcc.gnu.org/*
> // change our fetch line accordingly
> [remote "gcc.gnu.org"]
>        url = git://git.infradead.org/gcc.git
>        fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
> // fetch the remote data from the mirror site
> git remote update

With git version 1.5.3.6 on Mac OS X, this results in:
potomac%:~/gcc%git remote update
Updating gcc.gnu.org
/opt/git/bin/git-fetch: line 220: /opt/git/bin/git: Argument list too  
long
warning: no common commits
[after a long wait and a good amount of network traffic]
fatal: index-pack died of signal 13
fetch gcc.gnu.org: command returned error: 126
potomac%:~/gcc%

Any ideas on what to do to resolve this?
