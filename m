From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git grep '(' = segfault
Date: Mon, 27 Apr 2009 11:50:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904271149480.22156@localhost.localdomain>
References: <37fcd2780904271046r7740ed42t3c9438e7aa93374@mail.gmail.com>  <alpine.LFD.2.00.0904271059060.22156@localhost.localdomain> <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyVwk-00068E-UC
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbZD0Sw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757585AbZD0Sw2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:52:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56274 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536AbZD0Sw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 14:52:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RIodC1010862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Apr 2009 11:51:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3RIocjQ027426;
	Mon, 27 Apr 2009 11:50:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <40aa078e0904271142u71d7ba97w9df80667c0d9b955@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.456 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117705>



On Mon, 27 Apr 2009, Erik Faye-Lund wrote:
> On Mon, Apr 27, 2009 at 8:10 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Something like this should fix it.
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>=20
> (Sorry that you're getting this mail twice, Linus - I forgot to reply=
 all)

Payback time. Now _you'll_ get it twice. Mmmwwhahahahaahaaa!

> $ git grep '('
> fatal: unmatched parenthesis

Try this:

        git grep -e '('

because 'git grep' actually allows multiple patterns, so you can do thi=
ngs=20
like

        git grep '(' -e hello --or -e 'hi there' ')' --and -e world

Practical? Maybe.

                Linus
