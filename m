From: duperrav@minatec.inpg.fr
Subject: [RFC] git bisect old/new
Date: Tue, 05 Jun 2012 18:45:54 +0200
Message-ID: <20120605184554.Horde.8ph4OHwdC4BPzjfCBNci47A@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: Lucien.Kong@ensimag.imag.fr, Valentin.Duperray@ensimag.imag.fr,
	Franck.Jonas@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr,
	Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 18:46:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwtO-0001dT-4R
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab2FEQp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:45:58 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:36864 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752354Ab2FEQp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 12:45:57 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 7AD021A02EA;
	Tue,  5 Jun 2012 18:45:54 +0200 (CEST)
Received: from wifi-030048.grenet.fr (wifi-030048.grenet.fr [130.190.30.48])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 05 Jun
 2012 18:45:54 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199263>

Hi,

We would like to work on modifying git bisect so it can be used easily
when looking for a fix instead of a regression.  Indeed, when you want
to do so you have to mentally switch "good" and "bad" to mark commit
which are still unfixed as good and those fixed as bad.

There have been discussions and patchs on how it could be implemented:

- http://thread.gmane.org/gmane.comp.version-control.git/86063:
   introduced git fixed and git unfixed which could be use instead of
   git good and git bad when looking for a fix.
- http://thread.gmane.org/gmane.comp.version-control.git/182398:
   created the option --reverse for git bisect start to switch good and
   bad.

But both solutions did not address the issue of how "git bisect
visualize" show the review of the commits because in both cases the
refs of the commit are not changed, the older commits are in revs/good
and the new ones are in revs/bad.
To prevent that, the idea raised in the second thread was to use
old/new (or yes/no) and ask the user what he is looking for.
With this we could look not only for regression or fix but for
whatever property used to be true and isn't anymore without flipping
the revs following the cases.
We will work on that last solution but we wanted to ask for comments
before coding too much for nothing.

Valentin DUPERRAY
Franck JONAS
Lucien KONG
Thomas NGUY
Hyuhn Khoi Nguyen NGUYEN

Grenoble INP ENSIMAG
