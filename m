From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git bisect Vs branch
Date: Thu, 22 Oct 2009 18:50:30 +0200
Message-ID: <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com>
References: <4AE07EEB.2010101@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?B?R3LpZ29yeSBSb23p?= <gregory.rome@maxim-ic.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N10rz-0003at-VD
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbZJVQu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZJVQu0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 12:50:26 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:55979 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044AbZJVQuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 12:50:25 -0400
Received: by pwj1 with SMTP id 1so1536719pwj.21
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 09:50:30 -0700 (PDT)
Received: by 10.115.98.40 with SMTP id a40mr6552007wam.97.1256230230355; Thu, 
	22 Oct 2009 09:50:30 -0700 (PDT)
In-Reply-To: <4AE07EEB.2010101@maxim-ic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131032>

On Thu, Oct 22, 2009 at 5:48 PM, Gr=E9gory Rom=E9 <gregory.rome@maxim-i=
c.com> wrote:
> Considering the following story what is the method to find the regres=
sion
> with bisect?
>
> I cloned a git repository (origin) which derives from another one
> (first-origin). A merge is done from first-origin to origin at each s=
table
> release (identified by a tag).
>
> first-origin/master =A0*---A---------B-----------------------C-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 \ =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> origin/master =A0 =A0 =A0 =A0 =A0 =A0 =A0----------B'----------U-----=
------C'-
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \ =A0 =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 \ =A0 master
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------------U'---=
-------C''-
>
> Now, after that I merged C' I fixed the conflicts and compiled withou=
t error
> but I have a regression. It could come from any commit between B and =
C or U
> and C', and I need to modify my code to correct the issue.
>
> I would like to find the commit which introduce this regression by us=
ing git
> bisect but as the history is not linear it is not so easy (1). It tho=
ugh to
> create a linear history but I have no idea how to proceed...

You just have to proceed as normal, but you may test more commits than
with a linear history.

The only problem is iff the culprit is a merge commit (as in the
user-manual chapter you linked). And the "problem" is to know where
exactly in the (merge) commit is the bug, but not the procedure.

HTH,
Santi
