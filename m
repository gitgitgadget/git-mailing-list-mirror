From: "Steve French" <smfrench@gmail.com>
Subject: default commit message for a tree
Date: Fri, 25 Apr 2008 20:39:20 -0500
Message-ID: <524f69650804251839u56198808o8b7a66d9894fbbfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 03:40:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpZOr-0001za-BY
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 03:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYDZBjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 21:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbYDZBjW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 21:39:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:7577 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYDZBjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 21:39:21 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5220294fkr.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 18:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=w5pXdB7cd9+Y6aVGGXJJA3VRM3U6zIthogeqxed5MNE=;
        b=x63BpgIUow51O+uvUP/6jtmV7PhTwURk95HcwNYwLCpwFBqmEvECh3pj6tqME6H813h/pOX2FctyVHO07L2EAXrYDo6BFDoeQzC7Af6uHSt/OopF8VhePpV0q1aSQyWLVp71xw2pVeg3jFU13H+4VqgvVUjXkbbxOWyt4ztoTGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jab+di3hSC3l4xvI1wrwI/32r4/+h7sE0gPJyiCpHf5X+h9TFbWoekAPI6pfcTJitec9iawk6naE/qi0NnV0eCQsk/EGP4rFp+Kt8NMJnA1NJrC9zQnPEBp1YH2E/yXaH8YU2SARVctAU86aaUsfOQhIqLIb4jpedP2QBTkBoEU=
Received: by 10.78.131.8 with SMTP id e8mr3440392hud.96.1209173960309;
        Fri, 25 Apr 2008 18:39:20 -0700 (PDT)
Received: by 10.78.172.19 with HTTP; Fri, 25 Apr 2008 18:39:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80362>

What needs to be done to setup a default commit message in git?

I did the following, trying to setup a default commit message (to get
the equivalent of  what I used to have with cg-commit in the past
where 1/2 of my commit text was filled in automatically from a file in
my tree ie default signed off line etc...

What I tried: First I did
    git-config commit.template commit-template

which changed the .git/config to add  new "[commit]" section (see below:
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

[commit]
        template = commit-template




I created a file .git/commit-template with default text as follows:

[CIFS]

Signed-off-by: Steve French <sfrench@us.ibm.com>




Now doing a "git commiit -a" though does not show this text.  It just
shows the typical
empty default message in vi e.g.


# Please enter the commit message for your changes.
# (Comment lines starting with '#' will not be included)
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   fs/cifs/CHANGES
....

-- 
Thanks,

Steve
