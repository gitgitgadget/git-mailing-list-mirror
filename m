From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 23 May 2016 21:31:16 +0200
Message-ID: <CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
References: <loom.20160523T023140-975@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Yotam Gingold <yotam@yotamgingold.com>
X-From: git-owner@vger.kernel.org Mon May 23 21:31:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vZS-0002c2-US
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbcEWTbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 15:31:18 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37104 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbcEWTbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 15:31:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id z87so60748820wmh.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=lstBkU37W/jxK8jPo0FpS05DyaAYCvl+0nF/oQbngvg=;
        b=D7H7ihsAyRychabFhSp/qEQKlQpb+bEBv95BdmNFbilZV2mFeyqhd1IjinnqvREzl6
         Fp2Q1VijH2QYy3MO7UUzMRT8uJREZah8Pk7OyTFdtO5dhVSZXIZxo0s+AM0sA+4ld45d
         171z1z3VoiESsHd16fgHi/V1MzQC2MBtki0z4MVXDcT0f+RthGBoxuMCB4FjG1quGKrI
         4L/k1uvWCTvf0Va69c1mOETL2TNGBd/r9QDLwOLfCpZt0UQSaH2ymMuSmr45ZJca0Ilx
         oCThJWVOXZ/252da6tTtCjJR6INoTahu9QSgRe5PmUAO5mT5aPgPQetY6rlM8RvQ6ugJ
         cFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=lstBkU37W/jxK8jPo0FpS05DyaAYCvl+0nF/oQbngvg=;
        b=eElmgBWVuy7YNyxIMgQJSKD2xu91V1QsFLgHcusCsuLP/E3U2qMckku/+BM5aB3ff8
         +dFLnjn66VWALkoYHDN4XUzOM2w2rlWAmXFv0xe9BNjhv/Fpleei2gN6wIq2y21H/s6k
         DxCDDx/m/J+qUAR+NnKxxuqVG42KMPQX2v19DI5Nx2wurtJRWrldkPyfSXEd22dQw0OY
         5rcVEdRYiVWVx7S2e7kcx7ubzGlY3gDdJ0pF5Z3G0CJ6Yx6QHQA9Rzy90fSOVYZvxHXz
         CibwL7gbVb9vX/gD42XF09h0SMzksxntbPymHgriXbEk+scbIKQtyqMqzJ2EvfIgf1A2
         1oig==
X-Gm-Message-State: ALyK8tJe7HK9WbPjv3t7vAh5j+kYeEzCS4Bm0uma5Xoi2Zb3kT1OO1I5nmGdE9Xmfqe8V+1v3pc1GX0BpvcEeg==
X-Received: by 10.194.109.4 with SMTP id ho4mr454209wjb.78.1464031876110; Mon,
 23 May 2016 12:31:16 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 23 May 2016 12:31:16 -0700 (PDT)
In-Reply-To: <loom.20160523T023140-975@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295378>

On Mon, May 23, 2016 at 2:55 AM, Yotam Gingold <yotam@yotamgingold.com>=
 wrote:
> Pierre-Fran=C3=A7ois CLEMENT <likeyn <at> gmail.com> writes:
>> 2014-06-10 17:27 GMT+02:00 David Kastrup <dak <at> gnu.org>:
>>> Pierre-Fran=C3=A7ois CLEMENT <likeyn <at> gmail.com> writes:
>>>
>>>> ...
>>>>
>>>> Hm I see. Even though the documentation doesn't make it very clear
>>>> about what happens to such files, it turns out the scenario we
>>>> stumbled upon seems to be the special use case after all. Thanks f=
or
>>>> shedding some light on this :) I wonder why does git-reset's hard =
mode
>>>> not always remove untracked files then?
>>>
>>> Because it never removes them?  Git only removes files once it trac=
ks
>>> them.  This includes the operation of removing _and_ untracking the=
m,
>>> like with git reset --hard.
>>>
>>> The only command which explicitly messes with untracked files is
>>> git-clean.
>>>
>>> --
>>> David Kastrup
>>
>> ... I couldn't find a definition that backs this in the man
>> pages (maybe the git-glossary would be a good place for it?), and th=
e
>> one from the Git-Scm book only confused me in thinking the opposite.
>> Thanks for the clarification
>>
>> --
>> Pierre-Fran=C3=A7ois CLEMENT
>> Application developer at Upcast Social
>
> Jumping into this conversation two years later*. There's confusion ab=
out what
> constitutes a tracked file for git reset --hard, and good reasons for=
 git reset
> --hard's behavior. Nevertheless, I think we can all agree that the ma=
n page
> entry for git reset --hard is woefully deficient:
>
> --hard Resets the index and working tree. Any changes to tracked file=
s in the
> working tree since <commit> are discarded.
>
> This should be clarified to define what a tracked file is. I propose =
appending:
>
>     A file is considered tracked if it exists in a prior commit or in=
 the
>     staging area. Note that a newly added file not in any prior commi=
t will be
>     removed.

Would you like to send a patch with something like the above?

I don't know if something about why it is like this, or why it is the
right thing to do, at least for recovering from merges, should be
added though.

> I would also like to propose that the staging area's tree object be s=
aved,
> perhaps in the reflog or perhaps just as a dangling object. This woul=
d allow
> graceful recovery from git reset --hard. Witness the many questions a=
nd answers
> on recovery:
>     http://stackoverflow.com/questions/7374069/undo-git-reset-hard-wi=
th-uncommitted-files-in-the-
> staging-area
>     http://stackoverflow.com/questions/5788037/recover-from-git-reset=
-hard
>     http://stackoverflow.com/questions/5473/how-can-i-undo-git-reset-=
hard-head1
>     http://gitready.com/advanced/2009/01/17/restoring-lost-commits.ht=
ml
>     https://bani.com.br/2014/10/recovering-lost-files-after-a-git-res=
et-hard/
>     https://medium.com/@CarrieGuss/how-to-recover-from-a-git-hard-res=
et-b830b5e3f60c
>
> All of these solutions recover the contents of files, but not their n=
ames or the
> directory structure. Saving the tree object somewhere (anywhere!) wou=
ld solve
> this problem.

Yeah, it might be a good idea.

> I was bitten by this in a vicious way. I was setting up a new reposit=
ory for a
> bunch of code and data (git init; git add .), changed my mind about a=
dding the
> data (git reset --hard), and nearly lost everything.

I think we could also perhaps have a special case when the current
branch doesn't really exist yet.

At least if you had used "git reset --keep", it would have failed with:

$ git reset --keep
error: You do not have a valid HEAD.
fatal: Could not reset index file to revision 'HEAD'.

Also if there had already been a commit, with --keep the new files
would not have been deleted.

> The only tree object that
> could be found was an empty one, so I got file contents without names=
 or
> directories (not good, because experimental conditions for the data w=
ere encoded
> in the directory structure).

Best,
Christian.
