From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 18:44:53 +0100
Message-ID: <vpq62t3ejje.fsf@bauges.imag.fr>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
	<20110129231310.GA11088@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKHq-0000af-LH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab1BARo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 12:44:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52788 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154Ab1BARo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 12:44:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p11Hiq6x028972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Feb 2011 18:44:52 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PkKHe-0006aN-9s; Tue, 01 Feb 2011 18:44:54 +0100
In-Reply-To: <20110129231310.GA11088@burratino> (Jonathan Nieder's message of "Sat\, 29 Jan 2011 17\:13\:10 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Feb 2011 18:44:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p11Hiq6x028972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297187093.71666@iiTn5yVWPmgZB250x0RH/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165835>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> support for tracking empty directories
>
> Tricky to get the UI right.  I am interested in and would be glad to
> help with this one.

A starting point, with some proposed (broken) patches:

http://thread.gmane.org/gmane.comp.version-control.git/56310/focus=56348

>> advisory locking / "this file is being edited"
>
> Probably better to implement out of band (using hooks?).  I don't
> know of any work or documentation in that direction.

File locking and distributed tool are conflicting interests. A
file-locking tool for git should be able to use a centralized locks
database (for example, one can imagine a simple PHP script hosted
somewhere independantly of the Git repo, keeping a list of locked
files up to date).

That needs to be integrated with Git, but it should probably still
remain out of the Git core, because different users would want
different locking databases. Hooks and git-* commands in the $PATH are
probably sufficient.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
