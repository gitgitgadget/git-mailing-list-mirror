From: Ulrich Spoerlein <uspoerlein@gmail.com>
Subject: git-notes, how do they work?
Date: Sat, 12 May 2012 12:43:32 +0200
Message-ID: <20120512104332.GN71676@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 12:43:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST9nX-0002bD-70
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 12:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab2ELKnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 06:43:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40486 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2ELKne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 06:43:34 -0400
Received: by wibhn6 with SMTP id hn6so1004172wib.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=nUIs9KwuAoHJrlq0ni9Qrt6DvBmwvjAR0a00nCSslyk=;
        b=KW9OCUXFPwRWWzC89IO1L1Xs68t5YbebdubYpgYUd3HF0YZVr3VlGHUp7vMPuqAkWT
         XEXPMN5FxwAc74yY8LaQc2FdFbM1WrojflIW73u4TCIhfIxscWj1m/cQvJ+5rZQjUSlI
         Q+AAY71ELx0Yp4MAdWpfVPiPtjR4ltYusWzd2sBjuH/tymtzYdVRszVoJPv3L3GfjSyV
         g/xv/+dveSt6Zo5HC3jCk1Dvitl8XWSrlDC8lwXz3Y/j4Vj0tI3DLchaGnF1ydoh2oSs
         KHU6AHRjbwurf8hOyA2O2bw9BlCD8MdzahDimU1JfjhHWTyiE0LGZuHpQJU3Jzzd/7+r
         AExw==
Received: by 10.216.134.145 with SMTP id s17mr942694wei.22.1336819413338;
        Sat, 12 May 2012 03:43:33 -0700 (PDT)
Received: from localhost (acme.spoerlein.net. [88.198.49.12])
        by mx.google.com with ESMTPS id f19sm28299597wiw.11.2012.05.12.03.43.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 03:43:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197721>

Dear all,

I cannot figure out how notes are supposed to stay around and not be
GC'ed eventually, seeing as nothing references them, usually.

But let me start from the beginning, I'm using svn2git to convert a
large repository and I want it to store metadata in the notes, which it
does just fine. However, after a while of running (and I suspect garbage
collection is to blame) the older notes start to disappear and only HEAD
has a note attached to it. This means that the notes, as pushed to
github, are only partially complete.

IIUC refs/notes/commits points to the latest note, which points to HEAD.
However, there's no reference that points to the note pointing to
HEAD^1, so how will it not be garbage collected? How can it be pushed to
a remote repository?

I understand that notes cannot point to older notes, as that would make
removing/adding notes from/to older commits quite a hassle.

So, what am I doing wrong here? How can I avoid notes from disappearing
so that each and every one of it remains in the repo?

Cheers,
Uli
