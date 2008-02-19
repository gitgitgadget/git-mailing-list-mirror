From: Mike Hommey <mh@glandium.org>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 10:39:45 +0100
Organization: glandium.org
Message-ID: <20080219093943.GA31006@glandium.org>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com> <20080219063937.GB3819@glandium.org> <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JROxh-0006Ry-Fa
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 10:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYBSJjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 04:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbYBSJjy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 04:39:54 -0500
Received: from vuizook.err.no ([85.19.215.103]:40815 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbYBSJjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 04:39:53 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JROx3-0004sw-EO; Tue, 19 Feb 2008 10:39:49 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JROwz-00088Q-4z; Tue, 19 Feb 2008 10:39:45 +0100
Content-Disposition: inline
In-Reply-To: <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74390>

On Mon, Feb 18, 2008 at 11:09:39PM -0800, Anatoly Yakovenko <aeyakovenko@gmail.com> wrote:
> > > *.*.*.*- foobar [18/Feb/2008:16:40:12 -0800] "PROPFIND /git/repo
> > > HTTP/1.1" 301 320
> >
> > Try adding a / at the end of the url you use for your repo.
> 
> ah cool, that was it.  The initial push seems to have worked,
> 
> $ git push -v upload master
> Pushing to http://aeyakovenko@myserver.com/git/repo/
> Getting pack list
> Fetching remote heads...
>   refs/
>   refs/tags/
>   refs/heads/
> 'refs/heads/master': up-to-date
> 
> but i cant clone or just normally push and pull the repo.
> 
> $ git-pull
> fatal: 'origin': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly

Try again with the GIT_CURL_VERBOSE variable set to 1 and try to see
if everything looks right in requests and responses.

> and
> 
> $ git-clone http://aeyakovenko@myserver.com/git/repo/ foobar
> Initialized empty Git repository in /home/aeyakovenko/projects/foobar/.git/
> cat: /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin/master:
> No such file or directory
> /usr/bin/git-clone: line 450: cd:
> /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin: No such
> file or directory
> fatal: : not a valid SHA1
> fatal: Not a valid object name HEAD

The error message is strange... Anyways, you might want to run this command
under sh -x (i.e. sh -x $(which git-clone) http://aeyakovenko@myserver.com/git/repo/ foobar)
What version of git are you using ?

Mike
