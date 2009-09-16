From: Rustom Mody <rustompmody@gmail.com>
Subject: git workflow for fully distributed mini-teams
Date: Wed, 16 Sep 2009 13:05:05 +0530
Message-ID: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 09:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnp9c-0002Ks-Qx
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 09:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZIPHmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 03:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbZIPHmH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 03:42:07 -0400
Received: from mail-px0-f176.google.com ([209.85.216.176]:53963 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZIPHmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 03:42:06 -0400
Received: by pxi6 with SMTP id 6so3806152pxi.21
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=B5kS0P9/LW/Yl7KcDdL8z/JVhPmiDyQzNP1fWyINBIs=;
        b=AZj4l0reQwIc1aYup67UhtQWLjB2lxbNDOe5JkaSvbEj3f3mQKQTi+nIh6kfhXd724
         R2rrVBr8Rt4coM+svqjFScBKQH1uI22SJbT9NgdChNZERnV6ZsaPAzgN0GNOn6S52B9C
         hjE1f62VXLYxfJTunc/Pdj7/sddgsuWzP4h2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GaFWPcxHAJg99mEDHtJ/jz8iu8X8gD+KWWFOw5PLf28RZ3YUxPfChojC0SzG1eUriP
         Vd44Dremgza4TLeaxzW/z6K0sKJP/hsmPf+S7kKGtIMNtLe2+WXo/mke1aRu+AsQK0ne
         YKrjNpp08yU60dofNTRC3GSVBD8/x4y6kmyDA=
Received: by 10.114.18.4 with SMTP id 4mr15647647war.137.1253086505495; Wed, 
	16 Sep 2009 00:35:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128610>

I am trying to formulate (and understand) what it means to have a
fully-distributed mini team workflow with git.

By fully distributed I mean theres no central repo -- not for pushing
or even pulling; all communication is by email.
By mini-team I mean: Not more than 5 programmers.

Heres a typical scenario.

There are 3 programmers A B and C who communicate by email who have
started off from the same code base.

A's branches: dev, master, B, C
B's branches: dev, master, A, C
C's branches: dev, master, A, B

A's best practices (and invariants) are:
I (ie A) develop on dev (or other topic branches).
I only merge onto master; never commit.
I never work on nor merge onto B and C.
When B sends me patches I apply them to the B branch likewise for C.
Thereafter I merge that branch onto dev or master.
There are no tracking branches because there are no remotes -- no
central repo. [not clear about this]

B and C have corresponding practices/behavior.

So the questions...

Is there a better way of doing things?
Can some of these practices/invariants be enforced by scripts/options etc?
What about checkpointing and restoring from botches?
