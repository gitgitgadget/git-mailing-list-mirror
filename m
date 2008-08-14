From: Mark Struberg <struberg@yahoo.de>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 22:09:12 +0000 (GMT)
Message-ID: <52593.49180.qm@web27802.mail.ukl.yahoo.com>
References: <20080814212654.GS3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTl1M-0006dg-SH
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYHNWJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYHNWJO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:09:14 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:35263 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751390AbYHNWJN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:09:13 -0400
Received: (qmail 49649 invoked by uid 60001); 14 Aug 2008 22:09:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=uZdQZibwaKCDE5xqRDIpExI7i28Vmvg8l6cULtrWAF+KJhVrIn47c1b2o9aFVDQgowLH4Vs+O9HNAkJBje1Y+otLLKHbIYOZHhukVreXyA/INIahLFeaHW9ESf5ExeHDLx9i4S9Iwu7eDDGHbt7Wfv/lA0jA8w4wUeST7HlmkNI=;
Received: from [213.162.66.179] by web27802.mail.ukl.yahoo.com via HTTP; Thu, 14 Aug 2008 22:09:12 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <20080814212654.GS3782@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92414>

Hi Shawn!

Since maven-scm should run under various OS (including Windoof) the tar=
 thingy will not work out.

The second approach is close to my original attempt to simply clone + c=
heckout + rm -rf .git, isn't?.

At least I now know that it's really unlikely that this functionality d=
oes exist yet.

txs and LieGr=FC,
strub



--- Shawn O. Pearce <spearce@spearce.org> schrieb am Do, 14.8.2008:

> Von: Shawn O. Pearce <spearce@spearce.org>
> Betreff: Re: does anything like cvs export exist in git?
> An: "Mark Struberg" <struberg@yahoo.de>
> CC: git@vger.kernel.org
> Datum: Donnerstag, 14. August 2008, 23:26
> Mark Struberg <struberg@yahoo.de> wrote:
> > I'm the initial author of the Apache
> maven-scm-providers-git and
> > I need to update our SCM-Matrix.
> >=20
> > This is just for making sure I did not oversee
> anything.
> >=20
> > I didn't came across anything like 'cvs
> export' and I do not
> > think git really needs this, since it doesn't
> pollute the working
> > directories with lots of waste like CVS and SVN does.
> >=20
> > But I just want to make sure to not build workarounds
> in our
> > scm-provider (checkout + afterwards blasting the
> GIT_DIR) for things
> > that do exist natively in git.
>=20
> You can use:
>=20
>   git archive --tar HEAD | (mkdir ../dest;cd ../dest;tar xf
> -)
>=20
> Or you can do something even more bizzare like:
>=20
>   export GIT_INDEX_FILE=3D/tmp/$$.index;
>   export GIT_WORK_TREE=3D../dest;
>   export GIT_DIR=3D.git;
>   git read-tree HEAD &&
>   git checkout-index --force --all &&
>   rm $GIT_INDEX_FILE
>=20
> --=20
> Shawn.

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
