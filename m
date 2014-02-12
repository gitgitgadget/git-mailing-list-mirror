From: Mike Hommey <mh@glandium.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 08:09:09 +0900
Message-ID: <20140212230909.GB7208@glandium.org>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
 <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
 <87y51g88sc.fsf@fencepost.gnu.org>
 <CAHOQ7J_pg6Nqc5TdU9OA81=d+ZG_JpLFQ5-eFLY3uW8CuAQrUQ@mail.gmail.com>
 <87ppms87n7.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Zager <szager@chromium.org>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 00:09:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDivu-0000vp-MH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 00:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbaBLXJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 18:09:30 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:37192 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754647AbaBLXJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 18:09:30 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2014 18:09:29 EST
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WDivV-0002Cn-Up; Thu, 13 Feb 2014 08:09:09 +0900
Content-Disposition: inline
In-Reply-To: <87ppms87n7.fsf@fencepost.gnu.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242032>

On Wed, Feb 12, 2014 at 08:15:24PM +0100, David Kastrup wrote:
> Stefan Zager <szager@chromium.org> writes:
> 
> > On Wed, Feb 12, 2014 at 10:50 AM, David Kastrup <dak@gnu.org> wrote:
> >
> >> Really, give the above patch a try.  I am taking longer to finish it
> >> than anticipated (with a lot due to procrastination but that is,
> >> unfortunately, a large part of my workflow), and it's cutting into my
> >> "paychecks" (voluntary donations which to a good degree depend on timely
> >> and nontrivial progress reports for my freely available work on GNU
> >> LilyPond).
> >
> > I will give that a try.  How much of a performance improvement have
> > you clocked?
> 
> Depends on file type and size.  With large files with lots of small
> changes, performance improvements get more impressive.
> 
> Some ugly real-world examples are the Emacs repository, src/xdisp.c
> (performance improvement about a factor of 3), a large file in the style
> of /usr/share/dict/words clocking in at a factor of about 5.
> 
> Again, that's with an SSD and ext4 filesystem on GNU/Linux, and there
> are no improvements in system time (I/O) except for patch 4 of the
> series which helps perhaps 20% or so.
> 
> So the benefits of the patch will come into play mostly for big, bad
> files on Windows: other than that, the I/O time is likely to be the
> dominant player anyway.

How much fragmentation does that add to the files, though?

Mike
