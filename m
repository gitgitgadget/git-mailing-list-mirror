From: Levend Sayar <levendsayar@gmail.com>
Subject: panic recovery
Date: Sun, 16 Jan 2011 14:33:34 +0200
Message-ID: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eda Ercan <edaercan@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 16 13:34:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeRoK-0002Mu-LV
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 13:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab1APMeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 07:34:15 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57368 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1APMeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 07:34:15 -0500
Received: by qyj19 with SMTP id 19so1013769qyj.19
        for <git@vger.kernel.org>; Sun, 16 Jan 2011 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=w9C1XMgzHthXm99Y2jECINnDDtmKgh6DM2DdhwCRRdg=;
        b=oJZrMSvJT7yhBgCXsJBvLDkoDzCwyEfpbK4P5tU8sn8BFMj0NPOfK1yrLZQwrqBWlq
         aUCU+FyXQxYxa0epB0zDvvmSmQnmMkr61KRgCwzZ2abl7gzmWW8Kw5xqv4HGhzcjXeLx
         IqYUhjm/v5oCsikLEWLCZCGjhpe7yLVG/h63s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=w4uWr0Ng0k/0iKK6L8sHqj810BmL0DP1BG0DfnX4EpONbn2G6UVsvpf44W6mFCPDQF
         5eEryOf+fg9ie/Y6nku4zStreTHan8gvrBX6ozZONk2Ie0Bjwdcwa88noU0kIEngyQMI
         NUhRjDxzUKF3bQNoPnI+RvVrMb9MWCDsGU+b8=
Received: by 10.229.251.209 with SMTP id mt17mr2621154qcb.66.1295181254117;
 Sun, 16 Jan 2011 04:34:14 -0800 (PST)
Received: by 10.229.212.131 with HTTP; Sun, 16 Jan 2011 04:33:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165163>

Hi, all.

Yesterday one of my colleague tried to commit her two weeks of work.
Nearly 10 source code files.
After an unsuccessful am and apply commands, she tried rebase. And git
bothered something like you have to finish your am first.
Then I suggested to do

git am --abort

After that, we saw that all the sources she developed for two weeks
are gone. We really got panic.But I know that git stores everthing as
objects, namely commit,tree,blob and tag objects.

We sorted every file according to modification time under .git/objects
directory and use "git show" for every single object.
After a cumbersome work, we found blob objects for our source codes
that we lost and commit objects. Namely we rescued her work.

Is there a better way to use in this kind of situations ?

For example, to list every single objects under objects directory
according to their types ?
Or search a phrase in every blob obejcts to find the source code we
are looking for ?

_lvnd_
(^_^)
