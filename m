From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git and concurrent access to local repository
Date: Tue, 22 Mar 2016 10:46:15 +0100
Message-ID: <56F11467.3010004@web.de>
References: <8C0042D8869AEA4AA334B49AFBBCEF82B53CF505@TUT-EX02-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:46:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiItN-0002oP-Mq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 10:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbcCVJqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 05:46:22 -0400
Received: from mout.web.de ([212.227.17.12]:58312 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756990AbcCVJqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 05:46:20 -0400
Received: from macce.local ([93.222.10.132]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lb29N-1a2PgX0V4r-00kfcV; Tue, 22 Mar 2016 10:46:16
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <8C0042D8869AEA4AA334B49AFBBCEF82B53CF505@TUT-EX02-PV.KSTG.corp>
X-Provags-ID: V03:K0:a6gTFTcyTlbXCjMZ3XV08Uq3prNHm23gQTCCioLdN/f6h9ekX5D
 DnfaZba7kbi1gr4rszqtGQApAiSkSpLekvJiT0CRO7gJgj2S7yPK71jKfhNMRl7WeFFaf1n
 +psaTx/Dc7pNdNb7G4Flb229MtwbtfCRet4YvWJfMALWH6gxEF9llATOTJkJecKLIeD4mjt
 GdBCRjL3tCEUG8s/tMoUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5Ld/zjBM7w=:DT0rlNWhZycGADr1ImwJP/
 pS9hXUuPN7HZ0ceAYzyEJ7DNvRkyoS+RUeC/jueMIy7Hbw9Kb6gbHEKZuOUEWRkx3tYI9stm0
 3BIMcDYMfr9G8kAN07bjoMt8nrLI5QXB5h7bYNEJtbzuyxnO4+KTBgdJnmkxSa4YMJeegA2TF
 /7zAQfWQJPdncXAX5HvMm63snX14gcglcv355PeRmPmLcdh/13yrGGroVt4y7p4fmNLgDIP61
 LKrBtL5uJEqaDNsYYd2mOGgXG8jVgl7SNkm8LEGfKEwQSDOWKBGWUH1wo+SOCS9tzLGnk/KKr
 JKYNaD1f4kmK48q1Vn9IcPodizcsSjDZ81aa5LcVD/WY7RZMQlPJetlBD6fZwwcAY+dpzUi/7
 2pBP1nlI3oX+BFbttELmjmRDzAv9zOcvZGyklClzePI+Il9iwe8yIjaSgQVzdoGTLkxYxIXC2
 kNUggrnYkNLGmDgqbkbR9GRQvZ4K2QPZMZJdvAMABor1Knd1et1f7sMkoNoTrVdbK72MznxO3
 S9TzuqTUPWsINvuYNINd9MANSxxFj6PuLkuuFHWQm2hXykcxYTjggA1yBa0L0m3qYbZBaBOMe
 sqWm5xhzwWRdQBBIJh9XAdB3VxbksrER6YF7b8sHrUmGmdH6GbPG6+miQv/gGli1xQSoKxrAZ
 PM7hNTk/Nv0FyEjr5gfetS2+lDM2x2cxPw+W0s9u8h8HzWSk8TKhk2tPySu4Xr0bJo6gC/I59
 WkHtqH9qdtuNd1o95fYcYjcLQ1uD+3BnthjCwPf5fjipC3UBHMiLjIedvHk+HQ0H29fVIT4+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289500>

On 2016-03-22 09.00, Boettger, Heiko wrote:
> Hi,
>=20
> I always thought git allows concurrent access to a repository and exp=
ected that this also is true when working with local repositories. The =
only problem I was aware of is that the use of NFS and windows shares m=
ight cause problems. However I sometime see the following error message=
s in our concurrent build process.
>=20
That depends.
concurrent read only access should work, AFAIK.
concurrent read/write access (in the way I understand what you describe=
 below)
is not supported. (Well, that is my knowledge).

> message 1:
>=20
> Fetching origin
> error: cannot lock ref 'refs/remotes/origin/branchname  Unable to cre=
ate '/home/workingcopy/.git/refs/remotes/origin/ branchname.lock': File=
 exists.
>=20
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other gi=
t
> process is running and remove the file manually to continue.
> From servername:gitrepo
> ! ccea072...349809e branchname  -> origin/branchname  (unable to upda=
te local ref)
> error: Could not fetch origin
>=20
> message 2:
>=20
> error: cannot lock ref 'refs/remotes/origin/master': ref refs/remotes=
/origin/master is at 07cd4a461229f9352d16063ff209e828cba592ea but expec=
ted 7c4ddcf998bad94f4f7e8e806baaa475f2069e60
>=20
> message 3 (on git pull --rebase):
>=20
> Cannot rebase onto multiple branches
>=20
> Does that mean there is an issue inside git's locking or is concurren=
t access to the same workingcopy not supported  at all? I expected the =
commands would blocking until they can acquire the lock, but It seems l=
ike there are other command which are either aborting or not locking at=
 all (git pull -reabase). I think git pull --rebase is just a chain of =
other git commands where the lock is done on the individual steps.
>=20
The whole scenario does make little sense to me.
One user/process/shell script should update one work tree,
like fetch/pull/rebase. After that, the build is started.
This has nothing to do with NFS, it's more that it is clear,
what is done in which order, and to have things reproducible.

like
- fetch
- checkout
- make
- test.

How does the scenario work, that you want to achieve ?

And why and how are multiple users/processes work in the same directory=
 ?


> Am I doing something wrong or is it concurrent access just not suppor=
t this way?=20
> Does that mean I have to use my own locks such as putting flock aroun=
d each call?
I'm not sure, if I understand the scenario completely.
It looks, as if different processes share one work tree,
as if 2 persons share one keyboard, one doing lets say C-programming,
and the other is doing some shell script development. At the same time.
Using the same keyboard.

I don't know, if flock will help you, but I may miss something.
>=20
> Best Regards
> Heiko B=F6ttger
