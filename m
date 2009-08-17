From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 07:18:15 +0200
Message-ID: <200908170718.15423.thomas.schlichter@web.de>
References: <200908161557.26962.thomas.schlichter@web.de> <200908161652.37282.thomas.schlichter@web.de> <be6fef0d0908162152o54206acfge43f6ffa012bb307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:18:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcubz-0006fe-7a
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 07:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbZHQFST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 01:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbZHQFST
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 01:18:19 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33354 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQFSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 01:18:18 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id BE2FF10D944FC;
	Mon, 17 Aug 2009 07:18:18 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Mcubq-0007pB-00; Mon, 17 Aug 2009 07:18:18 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <be6fef0d0908162152o54206acfge43f6ffa012bb307@mail.gmail.com>
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX19If97gWISr5lYRH/NYJNF8E+0uGQo75/Vw1NHr
	0FGsb3ITaG+m6NOqhQW2c5FYKepQwhdh/EIW+vToO01fTs11UV
	F9ryVyt8u8C15HqQ4OSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126118>

Hi,

Am Montag 17 August 2009 06:52:32 schrieb Tay Ray Chuan:
> Hi,
>
> On Sun, Aug 16, 2009 at 10:52 PM, Thomas
>
> Schlichter<thomas.schlichter@web.de> wrote:
> > Steps to reproduce:
>
> before I try this out, I have a few queries:
> >  1. locally set up a git archive:
> >     mkdir dummy.git
> >     cd dummy.git
> >     git init --bare
> >  2. Upload this directory to the server.
> >     I did do this using KDE's dolphin via WebDAV.
> >  3. Clone this remote repository:
> >     git clone https://webdav.smartdrive.web.de/dummy.git my_dummy
>
> You didn't run git update-server-info before doing the clone; cloning
> wouldn't work cos git can't find a info/refs file. Perhaps you did do
> it and unintentionally left it out from your procedure listed here?

Oh, yes, sorry.
I did run it but unintentionally left it out. At least I had no problem with 
clone, it did clone an "empty repository" without a problem. Even during 
bisecting, I never had a problem with pulling from the server, only with 
pushing to it.

> >  4. Create a local commit:
> >     cd my_dummy
> >     touch dummy.c
> >     git commit -a
>
> I assume you want to commit dummy.c?

Yes, indeed...

> But you didn't tell git to track
> it in the first place (git add dummy.c).

I think that was not neccessary,  the parameter "-a" should do it for me...

> >  5. Push this commit up to the remote repository:
> >     git push origin master
>
> I also find it strange that git only pushed 1 object from your git
> push output, when usually there would be a tree, a blob and a commit
> to push for a new commit.

Yes, most of the times git tries to push three objects, and fails with all 
three. As I wrote, during bisecting I was able to commit several times. The 
reported message was the last one failing. Unfortunately git only needed to 
push one object that time. I didn't think it was important if it were three or 
just one object?!

Kind regards,
Thomas Schlichter
