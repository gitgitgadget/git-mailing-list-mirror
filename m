From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 23:12:52 -0700
Message-ID: <5BC36977390A4E61B826613630DF0BBC@ntdev.corp.microsoft.com>
References: <20070917193027.GA24282@old.davidb.org> <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0055_01C7FB12.9AC6A040"
Cc: "Git" <git@vger.kernel.org>
To: "David Brown" <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 08:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYFHg-0004Wz-4H
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 08:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbXITGM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 02:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755544AbXITGM6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 02:12:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:63481 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbXITGM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 02:12:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so499419wah
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        bh=Tswntt7O2WkEeajFy5/yrCjfGugVNE5QH0zHLnzVwDE=;
        b=c0K3VwwqNlVCGEM1Q8sZ2y4E8esjj7WH30r2qaKIGPLU+NpRISxIggFpvNNmSW50rXmqcH70u6+KC0042RI04gWk5fTeR5AyYLpBHt9Y/dXcZHwlDBjv2+McOx0ouM7PVTiSbI32JPJUwvZwkUbLxz9SBAFjlvFkLnSGhKI5kuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=bU79y0eYtIXeQN5PR9DTY/j4yF8BSOQl2bl8V+5zHNYLC6uHlgwKTo9BeybM9qDOfLdhS7qgwkAgux0qRP6vw9jn/Ook1NRQs2o9qyx93qbY3B2inle+LvUFE3wD73T7laugqMBrj0SeEA5v5DW02lTALVJxL7x24lLmOr8N+IQ=
Received: by 10.114.151.13 with SMTP id y13mr1713033wad.1190268775961;
        Wed, 19 Sep 2007 23:12:55 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id l28sm1956336waf.2007.09.19.23.12.54
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2007 23:12:55 -0700 (PDT)
In-Reply-To: <20070918154918.GA19106@old.davidb.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58757>

This is a multi-part message in MIME format.

------=_NextPart_000_0055_01C7FB12.9AC6A040
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

I had to import quite a big Perforce depot too. And after some struggle it 
went fine.
For case mismatch: 
http://kb.perforce.com/AdminTasks/SuperuserTasks/CrossPlatfor..erMigration, 
bullet 10. It requires server access.
For a@b and for excluding one p4 path during migration you could use my 
quick-and-dirty fix (attached).
You can easily extend it to include and exclude multiple paths. Then it 
becomes as flexible as p4 client mapping.

- Dmitry
----- Original Message ----- 
From: "David Brown" <git@davidb.org>
Newsgroups: gmane.comp.version-control.git
To: "Sam Vilain" <sam@vilain.net>
Cc: "Git" <git@vger.kernel.org>
Sent: Tuesday, 18 September 2007 8:49
Subject: Re: State of Perforce importing.


> On Tue, Sep 18, 2007 at 07:27:13PM +1200, Sam Vilain wrote:
>
>>I'm pretty close to giving a newer one a spin, that actually imports
>>from the raw perforce back-end files without needing the perforce
>>server.  I am hoping that this should give a very clean import and will
>>be very fast and efficient, sending files that share ancestry to gfi in
>>sequence so that the on-the-fly delta system works.
>
> Unfortunately, this isn't something I'm going to be able to use.  The
> Perforce server will remain live, and resides on a machine I don't have
> access to.
>
>>It could possibly be adapted to use the p4 client (though I'd expect
>>that to be relatively slow per-revision), and possibly be extended to be
>>bidirectional as all of the upstream change number information is
>>recorded, a la git-svn.
>
> I was able to get 'git-p4' to work a lot better by using @all, but it 
> still
> has some problems, at least bad interactions with P4.
>
>   - It doesn't use any client spec.  Our P4 server space is a complete
>     mismash and has to be fixed up to get a sane directory layout.  For
>     example, some revisions have hundred-MB tar files sitting in the root
>     directory and I don't want that in the repo.  I also need to exclude
>     directories, and in some cases completely rearrange the directory
>     layout.
>
>   - Our P4 server is set to be case insensitive.  'git-p4' ignores paths
>     that come back from the server that are specified using a different
>     case.  Unfortunately, this means that a handful of files just get
>     randomly dropped from each revision.
>
>     I tried importing a client path instead of a depot path, but the names
>     that come back from 'p4 files' are depot based so none ever match.  I
>     end up with a nice revision history of entirely empty trees.
>
> I'm probably going to end up writing an importer that uses an actual 
> client
> workspace to let Perforce do the client mapping.  I'm also going to have 
> to
> put some work into some code to clean up the log messages, since most of
> our changes have as a first line "New Features:", which makes for a rather
> uninformative shortlog.
>
> But, I did learn about 'p4 -G' from git-p4 so that will help in getting
> information from the repository.
>
> Thanks,
> David 

------=_NextPart_000_0055_01C7FB12.9AC6A040
Content-Type: application/octet-stream;
	name="0001-git-p4-Added-exclude-option-and-use-P4-client-nam.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-git-p4-Added-exclude-option-and-use-P4-client-nam.patch"

>From a089b02239c3bc310956964d61075b093d26549f Mon Sep 17 00:00:00 2001=0A=
From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>=0A=
Date: Sun, 9 Sep 2007 13:58:12 -0700=0A=
Subject: [PATCH] git-p4: Added --exclude option and use P4 client name =
in commits=0A=
=0A=
---=0A=
 contrib/fast-import/git-p4 |   19 +++++++++++++++----=0A=
 1 files changed, 15 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4=0A=
index adaaae6..337854f 100755=0A=
--- a/contrib/fast-import/git-p4=0A=
+++ b/contrib/fast-import/git-p4=0A=
@@ -769,6 +769,7 @@ class P4Sync(Command):=0A=
         self.keepRepoPath =3D False=0A=
         self.depotPaths =3D None=0A=
         self.p4BranchesInGit =3D []=0A=
+        self.cloneExclude =3D None=0A=
 =0A=
         if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":=0A=
             self.syncWithOrigin =3D False=0A=
@@ -779,8 +780,12 @@ class P4Sync(Command):=0A=
         while commit.has_key("depotFile%s" % fnum):=0A=
             path =3D  commit["depotFile%s" % fnum]=0A=
 =0A=
-            found =3D [p for p in self.depotPaths=0A=
-                     if path.startswith (p)]=0A=
+            if self.cloneExclude and path.startswith( self.cloneExclude =
):=0A=
+                found =3D False=0A=
+            else:=0A=
+                found =3D [p for p in self.depotPaths=0A=
+                         if path.startswith (p)]=0A=
+=0A=
             if not found:=0A=
                 fnum =3D fnum + 1=0A=
                 continue=0A=
@@ -905,6 +910,8 @@ class P4Sync(Command):=0A=
         else:=0A=
             committer =3D "%s <a@b> %s %s" % (author, epoch, self.tz)=0A=
 =0A=
+        committer =3D "%s <%s@%s> %s %s" % (author, details["user"], =
details["client"], epoch, self.tz)=0A=
+=0A=
         self.gitStream.write("committer %s\n" % committer)=0A=
 =0A=
         self.gitStream.write("data <<EOT\n")=0A=
@@ -1540,10 +1547,14 @@ class P4Clone(P4Sync):=0A=
         P4Sync.__init__(self)=0A=
         self.description =3D "Creates a new git repository and imports =
from Perforce into it"=0A=
         self.usage =3D "usage: %prog [options] //depot/path[@revRange]"=0A=
-        self.options.append(=0A=
+        self.options +=3D [=0A=
             optparse.make_option("--destination", =
dest=3D"cloneDestination",=0A=
                                  action=3D'store', default=3DNone,=0A=
-                                 help=3D"where to leave result of the =
clone"))=0A=
+                                 help=3D"where to leave result of the =
clone"),=0A=
+            optparse.make_option("--exclude", dest=3D"cloneExclude",=0A=
+                                 action=3D'store', default=3DNone,=0A=
+                                 help=3D"exclude depot path")=0A=
+        ]=0A=
         self.cloneDestination =3D None=0A=
         self.needsGit =3D False=0A=
 =0A=
-- =0A=
1.5.3.mingw.1.1.g01e3a1=0A=
=0A=

------=_NextPart_000_0055_01C7FB12.9AC6A040--
