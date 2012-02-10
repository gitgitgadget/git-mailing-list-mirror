From: Sam Vilain <sam@vilain.net>
Subject: Re: git svn problem
Date: Fri, 10 Feb 2012 13:21:23 -0800
Message-ID: <4F358A53.8010409@vilain.net>
References: <CAPqC6xRtZXwv+U6AKRUXDz=m-G4AjgWksbwqeMD_qzS8YC=DoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Serhat Sevki Dincer <jfcgauss@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvxuK-0000iE-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760193Ab2BJVVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:21:24 -0500
Received: from uk.vilain.net ([92.48.122.123]:36376 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759174Ab2BJVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:21:24 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 63FDB8274; Fri, 10 Feb 2012 21:21:23 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 59205822F;
	Fri, 10 Feb 2012 21:21:21 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CAPqC6xRtZXwv+U6AKRUXDz=m-G4AjgWksbwqeMD_qzS8YC=DoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190456>

On 2/10/12 10:15 AM, Serhat Sevki Dincer wrote:
> Hi,
>
> I am using git-svn (1.7.4.1-3 on ubuntu) to get a project. It has two
> svn repositories, apparently disjoint. First half is at
> http://svn.plone.org/svn/plone/plone.app.locales, and the continuatio=
n
> at http://svn.plone.org/svn/collective/plone.app.locales
> How can i get a nice linear git-svn repository? the second one is the
> new location of the project. I am only interested in the trunks btw.

Import them separately to different git-svn remotes, and once they are=20
in the same repository you can graft them together using=20
=2Egit/info/grafts (see man gitrepository-layout).  Once it looks right=
=20
(check using 'gitk' etc), make it permanent using git filter-branch.=20
You'll also want to remove the .git/svn directory, and re=E2=80=93run '=
git svn=20
fetch' so that git svn's revision database is recomputed.  Don't forget=
=20
the -A option to 'git svn fetch'!

Good luck,
Sam
