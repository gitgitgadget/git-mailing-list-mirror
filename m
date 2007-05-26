From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFH] QGit: how to cram a patch in a crowded screen
Date: Sat, 26 May 2007 10:46:21 +0200
Message-ID: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 26 10:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrrv0-0008PA-Ue
	for gcvg-git@gmane.org; Sat, 26 May 2007 10:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbXEZIqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 04:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbXEZIqX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 04:46:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:30335 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXEZIqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 04:46:22 -0400
Received: by nz-out-0506.google.com with SMTP id n1so528606nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 01:46:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i4ABPWAgeiNbYj99NnFWnWaBFcCB4LRg1JNPftSDzRRmr4kk0AdKedFvzlxNptpHJfo2ePzpY6l9oYfBFcU7IHDMsOntd0uNfdvkgVpEpPxWuicp1oK5taSHZ1Vmx0ORa8nWJMef1q1c/WpdrF9Nhgswd2Y6KFF7GeTKDvl4Iyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DpODE9vn7viifs9I8jrpfa97f/7vTuJIecoxGYdVTuKpX5nfVELzIi630q7IZbeoNPbyaop00O0xPO0KUXW1057Ge49c5pnhWqAzFfQP5xmLuzFRRgbhy1fvXhd8UQflTKoQHWnJxlt2SwDpRweiADdo7Y/X3Gt/EeSOZ1eO9K4=
Received: by 10.114.177.1 with SMTP id z1mr1843432wae.1180169181897;
        Sat, 26 May 2007 01:46:21 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 26 May 2007 01:46:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48462>

Me and Pavel were discussing about usability improvements in the new
qgit (Qt4 based) that is going to replace the current Qt3 based one.

Currently there are no released tarballs, just a git repo:

git://git.kernel.org/pub/scm/qgit/qgit4.git

but it's already quite stable and feature complete and works also under Windows.

The biggest issue Pavel pointed out is that the main view does not
show patch content.

Currently qgit is tab based, so you have the main view tab with
revision header info:
http://digilander.libero.it/mcostalba/qgit4_1.png

Or without header info ('toggle 'h' key) for bigger screen estate
given to the revisions list:
http://digilander.libero.it/mcostalba/qgit4_2.png

Then to see the patch you have to switch to 'patch tab' ('p' key and
'r' key to go back to revisions list tab):
http://digilander.libero.it/mcostalba/qgit4_3.png

In case you need to give a deep look at the patch maybe it's worth
toggling the split view with 's' key:
http://digilander.libero.it/mcostalba/qgit4_4.png

Form any tab you can navigate with 'i' (move up one) and 'n', 'k'
(move down one) so that if you are interested in patch content only
you can avoid going back ('r') to main tab and stay in patch tab while
browsing the repo.

But for Pavel this is not enough, and I agree with him, because you
cannot  see both the list and the patch content in one view.

Long time ago qgit was using independent overlapping windows to show
each kind of content, something similar to what git-gui uses now, then
I switched to tabs because I found myself spending more time in
arranging windows then in browsing contents.

The legacy way to do it is the gitk way: patch content below revision
log messages.

I tried to study that approach and to understand why it is practical
and handy, at least if you don't need to see the patch at full screen,
as I need in case I really want understand a difficult patch, but
probably this is a my limitation.

What I found, the 'secret' of space screen saving also with patch
content, is that when you look at the patch, scrolling down the
bottom-left pane, the revision logs and messages automatically fade
away because are scrolled out of the pane.

So it seems that you can see revision list + log messages + patch
content, but indeed what you see is revision list + log messages + *a
couple of patch lines* _OR_ revision list + patch content.

A natural consequence of this could be the introduction of another
shortcut to toggle messages and patch content in main view bottom left
pane....



After all this long introduction here we come to the subject of the e-mail.

We need some help, in terms of ideas, to better arrange the
information to be shown in main view so to improve repo browsability.

I could implement almost anything good comes up in this thread. But
still I don't figure out myself what is the best solution.

Any suggestion is greatly appreciated.

Marco

P.S: To be a clone of gitk is not necessarily a design spec.
