From: david.hagood@gmail.com
Subject: Problems with GIT under Windows - "not uptodate"
Date: Tue, 1 Sep 2009 10:46:39 -0500 (CDT)
Message-ID: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 17:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiVZT-0002eS-7c
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 17:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbZIAPql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 11:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbZIAPql
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 11:46:41 -0400
Received: from mail-pz0-f175.google.com ([209.85.222.175]:51166 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbZIAPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 11:46:40 -0400
Received: by pzk5 with SMTP id 5so80298pzk.21
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :date:subject:from:to:user-agent:mime-version:content-type
         :content-transfer-encoding:x-priority:importance;
        bh=Ejx4WMWhAzxm4hO9MKLHZnY65J0DkOfqNIktTkyaJxk=;
        b=jtNLWf6AVsJchUKVlV3hoYZUJfNqriJVB+iyn9SRhtaKZCONtnWNHi9EQSk6pv8HG+
         mSnt5quKA8ZOR0MS3jC8fJ85B7OiH6SZdA+ti87gMCiICgFXBwEY8UQN8fPAhUFGfCdO
         m2ppIpPN6SacfZJA7mc8rYxgpOXyR7lRl36Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:user-agent:mime-version
         :content-type:content-transfer-encoding:x-priority:importance;
        b=f/3iRIURCObJz3OzFZq68VlYF/I4nz/ScZwdFl5EhQHAbx+78YKCTZNU4pQqjSYH98
         hur+BwpoTp2KUnOrsY6XPd03RIedZF4FQzLeoXUp+qvkPiVWP8CZidxpic1b7bjg9h4e
         2DT77+UqtSWLIPBJN3MI5ejqEW2nyjDUXV0l0=
Received: by 10.115.117.39 with SMTP id u39mr4673024wam.116.1251820002737;
        Tue, 01 Sep 2009 08:46:42 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.121.34.clradsl.sktc.net [64.71.121.34])
        by mx.google.com with ESMTPS id 20sm457140pxi.12.2009.09.01.08.46.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 08:46:42 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id C3497C7B8248
	for <git@vger.kernel.org>; Tue,  1 Sep 2009 10:46:39 -0500 (CDT)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Tue, 1 Sep 2009 10:46:39 -0500 (CDT)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127541>

I am having a problem trying to support my poor, deluded cow-orkers who
use Windows and need to use GIT.

The scenario goes something like this:

They have a local repo, they have changes on their branch, they are
staging a commit to the master branch on their local.

They do a "git merge" and the merge has conflicts. They need to undo the
merge, so they do a "git reset --hard".

>From that point onward, if they try to access the origin repository (e.g.
"git pull") they get the error message

Error: Entry "Some file name" not uptodate: cannot merge.

We've tried "git reset --hard; git pull ." We've tried "git reset --hard;
git checkout -f master". Neither seems to fix this.

We Linux users don't see this.

I conjecture it is something to do with DOS's CR/LF line endings (the
files in question are a type of XML file which ALWAYS have CR/LF endings,
even under Linux) - perhaps *something* in the GIT processing chain is
trying to do a CR/LF -> LF conversion, and screwing things up.

Does anybody have any suggestions on what I am doing wrong (Please, not
"you are using Windows")?
