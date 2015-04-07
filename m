From: Mike Hommey <mh@glandium.org>
Subject: Announcing git-cinnabar 0.2.0
Date: Tue, 7 Apr 2015 11:27:44 +0900
Message-ID: <20150407022744.GA21468@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 04:28:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfJFB-0002GD-IG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 04:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbbDGC1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 22:27:53 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46354 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbbDGC1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 22:27:50 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YfJEu-0005f2-QO
	for git@vger.kernel.org; Tue, 07 Apr 2015 11:27:44 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266896>

Git-cinnabar is a git remote helper to interact with mercurial
repositories. It allows to clone, pull and push from/to mercurial remote
repositories, using git.

Code on https://github.com/glandium/git-cinnabar

[ Previous announcements:
  http://marc.info/?l=git&m=142364715001983
  http://marc.info/?l=git&m=141781485726430 ]

What's new since 0.1.1?

- git cinnabar git2hg and git cinnabar hg2git commands that allow to
  translate (possibly abbreviated) git sha1s to mercurial sha1s and
  vice-versa.
- A "native" helper that makes some operations faster. It is not
  required for git-cinnabar to work, but it can improve performance
  significantly. Check the Setup instructions in the README file.
- Do not store mercurial metadata when pushing to non-publishing
  repositories.
- Made the discovery phase of pushes require less round trips (the phase
  that finds what is common between the local and remote repositories),
  hopefully making pushing faster.
- Improved logging, which now doesn’t require fiddling with the code to
  get extra logging.
- Made fsck validate more things, and act on more errors.
- Fixed a few edge cases.
- Better handle files with weird names, and that git quotes in its
  output.
- Extensively tested on the following repositories:
    https://hg.mozilla.org/mozilla-central/
    https://hg.mozilla.org/releases/mozilla-beta/
    https://selenic.com/hg/
    https://bitbucket.org/durin42/hg-git/
    https://hg.python.org/cpython/

What to expect next?

- Allow to push merge commits.
- Improve memory footprint for pushes (currently, it’s fairly
  catastrophic on big repositories ; don’t try to push multiple hundreds
  of commits of a Mozilla-sized repository if you don’t have multiple
  gigabytes of memory available).
- As mentioned above, allow to remove some metadata.
- And more...

If you want to follow the improvements more closely, I encourage you to
switch to the `next` branch. I won’t push anything there that hasn’t
been extensively tested on the above mentioned repositories.

And as always, please report any issue you run into:
https://github.com/glandium/git-cinnabar/issues/new

Mike
