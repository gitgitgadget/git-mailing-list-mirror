From: Bill Okara <billokara@gmail.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Wed, 24 Feb 2016 17:03:04 -0700
Message-ID: <CADsr5c_DyzTNcPg9aZ6TJse0i0o=4LMz7_-QXtOpfnLhF3cKLw@mail.gmail.com>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
	<xmqqwpptr83a.fsf@gitster.mtv.corp.google.com>
	<CADsr5c8akqt7tsgptuDqCyt2JW8ie9js5eFt7oxXxDxtGMLJFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:03:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjP8-0007BG-3F
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbcBYADI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 19:03:08 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35065 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcBYADF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 19:03:05 -0500
Received: by mail-oi0-f52.google.com with SMTP id x21so28903515oix.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6VK7LXnlcyPI8Fg3k7bHJcojRGgS0lt8KnkZ12KSzqQ=;
        b=xuShKVY/ONHE2dG2a/PibRgsWO0pL2KkTIIBzsnYOUVFfRPOOBHtz+B3c6I16j9hYQ
         5Tyf3m0U5k1tKLOinXpmLieAI8vbnysV7RfJWy6FRa9Rkdx1L+8Qf9XahA6WmEVCc7Nu
         Fg0s3MOLBi7TO2QzB1S6AOlyKoHa3sk9eJrnRBhKfWCG+6DQMQaU/Ts9BVECC2HDErqL
         Qu0IHHxSUH9fU+IXnDcLvHsefGRNLGmIhdPymZPi4zL5iJYVKTMocKX4lld3BDLDlyzz
         CU+ZeH8guxUjd5iY1CDKO2lJwfIa5IFw0t3vk4IUFmjVmo5++nU2bgT84iaJ0DGrs7Tt
         J/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6VK7LXnlcyPI8Fg3k7bHJcojRGgS0lt8KnkZ12KSzqQ=;
        b=Zm6lf2Gg6PT451SY89l434pr8oBj3R9c2aIU6Z+qJgmm7RtWj4ZRI7MpQibKRTPt9v
         y4Kz1GoXEUq+Susy4pAXMjX4lITCnCQgCm7QcbZh2AAbPHHl8zdcs4fRTlleQPa3oOBd
         6cFTniloLt1wvKsFtZl9uxHo89PDNwRhPmJr1wZ9zQS8yovP8jJYu3HmLYkhNCMowEL3
         hzwKJlnkuAb8/6KARmAUpyU6KLpCkcEV1Db4IBJQJBA35gCzmTjHAqTlXPWEOt8HJvYk
         oXfF6yfkcy321BO/JAjYkwpx65Bfjgp24JV+XS/dgHaHUXquoK99iG9QVjysB6vqvaBy
         MGzQ==
X-Gm-Message-State: AG10YOQz9g2Rsq+J5g0j/Wvaho5LXwZjUXKY4W2xwwioHx7w4jpgqZFn7mGotQ1HHWKdAIKs7MPjSSPxBGTXfA==
X-Received: by 10.202.221.137 with SMTP id u131mr33469982oig.118.1456358584733;
 Wed, 24 Feb 2016 16:03:04 -0800 (PST)
Received: by 10.182.17.103 with HTTP; Wed, 24 Feb 2016 16:03:04 -0800 (PST)
In-Reply-To: <CADsr5c8akqt7tsgptuDqCyt2JW8ie9js5eFt7oxXxDxtGMLJFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287288>

following are the steps to help illustrate the issue. its actually
quite common to have projects include identical placeholder files
before update/refactoring...

// Create in master branch

> mkdir gittest
> cd gittest
> init
> mkdir -p gitmvtest/resources
> mkdir -p gitmvtest/resources/demo
> mkdir -p gitmvtest/resources/dev
> mkdir -p gitmvtest/resources/prod
> cd gitmvtest/resources/demo/
> echo 'This is the line that contains the common content=E2=80=99 >> c=
ontent.txt
> cd ..
> cp demo/content.txt dev/.
> cp demo/content.txt prod/.
> cd ../..
> git add .
> git commit -m "master content.txt first commit"


# change to a new branch

> git checkout -b newTestBranch
> mkdir -p gitmvtest/src/main
> git mv gitmvtest/resources gitmvtest/src/main/.
> git commit -m "newTestBranch: mv resources to src/main/resources"

[newTestBranch 5faed26] newTestBranch: mv resources to src/main/resourc=
es
 3 files changed, 0 insertions(+), 0 deletions(-)

 rename gitmvtest/{resources/prod =3D> src/main/resources/demo}/content=
=2Etxt (100%)
 rename gitmvtest/{ =3D> src/main}/resources/dev/content.txt (100%)
 rename gitmvtest/{resources/demo =3D> src/main/resources/prod}/content=
=2Etxt (100%)


// Change back to master and update the 3 files

> git checkout master
> echo 'this is DEMO content' >> gitmvtest/resources/demo/content.txt
> echo 'this is DEV content' >> gitmvtest/resources/dev/content.txt
> echo 'this is PROD content' >> gitmvtest/resources/prod/content.txt
> git add .
> git commit -m "master: update content.txt to include parent folder na=
me"

[master 18d85f9] master: update content.txt to include parent folder na=
me
 3 files changed, 3 insertions(+)


// Change back to the new branch and merge from master

> git checkout newTestBranch
> git merge master
Auto-merging gitmvtest/src/main/resources/prod/content.txt
Auto-merging gitmvtest/src/main/resources/dev/content.txt
Auto-merging gitmvtest/src/main/resources/demo/content.txt

Merge made by the 'recursive' strategy.
 gitmvtest/src/main/resources/demo/content.txt | 1 +
 gitmvtest/src/main/resources/dev/content.txt  | 1 +
 gitmvtest/src/main/resources/prod/content.txt | 1 +
 3 files changed, 3 insertions(+)


// SEE the ERROR:
//demo/content.txt wrongly merged with data from prod/content.txt

> cat gitmvtest/src/main/resources/demo/content.txt

This is the line that contains the common content
this is PROD content

On Wed, Feb 24, 2016 at 4:51 PM, Bill Okara <billokara@gmail.com> wrote=
:
> it actually does matter in the following scenario:
>
> 1) master branch has identical content.txt files in the folder struct=
ure
> 2) do the git mv in a new branch
> 3) master branch updated the context.txt to contain new data (more
> relevant to the containing folder)
> 4) new branch need to merge the updates from master
>
> after the merge, demo/content.txt in the new path would contain
> updates from dev/content.txt from master...
>
> On Wed, Feb 24, 2016 at 4:39 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Bill Okara <billokara@gmail.com> writes:
>>
>>> just want to see if this is a bug, user error (on my end), or??
>>
>> Not a bug, not a user error, just "it does not matter", I think.
>>
>>
