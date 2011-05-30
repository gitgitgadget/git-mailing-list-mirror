From: Shawn Pearce <spearce@spearce.org>
Subject: Re: blame --reverse selecting wrong commit
Date: Sun, 29 May 2011 20:11:19 -0700
Message-ID: <BANLkTimXppE9sCW8tMntbD8p5-bRVFLHmQ@mail.gmail.com>
References: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com> <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 05:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQstO-0003CH-8W
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 05:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab1E3DLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 23:11:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63375 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab1E3DLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 23:11:40 -0400
Received: by vws1 with SMTP id 1so2403641vws.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 20:11:39 -0700 (PDT)
Received: by 10.52.74.4 with SMTP id p4mr948312vdv.137.1306725099130; Sun, 29
 May 2011 20:11:39 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Sun, 29 May 2011 20:11:19 -0700 (PDT)
In-Reply-To: <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174715>

On Sun, May 29, 2011 at 19:33, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, May 29, 2011 at 19:21, Shawn Pearce <spearce@spearce.org> wrote:
>> Although blame shows Stefan Lay removed the block in commit 05fa1713,
>> this isn't what happened. It was actually removed in commit 2302a6d3
>> by Christian Halstrick. It looks like blame gets confused around this
>> section of the JGit history.

Oh. Re-reading the man page for git blame helps. It says blame shows
the last revision that a line exists in, rather than the revision that
removed the line. IMHO, I expected reverse to show me the revision
that deleted (or replaced) that line, so I can inspect the commit
message and the contents of the patch. Showing me one of the potential
parents of that revision seems to be nearly useless.

Rereading commit 85af7929ee ("git-blame --reverse"), it seems you left
this an "exercise for the reader"... and in the past 3 years, no
reader has stepped forward to implement the exercise as a patch to
blame. *sigh*

-- 
Shawn.
