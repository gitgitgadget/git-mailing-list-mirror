From: Wincent Colaiuta <win@wincent.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sun, 22 Mar 2009 16:54:23 +0100
Message-ID: <FC18101D-268C-40DF-9733-598EE25CAFA6@wincent.com>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org> <0768D909-FCD5-4E5B-95A7-2602824FC431@wincent.com> <7vskl6ekve.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 16:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlQ1o-0003Ci-3h
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZCVPyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 11:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbZCVPyb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:54:31 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:39963 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbZCVPya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 11:54:30 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2MFsNlh017914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 22 Mar 2009 11:54:25 -0400
In-Reply-To: <7vskl6ekve.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114149>

El 21/3/2009, a las 20:28, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>>> Given that git-difftool shares basically all the same options as
>>> "git diff", I think a good long-term plan would be looking at addin=
g
>>> the "--tool" option to "git diff" itself so that users wouldn't hav=
e
>>> to learn a new subcommand, just a new option.
>>
>> What do people think?
>
> I am not "people" but since I was "To:"ed not "Cc:"ed...
>
> I did not comment on it because personally I was not very interested =
=20
> in
> it; admittedly, I do not use difftool myself, but:
>
> (1) "git diff --tool" is more to type than "git difftool"; and

True, although an alias would fix that.

> (2) it requires adding more code to "git diff" for a dubious benefit =
=20
> from
>     end user's point of view.

=46air enough. I was just wondering if we could avoid adding yet anothe=
r =20
command to the already long list of installed commands. I understand =20
that "diff" is actually a thin dispatcher for different modes of =20
operation, but seeing as all of those modes basically boil down to =20
"show me the difference between two things", and that happens to be =20
the purpose of "difftool" as well, I thought it might make sense to =20
combine them.

> When an end user says "I want to compare two things with these =20
> settings
> (e.g. use color, with 5 lines of context, only inside Documentation/=20
> howto
> directory, detect renames with lower-than-usual threashold, ...)", th=
e
> mental model is same whether the two things being compared happens =20
> to be
> index-vs-worktree or tree-vs-index from the end user's point of =20
> view.  It
> makes a lot of sense for "git diff --options" to invoke both modes of
> operations with a similar-looking command line.
>
> Even though the --no-index mode of operation internally does not fit =
=20
> very
> well compared to the original four modes from the implementation =20
> point of
> view, it still naturally fits the end user's mental model and that =20
> is why
> it is given as an option to "git diff".
>
> Does "git difftool" fit well in the end user's mental model in a =20
> similar
> way to "git diff"?  I somehow suspect it doesn't.  What does it mean =
=20
> to
> give "-U8 --color --stat --summary -p --ignore-space-at-eol" options =
=20
> when
> you invoke it, for example?

Good question. Seeing as right now "difftool" just passes all options =20
through to "diff", I guess it's up to the user to pass in options =20
which actually make sense.

Cheers,
Wincent
