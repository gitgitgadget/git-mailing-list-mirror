From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Thu, 23 Feb 2012 11:02:59 -0800
Message-ID: <7vpqd54bks.fsf@alter.siamese.dyndns.org>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com>
 <7vipiy8m5q.fsf@alter.siamese.dyndns.org>
 <CAFouetiSpsZGtLt2tG4ou-H18zigNx5xWQH4cy8GrL1eDxbjJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com, stefano.lattarini@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0dwc-0000FR-DV
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab2BWTDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 14:03:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab2BWTDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 14:03:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E29E6803;
	Thu, 23 Feb 2012 14:03:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=JxQojQE20/bA+Nt4IUbpBjJCc
	XI=; b=NJCqGnWkiOFrQed3hZUqcI6aTmGXQRp7FfSNXAvEBVhmb9tvp7CutBIUS
	0TnVBPM4XCTUxcUQA24pLZMmnIDaCJX8zkYgYpOvEglVC0q5jVuNvqEdxdQ10zq4
	4Rd2Gm4AU/Rs8EjWOFuol/x6PogVT6+XN1H2ac6WQ9VgXK4yU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=r70V6yFp4dEvZqBT4Fh
	ZWfb0lHAyanoMB29i/GRB34zX/ujl4vx2Na3HVJ+sCG12Cjggd0C5PI/gdxTp6ee
	e5fu+FfT10SH+LE/BfDzwyl5aKTz+uxMHJAuS3gLBc0lvpOkggCVlzOimB3qPmfv
	CHZ6Ikuwew+HYc5kzRyMdCow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 951F76802;
	Thu, 23 Feb 2012 14:03:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC28C6800; Thu, 23 Feb 2012
 14:03:00 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0177D308-5E51-11E1-A9D9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191383>

Tim Henigan <tim.henigan@gmail.com> writes:

> On Wed, Feb 22, 2012 at 6:48 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>
>> Another thing that comes to my mind is if a user has an external too=
l that
>> can use "diffall", is there ever a situation where the user chooses =
to use
>> "difftool" instead, to go files one by one. I cannot offhand imagine=
 any.
>
> It was my assumption that any tool that supports directory diff also
> supports individual file diff.  It seems like a strict subset of
> directory diff case.
> ...
>> Perhaps a longer term integration plan may be to lift the logic from=
 this
>>
> ...snip...
>>
>> But that is all two steps in the future.
>
> I hope that this feature finds it way into the existing core commands=
=2E
> This script is intended to be a conversation starter that is also
> immediately useful as a separate command.  Would it be better to begi=
n
> the long-term discussion now and skip adding this to contrib?

I would envision we have this in contrib/ first, without even fixing th=
e
whitespace-in-pathspec and whitespace-or-lf-in-paths issues I pointed o=
ut
in my review, and let people play with it.

My crystal ball tells an optimist in me that we will see people (you an=
d
others) try to fix issues they hit in their real life use cases, and th=
e
script will be improved while it is still in contrib/.  And then somebo=
dy
who has worked on difftool will step up and roll it into difftool prope=
r,
along the lines I hinted in the message you are responding to, at which
point the script will be removed from contrib/.  That is the first step=
 in
the future.

The second step in the future may or may not come.  It will involve add=
ing
an updated external diff interface on the core side and would prepare t=
he
two temporary directories before the core side calls the difftool among
other things, and when that happens, we can lose most of the code in th=
is
script that the first step in the future may have ported into difftool.

>> You can write multiple assignment on a line to save vertical space i=
f you
>> want to, and the initialization sequence like this is a good place t=
o do
>> so.
> My personal preference is to keep them on separate lines.  However if
> the compressed style is preferred, I will change it.

"I wouldn't bother" was what I meant by "if you want to".

>>> + =C2=A0 =C2=A0 -x|--e|--ex|--ext|--extc|--extcm|--extcmd)
> ...
>> Don't you want to match "-t/--tool" that "difftool" already uses?
>
> Are you suggesting that I a) change "-x/--extcmd" to "-t/--tool" or
> that b) I add support for the "difftool -t/--tool" option?

No, I just misread the set of options "difftool" takes, without realizi=
ng
that --extcmd and --tool are two different things, and it is correct to
call your option "--extcmd" if it specifies what corresponds to what
"difftool --extcmd" specifies.  Sorry for the confusion.

>> Hrm, so "diffall HEAD~2 Documentation/" is not the way to compare th=
e
>> contents of the Documentation/ directory between the named commit an=
d
>> the working tree, like "diff HEAD~2 Documentation/" does.
>>
>> That is not a show-stopper (a double-dash is an easy workaround), bu=
t
>> it is worth pointing out.
>
> So I would need something to determine if a string represents a
> commit/tag/branch or a path?.

"It does not have to be fixed in the first version" (aka "for future
consideration") was what I meant by "not a show-stopper".

>> And this will not work with pathspec that have $IFS characters.  If =
we
>> really wanted to we could do that by properly quoting "$1" when you =
build
>> $paths and then use eval when you run "git diff" here (look for 'sq'=
 and
>> 'eval' in existing scripts, e.g. "git-am.sh", if you are interested)=
=2E
>>
>> Also you may want to write filelist using -z format to protect yours=
elf
>> from paths that contain LF, but that would require the loop "while r=
ead
>> name" to be rewritten.
>
> I just discovered that the script fails to handle files that have
> spaces in their name, so some further work is needed.

Again, "It does not have to be fixed in the first version" (aka "for
future consideration") was what I meant by "If we really wanted to".

>> What is this "--ignore-failed-read" about? Not reporting unreadable =
as an
>> error smells really bad.
>
> If a file was added or deleted between the two commits being compared=
,
> tar would fail because a file was missing from "$tmp/filelist".  The
> "--ignore-failed-read" prevents tar from halting the script in this
> case.

But it will also ignore errors coming from other causes, no?  Wouldn't =
we
rather see an error if tar fails to read from a path that *has to* exis=
t
in the working tree because "diff" said it does?

Again, it is just "for future consideration".

>> If you require GNUism in your tar usage, this should be made configu=
rable
>> so that people can use alternative names (some systems come with "ta=
r"
>> that is POSIX and "gtar" that is GNU).
>
> Is there an example showing how this could be configurable?  The
> problem is that the "--ignore-failed-read" was not supported in all
> flavors of tar.

Grep for "$TAR" and also @@DIFF@@ in the Makefile, and add substitution
for @@TAR@@ in cmd_munge_script, perhaps?

By the way, I actually have an even more radical suggestion that may le=
t
you get rid of most of the lines in your script.

If you tweak the usage so that "diffall" specific options *MUST* come
first, e.g.

	USAGE=3D[--copy-back] [-x <cmd>] <arguments for diff>

then you can parse your argument partially, i.e.

	copy_back=3D extcmd=3D
	while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
        do
		case "$1" in
                --copy-back)
                	copy_back=3Dtrue
			;;
                -x | --extcmd)
			test $# !=3D 1 || usage
			extcmd=3D$2
                        shift
			;;
		*)
                	break
                        ;;
		esac
                shift
	done

then feed the remainder all to "diff", e.g.

	diff --raw --no-abbrev "$@" |

And then you can prepare two temporary index files and stuff the output=
 in
them, by having something like this on the downstream of the pipe:

	while read -r lmode rmode lsha1 rsha1 status path
        do
        	if test "$lmode" !=3D $null_mode
		then
                	GIT_INDEX_FILE=3D$tmp.left_index \
                        git update-index --add --cacheinfo $lmode $lsha=
1 $path
		fi
        	if test "$rmode" !=3D $null_mode
		then
                	GIT_INDEX_FILE=3D$tmp.right_index \
                        git update-index --add --cacheinfo $rmode $rsha=
1 $path
		fi
	done

Side Note:
	In the production version, you would probably give the "-z" option
	to "diff", and write this loop in Perl so that you can cope better
	with funny characters in the path.  Instead of running two
	instances of "git update-index" for every path, the loop would
	group the entries for left and right side, and drive one instance
	of "git update-index --index-info" each to populate the two index
	files.

	Also the above needs to be adjusted to deal with the side that
	represents the working tree files; they are reported with $null_sha1
	so in such a case instead of putting it in the temporary index,
        you would copy the working tree file to the temporary location.

After you prepare these two temporary index files, you can then use the=
m
to populate your left_dir and right_dir like this:

	GIT_DIR=3D$(git rev-parse --git-dir) \
	GIT_WORK_TREE=3D$left_dir \
        GIT_INDEX_FILE=3D$tmp.left_index \
        git checkout-index -a

With this, you do not have to worry about anything about the funny
combinations of where the two "directories" comes from when preparing
the temporary directories to be compared.
