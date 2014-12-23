From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Question about installing git from source
Date: Tue, 23 Dec 2014 23:53:27 +0600
Message-ID: <CANCZXo4q-TwH8WyqP1GYcUY-obWG1HAt8gSEs7jy5TJiUDG0HA@mail.gmail.com>
References: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
	<xmqqioh247th.fsf@gitster.dls.corp.google.com>
	<CANCZXo4daZffQ7binFpHBy9adKKeuwHuR5VRixXUowMdgAdhTQ@mail.gmail.com>
	<xmqq1tnq45yk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:53:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3TeH-0007pV-8d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbaLWRx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 12:53:28 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42539 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbaLWRx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 12:53:28 -0500
Received: by mail-oi0-f53.google.com with SMTP id g201so14641008oib.12
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r5lewZ3WlmRmlRRjsE6CUbgzT9HFOLPnCLu25DtVPRY=;
        b=m0ggm1NfLm0YpMqxxti+W8ss8y+7++OMUDv4uK+eVrDWpE70jfywgj5efZe4xgPN/n
         TTrwJZRJdELtUx3A45Jspb7WrOBCKC6lMkHFks4dNL9/Vxwv5gM9mzNM8F+2aTY+3zMj
         PMAEXA6gexk4eDci+ofe2hdCuIgkYij8avCI5Y9Eji5IRI3/9jZN6vkbKp7d8AKFrjfD
         md+avFzLPrFTO+Uo+b8QpDhiNInhSWCOtL0hOQJ03K7KSigPh/S7W8LQaf3eQlmwSZP+
         kA+6MLr2X9xCVbzGOE6e18r9BibnzK2Msn3HAO/w+eYsbvOd2FSlPdNg/7cN/aS68hJk
         S2Yg==
X-Received: by 10.202.226.70 with SMTP id z67mr16346993oig.95.1419357207504;
 Tue, 23 Dec 2014 09:53:27 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 23 Dec 2014 09:53:27 -0800 (PST)
In-Reply-To: <xmqq1tnq45yk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261749>

I looked at Makefile, and seems that it occurs from here:
https://github.com/git/git/blob/master/Makefile#L2205

It tries to copy all files/folders from git root directory but
'install' command prints this error. I tried to execute 'sudo install
-d -m 755' in other directory and if there is directory too it prints
the same error. For example:

~/scripts $ ls
addPPA    cleanMailTrash  git-autor    git-ranges       git-tp
            install     scripts    ssh-live       term-help  tp-git
    updateMail  xray-start
buildGit  deployWork      git-install  git-remove-tags
git-update-commit-message  install.sh  ssh-build  ssh-wiwob-lab  test
     updateGitDev  updateNews

test - is directory here

~/scripts $ sudo install -d -m 755 .
Copying scripts to /usr/bin
cp: omitting directory =E2=80=98test=E2=80=99
Done

2014-12-23 23:43 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> install -d -m 755 '/usr/bin'
>> Copying scripts to /usr/bin
>
> As 'git grep "Copying scripts"' gives us nothing, the message is
> obviously not what we are giving.  Perhaps you have a strange "instal=
l"
> in your path that does not understand "-d" is a way to tell it to
> make sure a directory exists (by creating one as necessary)?
>



--=20
_________________________
0xAX
