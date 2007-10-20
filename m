From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 13:15:19 +0200
Message-ID: <87ACA689-CBBD-4E6D-9BAD-B3BBA8391DB9@wincent.com>
References: <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org> <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjCJV-0006Ke-TV
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbXJTLQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2007 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXJTLQG
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:16:06 -0400
Received: from wincent.com ([72.3.236.74]:33014 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbXJTLQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2007 07:16:05 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9KBG0Cf014900;
	Sat, 20 Oct 2007 06:16:01 -0500
In-Reply-To: <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61823>

El 20/10/2007, a las 8:45, Michael Witten escribi=F3:

> On 20 Oct 2007, at 2:36:28 AM, Shawn O. Pearce wrote:
>
>> Today I move the file, then unstage the hunks I'm not sure about,
>> then go back and restage them.  Annoying.  It really disrupts
>> my workflow.
>
> I know it's against policy, but the proposed change should be set
> as the default at some point, in my opinion.

I think the issue here is that git-mv as it is currently implemented =20
really conflates two things:

1. Renaming a file in the traditional "mv" sense
2. Staging the entire contents of the file in the index, ready or not

So it's kind of like the command were called git-mv-and-add or git-=20
rename-and-add. And given that the index as a staging area is such a =20
central content in Git, users often want to have more control over =20
what gets added to the index than that; ie. "I really just wanted to =20
rename the file, and leave the staging of modifications to the =20
content up to me".

Cheers,
Wincent
