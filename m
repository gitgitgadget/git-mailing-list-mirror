From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 09:36:38 +0000
Message-ID: <CAPabhsKrnFq3z6wTcZny+Jh1PF-7arx_r8WyNRHmgQUu=U4sig@mail.gmail.com>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
	<1347355466-ner-6656@calvin>
	<CAPLaKK4Xm8KzQ8HcM_TbbuDr1hcLjhjSOWSyJS3jFX0toFBjsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@entel.upc.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 11:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBMtk-0004Jd-Av
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 11:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab2IKJgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 05:36:40 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64369 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab2IKJgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 05:36:39 -0400
Received: by lbbgj3 with SMTP id gj3so223316lbb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fNal4jCTz10ltjV3oWeMrC0crZ3ZA/S9MZo6zio2er8=;
        b=W4nlppdDrjppXrOJAYbHSPgTK7cboZNZdr5ayLg0XVKuOY1Wy4k+8iZ00b7OiBmNUF
         K/Uy/T2wkJyNTTiEiE7jEOzBlV9Y578VjiWZI0/NSTGVzaV+z80AigbZkIlo/AFeMz2H
         MvBd693C4NVA27Qo3i+0glfGn3BWGZVsSck2Uwe+//EmUx1twLaauXpCCsWpD/vFVkPI
         VBVhdgG0vnwbhS5r98N1oHFMp1NxfwsRI+zmqoxM+JNiqeTMVnItDTgmQUk2J8X56nHS
         JJ9HEwYxA6kg5y3myDcyLmdIefYC/zLqqjhpz2ksH1YicS0xg1tBuSSBhfmiXEXhgsDt
         uL7Q==
Received: by 10.112.101.6 with SMTP id fc6mr5898550lbb.110.1347356198244; Tue,
 11 Sep 2012 02:36:38 -0700 (PDT)
Received: by 10.114.18.163 with HTTP; Tue, 11 Sep 2012 02:36:38 -0700 (PDT)
In-Reply-To: <CAPLaKK4Xm8KzQ8HcM_TbbuDr1hcLjhjSOWSyJS3jFX0toFBjsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205212>

On Tue, Sep 11, 2012 at 9:30 AM, Roger Pau Monn=C3=A9
<roger.pau@entel.upc.edu> wrote:
> On Tue, Sep 11, 2012 at 10:24 AM, Tomas Carnecky
> <tomas.carnecky@gmail.com> wrote:
>> On Tue, 11 Sep 2012 10:21:16 +0100, Roger Pau Monn=C3=A9 <roger.pau@=
entel.upc.edu> wrote:
>>> Hello,
>>>
>>> I'm using git for all my projects, and I usually work under Mac OS =
X
>>> with the default filesystem (that's case-insensitive, but
>>> case-preserving). I'm currently working on a project that has sever=
al
>>> branches, and two of them are called origin/DHCPCD and origin/dhcpc=
d
>>> respectively, that's unfortunate, but I cannot do anything about it=
=2E
>>> This completely breaks the git repository, because
>>> .git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd a=
re
>>> actually the same file, so when I try to update my repository
>>> performing a git pull I get the following error:
>>>
>>> error: Ref refs/remotes/origin/dhcpcd is at
>>> 6b371783de2def2d6e3ec2680ba731f7086067ee but expected
>>> 79f701ce599a27043eed8343f76406014963278a
>>>
>>> So I was wondering if anyone has stumbled upon this issue, and what=
's
>>> the best approach to fix it.
>>
>> Make a disk image and format it with a case sensitive filesystem (us=
e the Disk
>> Utility to do that). Do your work there.
>
> Yes, I could also create a partition, or format my entire disk to
> case-sensitive (although I heard it might break some OS X
> applications), I guess adding a workaround for this in git itself is
> not appealing (like storing the branch file using a slightly differen=
t
> name?)

No, I'm not talking about a partition. I'm talking about a Mac OS X
disk image (eg. http://en.wikipedia.org/wiki/.dmg).
