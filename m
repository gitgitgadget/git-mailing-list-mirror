From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] CLI option parsing and usage generation for porcelains
Date: Sun, 14 Oct 2007 02:18:55 -0700
Message-ID: <20071014091855.GA17397@soma>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 11:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igzct-0001iY-QU
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXJNJS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbXJNJS6
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:18:58 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44739 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbXJNJS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:18:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 422D07DC0FE;
	Sun, 14 Oct 2007 02:18:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1192282153-26684-1-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60818>

Pierre Habouzit <madcoder@debian.org> wrote:
>   Following Kristian momentum, I've reworked his parse_option module
> quite a lot, and now have some quite interesting features. The series is
> available from git://git.madism.org/git.git (branch ph/strbuf).
> 
>   The following series is open for comments, it's not 100% ready for
> inclusion IMHO, as some details may need to be sorted out first, and
> that I've not re-read the patches thoroughly yet. Though I uses the tip
> of that branch as my everyday git for 2 weeks or so without any
> noticeable issues.
> 
>   And as examples are always easier to grok:
> 
> $ git fetch -h
> usage: git-fetch [options] [<repository> <refspec>...]
> 
>   -q, --quiet           be quiet
>   -v, --verbose         be verbose
> 
>   -a, --append          append in .git/FETCH_HEAD
>   -f, --force           force non fast-forwards updates
>   --no-tags             don't follow tags at all
>   -t, --tags            fetch all tags
>   --depth <depth>       deepen history of a shallow clone
> 
> Advanced Options
>   -k, --keep            keep downloaded pack
>   -u, --update-head-ok  allow to update the head in the current branch
>   --upload-pack <path>  path to git-upload-pack on the remote
> 
> $ git rm -rf xdiff # yeah -rf now works !

Very nice.  I worked on gitopt around summer of 2006 but never had the
time to test it thoroughly.  It was a _lot_ more intrusive than yours
currently is (it touched the diff + revision family of commands).

One feature I really like is automatically handling of long option
abbreviations.  gitopt supported this at the expense of complexity
and the aforementioned intrusivenes.  This allows automatic handling
of the abbreviation style seen commonly in git shell scripts:

   --a|--am|--ame|--amen|--amend)  (from git-commit.sh)

-- 
Eric Wong
