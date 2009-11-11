From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Locally manage user/branch setting files without pushing them 
	remotely
Date: Wed, 11 Nov 2009 13:01:26 +0100
Message-ID: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 13:01:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8BtF-0007Os-06
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 13:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406AbZKKMBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbZKKMBW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 07:01:22 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41543 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383AbZKKMBV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 07:01:21 -0500
Received: by bwz27 with SMTP id 27so906423bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=odzrv3yIPAX8t5NR+TWkr6wCOV7pbF84gpKOrCHz8Mg=;
        b=lr40n4tz62vvcETadQV4tB2gbxPxYGNc6I93OuW+9HERi768xHjm9i5zQFJJHFEHSs
         ymCThFWiyiGwqHsHwElrVDVHV3/siNyzDHKZOO+X8aNl6rMOLmXdId4HqeYCobx1M7Ah
         sfLK4WuTKzzudLRUL6DrLNzdT0TOEhhs79AcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pfKK9FlTnf8FFuxFhwy9KaY90lQ0unbpZtwZmPPMExNG+qMt+C3Cz7HhxrulOcYxR4
         LPusaprizJiTFUS2xRKKYBWJFBkj+tANbTWW0hhfOSvGr3kPXuuhRerBWWwXMCYKwWd8
         5eVdwjcfdq8xdnmroteQc8R9kcF9hUTKBaubM=
Received: by 10.204.24.71 with SMTP id u7mr1388864bkb.35.1257940886049; Wed, 
	11 Nov 2009 04:01:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132643>

Hi,

I had a situation I don't know how to manage with Git.

The project has a lot of setting that are really binded to the user
and should not go pushed in a remote repository (example: database
connections parameters / filesystem paths)
We have a .template file for those settings but the actual settings
are really binded to the user environment.
I added those files to the .gitignore but now I can't keep an history
of them and I can't use different version of them in different
branches.

I tell you what's the real situation but I will simplify things a
little, suppose I only have two branches: master and experiments.

I've a java application and some ANT script to automatizations like
compiling, packaging and deploying stuffs.

On my system I had two application servers and two databases one for
"master" and the other for "experiment".
There is a property files with the path of the two application servers
and the parameters to connect at the DB.

The ant script automatically deploy on the right application server
and automatically set the properties to connect at the right database.

This allow me to clean my experimantal database everytimes I need to
and start over by a clean situation and keep the "master" one
populated with all the data so I can do stress test/update procedures
test and so on...

At the moment I manually modify that property files when I checkout
one of the two branches and I need to deploy it to test or whatever.



Is there a way with Git to automatically switch that file when i
switch through branches?
It would be really perfect if I could also keep version of that file
so that when I checkout an old commit I had the options I was using
when I was testing that commit.

Ideally that means that should be some files that are kept within each
commit but they are not pushed to a remote repository.
(Even if i'm talking about pushing I'm using git-svn because my
company still use SVN as versioning system so I don't push but i do
git svn dcommit when committing on a remote repository)

How do you manage situation like this?

thanks,
Daniele
