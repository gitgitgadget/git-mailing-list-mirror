From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:35:24 +0200
Message-ID: <200610180135.24606.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZyw5-0001A5-Pt
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJQXey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWJQXey
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:34:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:37547 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751130AbWJQXex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 19:34:53 -0400
Received: by ug-out-1314.google.com with SMTP id o38so70252ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 16:34:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cb6zwygvrfWpYqLEmBF8G/UP0b2aXY5tn60mECn09pR7dj6fo+14v8TdX3XbUc/8DBvF3cGTFUsJL7rMQJXQgwXCYENjVlWBTAz+LX7PLGUvSM2N7TNWy5MxsABCvz3gpM94qdnz/vSjwQI/6W8aIsX6izO1+YituoGoTj1tZ3s=
Received: by 10.66.249.11 with SMTP id w11mr10756324ugh;
        Tue, 17 Oct 2006 16:34:52 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id z40sm249183ugc.2006.10.17.16.34.51;
        Tue, 17 Oct 2006 16:34:51 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <200610172301.27101.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29138>

Dnia wtorek 17. pa=BCdziernika 2006 23:01, Jakub Narebski napisa=B3:
> Aaron Bentley wrote:
> > Andreas Ericsson wrote:
> >> Aaron Bentley wrote:
> >>> Ah. =A0Bazaar uses negative numbers to refer to <n>th parents, an=
d
> >>> positive numbers to refer to the number of commits that have been=
 made
> >>> since the branch was initialized.
> >>>
> >>
> >> What do you do once a branch has been thrown away, or has had 20 o=
ther
> >> branches merged into it? Does the offset-number change for the rev=
ision
> >> then, or do you track branch-points explicitly?
> >=20
> > We always track the number of parents since the initial commit in t=
he
> > project. =A0Sorry, I don't think I said that clearly before.
>=20
> While this I think is quite reliable (there was idea to store "genera=
tion
> number" with each commit, e.g. using not implemented "note" header, o=
r
> commit-id to generation number "database" as a better heuristic than
> timestamp for revision ordering in git-rev-list output), and probably
> independent on repository (it is global property of commit history,
> and commit history is included in sha1 of its parents), numbering bra=
nching
> points is unreliable, as is relying on branch names.

Take for example the following situation:


In the following we had

  A--B--C--D  - repository A

we have cloned repository

  A--B--C--D  - repository B

Then, in parallel/independently we branched off C in repository A, and
branched off B in repository B

          -x
         /
  A--B--C--D  - repository A


  A--B--C--D  - repository B
      \
       -y

If we then fetch changes from B into A, and fetch changes from A into B=
,
we will have that in repository A branch off C appeared earlier, and
in repository B branch off C appeared later.
--=20
Jakub Narebski
Poland
