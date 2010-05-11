From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Reconstructing git-svn metadata after a git clone
Date: Tue, 11 May 2010 05:27:05 +0100
Message-ID: <AANLkTinMZvBUPPmChwrA1dHr47HXpFldnKH9GO60oIkU@mail.gmail.com>
References: <AANLkTikR5EpZhwFXmRfmE9jSNtiuFoGwTgGbpcwUBxnq@mail.gmail.com> 
	<t2l86ecb3c71005081120lf87fc99bh1566c82a4d21904e@mail.gmail.com> 
	<AANLkTin_hVhyrhjwoM_on_sd1RIZrk6YIFVsYXKm5UKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 06:27:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBh4C-0000nj-NW
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 06:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab0EKE11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 00:27:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42351 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0EKE10 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 00:27:26 -0400
Received: by pvb32 with SMTP id 32so329410pvb.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=3wesE2Yro6lP3XdPa+iW1B7758xlrnYfdxHWtoSbAbg=;
        b=uxx/dPgE+3ijuV02YmDFjuzbdO7o1UnKXQ3l5o4/k0rsshCLM9whkypN50en5CQqJl
         cSkmFrRXYPYYCqp5wUDcvv8DVaL9I2jc0DcvQn7E45GLuAEo5qdyU41JRXkj6UlyZ7W2
         4Q4bOWOzEJp/cFJy1nKnW+mQUBX0Tqdxe1gbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=TysfB5BZtwLEfsBYxZxGJHEj9kCrok+o27IJs9Ed5lGsuWkDCQbLVgBR89b8+UX9eD
         u70ElIb5eTQhLOtZZwRewAiwBYT2pDqnLcF853xueAMPE4z/2XUNkidlgOyBY/cYttN1
         Yzzb3UK6PXqGC0Xv5Bi24CLYHDT104FUCiXvo=
Received: by 10.142.209.12 with SMTP id h12mr3354908wfg.104.1273552045105; 
	Mon, 10 May 2010 21:27:25 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Mon, 10 May 2010 21:27:05 -0700 (PDT)
In-Reply-To: <AANLkTin_hVhyrhjwoM_on_sd1RIZrk6YIFVsYXKm5UKg@mail.gmail.com>
X-Google-Sender-Auth: GQUgFlv7NwexPdvWm2LNha_tnNY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146865>

On 10 May 2010 22:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com> wrote:
> On Sat, May 8, 2010 at 18:20, Dmitrijs Ledkovs
> <dmitrij.ledkov@ubuntu.com> wrote:
>> On 8 May 2010 18:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>>> So:
>>>
>>> =C2=A0* Am I doing something wrong? If so I can't see what it is.
>>>
>>
>> No
>>
>>> =C2=A0* Is there something that works for the general case, i.e. yo=
u only
>>> =C2=A0 have to know the original `git svn init` options. If there i=
s I'd
>>> =C2=A0 like to document that & submit a patch.
>>>
>>
>> In my repo I have a branch with no anestors which has a config file,
>> setup.sh & fetch.sh
>>
>> I instruct to clone repo, checkout "utils" branch, run setup.sh (it
>> overrides .git/config with config file committed to utils branch and
>> after it copied config it runs git svn init URL), fetch.sh just runs
>> git svn fetch =3D)
>>
>> I have to do this because I have two svn remotes and both are not
>> standard layout. The only way for me to represet "same init options"
>> is by editing .git/config cause it's impossible for me to supply
>> git-init options on the command line =3D)
>
> If I can't resolve this I'll do something similar. Just provide a
> tarball of .git/svn for each repo that is.
>

Always an option.

>>> =C2=A0* Depending on the above; can git-svn itself be friendlier he=
re?
>>> =C2=A0 Maybe by having a `git svn bootstrap` command. E.g.:
>>>
>>
>> It would be nice to have the git init info propogate with the git
>> clone. But this won't work. You are cloning *all* branches and
>> providing a git mirror, where as I want to to git init just my svn
>> branch or a subset of them. To achieve that I will clone just the
>> branches I need modify my .git/config and get the result I want.
>>
>> So imho git-svn is ok here.
>
> I still don't see why it can't work. Maybe I'm just hopelessly na=C3=AF=
ve
> to git-svn internals, but:
>
> =C2=A0 * Every commit message in the Git repo has info on the svn
> =C2=A0 =C2=A0 branch/svn commit.
>
> =C2=A0 * The Git repo has a list of branches that map to SVN branches=
=2E
>

Your local one does. But not the cloned one.

> =C2=A0 * If I supply the same `git svn init` options that made the re=
po,
> =C2=A0 =C2=A0 it should be able to bootstrap just using the above.
>

Yes, but it takes a while..... especially if the svn repo is huge.

> Why isn't that the case? What info is in .git/svn that can't be
> inferred from the above?
>

Is there a git versions mismatch between machine where the first
import was made and the machine where you are testing bootstrapping by
any chance?

on my machine I sometimes see "upgrading metadata" when I'm updating
some of my acient git-svn clones.

>>> =C2=A0git clone git://$some_url
>>> =C2=A0# Does all the work of setting up metadata/refs
>>> =C2=A0git svn bootstrap --stdlayout $remote_svn_url
>>
>> If you are committing to svn regularly you are better of with bzr-sv=
n
>> in my opinion. Because launchpad can run automatic imports for you
>> (webkit is already running btw) and the whole bootstrapping thing is
>> done the way you are expecting it.
>>
>> #create repository to store revisions efficiently
>> $ bzr init-repo .
>>
>> #on the first ever run it will rebuild meta-data
>> #subsequent runs just fetch missing revisions
>> $ bzr branch svn://path.to.any.branch
>>
>> And you can commit from that =3D) and bzr can operate on your svn
>> checkouts. And every single clone done by bzr-svn is identical (unli=
ke
>> git where everyone has to follow the same git-svn mirror to get same
>> revision-ids).
>>
>> You have two options when commiting with bzr-svn. Regular bzr ci wil=
l
>> store bzr merge information in revision properties on svn server or
>> you can use bzr dpush which is like git svn dcommit.
>>
>> IMHO bzr-svn is the best when you need to commit back to svn and
>> painlessly commit parts of the feature branch and merge other bits
>> later.
>
> That's informative. But from having used Bazaar a bit my experience
> with it was that I might as well be using Subversion.
>
