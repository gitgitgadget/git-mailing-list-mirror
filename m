From: Jerome Yanga <jerome.yanga@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Fri, 30 Mar 2012 11:23:02 -0700
Message-ID: <CAC0z1F8jZDr=E9wSGGwd9Ar=5S=DeLJrtZWcPdMRS3OdS1Ozuw@mail.gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
	<4F567DC6.4070903@gmail.com>
	<4F567FEF.5000105@gmail.com>
	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>
	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
	<CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
	<4F569EA8.4050907@gmail.com>
	<CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
	<4F56C946.8080601@gmail.com>
	<4F5740AD.9080306@ira.uka.de>
	<CAC0z1F_hvqmWO5k-3KCbGaEDBf_iadKaqPg0tj3iCrCar2mJ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDgTd-0002NF-H7
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 20:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759626Ab2C3SXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Mar 2012 14:23:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37716 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758946Ab2C3SXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2012 14:23:02 -0400
Received: by vcqp1 with SMTP id p1so554002vcq.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2IkRmNTEIC5M6XF1us5zX6R37dqJcEmiX5xj5sUITKA=;
        b=qurbh59pl4U9isZae4CZAL9uHxks1k9fQMqVn34PbEVBSlcr47EaiIWDJ8VLZe6Bs2
         moC8Mr9mAFhMq1ByhZdDuKJnPeL3aX7lMBWUxka1DCKMhY+lQau3fTOKxAUSsjHGTJ59
         CityWMwPHOeS3F/TrPNat5h25+1j8cmIC1SPHi4Red7vXiUOIWfcA30ZNU6exWRe+SIe
         xJP1hARPqxgvyvnH2Hf1xHeVjZBjVSohnY0h+ysTdQlqc74ZDqkCsMY0r+cFrKdOLjE+
         cWc8GXcmEuetikCZhoXsjha0SYzqncxyjEgFb0Apickd2zw158zxRH5K6kbHMiXx/BjK
         7YyQ==
Received: by 10.52.27.1 with SMTP id p1mr1384131vdg.17.1333131782195; Fri, 30
 Mar 2012 11:23:02 -0700 (PDT)
Received: by 10.220.178.198 with HTTP; Fri, 30 Mar 2012 11:23:02 -0700 (PDT)
In-Reply-To: <CAC0z1F_hvqmWO5k-3KCbGaEDBf_iadKaqPg0tj3iCrCar2mJ=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194385>

I finally got the chance to implement your suggestions.  I have
combined them and am very happy with the outcome.  The missing pieces
for being able to push via Apache are as follows:

01)  git config --global http.receivepack true (thanks Junio...found
this under githooks)
02)  chown -R apache:apache /var/www/git

On the other hand, I have also implemented a non-bare repo for testing
(thanks Neal and Holger) by cloning the bare repo.

I hope that this helps another.  ;)

Regards,
j

On Wed, Mar 7, 2012 at 7:43 AM, Jerome Yanga <jerome.yanga@gmail.com> w=
rote:
> Thank you all for the recommendations. =A0I will try them.
>
> I would like to confirm some info.
>
> Junio,
>
> Your assumption of my setup correct. =A0I shall read on post-update
> hook. =A0If you have a recommended link for it, please share it.
>
> Neal,
>
> You are also correct. =A0My current configuration's reaction to a pus=
h
> shows that the bare repo that was cloned from a non-bare repo are
> independent of each other. =A0I will also try your recommendation.
>
> Holger,
>
> Thank you for explaining what Neal meant.
>
> Regards,
> j
>
> On Wed, Mar 7, 2012 at 3:04 AM, Holger Hellmuth <hellmuth@ira.uka.de>=
 wrote:
>> On 07.03.2012 03:34, Neal Kreitzinger wrote:
>>>
>>> Create a new non-bare clone of your bare repo. Then do git-pull on =
the
>>> new non-bare after the bare gets updates (someone does git push to =
it)
>>> and you want to test those new commits. The worktree of the new non=
-bare
>>> clone can be the document root of your testing virtual host, if tha=
t's
>>> what you're doing. That way, you know that no one else is messing w=
ith
>>> new non-bare (test repo) like doing development in it and messing u=
p
>>> your tests.
>>
>>
>> To expand on Neals method, if you do git fetch (periodically in a cr=
on job
>> for example) on the cloned non-bare, 'git log HEAD..origin/HEAD' wil=
l have
>> output only if the non-bare has new commits.
>>
>>
