From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Checkout of orphan branch files into mainline worktree
Date: Thu, 25 Mar 2010 12:10:20 +0100
Message-ID: <adf1fd3d1003250410w5bd79777h77e1923e5a4b19dd@mail.gmail.com>
References: <hofehl$jbn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gianluca Pacchiella <gianluca.pacchiella@ktln2.org>
X-From: git-owner@vger.kernel.org Thu Mar 25 12:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NukxW-0002EP-T7
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 12:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab0CYLKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 07:10:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:8059 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab0CYLKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 07:10:21 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1929522fgb.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 04:10:20 -0700 (PDT)
Received: by 10.102.12.13 with SMTP id 13mr10131645mul.133.1269515420223; Thu, 
	25 Mar 2010 04:10:20 -0700 (PDT)
In-Reply-To: <hofehl$jbn$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143178>

On Thu, Mar 25, 2010 at 11:39 AM, Gianluca Pacchiella
<gianluca.pacchiella@ktln2.org> wrote:
> Hi folks,
>
> I have a repository where I maintain a project for a web site with a =
branch
> (disconnected from the mainline history) that contains some files
> (necessary only for a particular instance of a site) that don't inter=
sect
> with others files in the main project. Since I don't want to use subm=
odule
> and subtree I manage myself to this sequence of commands ("deploy" is=
 the
> branch name of the mainline history and "index" of the --orphan branc=
h) to
> checkout the index's files into the mainline files
>
> git read-tree index && ( git ls-files --with-tree=3Dindex | git
> checkout-index --stdin ) && git read-tree deploy
>
> Are there some other ways to do this? I'm crazy? are there side effec=
ts?

I don=B4t know if this is a good idea in general, but you could get the
same result with:

git merge --no-commit index &&
git reset deploy

HTH,
Santi

>
> Thanks,
> =A0 =A0 =A0 =A0Gianluca
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
