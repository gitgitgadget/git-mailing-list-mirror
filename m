From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 18:12:30 +0200
Organization: eudaptics software gmbh
Message-ID: <46CB0EEE.D46769FE@eudaptics.com>
References: <20070810031949.19791.54562.stgit@yoghurt> <20070810032318.19791.70483.stgit@yoghurt> <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com> <20070821155845.GA16221@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 18:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INWKZ-0004pK-Ec
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 18:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759895AbXHUQLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760202AbXHUQLo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 12:11:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36764 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759697AbXHUQLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 12:11:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1INWKT-00044Q-Q0; Tue, 21 Aug 2007 18:11:42 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 587BB546; Tue, 21 Aug 2007 18:11:41 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.374, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56304>

Karl Hasselstr=F6m wrote:
> On 2007-08-21 14:23:29 +0100, Catalin Marinas wrote:
> > On 10/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > > @@ -294,14 +301,16 @@ def set_head_file(ref):
> > >      # head cache flushing is needed since we might have a differ=
ent value
> > >      # in the new head
> > >      __clear_head_cache()
> > > -    if __run('git-symbolic-ref HEAD',
> > > -             [os.path.join('refs', 'heads', ref)]) !=3D 0:
> > > +    if __run('git-symbolic-ref HEAD', ['refs/heads/%s' % ref]) !=
=3D 0:
> > >          raise GitException, 'Could not set head to "%s"' % ref
> >
> > Why replacing os.path.join with a single string? I think the former
> > is more portable if, in the future, someone will try to run StGIT o=
n
> > Windows (and GIT would be compiled directly, without cygwin).
>=20
> Yes, that's the case iff it is a pathname in the file system. But I
> think forward slashes are used even on Windows in this case --
> otherwise too mmuch configuration would have to be changed. This is
> what I _think_, however; I haven't actually checked.

There are some instances where the MinGW port accepts backslashes in re=
f
names, but you are on the safe side with forward slashes.

-- Hannes
