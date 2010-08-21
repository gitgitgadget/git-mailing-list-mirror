From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: git-describe --contains fails on given tree
Date: Sat, 21 Aug 2010 22:42:42 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1008212241410.23864@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr> <m3occvoi5c.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 22:42:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omuts-00045V-9l
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab0HUUmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:42:44 -0400
Received: from borg.medozas.de ([188.40.89.202]:44807 "EHLO borg.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab0HUUmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:42:43 -0400
Received: by borg.medozas.de (Postfix, from userid 25121)
	id 12EC8F0C32A8E; Sat, 21 Aug 2010 22:42:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by borg.medozas.de (Postfix) with ESMTP id 096E865CB;
	Sat, 21 Aug 2010 22:42:42 +0200 (CEST)
In-Reply-To: <m3occvoi5c.fsf@localhost.localdomain>
User-Agent: Alpine 2.01 (LSU 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154160>


On Saturday 2010-08-21 21:55, Jakub Narebski wrote:
>> for some reason, git-describe cannot figure out v1.17~15^2^2 in
>> the pam_mount tree, despite me being able to actually give
>> a description that would fit the contains syntax:
>> 
>> $ git clone
>> git://pam-mount.git.sf.net/gitroot/pam-mount/pam-mount
>> Initialized empty Git repository in /dev/shm/pam-mount/.git/
>> remote: Counting objects: 7261, done.
>> remote: Compressing objects: 100% (1819/1819), done.
>> remote: Total 7261 (delta 5557), reused 6990 (delta 5348)
>> Receiving objects: 100% (7261/7261), 1.40 MiB | 832 KiB/s, done.
>> Resolving deltas: 100% (5557/5557), done.
>> 
>> $ cd pam-mount/
>> $ git describe --contains v1.17~15^2^2
>> fatal: cannot describe '95ce932690dfce8cbe50b6a3a8949e41a54c8966'
>> 
>> (Expected to get back: v1.17~15^2^2)
>> 
>> Why would it not want to return something? Possible bug?
>
>Is v1.17 an *annotated* tag?

It certainly is (if it were not, there be no tag, just commit):

$ git show v1.17
tag v1.17
Tagger: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 26 00:41:17 2009 +0100

pam_mount 1.17
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl8+J8ACgkQ92gFgoRMQ2Dd7QCeJj/u543aBiK/Los8LgvdkR/1
6nwAnA/CB23vjxFpVWsKZIW99GHxDglX
=yLqV
-----END PGP SIGNATURE-----

>What does
>
>  $ git describe --contains --tags v1.17~15^2^2

"Cannot describe 95ce..."

Funny thing is, describing "v1.17~15^2" does work, as does "v1.17~15^1".
