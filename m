From: Rob Aldred <raldred@gmail.com>
Subject: Issue with git rebase
Date: Tue, 14 Sep 2010 13:39:39 +0100
Message-ID: <AANLkTikUE1q-MrOsc3QOc1x0UHdLJn6nf7yGJZ=q_qqP@mail.gmail.com>
References: <AANLkTikWPkJ+8DJn5KZXfVw460HRY3Ui-xDZ_TR1X_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 14:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvUo4-00016B-T2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 14:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab0INMkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 08:40:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63631 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab0INMkA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 08:40:00 -0400
Received: by qwh6 with SMTP id 6so4299427qwh.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=K+nyv/W09uJBhDrdClN26ovn37Ce35HCZVY6ZzeYqh8=;
        b=YyHj7Y+/i+9HeN1PniPkI6E+H0LIlZliftPdNORfsix2qtTac+9ONr2rIktNn/v1V0
         HHiQrP9srDj28NgZ7gnG6NLmgeCQbXdbIugFjI3TuO0ogRwl+0U3hdhx6BoFmpiSb36D
         /xEyxoQMT0CPtNIv5yRhnNsGmsAW7z9EW79VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=bfj6HAg8/+Gvy2VNzGdC37sQA2eATWTlYWB/omLQdq1tk8WsL202+byMwdWJS/IvjH
         emXBwX65dPL4MzItKSVjdiQMnjbHmx3xpAGnggUeWmO5FNhr2Fphfx9MM/HHRRcomRcq
         OF3UkrMcWCnMZ/gn+SCdz2D7vrPThIoL3Kkqk=
Received: by 10.224.112.215 with SMTP id x23mr911808qap.37.1284467999113; Tue,
 14 Sep 2010 05:39:59 -0700 (PDT)
Received: by 10.229.72.135 with HTTP; Tue, 14 Sep 2010 05:39:39 -0700 (PDT)
In-Reply-To: <AANLkTikWPkJ+8DJn5KZXfVw460HRY3Ui-xDZ_TR1X_Xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156169>

Hey, I have a problem with rebase which i suspect is not very common
I'm trying to repair a commit where over 100,000 lines including a
diff were commited to the commit message.
I have followed the manual here:=A0http://bit.ly/9uVReJ
That produces an error when it reaches the bad commit, heres the output=
:

    First, rewinding head to replay your work on top of it...
    Applying: fixes #2791 - added page count back in
    Applying: fixes #2399 - commenting out code for starting and
restarting solr/sunspot on production sites
    Applying: fixes #2361 - all selenium features now pass
    Applying: fixes #2797 - fixed checkout footer
    Applying: Implementing cartridge chooser wizard, Showing featured
products on the homepage and improving the printer inks page
    =A0.......the rest of the massive 100000+ line commit message......
    /usr/local/git/libexec/git-core/git-am: line 765:
/usr/local/git/libexec/git-core/git: Argument list too long

The other way I have tried is suggested on stack overflow and other pla=
ces,
`git rebase -i bad_commits_parent`
So i get the editor popup with the list of pick lines and commit
messages, it also includes the huge 100000 line message of the bad
commit
so I remove the rubbish from the editor leaving the following:

    pick 9ca499d fixes #2791 - added page count back in
    pick 6554bab fixes #2399 - commenting out code for starting and
restarting solr/sunspot on production sites
    pick fcd461a fixes #2361 - all selenium features now pass
    pick abedb79 fixes #2797 - fixed checkout footer
    pick 2860581 fixes #2757 Tidying up search results partial added
in filtering feature for search added filter search controller
refactored filter helpers to help with testing added string method for
filter values
    pick 010b596 Improving printer type and printer type category pages
    reword e00b910 remove the full printer file we dont need it
    pick 46d0831 Show the show the printer picker on printer type categ=
ory pages
    pick 7c0a850 - printer email now works like all other jobs - price
band class should be called access via root from
CartridgeSave::PriceBand
    pick 96423bb - link to background jobs - add indexes to
background_job_errors
    pick aa5fba2 - tables are missing loads of indexes, so added a shed=
 load
    pick ee8d5e2 - index on status for orders, could get messy without
    pick 2de051a remove js logging
    pick 625243c fixes to specs for import mailer after rejig of jobs
    pick cbaafa1 * Use 'homepage' tag instead of 'featured' for
featured products on homepage. =A0* Show border around printer makes on
printer type pages =A0* Resized konica minolta image so it isn't so
large
    pick 2b1ea09 customer id index already exists on cards
    pick d4d4d7a Fixing a couple of failing features
    pick 6856c1e emails seem to be missing :format :html form urls, wei=
rd.
    pick fbfb16b renaming TallyGenicom printer brand image
    pick f02966a fixes #2757 - fixes problems with using pagination on
the filtering
    # Rebase 6fe8075..f02966a onto 6fe8075
    #
    # Commands:
    # =A0p, pick =3D use commit
    # =A0r, reword =3D use commit, but edit the commit message
    # =A0e, edit =3D use commit, but stop for amending
    # =A0s, squash =3D use commit, but meld into previous commit
    # =A0f, fixup =3D like "squash", but discard this commit's log mess=
age
    #
    # If you remove a line here THAT COMMIT WILL BE LOST.
    # However, if you remove everything, the rebase will be aborted.

i get the following out put:
Successfully rebased and updated refs/heads/master.

I'm left at the the parent of the bad commit anything newer including
the bad commit is gone.
I can only assume something happened internally of git and it stopped
at the bad commit.
I'm about to resort to manually cherry picking all the recent commits
and reapply everything manually.

Hope you can help.

Many thanks
Rob
