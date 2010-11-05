From: =?ISO-8859-1?Q?Philip_J=E4genstedt?= <philip@foolip.org>
Subject: Re: [PATCH] Documentation: fix misnested -l and --contains in git-tag synopsis
Date: Fri, 5 Nov 2010 10:28:12 +0100
Message-ID: <AANLkTikXM4BjRHOeS=3mirr9=YRW8sdaHFt05D-9BDxL@mail.gmail.com>
References: <1288783029-11226-1-git-send-email-philip@foolip.org> <7vmxpovq0r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 10:28:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEIbG-0008QI-LL
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 10:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab0KEJ2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 05:28:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42338 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0KEJ2e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 05:28:34 -0400
Received: by wyb36 with SMTP id 36so866293wyb.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 02:28:32 -0700 (PDT)
Received: by 10.216.158.18 with SMTP id p18mr920828wek.2.1288949312452; Fri,
 05 Nov 2010 02:28:32 -0700 (PDT)
Received: by 10.216.51.137 with HTTP; Fri, 5 Nov 2010 02:28:12 -0700 (PDT)
In-Reply-To: <7vmxpovq0r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160810>

On Thu, Nov 4, 2010 at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
> Philip J=E4genstedt <philip@foolip.org> writes:
>
>> This has been broken since the --contains option was added in
>> commit 32c35cfb1e9c8523b9d60e5095f1c49ebaef0279
>>
>> Signed-off-by: Philip J=E4genstedt <philip@foolip.org>
>> ---
>> =A0Documentation/git-tag.txt | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 31c78a8..8ad89d7 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>> =A0'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
>> =A0 =A0 =A0 <tagname> [<commit> | <object>]
>> =A0'git tag' -d <tagname>...
>> -'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
>> +'git tag' [-n[<num>]] -l [<pattern>] [--contains <commit>]
>> =A0'git tag' -v <tagname>...
>
> I do not think there is any "mis" nor "nesting" here. =A0The -l optio=
n can
> be used to tell the command to operate in "list tags" mode, and in th=
at
> mode it can use a pattern to limit the output (with or without --cont=
ains
> <commit>). =A0All of these are supported:
>
> =A0 =A0git tag -l --contains v1.7.0 v\*
> =A0 =A0git tag -l v\*
> =A0 =A0git tag --contains v1.7.0 -l v\*
> =A0 =A0git tag -l v\* --contains v1.7.0
>
> IOW, <pattern> is _not_ an optional argument to the -l option. =A0In =
fact, I
> think we should support more than one patterns, even though currently=
 this
> seems to silently ignore k\*:
>
> =A0 =A0git tag --contains v1.7.0 -l v\* k\*
>
> As I tend to consider that "limit by pattern" is like pathspecs (in t=
his
> case, it is _not_ a pathspec, though), having the pattern at the end =
looks
> the most natural, but it may be just me. =A0And that is why I think w=
e ought
> to accept and apply more than one patterns here.
>
> I would further say that "git tag -l <pattern> --contains <commit>" s=
hould
> be an error, even though the command currently seems to take it; perh=
aps
> parameter reordering is in effect? =A0I didn't look closely enough.
>

=46rom the documentation it's not clear that -l and --contains are
related at all, they look (and behave?) like orthogonal options. If
they do in fact interact in some non-obvious way or if -l <pattern>
--contains <commit> means something different from -l --contains
<commit> <pattern>, it would be great if that were made more clear. (I
wouldn't have expected the later to work at all, thus my assumption
that there was a typo in the documentation.)

--=20
Philip J=E4genstedt
