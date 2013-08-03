From: Adam A <hitsthings@gmail.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sun, 4 Aug 2013 07:46:47 +1000
Message-ID: <CAJOTJ-D6Aho_NJscXtu74Ok7u5sQmHn_L_Nma_F1kn9O6y95UQ@mail.gmail.com>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
	<CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
	<20130803163915.GB945@analysisandsolutions.com>
	<20130803165728.GB2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Convissor <danielc@analysisandsolutions.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 23:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5jf3-0007bg-3D
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab3HCVqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 17:46:49 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:48578 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab3HCVqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 17:46:48 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so1735321vbg.39
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wz6zrLffiHlH7S7/3aoXV5dUvMQV7iy/3B+g/2K/csU=;
        b=uhpijHtTpBD1aIYsjul39wy/aJH0EJm2zkccQBkHMX8+NarFLtEtcNY2IRIBf9AVH+
         v6PNc6d5a1OEUGaqc1Widjs9fm5Lf+hPtWC0q3SYRFNJMoFRmKHG5n5G7QDd91nbThvq
         QFAeftFTJGpV2119jLoj66CErSSVmGcNnTUM3ZmmGtYXVZAwUP8eTQkivHVBqIZ+J2AG
         OPy95ew88rTwR2pFKuBEZYeE2Vt2RKLVHlA4jmUaSJi/dE0/TP2lQL0zW6xzYE5J9tct
         YFGdIs7+mRre2g/cl+uoVO3eJAR063WdII0dMY8tgM+8Do15Hd1EScgx/ATxbngdS0f0
         3mmw==
X-Received: by 10.220.162.135 with SMTP id v7mr3889140vcx.35.1375566407511;
 Sat, 03 Aug 2013 14:46:47 -0700 (PDT)
Received: by 10.52.233.134 with HTTP; Sat, 3 Aug 2013 14:46:47 -0700 (PDT)
In-Reply-To: <20130803165728.GB2893@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231618>

On Sun, Aug 4, 2013 at 2:57 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Daniel Convissor wrote:
>
>> All is not lost.  Your local files should be stored in the repository's
>> reflog.  Examine the output of "git reflog".  You can then reset your
>> working directory to obtain those files by doing something _like_
>> "git reset --hard HEAD@{1}".
>
> Adam hadn't made a commit, so that wouldn't work in this case.
>
> "git fsck --lost-found" should be helpful, but yeah, this is a bug.
> See for example [1] for the start of a patch to play with (needs
> tests).

Ah I didn't realize the objects would still be there! `git fsck` +
`git show` is a wonderful workaround until the bug is fixed.

>
> Thanks and hope that helps,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/196502/focus=196503


Thanks so much guys!
Adam
