From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Thu, 14 Jun 2012 11:56:02 +0200
Message-ID: <CAP8UFD2LBKXuey2w_-0Zy9Thi1DWCgekjCL3RULmHWVK5DXCog@mail.gmail.com>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
	<1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
	<7vr4tkhys5.fsf@alter.siamese.dyndns.org>
	<20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Peff <peff@peff.net>
To: duperrav@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 14 11:56:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6mg-0006Gw-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab2FNJ4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 05:56:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60791 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab2FNJ4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 05:56:02 -0400
Received: by pbbrp8 with SMTP id rp8so3581138pbb.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tkLuM+N2Dk0zCmcpB/F63KZkHZ08BLwXie5HJODx/mU=;
        b=mGkIAiVsoZ5WB7H5jCd3aNEChrdPk7Aqd0XiQsdrwqX7mnvrvMiuC8yM3z8947YY2+
         AeAzMfHXlnhB4ifJNHEWHnKfVEzAJ4F1rq7yCUGPGD154sQsePAKAFcn1odnnL2kg7Sz
         llMJ9eKcQagcO4YDufoCa0CQbiaueYHYr1HGb57E5aUL7cI+bNskMp/3dQKTnJ0Ca9vR
         ojMgff335Q+Y2WucunNaTgJH6AwIXsWvH+jT6iBHif0QLXrcl/MepjWZwlBtgQ7RzhJ+
         RSvTWQLHmJghbvqZmDC0val3FyffzK0TvvGcSNWmAlBXA+2LlzV/25DAE11VJIeKNGR3
         KQ6Q==
Received: by 10.68.194.201 with SMTP id hy9mr6331993pbc.69.1339667762138; Thu,
 14 Jun 2012 02:56:02 -0700 (PDT)
Received: by 10.142.234.9 with HTTP; Thu, 14 Jun 2012 02:56:02 -0700 (PDT)
In-Reply-To: <20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199995>

On Wed, Jun 13, 2012 at 8:06 PM,  <duperrav@minatec.inpg.fr> wrote:
>
> Junio C Hamano <gitster@pobox.com> a =E9crit=A0:
>
>
>>> Some commands are still not available for old/new:
>>>
>>> =A0 =A0 * git bisect start [<new> [<old>...]] is not possible: the
>>> =A0 =A0 =A0 commits will be treated as bad and good.
>>> =A0 =A0 * git rev-list --bisect does not treat the revs/bisect/new =
and
>>> =A0 =A0 =A0 revs/bisect/old-SHA1 files.
>>> =A0 =A0 * thus, git bisect run <cmd> is not available for new/old.
>>> =A0 =A0 * git bisect visualize seem to work partially: the tags are
>>> =A0 =A0 =A0 displayed correctly but the tree is not limited to the =
bisect
>>> =A0 =A0 =A0 section.
>>
>>
>> Would be easier to review if the subject is marked as RFC while
>> these todo items are still there.
>>
>> Also before going too far into the implementation, I think it is a
>> good idea to think how you are going to address the above issues. I
>> suspect the changes to bisect.c will have to be vastly different
>> depending on that plan.
>
>
> =A0 =A0 =A0 =A0* git bisect start [<new> [<old>...]]:
>
> The idea would be to add a "--new" option to start in new/old mode.

I am ok with that.

> =A0 =A0 =A0 =A0* git rev-list --bisect:
>
> I see two solutions for this:
>
> =A0 =A0 =A0 =A0- read revisions from both refs/bisect/bad and refs/bi=
sect/new
> =A0 =A0 =A0 =A0 =A0(resp. refs/bisect/good and refs/bisect/old).
>
> =A0 =A0 =A0 =A0- read revisions only from refs/bisect/bad and refs/bi=
sect/good
> =A0 =A0 =A0 =A0 =A0when the BISECT_TERMS doesn't exist or contains ba=
d/good
> =A0 =A0 =A0 =A0 =A0and
> =A0 =A0 =A0 =A0 =A0read revisions only from refs/bisect/new and refs/=
bisect/old
> =A0 =A0 =A0 =A0 =A0when the BISECT_TERMS exists and contains new/old.
>
> I prefer the latter because I don't really know how reading all files
> will affect the calls of "git rev-list" outside of a bisect session a=
nd
> the two types of files should not be present simultaneously anyway.

Why didn't you consider adding another option: "--bisect-terms-new" or
"--bisect-terms=3Dnew,old" or "--bisect-refs=3Dnew,old"?

By the way, I just looked at the doc for "--bisect-vars". This outputs
text ready to be eval'ed by the shell, and, among the variables it
outputs, there are "bisect_bad" and "bisect_good".
So maybe we should avoid using BISECT_BAD and BISECT_GOOD shell
variables in git-bisect.sh to avoid confusion.

>> While this is not wrong per-se, I am not sure if storing and reading
>> two lines from this file is really worth the trouble.
>>
>> Wouldn't it be easier to change the convention so that the presense
>> of BISECT_OLDNEW file signals that the program is working in the
>> old/new mode as opposed to the traditional good/bad mode, or perhaps
>> a single line "true" or "false" in the file tells us if we are in
>> OLDNEW mode, or something?
>
>
> If there is consensus around the fact that no other terms will be add=
ed
> after old/new, only checking if the file is present would be easier
> indeed.

Here is the end of the previous thread where old/new was originaly disc=
ussed:

http://thread.gmane.org/gmane.comp.version-control.git/182398/focus=3D1=
83410

Peff said:

-------
Hmm. I think this is not quite as nice, but it is way simpler. It may b=
e
worth trying for a bit to see how people like it. If they don't, the
cost of failure is that we have to maintain "old/new" forever, even
after we implement a yes/no reversible scheme. But maintaining the
old/new mapping from yes/no would not be any harder than the good/bad
mapping, which we would need to do anyway.

So it sounds like a reasonable first step.
-------

So in my opinion, there was a consensus that if old/new is not enough
it should not be a big deal to maintain anyway.
And I agree with this provided that we indeed implement old/new so
that it's not a big deal to maintain if we change our mind later.
(For example we might later want "yes/no", or "good/bad" with a
meaning reversed, or perhaps something else.)

So I'd rather have a file with a generic name like "BISECT_TERMS", but
it may contain just one line like for example "new/old".
We could just check that the content of the line is "new/old" and
die("Only 'new/old' is supported in $GIT_DIR/BISECT_TERMS") if it is
something else.

Thanks,
Christian.
