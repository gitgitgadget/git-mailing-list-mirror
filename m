From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 6
Date: Tue, 8 Jun 2010 12:34:14 +0200
Message-ID: <AANLkTimpZ8OYY_4i6G46MNo_Q7IE4lnbiEQOF2znM21Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 12:34:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLw8n-0005Ge-Ea
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 12:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab0FHKeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 06:34:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39534 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0FHKeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 06:34:36 -0400
Received: by vws17 with SMTP id 17so1346863vws.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=xuhOjnLpordpgzE9HbKFSUvPPPDAqEcjvUlcmgBLwvk=;
        b=E06g/QV2V2Nrgju9uK3n/5K8R37a5AMfLykRCmGN+GKC/r1luvTdpqUt8PbdEnC7YO
         0Myj2+HSXjC8itP4GG4ebj4UV5Os6XyoehMYZr3WSHp8+mcSUPMYryCMFmWwnPq2e6S8
         LLBuRXzLbXPgHVhSYvBshUE83/Lpl6q2aBviE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=s58YNokEbsUKfBfhHAWway6kzdxMMFFWMd9wM2D7Vc3tZqRYPQpqtUO4htPuOMmKMT
         8EbIPDxrR+Xc3hMHOph7YBP2SM3RNmo0gZtnLbU/Xp901jcTQf6iyktwxaROgGDMCHqq
         uhRyVKMMFiKsTJeiIQ5RYrrAgiZSJmTqT2hBg=
Received: by 10.224.65.103 with SMTP id h39mr2657851qai.288.1275993274223; 
	Tue, 08 Jun 2010 03:34:34 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Tue, 8 Jun 2010 03:34:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148660>

Hi,

The skeleton svnclient using the RA API is finally complete, and I've
already sent a WIP patch to the list. David, Jonathan and I have been
working hard on the svn-fe.git to optimize it, and add support for
incremental dumps. I also made another another attempt to get
svn-fe.git merged into git.git, and Jonathan's awesome review has made
us fix more things- I'm confident that I'm closer to getting it merged
now. We also found that we're using mmap() with MAP_SHARED, and that
this is not portable (see discussion on mailing list)- we have started
working on an alternative now. After this is complete, I'll send
another series to the mailing list, and that should (hopefully) be
merged. In the meantime, I'm scrambling to complete the svnclient so
it actually dumps data in dumpfile format, so I can connect it up with
the exporter. For the mid-term evaluations, I estimate that the remote
helper should be complete with the import capability and be merged
into git.git. A minimalistic export capability should be an added
bonus.

-- Ram
