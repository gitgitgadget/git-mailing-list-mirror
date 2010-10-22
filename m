From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Fri, 22 Oct 2010 12:38:04 +0200
Message-ID: <201010221238.07964.jnareb@gmail.com>
References: <4258434.537707.1287703612372.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 12:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9F15-0000Me-HD
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 12:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0JVKiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 06:38:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36866 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab0JVKiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 06:38:19 -0400
Received: by bwz11 with SMTP id 11so380348bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vgh3NfmGob+I4TFf/8em+uUb5Kg6QmZL+/vHi5d3Xis=;
        b=Yd7OVPAT3w1py1t5M3LV2HwSlU6pkzuBK+UsMo1HGep9ywNbIvldciVK75/v0Vq9BR
         adp9wBBwFNLijS7rj0bQNERWXP/nIrURXyJ67cnnJwkLqEz4RUMMNmbZ0Jd/E60ZUJgv
         6378t1fhhuPkw7pbhzYuPigiJgcoQEMRxdUlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JOQvfcNOlUeXSeg9Stw8f6Fyex7RB2xzGR2W2ACVH/QcPi3r9kp0WZSsumT5/e8Qmt
         f+mciY1/nf05i2Thv2JvWMDwCeA5A128Ftcvh8SqdApWBspHALTRrX7RsnTkS+zAmMAs
         LwXMfv6W19QV1NeC+FIruTQ/0tPKKJYidNGxc=
Received: by 10.204.68.136 with SMTP id v8mr1755770bki.188.1287743897804;
        Fri, 22 Oct 2010 03:38:17 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id a25sm2017581bks.20.2010.10.22.03.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 03:38:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4258434.537707.1287703612372.JavaMail.root@mail.hq.genarts.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159676>

On Fri, 22 Oct 2010, Stephen Bash wrote:
> ----- Original Message -----
> > From: "Jakub Narebski" <jnareb@gmail.com>

> > Ah, I understand now that 'svn merge' (which is rather like 'cvs
> > update') can be used for cherry picking.
> > 
> > Sidenote: in Git cherry picking picks up change and applies it on top
> > of current branch as one would apply a patch.
> 
> Yes.
>
> > This is quite different
> > from merge, where you find comon ancestor and then perform 3-way merge
> > (ours, theirs, ancestor). 
> 
> Yes.

Well, I guess that 'svn merge -rN' (merging in a single revision) works
similarly to how git-cherry-pick works.
 
> > Is merging in Subversion using 3-way merge
> > (like 'cvs update -j ... -j ...' is), or re-applying changes?
> 
> Appears to the be 3-way merge if I'm reading the SVN archives correctly:
>   "It's a basic diff3 algorithm. 'man diff3' to learn about it and play 
>    with GNU's implementation of diff3."
> http://svn.haxx.se/users/archive-2005-03/1232.shtml
> 
> So my *guess* is they derive a common ancestor from their copy
> information, but I'm sure someone else more knowledgable could say
> more about that.  

I guess that in Subversion <= 1.4 it takes N in 'svn merge -rN:M' as an
ancestor version for 3-way merge, and that in Subversion >= 1.5 it takes
last merged in state (from 'svn:mergeinfo' property[1]) if branch is 
merged subsequent time, or first common revision for both branches[2]
if it is first merge.

[1] The 'svn:mergeinfo' is about "merged-in tracking" rather than about
    "merge tracking".  Though change in 'svn:mergeinfo' indicates a 
    merge commit.

[2] I guess this is to be able to find such common ancestor (common
    revision) on first merge is the reason why merging branch into trunk

         .---B---.---.---.---M---.
              \             /
               \---.---.---/

    and merging trunk into branch

         .---B---.---.---.---.---.
              \           \  
               \---.---.---M---.

    needs a manual (by the way of '--reintegrate' option) distinguishing.
 
> > > > I have read some documentation about svn:mergeinfo property:
> > > > http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html
> > >
> > > I guess this the first time I've read the 1.5 version of the SVN
> > > Book.
> > > This has consequences below...
> > 
> > Errr... what consequences? a:b vs a-b being closed (inclusive) or open
> > (exclusive) from one or other end?
> 
> No, just that post-1.5 merges do actually start to look more like Git
> merges. 

Well, at least they can be unambigously detected, instead of relying on
parsing commit message of merge commit.
 
> > > Back to the task at hand... having read the 1.5 SVN docs, I have no
> > > idea how this works now (big caveat!!!), but prior to 1.5 M1 would
> > > have been
> > >
> > >   svn switch svn://path/to/foo
> > >   svn merge -ra:b svn://path/to/bar destination-path
> > >
> > > which is "Take the changes introduced in revisions a through b, and
> > > apply them to the destination-path". This is why I think of SVN
> > > merges as cherry-picks -- I was allowed to specify exactly what
> > > changesets I wanted merge to work on.
> > 
> > On one hand side you "were allowed to specify exactly what changesets
> > you wanted to merge to work on", on the other hand side you *had* to
> > specify what changesets etc.
> 
> My point is because the user was required to specify the revisions
> to merge, I don't think an automated tool (i.e. the mapper) can make
> assumptions about what was actually merged in any given revision.  

The problem is with even detecting that it was a merge and not ordinary
commit (well, unless some commit convention was used for merge commits,
but how likely that is that it was applied thoroughly, consistently, and
without mistakes that would trip a parser of a merge detector).
 
> > > To truly illustrate this, consider a' is in between a and b:
> > >
> > > ---1---B---2---3-------M1--4---5---M2 <-- foo
> > >         \              /           /
> > >          \-a---a'---b-/-----c---d-/ <-- bar
> > >
> > > I could
> > >
> > >   svn switch svn://path/to/foo
> > >   svn merge -ra':b svn://path/to/bar destination-path
> > >
> > > and "a" would never be merged back to foo.
> > 
> > Such merge would be hard to represent in Git, I think.
> 
> I agree.

Well, at least in a way that merge in git would consider the same 
revisions as already applied as Subversion would when merging.

-- 
Jakub Narebski
Poland
