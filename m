From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug? Files are losing history after subtree merge
Date: Wed, 02 Oct 2013 22:21:36 +0200
Message-ID: <vpqy56bjuen.fsf@anie.imag.fr>
References: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com>
	<vpqsiwjlarx.fsf@anie.imag.fr>
	<CAN0XMO+y3Cwsz5LwbmzHBe31Rf-RwMykynLmvmqUsxY8f+1dsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 02 22:21:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRSvc-000311-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 22:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab3JBUVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 16:21:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35749 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab3JBUVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 16:21:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r92KLY8e021061
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Oct 2013 22:21:34 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VRSvR-0005UR-2J; Wed, 02 Oct 2013 22:21:37 +0200
In-Reply-To: <CAN0XMO+y3Cwsz5LwbmzHBe31Rf-RwMykynLmvmqUsxY8f+1dsQ@mail.gmail.com>
	(Ralf Thielow's message of "Wed, 2 Oct 2013 22:07:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Oct 2013 22:21:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r92KLY8e021061
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1381350099.48418@Z8LI9P2HmWioP364DuhGPg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235673>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Thanks for explanation.
> I knew the history of the repo is there, but the history of single files
> (and the ability to look at it)

There is no such thing as "single file history" in Git. Git knows about
the history of the project, and knows which files were there at each
commit. Then, some commands can walk through history following the
history of a file. "git blame" is very good at it, and should work with
subtree merges. "git log --follow" is a quick hack that nobody bothered
to fix up to now (sadly).

You can use workarounds like

  git log -- '*git-gui.sh'

(from the toplevel), to view each commit that touched a file whose name
ends with git-gui.sh. It won't follow actual renames, and may show false
positive if you have several files with the same basename. But it may
help.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
