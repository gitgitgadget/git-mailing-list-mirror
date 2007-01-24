From: Bill Lear <rael@zopyra.com>
Subject: Re: Problem with git push over <hostname>:/path protocol (ssh)
Date: Wed, 24 Jan 2007 14:40:24 -0600
Message-ID: <17847.50232.211128.994275@lisa.zopyra.com>
References: <17847.47131.694158.247941@lisa.zopyra.com>
	<Pine.LNX.4.64.0701241453410.20138@iabervon.org>
	<ep8fss$dlf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ovS-0005th-V3
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAXUke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXAXUke
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:40:34 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61499 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932600AbXAXUkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 15:40:33 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0OKeTl23984;
	Wed, 24 Jan 2007 14:40:29 -0600
In-Reply-To: <ep8fss$dlf$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37676>

On Wednesday, January 24, 2007 at 21:35:36 (+0100) Jakub Narebski write=
s:
>Daniel Barkalow wrote:
>
>>> So, if the developer then commits on his branch on machine 1, all h=
is
>>> changes get undone. =A0This has happened to him consistently --- he=
 is
>>> running git 1.4.4.1 throughout. =A0I just reproduced it using the a=
bove,
>>> and I am using 1.5.0-rc2 on machine 2, and 1.4.4.1 on machine 1.
>>=20
>> Git gets unhappy if you push into a branch that's checked out. It do=
esn't=20
>> update the index or working directory, so the state after the push l=
ooks=20
>> like the user reverted the patch in the working directory and update=
d the=20
>> index.
>
>So you usually push into _bare_ repository, or use fetch / pull instea=
d.

Well, what we want to do is have a public repo as a collaborative hub.
We would prefer this be bare.  However, there are problems with that,
at least with how we are doing things.

=46or example, if I collaborate with a peer and make a few changes,
I want to push my changes to my public repo and have an email sent
to him, and any other interested persons, when the update hook runs.

However, if I keep my private repo up-to-date with our company repo by
doing periodic pulls into it, and then push into my public repo, ALL
of the changes get noticed on the public repo side, and he gets a
flood of mail.  This also happens if I pull from my peer's repo into
my private repo, make changes, and then push to my public repo --- all
of his changes then get sent out to him again, and mine get mixed in
with his.

So, we resorted to using a non-bare public repo into which we could
pull, to avoid this mess, and it appears, actually, that we have
created a worse one.


Bill
