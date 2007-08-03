From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Thu, 2 Aug 2007 23:56:00 -0700
Message-ID: <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGr52-0006I5-I2
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbXHCG4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXHCG4H
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:56:07 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:28775 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025AbXHCG4E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 02:56:04 -0400
Received: by qb-out-0506.google.com with SMTP id e11so851646qbe
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 23:56:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=jyrKQSOv4rydlWZDXazoxu55msMHKLc7ddxX3yNWYeJvYiic/gVUBB8isOXqRtKVEX05/TipqBMvqe6SrpXGqkJjzsRQgEH1QXsHcQyrgcstqEqRtaC3d4UbY8QQuwcnTsoyVSdPeFCxuD8ZBnRbWI4BOI1WtOduRIzgtFvutJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=suIt8mOaJ9L/Ka3uceeJGXny3ueZ6zIPTFQSV3ws+6mVwMWVjwPU7omVU5WFFWGTGoH8ndhrjuJDVlx5zqYXR0TPb/bnRnaF27X5268xDptrE7AAqFbxn9aFwuKWt8MoBAdgIbQ6S6A0e2ztZb5MCTiCf+XZ98ux59ZDbaJ+oOQ=
Received: by 10.141.155.5 with SMTP id h5mr956010rvo.1186124163602;
        Thu, 02 Aug 2007 23:56:03 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id k5sm2554052rvb.2007.08.02.23.56.00
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 23:56:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708022206130.14781@racer.site>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54678>

Great job! Because finding and installing MSys, MinGW and dependencies was not trivial at all.
I have 2 suggestions for this package:
1. Remove git repository from it. It will make a download much smaller (~20MB smaller) and include the minimum git functionality to 
pull mingw git from the server (may be even automatically on first startup).
2. Add gdb. Not much could be done without it.

With this package (+gdb) it took me about an hour to figure out why git is broken on Vista (this includes learning how to use gdb 
:-). So you should expect much higher level of participation on the Windows side.

P.S. If package becomes sufficiently small for a single file, try to remove 7zip dependency (use WinZip instead). The easier the 
installation the better.

- Dmitry
----- Original Message ----- 
From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
To: <git@vger.kernel.org>
Sent: Thursday, 2 August 2007 14:23
Subject: Git on MSys (or how to make it easy for Windows users to compile git)


Hi,

I finally broke down, waiting for the sourceforge project to get granted.
In the meantime, I registered a project at

http://code.google.com/p/msysgit/

(WARNING: temporary only!)

Would you believe that Google code has a restriction to 20MB per file, and
100MB in total, and you cannot remove files?  The same Google that gives
you 1TB mail space and counting?  Yes, it is ludicrous.

Anyway, you can get a complete Development environment in 3 files (because
one would be too large), and... oh well, just read what is written on the
website if you're really interested.

The plan is to move to Source forget ;-) when they finally approve the
project, or stay with Google, should they decide to lift the quota a bit.

Dmitry already reported a buglet preventing gcc to run without changes on
Vista, his theory is that the infamous access() function is at fault.  So
if you are unlucky enough to be stuck with Vista, just copy
msysGit/mingw/libexec/gcc/mingw32/3.4.2/cc1.exe to msysGit/mingw/bin/ and
you're set.

Ciao,
Dscho
