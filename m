From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-svn taking a long time
Date: Wed, 10 Feb 2010 23:25:11 +0100
Message-ID: <873a18pw3c.fsf@krank.kagedal.org>
References: <87hbppp8k7.fsf@krank.kagedal.org>
	<6D721095-7A04-4097-8D86-1A2B915182DF@apple.com>
	<87bpfxov6w.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKzt-0003Bs-GD
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab0BJWZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 17:25:19 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:55963 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0BJWZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:25:18 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 88A0240019;
	Wed, 10 Feb 2010 23:23:31 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 7E40C40032; Wed, 10 Feb 2010 23:23:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 49A4B40019;
	Wed, 10 Feb 2010 23:23:31 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 9E52B60F47; Wed, 10 Feb 2010 23:25:11 +0100 (CET)
In-Reply-To: <87bpfxov6w.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of
	"Wed, 10 Feb 2010 18:29:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139562>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Andrew Myrick <amyrick@apple.com> writes:
>
>> Give 1.7.0-rc2 a try.  It includes commit 8bff7c5383ed833bd1df9c8d85=
c00a27af3e5b02, which attempts to persistently cache a lot of the proce=
ssing that git-svn has to do on subversion's merge tickets, which has i=
mproved my fetch times significantly. =20
>
> By "merge tickets", are you talking about the merge functionality tha=
t
> appeared in subversion 1.5? We don't use that.
>
> But I had another idea. I pecularity of our subversion repo is that w=
e
> no longer use the foo/trunk branch, but only foo/branches/*. But we d=
id
> once upon a time have a foo/trunk. And since I didn't include a "fetc=
h =3D
> foo/trunk:refs/remotes/svn/trunk" in my config, it might need to refe=
tch
> that information every time. For instance, the first revision is on
> trunk.
>
> I'm rerunning the fetch now with the trunk added, so see if it helps.

That seems to have done the trick. Now it's quick when there is nothing
to do.

Perhaps there is something in the git-svn caching that could still be
improved?

--=20
David K=C3=A5gedal
