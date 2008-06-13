From: Sven <svoop@delirium.ch>
Subject: Git over HTTPS Oddity with HEAD
Date: Fri, 13 Jun 2008 22:59:04 +0000 (UTC)
Message-ID: <loom.20080613T225103-368@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 01:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ILX-0003fJ-Pw
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 01:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbYFMXFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYFMXFG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 19:05:06 -0400
Received: from main.gmane.org ([80.91.229.2]:47950 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbYFMXFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 19:05:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K7IKM-0001Yw-Um
	for git@vger.kernel.org; Fri, 13 Jun 2008 23:05:03 +0000
Received: from 151.121.221.87.dynamic.jazztel.es ([87.221.121.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 23:05:02 +0000
Received: from svoop by 151.121.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 23:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.121.151 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008061004 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84950>

Hi

I'm using Git over HTTPS with up-to-date versions on both ends. With a populated
repo, I try the following:

# git ls-remote https://git.domain.com/myapp.git HEAD

This gives me no reply at all, and indeed ...

# git ls-remote https://git.domain.com/myapp.git
bb629d461b11d3c8edbc1e4f3c44085198fdaede	refs/heads/master

Besides this, however, Git over HTTPS seems to work just fine and if I look
inside the myapp.git on the server, a HEAD file is there:

# cat myapp.git/HEAD
ref: refs/heads/master

I assume it's something fishy on the server side although I haven't done
anything exotic there. Any idea what could be the reason for this?

Thanks!   -sven


PS:
The background story: Capistrano (Ruby on Rails) issues the above ls-remote HEAD
command during deployment, therefore not getting the head version in reply
causes Capistrano to bark.
