From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 10:35:02 +0100
Message-ID: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 10:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5cK2-0006Io-KC
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 10:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZKDJiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 04:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbZKDJiK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 04:38:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:53556 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976AbZKDJiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 04:38:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nA49Z2cL026704
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 10:35:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5cGc-0000Mi-Hy; Wed, 04 Nov 2009 10:35:02 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Nov 2009 10:35:02 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132067>

Hi,

I guess the answer is "no", but I'll still ask in case ...

Is it possible to access the reflog of a remote repository other than
logging into this repository?

My use-case is the following: I want to checkout "the last revision
pushed in master on ssh://host/repo/ on day D at midnight" (to fetch
the project of my students ;-) ). If it were locally, I'd do

  git checkout 'origin/master@{Nov 3 00:00:00}'

But this tells me where _my_ local master was on that date (i.e. the
last revision I had pulled).


So, the best I can think of is:

ssh host 'cd /repo/ ; git tag final-version "master@{Nov 3 00:00:00}"'
git fetch --tags
git checkout tags/final-version

Is there a better way?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
