From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: 'push origin master' takes over 8 minutes (local ssh)
Date: Sat, 14 Jul 2007 16:00:44 +0300
Message-ID: <f36b08ee0707140600i5dc25056k4c95a432ec225a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 15:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9hF5-0006lW-FV
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 15:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbXGNNAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 09:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXGNNAq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 09:00:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:57170 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbXGNNAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 09:00:45 -0400
Received: by nz-out-0506.google.com with SMTP id s18so615529nze
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 06:00:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FQKYQ1K+H8a2pP094o3mjSvp3vD0jPtx+KAfKX8J3o9yusY5xK0JsAGVxAmGEvORnBnIRyOflRSrztpCZmNuNyD7PSxaB/6vSntI61TywmvrhBwQX/3AwyhLHbuyJLWpupSJlHDg8WtXqpv09OfywnVus966872TKOLWrz/g7Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g0IBH39HnlK2d4BwIJDiiAsTetYOIKI6eDwGBFOF2UvPlJXDOKE9nuKgBJLuyE+m3Eqis9uh7lENX2bMvpzlg5En7j6WLDgdOwhW2MjEzRbFbNBg8Ml5pSmz7d9Turg2l3ZYuLgEy4Ur/z+QSOUFIhgoAfoj1GKReLMxQa3AF04=
Received: by 10.142.83.4 with SMTP id g4mr198243wfb.1184418044042;
        Sat, 14 Jul 2007 06:00:44 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Sat, 14 Jul 2007 06:00:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52477>

Something happened to the repo, and 'push origin master'
is taking now very long time: > 8 minutes  (this is ssh to localhost).
It's in git-pack-objects.

The git-pack-objects sits there for >8 minutes using very low cpu (<1 %)
but lots of RAM (>300MB). Then it bombs with malloc error.
I could add swap to the machine [1], but this long time with
low cpu usage is suspicious, no ?

Repo counters are below [2]

I suspect one file, history of which accumulated thousands commits
from the script. I'd like to erase the history of this file but I don't know
how. And I don't know where there is a connection.


Yakov

[1] This is vps machine that hasb 128MB ram + 256MB swap.

[2] Repo counters.

- the master repo which is being pushed to (it is bare, the "master" repo):
count: 653
size: 140692
in-pack: 21730
packs: 2
prune-packable: 5
garbage: 0

the repo which does the push:
count: 369
size: 42960
in-pack: 22145
packs: 4
prune-packable: 9
garbage: 0

Don't ask me about workflow.
I synchronize files between four hosts using git.
I beleive this is very unusual workflow. No branches.
