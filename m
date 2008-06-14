From: Sven <svoop@delirium.ch>
Subject: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git HEAD" doesn't work
Date: Sat, 14 Jun 2008 07:03:36 +0000 (UTC)
Message-ID: <loom.20080614T065448-251@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Poc-0001zJ-Sn
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYFNHDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYFNHDx
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:03:53 -0400
Received: from main.gmane.org ([80.91.229.2]:52423 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbYFNHDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:03:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K7Png-0008TQ-3b
	for git@vger.kernel.org; Sat, 14 Jun 2008 07:03:48 +0000
Received: from 151.121.221.87.dynamic.jazztel.es ([87.221.121.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:03:48 +0000
Received: from svoop by 151.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:03:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.151 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008061004 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84971>

Hi

Following up my recent post, I'm now pretty sure this is a bug. Apparently,
ls-remote does not list the HEAD version when used over HTTP(S) whereas it does
work otherwise. Check this out:

over HTTP - no HEAD listed here:
git ls-remote http://www.kernel.org/pub/scm/git/git.git

over GIT - HEAD is listed in this case:
git ls-remote git://github.com/lux/sitellite.git 

As Capistrano relies on "git ls-remote http://git.domain.com/repo.git HEAD" to
find out which version to pull, you can't deploy from Git over HTTP(S) repos for
now. Capistrano is the de facto standard for deploying Ruby on Rails (and
related) web applications.

Thanks a lot for looking into this!! (My knowledge unfortunately doesn't allow
me to submit a patch myself.)

-sven
