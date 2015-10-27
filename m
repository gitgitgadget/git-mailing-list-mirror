From: Kyle Meyer <kyle@kyleam.com>
Subject: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 18:04:46 -0400
Message-ID: <87a8r4ary9.fsf@kyleam.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 23:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrCMT-0003nM-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbbJ0WEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:04:53 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36108 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbbJ0WEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 18:04:52 -0400
Received: by qgad10 with SMTP id d10so157542849qga.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kyleam_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=01Iywl9op14YX9axfsmrilhFu/caGPr55omdldoOPfg=;
        b=v+ZCMFXY3NJUQt1TyRD+xg6ReMJ5mfLDRJLunFfJllVTz606AHd/+jJzaGubifvfzh
         KHSe9lHcjre2pGUDHjlP+D90DCQqBpLE3xHCuG3t8QVsbHg6b1J5Foy611trDjD2aaIn
         ujfELpRXQKW4pgn9E2QdjEUpAyLzelpbc7K8S0zemtd7sEQoFG9QOSbV+j6NRNJpq1QA
         +l+Xspaw7JVvnv7j0EPoDWPnEI0W/mpJAZy2LQ3D20mPq8U/uPmlnNs0wJRGKrwomSZ/
         i+zMEs4s0bYO3yGAm/45WLJqYOKQGizSl+iwyFI1biTaDPaA2d9nWP4OFTT+ev0ED5sx
         zOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version:content-type;
        bh=01Iywl9op14YX9axfsmrilhFu/caGPr55omdldoOPfg=;
        b=MiaBYKrHoXWsfr67cwvNk0WG+pnsUdzowmIbSZP9/M6xKno368LBowRgD+1dhYuqFy
         /+mFgjYtcm6jKHc48W6ARkiHuQkHws15A6f0K9O93CNlyDIa4S9b5Onaa1TUTBOygyCz
         o5XV8qylJd956Ak168LZTr9ZVut7Lxu4t0N68A8/xQPurVDh3cCqLlaEaFjp8SeuOALQ
         YUtKBlhRW7EJd0fRue3OpWaIeAmNxC52EtPaGKhvbCDb08ccjKFbBexfL+QTG+5q6dpB
         obI3VzhSrARpEe5H+j027wHebRoXDQ2V3EcfmXwq9GsyVcqS7r7sK2r69OUtbkCkUUKL
         j5yg==
X-Gm-Message-State: ALoCoQkbu/Xd3eJ+IjYgVx/ziNy5YhdG59EeiHj3IH7U5JZVZn4DjLSreJg2hHxNHgpFcnT/x4Du
X-Received: by 10.140.38.149 with SMTP id t21mr17988968qgt.5.1445983491022;
        Tue, 27 Oct 2015 15:04:51 -0700 (PDT)
Received: from localhost (nat-130-132-173-5.central.yale.edu. [130.132.173.5])
        by smtp.gmail.com with ESMTPSA id r73sm15814424qha.48.2015.10.27.15.04.50
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 15:04:50 -0700 (PDT)
X-Attribution: Kyle
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280307>

Hello,

When a ".git" file points to another repo, a ".git/gitdir" file is
created in that repo.

For example, running

    $ mkdir repo-a repo-b
    $ cd repo-a
    $ git init
    $ cd ../repo-b
    $ echo "gitdir: ../repo-a/.git" > .git
    $ git status

results in a file "repo-a/.git/gitdir" that contains

    $ cat repo-a/.git/gitdir
    .git

I don't see this file mentioned in the gitrepository-layout manpage,
and my searches haven't turned up any information on it.  What's the
purpose of ".git/gitdir"?  Are there cases where it will contain
something other than ".git"?

Thanks.

--
Kyle
git version 2.6.1
