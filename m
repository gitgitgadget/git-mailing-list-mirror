From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Tue, 17 Nov 2009 19:19:27 -0500
Message-ID: <4B033D8F.1080309@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm> <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm> <20091114071946.6117@nanako3.lavabit.com> <200911151807.15726.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	gitster@pobox.com, skillzero@gmail.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYH3-0006ES-F5
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbZKRATh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756500AbZKRATh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:19:37 -0500
Received: from smtp113.rog.mail.re2.yahoo.com ([68.142.225.229]:22805 "HELO
	smtp113.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756493AbZKRATe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 19:19:34 -0500
Received: (qmail 5900 invoked from network); 18 Nov 2009 00:19:39 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp113.rog.mail.re2.yahoo.com with SMTP; 17 Nov 2009 16:19:38 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: Sv4E38kVM1kkRC3ZOeUWtbqhlYD4NX39tClw3WlN4uzMN59Wx9JB86.CjDuElCXygQ--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id E3AA3638907;
	Tue, 17 Nov 2009 19:19:37 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UzLbi3PFkIzB; Tue, 17 Nov 2009 19:19:27 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id A1FBC21C0538;
	Tue, 17 Nov 2009 19:19:27 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <200911151807.15726.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133118>

Thomas Rast wrote:
> Nanako Shiraishi wrote:
>> Quoting rocketraman@fastmail.fm
>>> Add a basic introduction to the branch management undertaken during a
>>> git.git release
> [...]
>> Here are some corrections that can be applied on top of your change.

Ok. I am submitting another patch on top of yours and Nanako's with some additional explanation and guidance, as well as some rewording and reorganization. I also corrected an error that skillzero caught earlier.

I think the basics of Junio's message re rotating 'master', 'maint', and 'maint-one-rev-old' are already in the document, so I haven't added anything explicit regarding that.

> At the bottom there are some more corrections on top of your combined
> patches.  At this point I would prefer to squash everything into a
> single patch, but if you want to keep them separate I can come up with
> a commit message.

Squashing is fine with me.

> All but the last change are just intended to "sound nicer".  Since I'm
> not a native speaker either (I'm not sure any have commented in the
> threads so far), it would probably be nice to get some additional
> comments.

I *am* a native English speaker. Sadly, its the *only* language I speak, read, and write. However, additional comments would definitely be nice.

> As for the last hunk, I felt it was misleading to state 'pu' uses the
> same process as 'next' immediately after mentioning the "next will be
> rewound shortly" messages that Junio sends out.  Such a message is
> never required for 'pu' because (as is already explained in the
> manpage) the "contract" is that the maintainer may rewind it anytime
> he likes.

I added it back in with the additional explanation that the public announcement is not necessary. I think its important for a reader to understand how the 'pu' branch might be maintained. Besides, the title of the section includes pu, so some discussion around pu is warranted, or the title should change also.

> Apart from that, I'm not entirely happy with the way the "release" and
> "maint, after a feature release" sections are tangled yet.  There are
> several forward and backward references between them.  I see that you
> are trying to drive home the point that maint needs to be contained in
> master.  Can't we just deal with that in the "feature release"
> section?

Agree. I reworded the sections to untangle the information somewhat. Let me know what you think.

-- 8< --
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 490346c..91c0eea 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -216,10 +216,17 @@ Assuming you are using the merge approach discussed above, when you
 are releasing your project you will need to do some additional branch
 management work.
 
-Since 'master' is supposed to be always a superset of 'maint', you
-should first make sure that condition holds.
+A feature release is created from the 'master' branch, since 'master'
+tracks the commits that should go into the next feature release.
 
-.Make sure 'maint' fast-forwards to 'master'
+The 'master' branch is supposed to be a superset of 'maint'. If this
+condition does not hold, then 'maint' contains some commits that
+are not included on 'master'. The fixes represented by those commits
+will therefore not be included in your feature release.
+
+To verify that 'master' is indeed a superset of 'maint', use git log:
+
+.Verify 'master' is a superset of 'maint'
 [caption="Recipe: "]
 =====================================
 git log master..maint
@@ -228,8 +235,8 @@ git log master..maint
 This command should not list any commits.  Otherwise, check out
 'master' and merge 'maint' into it.
 
-Then you can tag the tip of
-'master' with a tag indicating the release version.
+Now you can proceed with the creation of the feature release. Apply a
+tag to the tip of 'master' indicating the release version:
 
 .Release tagging
 [caption="Recipe: "]
@@ -237,19 +244,15 @@ Then you can tag the tip of
 `git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
 =====================================
 
-Similarly, for a maintenance release, 'maint' is tracking the commits
-to be released. Therefore, simply replace 'master' above with
-'maint'.
-
-You need to push the new tag to a public git server
-when you push the updated 'master' (or 'maint',
-if you are making a maintenance release).  See
-"DISTRIBUTED WORKFLOWS" below. This makes the tag available to
+You need to push the new tag to a public git server (see
+"DISTRIBUTED WORKFLOWS" below). This makes the tag available to
 others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
-release tarballs and preformatted documentation pages.  You may want
-to defer the push until after you have updated your 'maint' branch
-(see the next section).
+release tarballs and preformatted documentation pages.
+
+Similarly, for a maintenance release, 'maint' is tracking the commits
+to be released. Therefore, in the steps above simply tag and push
+'maint' rather than 'master'.
 
 
 Maintenance branch management after a feature release
@@ -281,13 +284,10 @@ code so that maintenance fixes can be tracked for the current release:
 * `git merge --ff-only master`
 =====================================
 
-This should fast-forward 'maint' from 'master'. If it is not a
-fast-forward, then 'maint' contained some commits that were not included on
-'master', which means that the recent feature release could be missing
-some fixes made on 'maint'.  If that happens, you need to go back to the
-previous "Branch management for a release" step.  Correcting this mistake
-becomes messy if you have already pushed the release tag, and that is why
-you should wait until finishing this step before pushing the release out.
+If the merge fails because it is not a fast-forward, then it is
+possible some fixes on 'maint' were missed in the feature release.
+This will not happen if the content of the branches was verified as
+described in the previous section.
 
 
 Branch management for next and pu after a feature release
@@ -297,7 +297,7 @@ After a feature release, the integration branch 'next' may optionally be
 rewound and rebuilt from the tip of 'master' using the surviving
 topics on 'next':
 
-.Update maint to new release
+.Rewind and rebuild next
 [caption="Recipe: "]
 =====================================
 * `git checkout next`
@@ -319,6 +319,10 @@ so.
 If you do this, then you should make a public announcement indicating
 that 'next' was rewound and rebuilt.
 
+The same rewind and rebuild process may be followed for 'pu'. A public
+announcement is not necessary since 'pu' is a throw-away branch, as
+described above.
+
 
 DISTRIBUTED WORKFLOWS
 ---------------------
-- 
1.6.2
