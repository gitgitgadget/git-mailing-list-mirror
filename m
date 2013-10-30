From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Limiting disk usage
Date: Wed, 30 Oct 2013 08:44:49 +0100
Message-ID: <CAA01Cso8J+BBgskoRtxkPRrtM4KJ1O2FhcB4uh+QB2Dr=DZGyQ@mail.gmail.com>
References: <0a4899b7-f75f-4016-9c99-5e6e3fb9603c@email.android.com>
	<vpqob68ebcu.fsf@anie.imag.fr>
	<CAA01Cso+yTzatiAaQahx5h2N0nnOON7FsnWNSYrN-pV=8qzn7g@mail.gmail.com>
	<526FCA13.4090902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQSV-0001g7-17
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab3J3Hov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 03:44:51 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52406 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3J3Hou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 03:44:50 -0400
Received: by mail-ee0-f46.google.com with SMTP id c1so418738eek.33
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vbq5wwiDz2oWwjL6PE5Nu26Pujd/00opoMWGYFm59k8=;
        b=OIvCSfoQwS21Zf7erGpvVAbpJUvSA4RI78W5mHC7PwX6XdN0XSh44O26v47/djeFAK
         Ox0cOhQCtCcQAObnG7gRuWhPRYxGvR2LTTU90GMNA/rRrNi/f7lGymc17OKrGbExBR9w
         8ZVTQDcGRepbpIXdhHr5+awjcQPVIj/sNEzg9wUsbD9JZWQyEf053GbVC1SfwXQtx7CI
         qmeizOBHD2E6e9w9GrnseyeskQSFuCdcSJJKgLDfB2CP4TqLaHm9ww+XdfFUu4kJqxrt
         /h/8hivHzjJJx59eOAlxSJKH5BzgI611rJWqXrdTr9i+EYcaZ2uAFTNifR1jxrn8ZVVz
         rKNg==
X-Received: by 10.14.0.196 with SMTP id 44mr902203eeb.93.1383119089228; Wed,
 30 Oct 2013 00:44:49 -0700 (PDT)
Received: by 10.223.168.9 with HTTP; Wed, 30 Oct 2013 00:44:49 -0700 (PDT)
In-Reply-To: <526FCA13.4090902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236996>

On Tue, Oct 29, 2013 at 3:45 PM, Jakub Nar=EAbski <jnareb@gmail.com> wr=
ote:
> On 2013-10-29 14:50, Piotr Krukowiecki wrote:
>>
> Lot of code isn't problem, see Linux kernel or GCC, or LibreOffice.or=
g

OK, it depends on how much code is too much for you. I'm not talking
about performance of git, just disk usage. In my case I have too much
code.


> If they are independent projects, they should get independent reposit=
ories;
> you can stitch them back together using git-submodule (or git-subtree=
).
> reposurgeon can hel you with that.

They are not totally independent projects (nor totally dependent).
Normally you want them all, you want to create a branch/tag on all of
them, if new directory is created you want to automatically have it
too etc. But there are use cases when you need only some of them and
then they can be seen as independent .

git-submodule have several disadvantages for my use:
- does not track branches (you have to specify hardcoded SHA1 instead
of a branch name)
- additional complexity / command layer (you have to do things like
"submodule init", "submodule update")
- you can't simply work on all submodules (you can't simply branch,
merge, commit, log, diff, etc in all submodules using one command in
top-level project)

git-subtree looks much better in that regard, but for example it needs
an explicit prefix (name of "subproject") on which it operates. So you
can't say "update everything" or "commit everything" etc. With
hundreds of subprojects you need another layer to automate this...

--=20
Piotr Krukowiecki
