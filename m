From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 14:22:20 +0100
Message-ID: <868wpbmlmb.fsf@lola.quinscape.zz>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
	<496EE559.3060901@viscovery.net>
	<alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
	<200901151500.01876.trast@student.ethz.ch>
	<alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
	<alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
	<7vhc40s50t.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
	<adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
	<alpine.DEB.1.00.0901161415230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 14:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoic-0002K3-VK
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933520AbZAPNZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 08:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbZAPNZG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:25:06 -0500
Received: from main.gmane.org ([80.91.229.2]:34554 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932632AbZAPNZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:25:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LNoh5-0005l8-7E
	for git@vger.kernel.org; Fri, 16 Jan 2009 13:25:03 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 13:25:03 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 13:25:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:NeabknQ3Aa0dN2YKjFKsn2tD6Gs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105957>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 16 Jan 2009, Santi B=E9jar wrote:
>
>> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >
>> > Note that this affects creating bundles with --all; I contend that=
 it=20
>> > is a good change to add the HEAD, so that cloning from such a bund=
le=20
>> > will give you a current branch.  However, I had to fix t5701 as it=
=20
>> > assumed that --all does not imply HEAD.
>>=20
>> From the description I understand that it only affects when the HEAD=
 is=20
>> detached, but in t5701 the HEAD is not detached so nothing should be=
=20
>> fixed.
>
> The error in t5701 was that it _wanted_ to test a bundle without a HE=
AD,=20
> but it actually created it with --all.  That was implying that --all =
does=20
> not mean HEAD, and I disagree with that.

I don't think that a detached HEAD should be a special case, since you
can have other detached symbolic references no longer on a branch.  Non=
e
of those should be garbage-collected either, I think.

--=20
David Kastrup
