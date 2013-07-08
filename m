From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Mon, 8 Jul 2013 15:03:32 +0100
Message-ID: <CAHCaCkJDWTKQk4SrspXVCsCoHStRTaR_PSEgkvqwWHdmiLuY2w@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
	<CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
	<CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
	<CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com>
	<CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
	<CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
	<CAHCaCkL6p2ha-8yj4x0G5NodwSdupftCDO4Rst0WTLBRdK2PcA@mail.gmail.com>
	<CAHCaCkJ1rTj3xt4_rHEYTWzRbSDVnULwfkTggevn+qjLj_UC5A@mail.gmail.com>
	<CAOpHH-WxOhfYYOY8z5rc+O1B5QD8g22L9DFrNFEAtp9YwH+V_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 16:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwC2U-0007FD-4f
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 16:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3GHODe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 10:03:34 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:59950 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHODd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 10:03:33 -0400
Received: by mail-oa0-f49.google.com with SMTP id n9so6265926oag.22
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kmYEt26vMj7pLxy6G6reptW9zcCIwPHzm6RbxEEH0c8=;
        b=IUAb5JCEUY5Q5/ldznAtamkG41k0U4p3sfDNfY6IqJGwtxkcbQfn6Rvkg9EkOVtrB8
         RZJTorIlt8IzIcAb1xolw5lcMXd5tNWE/BVqx5cLIPLPJoaw4q7GgMOYNcN9okumHXJy
         NtEFHCeCFtRrqHMPUvPNjpiVJk4izQTNehrNPPWsjY9a+v+rTttI6h1O+I4/eENrscWJ
         ax8xhC0TbLL6Navj1guhTIYBQ5ZR6e02PWplQ5D+0iGaP4uXKayuczKTT64C2RRH+GF2
         rmjsyq3CexkswE521xzfFeg1wN8xNrEfFthhYLKJhrc/IS0I2wXcbwA/wyuKu4dj1QVL
         h9Yw==
X-Received: by 10.182.153.72 with SMTP id ve8mr20539110obb.39.1373292212951;
 Mon, 08 Jul 2013 07:03:32 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Mon, 8 Jul 2013 07:03:32 -0700 (PDT)
In-Reply-To: <CAOpHH-WxOhfYYOY8z5rc+O1B5QD8g22L9DFrNFEAtp9YwH+V_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229858>

Hi,

I tried without spec, but then it tried importing everything, even
though there was a .gitignore and a .git/config/exclude file.
Then, it crashed during the importation because it could find an old
branch (I don't have access to everything on the repository), so I
tried importing just the recent past, but then it failed because it
identified a branch names Branch/Main/src...
It is starting to feel as if I will have to compromise between
something that works but without branches and without the proper names
(the files are named Project/Branch/Main/...) or having the proper
names, but with all binaries, bogus branches...
I know it is not due to git, it is mainly that Perforce and git have
very different workflows. Or perhaps with any luck, the server is up
to date, and I can find a way of using Perforce's bridge.

Thanks,

Matthieu



2013/7/8 Vitor Antunes <vitor.hda@gmail.com>:
> On Mon, Jul 8, 2013 at 12:10 PM, Matthieu Brucher
> <matthieu.brucher@gmail.com> wrote:
>> Without the spec client, it seems that the branches are recognized,
>> but there are some many binary files that I need to remove them during
>> the migration.
>> I tried setting a .gitignore beforehand, but it is not respected (I
>> tried to remove some folders with folder/ in .gitignore, but the
>> folder are still imported).
>> It there a switch for the import somewhere?
>
> Hi Matthieu,
>
> Unfortunately I've never tested the branch detection together with spec
> configuration. But there is a test case for it in the code that refers
> to the following question in StackOverflow:
>
> http://stackoverflow.com/questions/11893688
>
> Could you also tell us which version of git you are using?
>
> Pete, maybe you can help Matthieu further on this question?
>
> Thanks,
> Vitor



-- 
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/
