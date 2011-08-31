From: Ryan Wexler <ryan@iridiumsuite.com>
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 10:09:12 -0700
Message-ID: <CAKjsY4kYm4ixTVQE4+8XZrf7DkAfn=ASoeMYob=5i1FmJ6eK5w@mail.gmail.com>
References: <1314804325568-6746957.post@n2.nabble.com>
	<uvMkLVapQYcSvOHVhcHX8CqGzEDajPEPvBbkL_DctzZvxm7aI-PjCQ@cipher.nrlssc.navy.mil>
	<20110831165405.GB4356@sigill.intra.peff.net>
	<XWAITZ7y0RejBGQezy-miO4ykUsgbNWA0mNtHRto22msjs3PP6WSZlN-pPueaz0duxAP6dCio3ZH2lna0K_g79NKdL0q7sJbzjj8sEKicYM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyoHy-00059r-OK
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab1HaRJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 13:09:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41893 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab1HaRJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 13:09:13 -0400
Received: by wyh22 with SMTP id 22so319973wyh.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 10:09:12 -0700 (PDT)
Received: by 10.216.164.210 with SMTP id c60mr628724wel.35.1314810552143; Wed,
 31 Aug 2011 10:09:12 -0700 (PDT)
Received: by 10.216.53.77 with HTTP; Wed, 31 Aug 2011 10:09:12 -0700 (PDT)
In-Reply-To: <XWAITZ7y0RejBGQezy-miO4ykUsgbNWA0mNtHRto22msjs3PP6WSZlN-pPueaz0duxAP6dCio3ZH2lna0K_g79NKdL0q7sJbzjj8sEKicYM@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: Xxp39boGHMFEJ2_Utv86dWPn6f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180496>

Ok thanks for all the replies guys.  I thought I was SOL.  I will
start playing with it here and let you know how it goes.

On Wed, Aug 31, 2011 at 10:01 AM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 08/31/2011 11:54 AM, Jeff King wrote:
>> On Wed, Aug 31, 2011 at 11:14:48AM -0500, Brandon Casey wrote:
>>
>>> =A0 =A0git checkout -b devel && =A0# make a new branch named "devel=
"
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# which =
has the same state as the
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# curren=
tly checked out branch: "master"
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# i.e. d=
evel and master point to the
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# same t=
ip commit.
>>> =A0 =A0rm -rf * && =A0 =A0 =A0 =A0 =A0 =A0 =A0 # remove the files i=
n the working dir
>>> =A0 =A0cp -a $devel_dir/* . && =A0 # cp devel source code to workin=
g dir
>>> =A0 =A0git add -A . && =A0 =A0 =A0 =A0 =A0 # add new/removed files =
to the index
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# to be =
committed on next 'git commit'
>>> =A0 =A0git commit
>>> =A0 =A0# use editor to give descriptive commit message
>>>
>>> Repeat for your topic branch based off of devel.
>>
>> I am probably just going to confuse the original poster more, but he=
re
>> is how I would do it. It's slightly more efficient, as it doesn't
>> involve removing and copying files for the intermediate states:
>>
>> =A0 # make a repo and switch to it
>> =A0 git init repo && cd repo
>>
>> =A0 # and now add everything from the "master" version, and
>> =A0 # make a commit out of it
>> =A0 GIT_WORK_TREE=3D/path/to/master git add -A
>> =A0 git commit
>>
>> =A0 # now make the devel branch and do the same
>> =A0 git checkout -b devel
>> =A0 GIT_WORK_TREE=3D/path/to/devel git add -A
>> =A0 git commit
>>
>> =A0 # and then check out the result in the working tree of
>> =A0 # your newly created repo
>> =A0 git checkout -f
>
> Better.
>
> -Brandon
>
