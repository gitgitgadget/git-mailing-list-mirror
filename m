From: zhifeng hu <zf@ancientrocklab.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 16:55:17 +0800
Message-ID: <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com> <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
	<vnwildman@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 09:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlxNm-000219-5t
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 09:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab3K1Iza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 03:55:30 -0500
Received: from imap1.ox.registrar-servers.com ([198.187.29.233]:37303 "EHLO
	imap1.ox.registrar-servers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884Ab3K1Iz3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 03:55:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by oxmail.registrar-servers.com (Postfix) with ESMTP id 33D49200089;
	Thu, 28 Nov 2013 03:55:29 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap1.ox.registrar-servers.com
Received: from oxmail.registrar-servers.com ([127.0.0.1])
	by localhost (imap1.ox.registrar-servers.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bYmETKyKSBJT; Thu, 28 Nov 2013 03:55:29 -0500 (EST)
Received: from [192.168.1.101] (unknown [119.98.73.69])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by oxmail.registrar-servers.com (Postfix) with ESMTPSA id 326D3200081;
	Thu, 28 Nov 2013 03:55:25 -0500 (EST)
In-Reply-To: <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238482>

The repository growing fast, things get harder . Now the size reach sev=
eral GB, it may possible be TB, YB.
When then, How do we handle this?
If the transfer broken, and it can not be resume transfer, waste time a=
nd waste bandwidth.

Git should be better support resume transfer.
It now seems not doing better it=92s job.
Share code, manage code, transfer code, what would it be a VCS we imagi=
ne it ?
=20
zhifeng hu=20



On Nov 28, 2013, at 4:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:

> On Thu, Nov 28, 2013 at 3:35 PM, Karsten Blees <karsten.blees@gmail.c=
om> wrote:
>> Or simply download the individual files (via ftp/http) and clone loc=
ally:
>>=20
>>> wget -r ftp://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/
>>> git clone git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
>>> cd linux
>>> git remote set-url origin git://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>=20
> Yeah I didn't realize it is published over dumb http too. You may nee=
d
> to be careful with this though because it's not atomic and you may ge=
t
> refs that point nowhere because you're already done with "pack"
> directory when you come to fetcing "refs" and did not see new packs..=
=2E
> If dumb commit walker supports resume (I don't know) then it'll be
> safer to do
>=20
> git clone http://git.kernel.org/....
>=20
> If it does not support resume, I don't think it's hard to do.
> --=20
> Duy
