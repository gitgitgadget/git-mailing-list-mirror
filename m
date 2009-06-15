From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 14:07:23 +0200
Message-ID: <81b0412b0906150507r7b141951w7246b0abab9624e2@mail.gmail.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dotan Barak <dotanba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGAyt-0002lM-TH
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758509AbZFOMHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757906AbZFOMHX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:07:23 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59644 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950AbZFOMHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 08:07:21 -0400
Received: by bwz9 with SMTP id 9so3267906bwz.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 05:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A4bgYgOBtlwdl3PrUQhViE9L15jNsbtCBRD1UCxJdjo=;
        b=eVTQ5LjznQHX1RSyEuLIY9Oh/W+umkUyuP9PX0gx5iFtLCm8RWdHqcjefKbCE3q8nL
         24RTmBg18hSFd32zJX6JukwjCu/GKLqMP6TiamuXINm5e+Dg3CWyqvisAw7u8OWHNl7j
         63hqI9WtnUo0ar3HTXf3GZ5jNNjoV1YQ+LqfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hSJ5IxzFCO2Aym3LMEW4qZoIgZRpni2sd9/0Gq1j1nk5vZv88+ftcPxcrgl8M4axbB
         ougZVsxjVa03dA8QuILHY9Rh8jrWvSDd29sV4PZV4EI2qfzPSbv1vvNnCaQ+W8tMVn3/
         zzxeVokdhMiU5rV86K0/XE29xkjf7/1u4bGgI=
Received: by 10.204.113.198 with SMTP id b6mr6976115bkq.115.1245067643053; 
	Mon, 15 Jun 2009 05:07:23 -0700 (PDT)
In-Reply-To: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121599>

2009/6/15 Dotan Barak <dotanba@gmail.com>:
> Is it possible to find the origin of a branch?
> (the remote repository that this branch was cloned and checked out from)

Look for a repository which has the smallest count of commits
in common with the branch.

You can use git merge-base to find all the commits which could
possible be the point of divergence (aka "merge base"). Then
you can find all the remote branches which have the "merge bases"
(git branch --contains <base>). Any of that remote branches
could have been the origin of your local branch.

You'll seldom (if ever again) need that, I think.

P.S. You don't clone branches. Not as such. You clone repositories,
which have the commits, which a branch (as in "reference") can point to.
