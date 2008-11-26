From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 18:21:32 +0100
Message-ID: <85b5c3130811260921s474bc724hb74b54e21e8be912@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
	 <492D6CC3.2050408@drmicha.warpmail.net>
	 <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
	 <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 18:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5O6E-0004Q7-Br
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 18:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbYKZRVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 12:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYKZRVf
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 12:21:35 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:11807 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbYKZRVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 12:21:34 -0500
Received: by gv-out-0910.google.com with SMTP id e6so206254gvc.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=BMD0lSyrs5sub5I84eaoTOx2P6ymSyM968H3ykBeFwA=;
        b=T5zpv5xl1A3Y1QI+PYgW8CKrGr7U3sGcabml1RU2gjJch1h1mPn/Nzzu8Yta2K+mlv
         k2TbDhVpyRB9afmgGC+Z0E9N8qw8e0mPM9FuHRcIWWCgmEonMdozwJYr2ilfkyXuBceu
         JgC6RRV2bHdDFMPtiuxGVx9hwUYMD0H9ySdqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=wNNrcVkmvjtONP1r+ypa+In/u7NoVzqB/1rBbAA5uu+ZNSctCFo2j7JFtJgvgagKxZ
         elcxB5rkQcTQM9K4g9FivVTHor54doqZ6RbdYKusBsja1MGsMmR8ChufjggbzpfsAbcp
         vXF2N8Al51roGpM4be6pj8icoJH1Y7lyt9Fi4=
Received: by 10.86.51.10 with SMTP id y10mr3951621fgy.51.1227720092173;
        Wed, 26 Nov 2008 09:21:32 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 09:21:32 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: c3f3052a0a80b4b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101750>

On Wed, Nov 26, 2008 at 5:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 26 Nov 2008, Ondrej Certik wrote:
>
>> I am also trying to make the example simpler. I tried to squash the
>> first uninteresting ~1500 commits into one, but "git rebase -i" uterrly
>> fails after squashing about 600 commits. Still investigating.
>
> 1500... wow.
>
> The best idea would probably be to just "edit" the first, delete the rest
> of the 1500, and then 'git read-tree -u -m <last-of-the-1500-commits>"' on
> the command line (when git rebase stops after the "edit" command).

That worked, thanks! My original repo:

A -- B -- ... --- D --- E --- ...

where E and the rest of the commits (there are branches and merges in
there) are the ones that I need to preserve, but all the commits
between B and D can be squashed (~1500 of them). So I created a
branch:

A -- B -- ... --- D

then squashed the commits using the technique you described above, so
now I have:

A -- BD --

and now I would like to append "E -- ..." to it -- is there any way to
do that? I tried rebase, but that destroys all the branches and merges
and those are necessary to reproduce the fast-export bug.

>
> rebase -i was _never_ meant for such _massive_ interactions; that's just
> too much for a shell script.

In fact, I think it would work, but there is probably another bug,
that I am hitting, maybe due to whitespace problems --- in the
original repository, the patches are linear, but when I create a
branch before the failing patch and then cherry-pick it (that should
work), it fails and creates conflicts. The same behavior is with git
rebase. So I'll investigate more and report it in a separate thread,
as it is not related to fast-export.

Ondrej
