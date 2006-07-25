From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-1.4.1.1-1 git-clone-pack: unable to read from git-index-pack
Date: Tue, 25 Jul 2006 13:23:59 -0700
Message-ID: <20060725202358.GI23286@h4x0r5.com>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de> <1153829608.2258.32.camel@Homer.simpson.net> <1153829908.2258.34.camel@Homer.simpson.net> <Pine.LNX.4.63.0607251655360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 22:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5TRt-000581-Gy
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 22:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWGYUYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 16:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWGYUYK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 16:24:10 -0400
Received: from h4x0r5.com ([70.85.31.202]:50960 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751513AbWGYUYJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 16:24:09 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1G5TRg-0002rY-25; Tue, 25 Jul 2006 13:24:00 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607251655360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24184>

On Tue, Jul 25, 2006 at 04:57:39PM +0200, Johannes Schindelin wrote:
> On Tue, 25 Jul 2006, Mike Galbraith wrote:
> 
> > On Tue, 2006-07-25 at 14:13 +0200, Mike Galbraith wrote:
> > > Greetings,
> > > 
> > > Having finally acquired DSL (only 400kbps, but at least I'm in the
> > > twentieth century [not typo]), I decided to finally give git a try.  I
> > > installed git-1.4.1.1-1, and armed myself with Jeff's how-to.  I didn't
> > > get far before git saved me the trouble of truly testing my resolve :)
> > > 
> > > 	-Mike
> > > 
> > > git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> > 
> > Oops, missed a line.
> > 
> > fatal: packfile '/usr/local/src/tmp/linux-2.6/.git/objects/pack/tmp-nE9k3G' SHA1 mismatch
> > 
> > > error: git-clone-pack: unable to read from git-index-pack
> > > error: git-index-pack died with error code 128
> > > clone-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed
> 
> Was this after about 10 minutes? I had the impression that this was fixed 
> with the 1.4.1.1 version _on the server side_. See
> 
> http://www.kernel.org/git/gitweb.cgi?p=git/git.git;a=commit;h=a0764cb838c2f1885fb58ca794c21523fb05c825
> 
> for details. So, please be patient until kernel.org's server is updated.

Or do your initial clone as:

git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
cd linux-2.6 && sed -i -e 's/rsync/git/g' .git/remotes/origin

(The preferred thing is for the method you used to work, but the above
will avoid the bug for the moment.)
-- 

Ryan Anderson
  sometimes Pug Majere
