From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: something broken just now on git-pull from openbsd to OSX
Date: 18 Aug 2006 09:22:38 -0700
Message-ID: <86hd0ako8h.fsf@blue.stonehenge.com>
References: <86pseykogj.fsf@blue.stonehenge.com>
	<86lkpmkod3.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 23:09:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEBbA-0005uR-E0
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 23:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWHRVJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWHRVJl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 17:09:41 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:32871 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964929AbWHRVJk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 17:09:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9A1478EB20
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 14:08:58 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12761-01-37 for <git@vger.kernel.org>;
 Fri, 18 Aug 2006 14:08:58 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 938F48FBED; Fri, 18 Aug 2006 09:22:38 -0700 (PDT)
To: git <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.13.10.3; tzolkin = 1 Akbal; haab = 16 Yaxkin
In-Reply-To: <86lkpmkod3.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25696>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
Randal> I just updated my openbsd's GIT to 1.4.2.g55c3, and now my
Randal> git-fetch from there to my OSX fails with a fatal error almost immediately.

Randal> What just changed?  What can I check?

Randal> git-fetch from other repositories to OSX seems to work fine.

Randal> Ahh, it might even be a corrupt repository... here's what
Randal> a local git-clone shows:

Randal> git-clone ~/Git/stonehenge.git
Randal> remote: Generating pack...
Randal> remote: Done counting 2610 objects.
Randal> remote: Deltifying 2610 objects.
Randal>  100% (2610/2610) done
Randal> remote: Total 2610, written 2610 (delta 1244), reused 2610 (delta 1244)
Randal> error: git-fetch-pack: unable to read from git-index-pack
Randal> error: git-index-pack died of signal 11
Randal> fetch-pack from '/home/merlyn/Git/stonehenge.git/.git' failed.

Randal> What do you want me to try to help diagnose this?

And even more info:

    $ git-repack -a -d
    Generating pack...
    Done counting 2610 objects.
    Deltifying 2610 objects.
     100% (2610/2610) done
    Writing 2610 objects.
     100% (2610/2610) done
    Total 2610, written 2610 (delta 1244), reused 2610 (delta 1244)
    Pack pack-3cd61a256bd8736b13b0356aafff016260c22b80 created.
    $ git-repack -a -d -f
    Generating pack...
    Done counting 2610 objects.
    Deltifying 2610 objects.
    Segmentation fault 

Oops!  That's not good.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
