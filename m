From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] test: mailmap can change author name without changing email
Date: Wed, 15 Feb 2012 00:48:10 +0200
Message-ID: <CAMP44s1HitxHkfre_1BPOpt2oVo_rwMnbcer2zxFuA6KJXnj_g@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214203519.GC13210@burratino>
	<CAMP44s3di25SbMa1T1=0_s6f-rKnniwEcA+o5HWT7xedcghSeg@mail.gmail.com>
	<20120214215023.GC9651@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:48:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRAW-0005mw-Or
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282Ab2BNWsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:48:12 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:51178 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755181Ab2BNWsL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:48:11 -0500
Received: by lbom4 with SMTP id m4so218331lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OaI244Ox0Nhf8LBaQ+5AwHpzEXa734uHtMLaOCR1bEU=;
        b=N10z8uBIoNcLanek+JO7MhN/LPzePd7cpB2VXvtr28G+TMbhx7kDidGeyXqFqa0km8
         JrlMTxYzichkXLo4wwZuxLQ4KKKJLZIM6k7EXKBbZHTX4w8Jf+veQCZxcwBnVddZUwYr
         GdkNg86oOgp6xRoiPGlTNyO8BaEVRvvx6L6Pc=
Received: by 10.152.123.68 with SMTP id ly4mr15810545lab.13.1329259690066;
 Tue, 14 Feb 2012 14:48:10 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:48:10 -0800 (PST)
In-Reply-To: <20120214215023.GC9651@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190788>

On Tue, Feb 14, 2012 at 11:50 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>> On Tue, Feb 14, 2012 at 10:35 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> (2) 'email@example.com'
>>> becomes the canonical author email for commits with author name 'A =
U
>>> Thor'.
>>
>> That's not true. I initially thought that was the case, and I think =
it
>> might be useful to have that, but it's not the case now, and your
>> patch doesn't test this.
>
> Thanks for explaining. =C2=A0I had indeed confused myself into thinki=
ng 'A
> U Thor <email@example.com>' would act like 'A U Thor
> <email@example.com> <email@example.com>'.
>
> I should have said:
>
> -- 8< --
> A mailmap entry in the format 'A U Thor <email@example.com>' means
> that 'A U Thor' should be the canonical author name for commits
> with author address 'email@example.com', and the email address
> should be left alone.
>
> We already have tests for this format regarding the committer name,
> but not in the author name, so the tests do not cover the shortlog an=
d
> blame codepaths as they should. =C2=A0Fix that.
> -- >8 --

At which point the summary doesn't seem to be correct "test: mailmap
can change author name without changing email". Plus, I fail to see
what would be the usefulness of this test, as changing name is
changing the name, regardless if it's the author or the committer.

> [...]
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> I most definitely did not sign this off, and I didn't add any of the=
se
>> lines, nor wrote anything about this commit message.
>
> That's why I described the changes I made, signed with my initials,
> and put my own sign-off below yours. =C2=A0Did I screw up somewhere?

You more or less rewrote the whole thing, I don't think you should put
my s-o-b in those cases.

Anyway, I have seen people use this format:

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
[jn: rewrite the patch]
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Even better:

Based on a patch by Felipe Contreras.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

> Note that I am making these changes because, at its heart, I think
> your patch is good and useful. =C2=A0Otherwise I would have ignored i=
t and
> worked on something else. =C2=A0If you prefer that I don't make
> improvements like this, please indicate why that's a good idea;
> otherwise I will probably continue to do it when I see good patches,
> despite all the signals you are giving that I have done something
> awful by corrupting your perfect patch in this way.

I didn't hint I preferred that. You said you wanted to improve my
patches, why can't I do the same?

--=20
=46elipe Contreras
