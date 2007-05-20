From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Sun, 20 May 2007 22:02:29 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0705202158580.3133@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
 <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
 <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
 <20070520124345.GB27087@efreet.light.src>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243703-1265548334-1179687749=:3133"
Cc: David Kastrup <dak@gnu.org>, Paolo Teti <paolo.teti@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 20 21:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpqg7-00088D-9a
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbXETTCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755749AbXETTCc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:02:32 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40471 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065AbXETTCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:02:31 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Sun, 20 May 2007 22:02:29 +0300
  id 0005BDFF.46509B45.00003891
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id 66C4DEBAE4; Sun, 20 May 2007 22:02:29 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id 54A21EAE3F;
	Sun, 20 May 2007 22:02:29 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
In-Reply-To: <20070520124345.GB27087@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47889>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1265548334-1179687749=:3133
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 20 May 2007, Jan Hudec wrote:

> On Fri, May 18, 2007 at 17:02:56 +0300, Ilpo Järvinen wrote:
> > David Kastrup <dak@gnu.org> wrote:
> > 
> > > Only if size_t is a larger type than int (could be on x86-64 and alpha
> > > architectures).  Other than that, this comparison would work.  Which
> > > does not mean that this does not warrant fixing, but it is not
> > > necessarily the cause of this problem.
> > 
> > ...sizeof(size_t) == sizeof(int) should hold...
> 
> Really?
> 
> $ cat test.c
> #include <stdio.h>
> int main(void)
> {
>     printf("sizeof(int) = %i\n", sizeof(int));
>     printf("sizeof(long) = %i\n", sizeof(long));
>     printf("sizeof(size_t) = %i\n", sizeof(size_t));
>     return 0;
> }
> $ gcc -otest test.c
> $ ./test
> sizeof(int) = 4
> sizeof(long) = 8
> sizeof(size_t) = 8
> 
> Hm, it does not seem that sizeof(size_t) == sizeof(int).

...On 64-bit perhaps but mine isn't one of them... I'm sorry if my 
wording was misleading, I meant to say that on my system the equality 
of sizeof()s should hold... :-)

> $ uname -m
> x86_64
> 
> Yes, this is a 64-bit system.

ijjarvin@kivilampi-30:~/src/testsize$ ./main
sizeof(int) = 4
sizeof(long) = 4
sizeof(size_t) = 4

$ uname -m
i686


-- 
 i.
---696243703-1265548334-1179687749=:3133--
