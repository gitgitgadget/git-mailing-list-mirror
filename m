From: Toan Pham <tpham3783@gmail.com>
Subject: Re: Big project, slow access!
Date: Tue, 22 Sep 2009 10:51:24 -0400
Message-ID: <ffb2c0280909220751r79946d76x3b23b146077781f5@mail.gmail.com>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
	 <20090918213216.GJ18785@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "R. Tyler Ballance" <tyler@slide.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 16:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq6iX-0004KB-3G
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 16:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbZIVOvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2009 10:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbZIVOvW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 10:51:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:16507 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZIVOvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 10:51:21 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1229447qwd.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/ixi9pSU9nkt/Imvy241M+mzUAvLVr0d6Ep8YJpiipU=;
        b=MNmRsYWXDAR8ueX7/gOanmIlFisNOlu6bgT/zuhdZzauU+mw2S7C7p+a0byzbGwMyl
         qp9hZqb6FtgtNSot8vt0PzSjRiN8lKfFlBDojgtkI/zbzRNZUPh4fvDQ9DZP61Zr/Vl0
         +VuFiHmeHnRYJEa1OtYMEm0v8r5L1JG12IJyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=n0WPBE+Ao/pbn4XTkuZx41KaNz0itACjzNQRP9ltg4gY/YNPyQ0KSt+RCyTGjZCtpm
         6zc8aCgTsbX6iKkW6f5g9viOUESs1BC38p/vwEwIdoMl40r82ZotAqRPaS232OtGeMbp
         ZvZMR0K74zaMLLgnK7XiogGoo5Yzy1Lrjiwsw=
Received: by 10.229.36.195 with SMTP id u3mr333440qcd.61.1253631084797; Tue, 
	22 Sep 2009 07:51:24 -0700 (PDT)
In-Reply-To: <20090918213216.GJ18785@starfruit.corp.slide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128935>

Dear Tyler


Thank you for your valuable feedback.

I'll research into git-filter-branch and also dividing a big project
into several sub-repositories.
This seems to increase the performance very much; however, there is a
draw-back that I am a little bit
concern with.  When we use several sub-repos option, we would probably
do manual book-keeping as to
which repo commits are compatible/built-able with other repo. commits.
 How did you manage to track
dependencies and their versions between different depos?

>>i'm waiting for a new fancy SSD to help alleviate my issues.

Please report the performance increase after you tested on your SS Driv=
e.








On Fri, Sep 18, 2009 at 5:32 PM, R. Tyler Ballance <tyler@slide.com> wr=
ote:
>
> On Fri, 18 Sep 2009, Toan Pham wrote:
>
>> Hi,
>>
>> I use git to maintain a project that is at least 8 gigs in size.
>> The project is a Linux from Scratch repository that includes source
>> codes to approximately 2000 open source projects,
>> gcc tool-chain, 1000+ configurations for different software packages=
,
>> source code for different kernel versions,
>> and many linux distributions/flavors resulted from this LFS build en=
vironment.
>>
>> The git's object repository is now 4.6 gigs and consists of approx.
>> 610,000 files and folders.
>> The speed of git is now terribly slow. =A0Each time I use basic comm=
ands
>> like 'git status' or 'git diff',
>> it would take at least 5 minutes for git to give me back a result.
>> Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.
>
> Howdy Toan, we have a similarly large repository ~405k files, the .gi=
t
> folder fully packed is ~6GB.
>
> The advise to fully-pack your repository is likely going to have the
> greatest impact on your performance in the short term, in the long te=
rm
> however you might want to consider using git-filter-branch(1) or othe=
r
> tools available to separate our the components of your current Git
> reposotory into a series of repos.
>
> The performance hit you're seeing likely has nothing to do with your
> processor speed either, but rather your disk search speed (i'm waitin=
g
> for a new fancy SSD to help alleviate my issues ;))
>
>> would =A0someone please recommend on how i can optimize git's perfor=
mance?
>> Git is so slow, are there better ways to manage a project like this?
>
> Rethink how your project is laid out, and whether certain binaries fi=
les
> need to sit in the tree, or can be build on a need-by-need basis.
>
>
>
> Cheers
> -R. Tyler Ballance
> Slide, Inc.
>
