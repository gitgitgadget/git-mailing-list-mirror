From: =?UTF-8?Q?Carl_F=C3=BCrstenberg?= <azatoth@gmail.com>
Subject: gut submodule update and merge
Date: Thu, 17 Mar 2011 21:16:47 +0100
Message-ID: <AANLkTimneYSkr11yDt1eL5d-r6pJrt2EMLGEOBfOxOoD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 21:16:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Jcu-000248-NP
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab1CQUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 16:16:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59436 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab1CQUQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 16:16:50 -0400
Received: by wwa36 with SMTP id 36so4013953wwa.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=KCEj08WYj/ZZtYk89RmfpHPujFCgiV/BiVJgF3VXfbs=;
        b=IWQAaJ/aJvx/8DbjVUypuo6yqqO55I7HdHFYOAEbBbZ2I2Yvtesx2objBUnZpnTudn
         IHflkiiAAsBJ7PIpi2Uo4l8Pw+Plj7DSo1hET4piSPku6Ozt0DfjP+2io0t4zJrk1ONp
         IhgTcYXEcqVy4/tCNEt1yi+ovP2leQ0DBrKtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Kb8tzupaVYFJfiJaWK5pGjf/21pIf6bhUULxGdkwq9TQu/+rAh+NyOQE39x+uTTOvm
         m6YNfFwaKRkXkq2CfJTV6EeYYn9HB6Ta8cT38MG5DeaR9FOe2kQxCarG7pdnFT4KY3/5
         u+qZUZfxYJpqoEIPlF2lndpT5b62uYebZBiUw=
Received: by 10.216.209.20 with SMTP id r20mr236511weo.30.1300393007749; Thu,
 17 Mar 2011 13:16:47 -0700 (PDT)
Received: by 10.216.170.211 with HTTP; Thu, 17 Mar 2011 13:16:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169274>

Hello,

I've tried to setup in a n makefile a way to easy initialize and
update submodules and at the same time keep eventual changes in the
submodules. I though an "git submodule update --init --recursive
--merge" would work,
but  this i notices created strange result if the submodules hadn't
been checked out in the first place. the result then was that it
marked in index all files to be deleted.

This behavior wasn't what I had in mind, and it resulted in I did
following "fix" to resolve the issue (ugly):
https://github.com/azatoth/jquery/commit/9977732a26820dd7f3ced2ce4554edadd62ae52c

Is this the intended behavior? logically I think an clean "git
submodule update --init --merge" should not try to merge if there
wasn't anything to begin with.

/Carl
