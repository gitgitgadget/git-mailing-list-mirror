From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Fwd: Fw: sort of a bug report - git rebase dropping empty commits
Date: Thu, 7 May 2015 01:19:42 +0100
Message-ID: <CAJMB+NhVapp+upsk2AQQmZndaNFjaOieom7=n6mY31v0QemaYA@mail.gmail.com>
References: <1430956735.75040.YahooMailBasic@web172301.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 02:20:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq9Xi-0005YX-BI
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 02:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbbEGATo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 20:19:44 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37871 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbEGATn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 20:19:43 -0400
Received: by widdi4 with SMTP id di4so40857892wid.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=1ayxGynUT+OddNx+nXP/ij1aE/bMG3SVwjsCyQX6M2E=;
        b=O/H2dMDuOov35TrMc+qCbi70yivxxsK18g6Wt1EsiOSt3HYXqNOj18u+z2mIb/wJAX
         GxRjPUmegPSP9hQnMhsBD06MbArVoci0VrGucC2R8sp0JEZOJHorPua1vvQtPNaHTu6M
         BPvi8JRntfpmER+nU0A0Ei6oDHAHl5oRFln8B5GzSLsokeCE6oHHtjxCG/2GLF93t+F1
         oxwqOtn6k1nrd6a85qzc46POS78vD1cZXjuLd5/rdGfRHwmo7acPHBXFicL6rusIfHqy
         QElOq0hIJfJonD/dmXR62JJQex5Y2yTt+r7QY6voFtTefCxUaGNKMNePzXOVmyogGcUN
         IxZA==
X-Received: by 10.180.78.199 with SMTP id d7mr221319wix.94.1430957982421; Wed,
 06 May 2015 17:19:42 -0700 (PDT)
Received: by 10.27.204.193 with HTTP; Wed, 6 May 2015 17:19:42 -0700 (PDT)
In-Reply-To: <1430956735.75040.YahooMailBasic@web172301.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268502>

Repost from another account. vger.kernel.org seems not
to like postings from my other alias (which goes through
yahoo).

> (please cc - I am not a subscriber)
>
> Recently I have started to keep some notes in git repo's
> with --allow-empty - i.e. the meaningful content is
> the commit message and the date itself, not the diff.
>
> One example I had yesterday was just committing dated
> snapshot
> of my phone contact list. (this obviously doesn't change all
> the time).
> I don't normally rebase such things, but I wanted to edit
> one
> of the commit message a moment ago. And was rather
> surprised
> that git rebase dropped a empty commit. Here is the reflog,
>
> f1c5e51 HEAD@{0}: commit: May 6 15:52
> ../mobile-2015-05-06/getphonebook-ME-r
> 828bc47 HEAD@{1}: rebase -i (finish): returning to
> refs/heads/master
> 828bc47 HEAD@{2}: rebase -i (pick): Mar 25 04:11
> ../mobile-2015-03-25/getphonebook-ME-r
> f78ccce HEAD@{3}: rebase -i (reword): Oct 17 2012
> ../mobile-phone-2012-10-17/contacts
> 978ae2c HEAD@{4}: cherry-pick: fast-forward
> 4b5cee9 HEAD@{5}: rebase -i (start): checkout
> 4b5cee9ad7d7338a368b1fdd0dd02fb9e5800b63
> 4d10a7c HEAD@{6}: commit: May 6 15:52
> ../mobile-2015-05-06/getphonebook-ME-r
> ec97077 HEAD@{7}: commit: Mar 25 04:11
> ../mobile-2015-03-25/getphonebook-ME-r
> 978ae2c HEAD@{8}: commit:
> ../mobile-phone-2012-10-17/contacts
> 4b5cee9 HEAD@{9}: commit: May 22 2010
> ../mobile-phone-2010-05-22
>
>
> so 978ae2c is reworded to f78ccce, ec97077 to 828bc47, and
> 4d10a7c was dropped
> (and I re-commit with f1c5e51).
>
> It isn't too surprising that rebase drops empty commits, but
> I would really rather
> it doesn't do that. Should this behavior qualify as a bug?
>
> This is with git 2.1.0
