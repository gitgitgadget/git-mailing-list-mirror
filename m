From: "John Yesberg" <john.yesberg@gmail.com>
Subject: Fwd: difficulties with http proxy
Date: Wed, 18 Jun 2008 10:09:28 +0100
Message-ID: <1033a22d0806180209v1cc405e8ob1c176cb2ffc34b8@mail.gmail.com>
References: <1033a22d0806180206g2cf3315bh1e533902fc834ecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 11:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8tgP-0002xh-In
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 11:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYFRJJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYFRJJb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 05:09:31 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:24607 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYFRJJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 05:09:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so87601ywe.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uJSK2+OyXa4yfrsmuaL38hi4iTgmdmpqFMlNxp7+B+c=;
        b=DIxBm0hwVf1Cw4Ey4YfhL4EZdRgp53Yr3isn2NA/Dze+4cD2Q3f8/v2Mpkd4LVP5d7
         hWdz4BZvTsFFj+wKZ8bmRkLaZdPFtylKaUntZsu2GwmDMqchCzQaLfiykyuZXQwBOzsm
         YupT66ngD3CvZ5Px7klOx8gFv0qeLBRszWO00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WL9feC/WY/rBUkCtSIypQ6BINCNt6P+f/KpyvdsjDtbaeWthll9E0FrP/Oz8A26jVM
         GEpFgl4j0qo2mLm+kx0W1nhxbYejW0Aj8dai+GRW7QAL9EwYUxtChqttP/abzsuOL7ai
         tFBeRF75FR8pUr7jqj8xVi1bqYBhPVyxkjc1Y=
Received: by 10.151.156.7 with SMTP id i7mr718397ybo.115.1213780168527;
        Wed, 18 Jun 2008 02:09:28 -0700 (PDT)
Received: by 10.151.14.21 with HTTP; Wed, 18 Jun 2008 02:09:28 -0700 (PDT)
In-Reply-To: <1033a22d0806180206g2cf3315bh1e533902fc834ecf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85370>

Hi Bruce

Short version:
0. Using git on WinXP from
http://msysgit.googlecode.com/files/Git-1.5.5-preview20080413.exe
1. When a proxy is required, the error message isn't very helpful:
     Cannot get remote repository information.
     Perhaps git-update-server-info needs to be run there?
2. I can't get git config to set the proxy
3. When I use a shell variable, I can set the proxy, but I still have
trouble cloning git over http.

John.

Long version:
I'm back behind my proxy.
I've tried
$ git config --global http.proxy http://proxyname:80
and
$ git config --global http.proxy proxyname:80
but neither seems to work:

$ git clone http://www.kernel.org/pub/scm/git/git.git git2
Initialized empty Git repository in c:/[path]/git2/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

When I try
$ export http_proxy=http://proxyname:80
then the following at least starts to work:
$ git clone http://www.kernel.org/pub/scm/git/git.git git

$ git clone http://www.kernel.org/pub/scm/git/git.git git2
Initialized empty Git repository in c:/[path]/git2/.git/
got 7562b87f6fcfb31a5fa52d2edfe866b5f1ee08d5
walk 7562b87f6fcfb31a5fa52d2edfe866b5f1ee08d5
got d47c7c24b429eac4bacc107c0b5e2987db40f04a
got 71910874a081be5196ae122c8d0b6024ec3afa5e
walk d47c7c24b429eac4bacc107c0b5e2987db40f04a
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git
Getting pack list for http://www.kernel.org/pub/scm/git/git.git
Getting index for pack f7be43530c5b167d6eff8e1d4ee72d7c98aa6710
Getting index for pack 38b949b3b9446f6ef31fe3bc5a70b09cf8cc5c82
Getting index for pack 535070eccfdc5b080d4b38e682f66b357f3cb4bd
got 89fa6d03bc038d6210e94d7fe9fbbffdbc84d883
Getting index for pack fb9e204382bfea5b1821f19b7a9e82d0e5be8498
got 02823413987d5a10364d936327e3a1cfb38cbac2

[snip]

Getting pack 17d608d0bea63b7c5b68bccd1515e9c5ac0961c5
 which contains 859d67990a62049c2f328dfd676cf21da8ff9a27
got 1afd0c69ed823f419f52951c3c02dcc50f1a44d1
got c824d887420754f98db0553a006865d31d01cf1d
got 0b8b0ebba758871ac9c79e729664b5057128e9ac
got 18330cdcd2cda94c9c16c02d70229fa16d4aeb33
got d8e0a5b843d8c8d02df2150a05f4d9c5928596f4
got e051903352f06b0ac9ba1594cd9451baf215bdc5
error: Unable to find a2e23c928a11bf526a3c63b34c9a00a94aac6b49 under
http://www.kernel.org/pub/scm/git/git.git
Cannot obtain needed blob a2e23c928a11bf526a3c63b34c9a00a94aac6b49
while processing commit 69cd7c5f72da62a221a740c4d454b29da15186f3.
rm: cannot remove directory `c:/[path]/git2/.git/clone-tmp': Directory not empty
rm: cannot remove directory `c:/[path]/git2/.git': Directory not empty
rm: cannot remove directory `c:/[path]/git2': Directory not empty

If I try to clone it again, I get a similar, but not identical failure:
...
Getting pack 1dbb69127c8efb2534f925b7cf031b0a2428e8b4
 which contains cb4b83de1eb48d163480185da54a828c5bb20941
got f1875d3b3de72c1834867ac4d6afe5243f54513e
got 347af19febc25fd47db2d11a634c2b38dbfe2c06
got 1f405709e7341c27e20c0159fb7c17efbf85975c
got 1df4bbf7263a22a2f8c94e0d8bd1d5fbcbab2152
got 345943a26466dab73034b41698c54ca317cc4d75
got b26b4e34bdfedbe7111dea48b4e5176d10555a76
got d6c44a5ed1cd8768a30f9e0e2339bbc49e8fa57e
error: Unable to find d69b20549bf956a5c7c3f64f5315a17ec71af038 under
http://www.kernel.org/pub/scm/git/git.git
Cannot obtain needed blob d69b20549bf956a5c7c3f64f5315a17ec71af038
while processing commit d47c7c24b429eac4bacc107c0b5e2987db40f04a.
rm: cannot remove directory `c:/[path]/git2/.git/clone-tmp': Directory not empty
rm: cannot remove directory `c:/[path]/git2/.git': Directory not empty
rm: cannot remove directory `c:/[path]/git2': Directory not empty


On Sat, Jun 14, 2008 at 6:29 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Sat, Jun 14, 2008 at 02:04:25PM +0100, John Yesberg wrote:
> > Bruce,
> >
> > Sorry, missed your reply in the flood (didn't realise how busy the list
> > would be). I'll check for more details next time I'm in the office - may be
> > Wednesday.
> > Appreciate your concerns; I didn't want newbies (who might be at work) to be
> > turned off too early in their git experience. I'm sure we can come up with
> > something suitable.
>
> Sure.
>
> > I'll try to find out more about why the git config http.proxy isn't working
> > too.
>
> OK, thanks.  Sorry that I don't have more constructive suggestions, but
> I'm a bit swamped right now.... So I'll expect to hear from you next
> week and leave thinking about this till then.
>
> --b.
>
> >
> > John.
> >
> > On Wed, Jun 11, 2008 at 8:58 PM, J. Bruce Fields <bfields@fieldses.org>
> > wrote:
> >
> > > On Wed, Jun 11, 2008 at 08:48:47PM +0100, John Yesberg wrote:
> > > > ---
> > > >  Documentation/user-manual.txt |   23 +++++++++++++++++++++++
> > > >  1 files changed, 23 insertions(+), 0 deletions(-)
> > >
> > > Thanks!
> > >
> > > >
> > > > diff --git a/Documentation/user-manual.txt
> > > b/Documentation/user-manual.txt
> > > > index bfde507..02b1be0 100644
> > > > --- a/Documentation/user-manual.txt
> > > > +++ b/Documentation/user-manual.txt
> > > > @@ -56,6 +56,16 @@ $ git clone
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > > >  The initial clone may be time-consuming for a large project, but you
> > > >  will only need to clone once.
> > > >
> > > > +If there is a proxy between you and the repository you want to clone,
> > > you
> > > > +may not be able to use the git protocol. But you can use the http
> > > protocol, by
> > > > +configuring the proxy. Note that the address to access the repository
> > > via http
> > > > +may be different from the git address:
> > > > +
> > > > +------------------------------------------------
> > > > +$ export http_proxy=http://theproxy.example.com:8080
> > > > +$ git clone http://www.kernel.org/pub/scm/git/git.git
> > > > +------------------------------------------------
> > > > +
> > >
> > > Especially this early in the manual, I really want to keep the text
> > > short--we need to get to the basics as quickly as possible--even if that
> > > means leaving out some corner cases.
> > >
> > > What actually happens when you run across this case as a user?  Are
> > > there any improvements to the error reporting from "clone" that would
> > > lead the user to the right solution without needing to deal with this
> > > case here?
> > >
> > > >  The clone command creates a new directory named after the project ("git"
> > > >  or "linux-2.6" in the examples above).  After you cd into this
> > > >  directory, you will see that it contains a copy of the project files,
> > > > @@ -129,6 +139,19 @@ $ git branch
> > > >  * new
> > > >  ------------------------------------------------
> > > >
> > > > +It is possible, particularly on Windows platforms, that as you checkout
> > > > +the original version, it will in fact be modified, by the autocrlf
> > > process.
> > > > +(Windows and Unix store newlines as CRLF and LF respectively, and
> > > autocrlf
> > > > +tries to adapt intelligently.) If the checked out version is modified,
> > > then
> > > > +trying to switch to a new branch will not work, because then the
> > > uncommitted
> > > > +changes would be lost. So you may need to add the +-f+ flag to _force_
> > > these
> > > > +changes to be thrown away. Another option might be to edit
> > > +~/.gitconfig+ or
> > > > +use the following command to disable the autocrlf function.
> > > > +
> > > > +------------------------------------------------
> > > > ++git config --global core.autocrlf false
> > > > +------------------------------------------------
> > > > +
> > >
> > > Again, I'd rather not deal with this case in the main text; if we
> > > absolutely need to, a quick reference to the appropriate documentation
> > > ("note: if you see an error like XXX, see the XXX man page...") might be
> > > the thing to do.
> > >
> > > --b.
> > >
> > > >  If you decide that you'd rather see version 2.6.17, you can modify
> > > >  the current branch to point at v2.6.17 instead, with
> > > >
> > > > --
> > > > 1.5.5.1015.g9d258
> > >
