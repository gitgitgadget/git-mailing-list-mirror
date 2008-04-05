From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: using git for file management while writing a thesis...
Date: Sat, 5 Apr 2008 08:17:24 +0100
Message-ID: <e1dab3980804050017s16d144fbp7f0a6c6d4206f50d@mail.gmail.com>
References: <56810483-5257-49CD-AA0E-303DB6C4CEFB@rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jordan Miller" <jmil@rice.edu>
X-From: git-owner@vger.kernel.org Sat Apr 05 09:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji2fD-00061B-Jk
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 09:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYDEHR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 03:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYDEHR0
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 03:17:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:42538 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYDEHRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 03:17:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so445679wxd.4
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sN+uBYQkL5rig0/amSj7Un9pvCRWBnmFyKKTJSmBxD4=;
        b=DPNjU2yTUCZ+dDffgkmm4o1xGt3QvCyq2QJdZpIoIWypBv9ytOkwP9wI6T+15gaI6sKYnvFeU4b66d7aspO05WTAIJEG0yiAMtoWJlIiTTXdPgA5jHafvSOZEwSTEvU87fwg5cXCKLBDY6b5GAI/Qk4l3nOMNMBJctlmwQWkLik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ucADlVBO4IKRdaP+TMCjCV2z228jh6lk1j3tSTsNgGmuqjNGuxN7qbjVd+vvDf/cQg+tAYTR1qILjI0V4odYvkfS1VLYKRbYZZuxcet2dIZQL8+ksggtnqjh31HIWkOQQtkhH0UvVxmieNXEpatqox8utrBYdG1HxIBRa7Tr9xg=
Received: by 10.150.200.8 with SMTP id x8mr1147026ybf.80.1207379844171;
        Sat, 05 Apr 2008 00:17:24 -0700 (PDT)
Received: by 10.150.53.15 with HTTP; Sat, 5 Apr 2008 00:17:24 -0700 (PDT)
In-Reply-To: <56810483-5257-49CD-AA0E-303DB6C4CEFB@rice.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78840>

On Thu, Apr 3, 2008 at 9:58 PM, Jordan Miller <jmil@rice.edu> wrote:
>  I am using git 1.5.3.1 on OS X 10.5.2 for file versioning for LaTeX files
[snip]
>  Everything works beautifully and incredibly speedily on my external 3.5"
> hard drive connected via Firewire.
>  On my USB keys, a huge number of changes are seen and git takes a very long
> time assessing ("deltifying") what are the changes needed (more than 10
> times the number of files are deltified!). Shouldn't git just realize that
> it only needs to make the changes that were made in the last commit, or am
>  Finally, I have also tried changing the disk formatting of the USB key to
> try to diagnose the problem. However, the problem is the same whether the
> format of the USB key is HFS+ Journaled or MS-DOS FAT32.
>
>  So, my question is what am I doing wrong with "git pull" and is there a
> better way to use git for the task at hand? Unfortunately, I have not yet
> been able to find a solution anywhere on the interwebnetblagosphere.

Not really directly relevant, but since no-one has replied: I daily
copy several revisions onto (git push) and back from (git pull) to USB
key (MS-DOS) on x86-Linux and it never takes more than a couple of
seconds. (Repo is around 17MB packed, maybe 10-400 objects updated per
push.) I know nothing about OS X, but the discrepancy between firewire
and usb suggests some performance issue in usb handling. I don't know
off the top of my head if packs on the receiveing end of a push are
mmap()'d (to find branch heads?), but OS X is said to have poor mmap
performance: maybe it interacts with usb driver to be even worse?

Anyway, only suggestion I've got is if you've got easy access to a
Linux machine with git available, try pushing from that and see if the
speed differs.

There have been reports of people using git when writing books, and I
use git to track papers I'm writing (amongst other things), so your
usage pattern is entirely normal.

HTH,
-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
