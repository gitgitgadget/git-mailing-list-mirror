From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Create a new commit from patches without using any worktree?
Date: Wed, 27 Oct 2010 03:49:12 +0200
Message-ID: <AANLkTi=Xi13_0+bC-TVRP3uVDmGWVdM3a708=SSzCR88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 03:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAv92-0006gR-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 03:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab0J0BtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 21:49:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47306 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab0J0BtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 21:49:13 -0400
Received: by qwk3 with SMTP id 3so154935qwk.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=i/WvIAPIS2Q++1K0GvVQOTdjVaYOtbddRFRYLH/xlGA=;
        b=C+7ajcmFZPKQpN9IGzRFZL/d+SZIQNrAFdcRiEint1YqAh0UKW5pRXRAsUwZ29fCC4
         b1ici8/rSLnNZ6qi/jkwL3BYnqek2KWO7gfK2FWJsmY6M9I8PmpxsI3uwQ9qyvCBLuX1
         G5tPNdsofcMAsAv6pwphHmXtKJCF3jaM/451E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=n/9RMrYEFfIVH/dQ8L75HdWCos1U24y9s50LTKly/wrOb0Va6Dj3jNjb0UdD7bSQ01
         yFCdeDqwdN2F8s/KFPPMGyy9V6YXQUS3csCIYQ6FPZ9Oz84VBS5Oo02xkcCmGsDfpJ32
         M7GbeF0kvWeHhusAHClGkcXxI+1m/BbtdY7v4=
Received: by 10.224.119.200 with SMTP id a8mr2057450qar.339.1288144152203;
 Tue, 26 Oct 2010 18:49:12 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Tue, 26 Oct 2010 18:49:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160017>

Hello

Is there any way to record a new commit based on contents in a patch
without going through a worktree? Of course the operation would have
to fail if the patch does not apply cleanly. The problem is I find
myself doing things like this:

put away current work on some branch A
checkout some branch B that is only used for patching
run git patch --check to see if patches apply cleanly. *reject* if
not. apply otherwise.
return to branch A.

I.e. the checkout of B is redundant because I'm anyway not going to
try to resolve any conflicts.

I know I can do something similar to what I need with "git-fetch
src:dst", except it's rather awkward if what you have is patches. I
suspect there must be some way to mimic that fetch behaviour manually,
and in a way that lets me choose exactly what to apply?

BR / Klas
