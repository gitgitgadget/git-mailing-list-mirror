From: Egon Elbre <egonelbre@gmail.com>
Subject: Having an invalid HEAD file causes git not to recognize the repository
Date: Fri, 17 Aug 2012 14:42:33 +0300
Message-ID: <CANtNKfp+9HpvWkAO0vrm84oMiJNvjFg9T-UtNQko+ABHhEWj6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 13:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Kws-0002FQ-ED
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 13:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab2HQLmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 07:42:36 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37102 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab2HQLmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 07:42:35 -0400
Received: by lbbgj3 with SMTP id gj3so2057371lbb.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FS090aoQ/7LpNX950UTaL/k9G1rPHAxtT0osJAoSdIw=;
        b=SETyloaKRmC6L45xugWrzezcDIHB2tSuhWSzB7K+yqCp6MGz6KrCK5357gISwBVCrp
         4a0JuuyUgvAF62AcnwH7tWLIUdKFQtljx7UdV7N0rVvo6e2AKO76CC8kMlFQU4HXA2U4
         1Ac9hc0ZGOH3nTeHk4EH1RpUhASn0NeVrYhSHwgfvaaoYa1phF35Ssr3+Hb/JxM47DOw
         H5BfV5KJbWeX6saS7weXkv9NWASX1JhDZpNE3ffzkn7mtOEb+AdaNWaoJ3V0tfA6lXdc
         3AETbVOVBVXxNIvNZBj9hm+6+Px+vvdIPyYB54WIXn5KaXWVyU2lEVPNVkjofkNyP7FZ
         JGiw==
Received: by 10.112.102.8 with SMTP id fk8mr2088978lbb.71.1345203753464; Fri,
 17 Aug 2012 04:42:33 -0700 (PDT)
Received: by 10.152.129.133 with HTTP; Fri, 17 Aug 2012 04:42:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203609>

Having an invalid HEAD file causes git not to recognize the repository
and will cause an invalid message "fatal: Not a git repository (or any
of the parent directories): .git" although there is a .git folder and
everything seems okay in it. Solution was just to change HEAD to a
valid ref/hash.

I ran into this problem when I had a BSOD during a rebase (ignore that
I'm having to use Windows). This meant that only half of the hash got
written into HEAD and all git commands I tried failed.

Not sure whether it's useful to add a better message for this case,
but at least if somebody stumbles on it again, maybe they can find
this text.

+ egon
