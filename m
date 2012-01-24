From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding all commits which modify a file
Date: Tue, 24 Jan 2012 19:10:59 +0100
Message-ID: <CA+gHt1BjqJpUke8JKjUmFyg3Zj5FmASd77LR-7P+6RrNLddD1A@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com> <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com> <52932.38.96.167.131.1327422884.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 19:11:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpkq6-0002Oh-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 19:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab2AXSLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 13:11:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49293 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876Ab2AXSLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 13:11:20 -0500
Received: by pbaa10 with SMTP id a10so2348451pba.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 10:11:20 -0800 (PST)
Received: by 10.68.74.68 with SMTP id r4mr32520418pbv.102.1327428680314; Tue,
 24 Jan 2012 10:11:20 -0800 (PST)
Received: by 10.68.56.164 with HTTP; Tue, 24 Jan 2012 10:10:59 -0800 (PST)
In-Reply-To: <52932.38.96.167.131.1327422884.squirrel@mail.lo-cal.org>
X-Gm-Message-State: ALoCoQllUQ/0PqVCk7Nc97TubghaM8jYEtvmuQXeXXq5OWMHeHY9rHMs4ByJKBrKuhOba5DARcWd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189052>

[ Do not cut the CC]

On Tue, Jan 24, 2012 at 5:34 PM, Neal Groothuis <ngroot@lo-cal.org> wro=
te:
>> On Mon, Jan 23, 2012 at 5:14 PM, Neal Groothuis <ngroot@lo-cal.org> =
wrote:
>>>> On 1/20/2012 3:35 PM, Neal Groothuis wrote:
>>>>> I'm trying to find /all/ commits that change a file in the
>>>>> repository...and its proving to be trickier than I thought. :-)
>>>
>>> On 1/21/2012 6:16 PM, Neal Kreitzinger wrote:
>>>> Does git-log --all help?
>>>
>>> I don't see how it would. =A0The commits are all reachable from HEA=
D,
>>> which
>>> would seem to be the problem that --all would correct.
>>>
>>> What I'm trying to do is find the commits in which a file differs f=
rom
>>> that same file in any of its parents.
>>
>> If you add parent rewriting (--parent, --graph or see it in gitk, wi=
th
>> --full-history) you'll get your B2 commit as it adds commits to have=
 a
>> meaningful history. But I don't think this is what you are asking fo=
r.
>
> Correct. =A0If I add parent rewriting, I get all merges, even those i=
n which
> the file is not changed from either parent.
>
> Based on what's in the man page for git log about the history
> simplification algorithm, it seems that B2 should be included in the
> output when I do a git log --full-history --simplify-history foo.txt,=
 as
> per the steps I noted in the original post. =A0Is my understanding of=
 the
> algorithm faulty?
>

=46ollowing your steps in the first post, B2 is excluded in the
--simplify-merge phase because it is (originally) TREESAME, even if it
is not in the rewritten history...

HTH,
Santi
