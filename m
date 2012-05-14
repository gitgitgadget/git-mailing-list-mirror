From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional
 argument
Date: Mon, 14 May 2012 09:16:01 -0700
Message-ID: <7vr4umivr2.fsf@alter.siamese.dyndns.org>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
 <CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, normalperson@yhbt.net, trast@student.ethz.ch
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STxwj-0005LY-1X
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128Ab2ENQQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 12:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab2ENQQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 12:16:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64EF29081;
	Mon, 14 May 2012 12:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KPW9uN5KsBBo
	rcCxhHfyVqF/MqI=; b=GQwhKbyKEwMFfbCMVUR80c71ypukXMd3brqsnxkhiCXA
	fQI93Tfsl/tgj75JqWyBTPy/apzU+y/cvyL1mkHws/7dDrWzm6W+XVz9EU2cCfo/
	XmGsXPbCNfvI/w5EFcdrUur7AnDTZEyQqqClpQddIRrk2j2J7RWsEma6XJ0RBl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BVB01+
	6r2L4tbj47JX3Bz936UQ5RO5wDray2ZR8abt2Kwe6UrtbjwR9P6RG25mvJrwLpYB
	oWnaxS773qJWvRzltQOnT0OIM8ZXM/NikAeh1wGnO+CpgF03FgAhlZKCxif+g9Zp
	Hx4J1RRMzIrGIxod7qgmCNC+An/oglNMRGUEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4D39080;
	Mon, 14 May 2012 12:16:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34CA19053; Mon, 14 May 2012
 12:16:03 -0400 (EDT)
In-Reply-To: <CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com> (Jon
 Seymour's message of "Mon, 14 May 2012 22:48:14 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A00265E-9DE0-11E1-8DBD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197778>

Jon Seymour <jon.seymour@gmail.com> writes:

>> =C2=A0'dcommit'::
>> - =C2=A0 =C2=A0 =C2=A0 Commit each diff from a specified head direct=
ly to the SVN
>> + =C2=A0 =C2=A0 =C2=A0 Commit each diff from the current branch dire=
ctly to the SVN
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository, and then rebase or reset (dep=
ending on whether or
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0not there is a diff between SVN and head)=
=2E =C2=A0This will create
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0a revision in SVN for each commit in git.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0It is recommended that you run 'git svn' =
fetch and rebase (not
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pull or merge) your commits against the l=
atest changes in the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0SVN repository.
>> - =C2=A0 =C2=A0 =C2=A0 An optional revision or branch argument may b=
e specified, and
>> - =C2=A0 =C2=A0 =C2=A0 causes 'git svn' to do all work on that revis=
ion/branch
>> - =C2=A0 =C2=A0 =C2=A0 instead of HEAD.
>> - =C2=A0 =C2=A0 =C2=A0 This is advantageous over 'set-tree' (below) =
because it produces
>> - =C2=A0 =C2=A0 =C2=A0 cleaner, more linear history.
>> ++
>> +When an optional git branch name (or a git commit object name)
>> +is specified as an argument, the subcommand works on the specified
>> +branch, not on the current branch.
>> ++
>> +Use of 'dcommit' is preferred to 'set-tree' (below) because it prod=
uces
>> +cleaner, more linear history.
>> =C2=A0+
>
> Mmmm. I wonder if I should have left the original wording of this
> paragraph, but switched the order with respect to the disucssion of
> the optional argument, so that the text reads:
>
>     It is recommended that you run 'git svn' fetch and rebase (not
> pull or merge) your commits against the latest changes in the =C2=A0S=
VN
> repository.
>     This is advantageous over'set-tree' (below) because it produces
> cleaner, more linear history.
>
>     When an optional git branch name (or a git commit object name) is
> specified as an argument, the subcommand works on
>     the specified branch, not on the current branch.

Probably not, but the order in the [PATCH v2] is not optimal, either.  =
I
would think it would read nicer to give "what it does" and then
"recommendations", i.e.

 - (what it does) Commit each diff from the current branch of git to sv=
n.
   With an optional git branch name, the subcommand works on that branc=
h.

 - (recommendations)
   . Do fetch and rebase, not pull and merge. =20
   . Prefer dcommit over set-tree.

The only reason why the original is not ordered that way, as far as I c=
an
tell, is because "It is recommended that" was part of an existing parag=
raph
when dd31da2 (git-svn: allow dcommit to take an alternate head, 2006-12=
-12)
added "An optional ...", so it was tucked after existing paragraph with=
out
reading the resulting whole to see if "at the very end" was the best pl=
ace.
