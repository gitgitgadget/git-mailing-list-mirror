From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Document format of basic Git objects
Date: Sun, 19 Feb 2012 01:14:20 -0800
Message-ID: <7vboovp4lv.fsf@alter.siamese.dyndns.org>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 <1329624946-32173-1-git-send-email-pclouds@gmail.com>
 <7vlinzp67m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 19 10:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz2qn-0008Tq-Py
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 10:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab2BSJO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 04:14:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab2BSJOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 04:14:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7487D6765;
	Sun, 19 Feb 2012 04:14:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uC60xtMGh1OH
	oSx7/zytFVN6ZrI=; b=fv2d6AaA+5SC0SgSK9/aSBl/9iBrdIXtbSDJOJ/MkQ5g
	bSHQ24deecJVMLrr2w2Fo0A3PqDFhbHsj4enC4yQT3s1tXNPNebvgrOWqzStXB5G
	BwQ5VCEq4vp5b2xoYn7NiLkJdI0wu49xCEWhblqHmOi5MVFYld0TDn6BG3ly2kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e90Wpb
	EV1XB0S3NAwt1OV4NpVsUlvonPgk3GALMtzxp4+7jGIVe0Kiv32LkMHubmwGN+jd
	MNVKK2WYjjmi1MapQyi38a7LUWWQPtSl7soDpCJwcaAWJzSnnMqfV+C3zdVcBLPj
	CJRi8e6VgCiu1b1wbXvazS0X8NiHkq2T+jin8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A526764;
	Sun, 19 Feb 2012 04:14:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A5606761; Sun, 19 Feb 2012
 04:14:21 -0500 (EST)
In-Reply-To: <7vlinzp67m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Feb 2012 00:39:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BEE2A22-5ADA-11E1-8B9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191022>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> Still draft for discussion.

Small clarifications and corrections.

> ... from a larger
> workflow point of view it would not be so useful, as it would involve
> steps like this:
>
> ...
>  * Then you give the general public the resulting commit.

The point of the above is *not* that it involves hash-object or having =
to
preserve both author and committer dates when secondary signers sign th=
e
commit---these are something the tool *could* learn to assist. The poin=
t
is that adding more signatures *must* change the resulting commit objec=
t
name, making it necessary not to expose it to the general public in ord=
er
to avoid history rewinding, which *is* what makes it "not so useful".

And that is why I didn't add such a tool support to help producing the =
end
result that wouldn't be so useful anyway.

>> +TREE OBJECTS
>> +------------
>> +Tree object payload contains a list of entries, each with a mode,
>> +object type, object name, and filename, sorted by filename. It
>> +represents the contents of a single directory tree.
>
> Drop "object type," from this list.  It is inferred from the mode.  I
> personally would prefer to say "path" or "pathname" when the entity
> referred to may not be a regular file.

The principle is not to say "filename" to give an incorrect impression
that we are only talking about a regular file. This principle applies t=
o
pathnames in general (i.e. covers what is recorded in the index, too), =
but
because we are talking about an entry in a tree, "pathname component" i=
s
even better than "path" or "pathname", because it has a specific meanin=
g:
one part of pathname delimited by a slash.

POSIX does use "filename" for this purpose (and mentions "pathname
component" as a synonym), but if we use the word, without clarifying th=
at
this document uses it in the strict POSIX sense, the reader can easily
misunderstand that we mean a more general "name of a regular file".

>> +The object type may be a blob, representing the contents of a file,
>> +another tree, representing the contents of a subdirectory, or a com=
mit
>> +(representing a subproject).
>
> and drop the above line.

Should be obvious from the context, but I meant "drop the above three
lines".

> I personally do not think it is necessary to have the above paragraph=
 at
> all in this object.

s/in this object/in this document/;

>> +Encoding
>> +~~~~~~~~
>
> "Encoding" is such a loaded word and does not help clarify what this
> section is really about, which is "format of a tree entry", or simply
> "Entries".
>
>> +Entries are of variable length and self-delimiting. Each entry
>> +consists of

Actually, title this section as "Tree Entries", and begin the paragraph
with

	Tre entries are of ...delimiting. Each entry consists of...

>> +Ident strings
>> +~~~~~~~~~~~~~
>> +Ident strings record who's responsible of doing something at what
>> +time. For a commit, the ident string in "author" line records who i=
s
>> +the author of the associated changes and when the changes are
>
> s/are/were/, perhaps?  Again, what the purpose of this document?  If =
this
> were more than to strictly describe the "structure", it is OK and eve=
n

s/ more than to/to/;

> preferable to leave the meaning the "author" as vague, but if this we=
re
> also to suggest the best current practice interpretation, it may be w=
orth
> to add something like
>
> 	There may be a case where it is difficult to attribute a commit to
>         a single author; think of it as recording the primary contact=
, the
>         person to ask any questions about the commit if needed later.
