From: Michal Stasa <michal.stasa@gmail.com>
Subject: Re: [Bug] - Processing commit message after amend
Date: Fri, 16 May 2014 12:34:25 +0200
Message-ID: <CALy3b+mmc-67pkS_bG=4Uwg2g37NGPdebMvpP7uEv78f5fxaCw@mail.gmail.com>
References: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
	<CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFTC-0005dt-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbaEPKe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 06:34:27 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:57412 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbaEPKe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 06:34:26 -0400
Received: by mail-vc0-f180.google.com with SMTP id hy4so5814091vcb.25
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pcwQ+1cv6LPkCoYsIrqD7oXpWuWM1sQu46Q9qPD+GXw=;
        b=qjSBR44r+3dN3JlVOCsUAkVO0QA9lBXxjKdOBKvQCY2cwoEmeQRzhr27/9jjYGKMnh
         /UkWd4i8j6dlY9Jy5kf3nq9hChkeX2QmC0K5SsXGV2Fsm9rOFOMirVhJq7B4Mbe5qF9r
         7GJ/Y4HLYdWp1flw/ozs9PdfupyzUqSPv5IC2e15/ccTZzsp99kiQKfSb26cQKOque5W
         UcneRu/5gQ10N4AdwToTFaUQrFc+v0hV0bt3zSSmz6a/Sga3mxuRtG5xhijXqyKfzo1h
         zENB4vKJAnEaKTRojf0ZHBKeNv9sGPZCKhhtUA0LvJjjFI9PJsBkRiX07gjnLrzIK8Qb
         YxaQ==
X-Received: by 10.52.13.41 with SMTP id e9mr11344518vdc.21.1400236465171; Fri,
 16 May 2014 03:34:25 -0700 (PDT)
Received: by 10.58.37.97 with HTTP; Fri, 16 May 2014 03:34:25 -0700 (PDT)
In-Reply-To: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249294>

It sounds like a good workaround but I think there could be a problem.
When vim opens there is the message on the first line and two lines
below is a commented text which uses # as comment char. Does the char
change when you change the comment char?
Michal Sta=C5=A1a

Santhos.net
www.santhos.net

+420 773 454 793
michal.stasa@santhos.net


On 16 May 2014 12:28, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, May 16, 2014 at 5:18 PM, Michal Stasa <michal.stasa@gmail.com=
> wrote:
>> Hi,
>>
>> I have stumbled on a weird bug. At work, we use redmine as an issue
>> tracker and its task are marked by a number starting with #. When I
>> commit some work and write #1234 in the message, it works. However,
>> later on when I remember that I forgot to add some files and amend t=
he
>> commit, vim appears and I cannot perform the commit because the
>> message starts with # which is a comment in vim and thus I get an
>> error that my commit message is empty.
>
> A workaround would be "git -c core.commentChar=3D@ <command> ..." (@
> could be some other character). But maybe git should detect that the
> current commit message has leading '#' and automatically switch to
> another character..
> --
> Duy
