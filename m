From: david@lang.hm
Subject: Re: Need help grasping some concepts
Date: Tue, 15 Feb 2011 18:50:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102151842210.9902@asgard.lang.hm>
References: <AANLkTi=RfK13jUiu+tT21M-dm65tPrkr+s8asa+nZdak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: GIT Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Jo=E3o_P=2E_Sampaio?= <jpmelos@jpmelos.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 03:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXTP-0000wi-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 03:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab1BPCub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 21:50:31 -0500
Received: from mail.lang.hm ([64.81.33.126]:33209 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1BPCu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 21:50:29 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p1G2oSc9032697;
	Tue, 15 Feb 2011 18:50:28 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <AANLkTi=RfK13jUiu+tT21M-dm65tPrkr+s8asa+nZdak@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166916>

On Tue, 15 Feb 2011, Jo?o P. Sampaio wrote:

> I've been reading this list for quite a while now, and trying to
> understand what's going on, and wandering around in the code.
>
> There are some concepts I'd like you to help me understand better:
>
> 1) What are plumbing and porcelain functions, methods, APIs... What's
> the meaning of that classification and difference between the two?

'plumbing' is the very low-level functionality, 'porcelain' makes use of 
the plumbing to get the job done in a user friendly way.

this is not a hard and fast separation, it is a set of terminology that 
grew because the initial git commands would do the jobe, but were ugly 
(and in some cases dangerous) to use. people wrote wrapper scripts that 
did sanity checking, offered good defaults, error messages meaningful to 
normal humans (as opposed to git developers), etc. There became a need to 
differentiate between the large population of wrappers and the underlying 
commands that they called. using a bathroom analogy, the core commands are 
the plumbing (it's there, but normally only experts understand it's care 
and feeding), and the things users are expected to use (the pretty, smooth 
fixtures that would be worthless without the plumbing under them)

> 2) What's going on about cache-tree not being able to handle empty
> trees, or something like that? You mean Git doesn't store empty
> directories in repositories?

git doesn't store directories at all. Git stores file contents and some 
metadata about the file (path, executable or not, but not ownership)

As such, if there is no file to store, git doesn't have anything to store.

so yes, an empty directory will not exist in a git repository (the 
workaround is to make a single, empty hidden file in that directory, 
typically something like .gitignore so that now there is a file to track)

> 3) And what are symbolic references? Are they just an alias I can
> attach to branches and tags, like symbolic links in Linux that I can
> attach to folders and files?

yep.

David Lang
