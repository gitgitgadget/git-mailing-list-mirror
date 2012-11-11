From: Jason Timrod <jtimrod@yahoo.com>
Subject: git log to use .mailmap by default?
Date: Sun, 11 Nov 2012 04:13:19 -0800 (PST)
Message-ID: <1352635999.79618.YahooMailNeo@web160306.mail.bf1.yahoo.com>
Reply-To: Jason Timrod <jtimrod@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWPv-0006Iz-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab2KKMNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 07:13:21 -0500
Received: from nm16-vm0.bullet.mail.bf1.yahoo.com ([98.139.212.253]:28044 "EHLO
	nm16-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab2KKMNU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:13:20 -0500
Received: from [98.139.212.152] by nm16.bullet.mail.bf1.yahoo.com with NNFMP; 11 Nov 2012 12:13:19 -0000
Received: from [98.139.212.195] by tm9.bullet.mail.bf1.yahoo.com with NNFMP; 11 Nov 2012 12:13:19 -0000
Received: from [127.0.0.1] by omp1004.mail.bf1.yahoo.com with NNFMP; 11 Nov 2012 12:13:19 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 535723.14478.bm@omp1004.mail.bf1.yahoo.com
Received: (qmail 71724 invoked by uid 60001); 11 Nov 2012 12:13:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1352635999; bh=Qd+YSxjMTGtt2bx3CMDxKqFxaj09BKSYKZy1ySJFMQU=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=z4gKQZF94365X3FlEk4DnEzcggnKwdrqmct+Vzh8bIqG6qJ4m0QyhnuSzgrTdn6HHA8YoXzsZ4zCRbeiTbcadB51bzaK6jBLgMw/u2jTyKx28cb8uOyVUm6rQ9slLFs++XRb1lNE1FABR42kv3ZqZAnMfEI7jtrUM37hIEBN+mU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qsrnwNGFBLkry8fXA31YjmUOr/I3RHUoWbiys1iucTjC1cWmbqfsz/D2hNpB/rapkbP3qO6kivPNZDAkxIIJXRNvmBu5xAI1qUuhXN1SMWoj7gXSooKxYMQPdEExrjsBlBWKt0Od//rzU0yLbfKSo4EF3HTYwsjvRlbBkgFYIFI=;
X-YMail-OSG: mtWepAkVM1l612yWtzspnQhJo8aEKmbVEPY.5R4SXsPcIPE
 jPRt116qNMzLSN6RxadV0FFaT82ag6VyRejmbfT_uOEQKDNmDjQTxbaDEbbq
 3bB06mV5CHlukT5T4CWqh_me4Sxe59Fn4F.PNKC0GmeF15J7x3tPlQEusDI9
 MRo2dgHOzEoQz7asEaeksF70pRArJI2M.I8LHt7HxdjMhdfqdUYu7DlAQJdL
 DHfXKF0vcGe4zcPja7UrolsmLPdhyn3v.lKCnYO6kpSBrVhz6qrxhzKJRghy
 ppC.VU16fnrO62taJkJHFpVc4BaELkZIltqJo4LuSfQ5la334MY5Y5UIDbcv
 9TYsisduec3BtGVTBHo_uF80s04iE4gTNj0caSyNUfk4Dwo33w3C20Eq1DO0
 gAqWqpO9wqNOBigh7Wz9HhcZSvc7WrwI2nFU_FlY-
Received: from [213.104.227.168] by web160306.mail.bf1.yahoo.com via HTTP; Sun, 11 Nov 2012 04:13:19 PST
X-Rocket-MIMEInfo: 001.001,SGksCgpJIG5vdGUgdGhhdCB3aGVuIGRlZmluaW5nIGEgLm1haWxtYXAgZmlsZSwgdGhhdCBpdCdzIGhvbm91cmVkIGJ5IGdpdC1zaG90bG9nKDEpIGJ5IGRlZmF1bHQsIGJ1dCBmb3IgZ2l0LWxvZygxKSBJIGhhdmUgdG8gZGVmaW5lIGFuIGVudGlyZWx5IG5ldyAtLXByZXR0eT0gZm9ybWF0dGluZyBvcHRpb24gdG8gdXNlIGl0LgoKV2h5IGlzIHRoaXM_IMKgV2h5IGRvZXNuJ3QgZ2l0LWxvZyBob25vdXIgdGhpcyBieSBkZWZhdWx0IGxpa2UgZ2l0LXNob3J0bG9nIGRvZXM_CgpXb3VsZCB0aGVyZSBiZSBhIHcBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.123.460
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209344>

Hi,

I note that when defining a .mailmap file, that it's honoured by git-sh=
otlog(1) by default, but for git-log(1) I have to define an entirely ne=
w --pretty=3D formatting option to use it.

Why is this? =A0Why doesn't git-log honour this by default like git-sho=
rtlog does?

Would there be a way of making .mailmap be the default without needing =
a pretty option each time to redefine the default?

TIA!

Jason
