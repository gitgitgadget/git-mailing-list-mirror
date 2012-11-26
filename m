From: Matt McClure <matthewlmcclure@gmail.com>
Subject: difftool -d symlinks, under what conditions
Date: Mon, 26 Nov 2012 15:23:16 -0500
Message-ID: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 21:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5DI-00011I-D7
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab2KZUXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:23:17 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41988 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970Ab2KZUXR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:23:17 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so8365023iay.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 12:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZgZCYR1czI3KnopuvCReHJkWh30+vuCan93KQc+teCE=;
        b=zryWZXuYAwM/UBE0TdPL6IwQH8pAKJRqdaiHExSQY+GcUaUKidYyegoN/AvScOJ0vh
         mNRzuj8Ih3ZfyKLFVmdoiNxZxT+xWyRSC8ZkQPHbhGG3dwiq15sN9mTaj5Y/zC6e7XBo
         IqATmTRcHoTdWerTmL1tYt93SjlXycZ9RKPEplHzDRmFwa29xynw52Mm2nsVKA/knjWr
         BejksJGurFYZJ85lOOoY7kZztB3rPeBFWIaucA4XvISk9J5ah2/PMseotLvX+a3Rjyrq
         JkIMV6nkqhGtanAN+QbO56T2mRPzElFELf63SGjxSM2tkaYp9CdC12Czj5lX6Qj39KKD
         syJQ==
Received: by 10.50.56.195 with SMTP id c3mr12898308igq.30.1353961396665; Mon,
 26 Nov 2012 12:23:16 -0800 (PST)
Received: by 10.50.57.167 with HTTP; Mon, 26 Nov 2012 12:23:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210479>

I'm finding the behavior of `git difftool -d` surprising. It seems that it
only uses symlinks to the working copy for files that are modified in the
working copy since the most recent commit. I would have expected it to use
symlinks for all files whose version under comparison is the working copy
version, regardless of whether the working copy differs from the HEAD.

I'm using

    $ git --version
    git version 1.8.0

on a Mac from Homebrew.

--
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
