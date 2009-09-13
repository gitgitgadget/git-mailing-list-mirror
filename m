From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 2/2] gitweb: append short hash ids to snapshot
 files
Date: Sat, 12 Sep 2009 22:57:16 -0700
Message-ID: <7vr5ub1j5v.fsf@alter.siamese.dyndns.org>
References: <4AAC2917.6000306@mailservices.uwaterloo.ca>
 <7v7hw34ivl.fsf@alter.siamese.dyndns.org>
 <4AAC85AC.9080004@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmi5d-0002Hq-7E
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbZIMF5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 01:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZIMF5Y
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:57:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbZIMF5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 01:57:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57FDA4EEF2;
	Sun, 13 Sep 2009 01:57:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZvY+md5IeKLg
	qGQylkhrfm8plHE=; b=mGgiCs7vtd/UOf+VKsjgYyfA4Cakxxr+L6RyXLI/jGh4
	44aWZXL4a7QpH4PsaVAYXZzpPn+fXM10CvAaEeGm/xNU+h0JMbEGBjwDYwafcG2Q
	bhc0jTgTmN43isqyMhIiaRhT0xH33M1AozesoGC/g5qzErToXdg4qcnBkJA/a8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JBrsLP
	53+AA69br4CoGJIs/E+2HTBKpr/CXWdKcB8e5mNy29U4U/kixe2y16XIRpnX1Jwi
	WS7JNJ9XRNokGPNDyqJ5FhthCFcJJsz8LC3W/tCwdq2Su92rcpVB4KHBVczqBBjw
	rTBKn6opxReWnavxvCKDWJyM6iapv5rch+FOg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A67C4EEF1;
	Sun, 13 Sep 2009 01:57:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B44584EEEE; Sun, 13 Sep 2009
 01:57:18 -0400 (EDT)
In-Reply-To: <4AAC85AC.9080004@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Sun\, 13 Sep 2009 01\:39\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E5992C0-A02A-11DE-8215-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128338>

Mark Rada <marada@uwaterloo.ca> writes:

> This was a manifestation of a suggestion from Jakub:
>
>> Second, I'd rather have better names for snapshots than using full S=
HA-1.
>> For snapshot of 'v1.5.0' of repository 'repo.git' I'd prefer for sna=
pshot
>> to be named 'repo-v1.5.0', and for snapshot of 'next' branch of the =
same

I think I've already said "Don't use $full_hash but if the user gave yo=
u
descriptive e.g. v1.5.0 in $hash just use it", which I think matches wh=
at
Jakub said above.

>> project to be named for example 'repo-next-20090909', or perhaps
>> 'repo-next-2009-09-10T09:16:18' or 'repo-next-20090909-g5f6b0ff',
>> or 'repo-v1.6.5-rc0-164-g5f6b0ff'.

I do not particularly care about these, except that if the user asked f=
or
'next', that string should be in the name somewhere, so the last one is
unnacceptable to me.  I'd rather vote for naming it just 'repo-next', a=
s
if I were writing a robot that goes once-a-day to next and download, I
would likely to be doing it like this:

	D=3D`date +'%Y-%m-%d'` && mkdir "$D" && cd "$D" || exit
        wget ...snapshot-url-for-next-branch...
	wget ...snapshot-url-for-some-other-branch...
	wget ...snapshot-url-for-even-some-other-repository...
	...

and I do not want any frills other than what I _asked_ gitweb to give m=
e,
which is "this repository, this branch".

But that is just my personal preference.  Treat it as no heavier than a
feature request from a random list participant.  It does not carry any
more weight than that merely because it comes from me.

> For me, there are two fates that snapshots will end up with: being de=
leted
> as soon as I have unrolled the contents, or long term archiving. For =
the
> latter case, it is nice to have an idea of when it came from, though =
I
> guess I should have appended a date in that case... =C2=AF\(=C2=B0_o)=
/=C2=AF

What date do you mean?  The commit date?  Or download date?

As long as it is clear which revision the snapshot came from, I do not
think anything fancier is necessary.

Besides, don't the paths in the archive have the timestamp of the commi=
t
object?

If you are talking about download date for archival use, I think the
timestamp of the archive file itself is sufficient, and the person who =
is
downloading can (re)name the result in whatever way he wants.
