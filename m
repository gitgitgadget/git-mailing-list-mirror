From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 14:19:52 +0200
Message-ID: <vpqbomyv4t3.fsf@bauges.imag.fr>
References: <4F855E6B.4010504@danisch.de> <20120411105906.GA19823@burratino>
	<4F8565BC.1070701@danisch.de> <vpq7gxmzf75.fsf@bauges.imag.fr>
	<4F856F67.4000609@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:20:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwWp-0002vN-Cs
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760116Ab2DKMT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:19:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab2DKMT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:19:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3BCE3JP017826
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 14:14:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SHwWf-0003Z9-7s; Wed, 11 Apr 2012 14:19:53 +0200
In-Reply-To: <4F856F67.4000609@danisch.de> (Hadmut Danisch's message of "Wed,
	11 Apr 2012 13:47:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 11 Apr 2012 14:14:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3BCE3JP017826
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334751244.64071@ajAVoqoWbiu3pfanWLThSA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195177>

Hadmut Danisch <hadmut@danisch.de> writes:

> e.g. open source software and the web pages describing it (like in git
> hub), or a web server tree and the software generating it. They are
> related, but do not logically share a history.

In these cases, you'll want to have two working directories, if only to
avoid:

git checkout documentation
# fix a typo
git commit
git checkout code
make
# complete rebuild triggered.

> Creating independent branches by pushing two separates into a single
> remote bare is a nice idea, but if I understood git correctly, the very
> first commit in a repos is always to the master branch,

Not necessarily. I don't see an option in "git init" to change the
default branch name, but you can

git init foo
cd foo
git checkout -b whatever-branch-name

and work.

Otherwise, you can have a branch that is locally called "master", and
push it as another name (but that is probably the "error prone" in your
message ;-) ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
