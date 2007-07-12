From: "David Frech" <nimblemachines@gmail.com>
Subject: sharing between local "work" and "nightly build" git repos
Date: Thu, 12 Jul 2007 16:36:58 -0700
Message-ID: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98Db-0001d0-MH
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 01:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759849AbXGLXhB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759776AbXGLXhB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 19:37:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:59526 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785AbXGLXhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 19:37:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so378201wah
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:36:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N2BE1V5/Au+srPrzW4iZrwUIA4fuDbNfbfd2lzkAlCzIPgcvvq2LIib7VYm5qkSfkmkdiaGA+dt4M5XWpjCEuVmTn1aTb+8E3hl4Awge0xGXqMzby29NBkG77/NJAIMES3uAHAxbGGJG1n76876CPbS72Su6L6zB6etLc7e+OIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ejmvAQkGa3THb1PuNRHweu9CHDjl8L3Trbty+4NXxAVvt1Sx9NVHL6gjXHI82R6g1JjiCyo7d3t0sh961L9dS+RXJFlvgJzl6BK3ljWFC62VJZlWhHAQSeTuldYjKXj16ODQ9HpOItmmqzGZz0ME/Ocl1k92BesdKjMJNENfATw=
Received: by 10.114.159.1 with SMTP id h1mr1061747wae.1184283418682;
        Thu, 12 Jul 2007 16:36:58 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Thu, 12 Jul 2007 16:36:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52342>

I'd like to have the following setup: a ~david/git directory, where I
am free to work on things, and a ~david/nightly-git, where a cron job
is going build and test a nightly "next" branch.

I'd like to share as much as possible between the two repos. My naive
first attempt was to clone the local repo (~david/git) using -l and -s
(which I admit I do not completely understand). This sort of worked,
but one issue is that doing a "git pull" in nightly is going to pull
from the *locally*-cloned repo, not from the main git. Another is that
a checkout in nightly failed with the obscure error:

[david@tashtego ~/git-nightly]% git checkout -b nightly-next next
git checkout: updating paths is incompatible with switching branches/forcing
Did you intend to checkout 'next' which can not be resolved as commit?

I assume this is because too much state is being shared the repos, and
something is unfinished in the "git" directory.

I'd love some pointers on how to:

* share as many objects as possible
* share as little state as possible
* make git pull pull from remote in both repos.

Cheers,

- David
-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
