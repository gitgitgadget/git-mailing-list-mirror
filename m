From: John Tapsell <johnflux@gmail.com>
Subject: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 11:36:03 +0000
Message-ID: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjEe-0001jm-N4
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996AbZCLLgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 07:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755807AbZCLLgG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:36:06 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:33936 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbZCLLgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 07:36:05 -0400
Received: by wf-out-1314.google.com with SMTP id 28so595148wfa.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hu1tjX64C2/GPmUZDBg59KFOwhJ08mDQmBqXZESx2H4=;
        b=aq2l0HcUeZYk5Jua67Q402ov8dwKBJIRKJuvYOmJg7BB5pVMYfkXpBkmCnFB/fiJHn
         WIXm7PHdRhJhLY9Gww99aupEUvuSiFT5vMpOMQzbgsxuNEHcgPylTUFieqjSbpsblvGe
         GM5HwaS7RRAQ6QWd1mUWru9ZeT6hmUYNkJRxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=cd1F7hIBedZEWk/PMwXEeOE/fon+S/4cl+XfTzlEtvSdOCV36vlKxfHZzNhT3SfV0q
         9RYi9hpAplA/uOYv/f+w8hb+8yEyFUkTmN4i78nYV9jPns8xmIpEe+QuILXtMBwlZkpj
         a9esnBA3SI/V7QGUjgemSefsU5/o6bkeM+u1U=
Received: by 10.142.226.10 with SMTP id y10mr4267454wfg.3.1236857763500; Thu, 
	12 Mar 2009 04:36:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113044>

Hey all,

  One of my collegues did:

git checkout origin/somebranch

  git complained that they need to specify the name with -b.  So they did:

git checkout -b origin/somebranch origin/somebranch

  Git accepts this with no problems, but boy - all hell broke loose.
Doing a push or pull gave errors, because "origin/somebranch" is now
ambigous (since there is two of them).  They can't even:  "git
checkout -b somebranch origin/somebranch"  anymore, since
"origin/somebranch" is ambigous.  It all got into a mess.

  I've sort it out now, but I'd like to request that git doesn't so
easily let the user shoot themselves in the foot.

  I propose that creating a branch called  "origin/*" or "remotes/*"
gives at _least_ a warning, and preferably an error (overrideable with
--force for people who really really want to do it)

John Tapsell
