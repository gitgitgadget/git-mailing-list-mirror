From: Hannu Koivisto <azure@iki.fi>
Subject: Unable to clone empty repositories remotely
Date: Tue, 25 Nov 2008 23:05:54 +0200
Organization: NOYB
Message-ID: <837i6rplcd.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 22:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5587-0002CJ-3x
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 22:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYKYVGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 16:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYKYVGL
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 16:06:11 -0500
Received: from main.gmane.org ([80.91.229.2]:34604 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbYKYVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 16:06:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L556j-00083w-0C
	for git@vger.kernel.org; Tue, 25 Nov 2008 21:06:05 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 21:06:04 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 21:06:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:/6DbVxhMe3duJL8mKf5NJvjv/4M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101683>

Greetings,

mkdir test
cd test
git init --bare --shared=group
cd ..
git clone test test2

works, though clone says it cannot checkout, which is expected.
This is nevertheless very useful when you create a shared
repository for a new project; you can then create a personal clone
and start adding stuff to it.  If, however, you normally work on
another machine and want to have your personal clone there
(i.e. git clone ssh://therepomachine/somewhere/test), cloning
doesn't work at all (tested with git 1.6.0.3.525.ge32c2 in Cygwin):

Initialized empty Git repository in /cygdrive/c/temp/test/.git/
fatal: no matching remote head

This behaviour isn't documented by either git-init(1) or
git-clone(1).  I think it would be very convenient if this worked
for the reasons mentioned above.  I'm sure you could create your
personal repository with git init and then git remote add the
shared repository to it but that's much more difficult.

-- 
Hannu
