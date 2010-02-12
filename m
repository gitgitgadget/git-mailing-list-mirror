From: Jan Koprowski <jan.koprowski@gmail.com>
Subject: Solve continuous integration (pending head / commit queue) problem 
	using git
Date: Fri, 12 Feb 2010 17:37:34 +0100
Message-ID: <c41cd75d1002120837t20f2a47fi41e8c67245c4284c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 17:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfyWT-0004QK-Iy
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0BLQhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:37:36 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:39295 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936Ab0BLQhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:37:36 -0500
Received: by bwz4 with SMTP id 4so2975056bwz.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=HVXUvQGvzyxLlqzSQdPp6VIr2II7b6FBfZS1NgX8heo=;
        b=f/W90r16v3U87TiWAiufVqMQWVe0Oyf54t5DRnAfVRXYn+YuecwiIJj3qaIWe6sMiW
         XQCTLxoQeLhUlfyVk5sswL2b8xmsC106GXfigbv4rtE8SVeaM6U8sHxbGVDPjZNQlAIf
         6T+QcbrJh4tgIRL82xIRPS8e/wfOu43hGGYb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GMxA8T0hOIXXLB522ZyZ6r7B3ToJ96EMM0jXpOUuSL+6eGkyEIp1Cj7VodWBIDC3zA
         CqJnhhEJaKE6A2j18vZQZ9aAIj1jcTkcmiuX2tWv5CeZJU1Wu4mN416R1j6h5D3UAAix
         nX6m2ett5VrHztedTYrc81vKBqgehnyDvGKnk=
Received: by 10.204.10.3 with SMTP id n3mr994872bkn.81.1265992654305; Fri, 12 
	Feb 2010 08:37:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139722>

Hi !

  This is my first mail on the list so hello everyone :)
  I'am currently write my MA. Part of my thesis is looking for some
way to stay "master" stable.
  First assumption is simple: Control version system make all dirty
job - programmers can't "stop" or "break" all procedure and work in
natural ways. We can't assume that programmer use some custom hooks on
their side or add some addition parameters to git commands.
  Second assumption  is that programmer can't compile source code one
their machine for some reasons. Only way to compile is some other way
- for example use CruiseControl or Hudson or some CI tools. This isn't
really matter in my question now.
  Third assumption: Code cloned from repository is stable = compiling
well and pass all tests.
  Forth assumption: compiling is testing are very very very fast.

What I meen "natural way of work" by programmer. They *clone*
repository (or *pull* changes) from some central repository. Then do
some stuff with code on their working copy and *push* their changes.
Ok but - their don't know is code working well. And this is a problem.
I know there is some options: XP pair programming, automated static
code analysis, code review and others ... but this is not the point.
In my "configuration" there are some frequently scheduled build of
system automated by some tool. Tool just get all stuff from repo,
compile all stuff, running tests (if compiling successes) and if
sending e-mail.
But SCM should "somehow" distinct unstable commits from stable commits
(after compiling).

Now. My idea. There is some revision tagged as "stable". *Clone* and
*pull* operations is somehow "overloaded" from server side and always!
return last revision tagged as stable. After compiling external tool
just move tag to another revision which pass all tests. Of course
there is some additional parameter (for example --last or --unstable)
which can clone fine way of repository.

Two questions.
1) Maybe I try to invent the wheel again. Is there any way to take the
effect without overloading standard git behaviours.
2) If not how overload git behaviors on git "server side" repo?

Thanks in advance!
-- 
><> Jan Koprowski [696775174] GSM
