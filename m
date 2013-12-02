From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 02 Dec 2013 10:18:31 -0800
Message-ID: <xmqq61r7rua0.fsf@gitster.dls.corp.google.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	<CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
	<1385985997.2054.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 19:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnY4t-0002BV-I9
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 19:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3LBSSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 13:18:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab3LBSSe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 13:18:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0702524C3;
	Mon,  2 Dec 2013 13:18:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9GLWDOSfcDbS
	9p7pjY7R/l/x2Ng=; b=A0F5pNUoF9Q4WZELTEEfBp8A8Rup5HaWYpxAIa6q2Pc8
	1tqaJLGlE6WgDvKcGb+wgl5pQ1PaT/4kup92QzjTr4BDzMmTIBnwuUuaYXEWWV2E
	AJoGCEgO38eeaSQEitKSEBk9Pj+EGcuNwvTkps3SFEEWbxjcE/tbRKX6SG7vtWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PeN+h8
	8I1wLnfwMoiXdWu3kKP9y+ZZ3xycOUOHOXOrt9qjvKsECtRY6uV/stktW2o7W9ul
	EkTS4iaucKXYBvshqZAbLAZfJBG4ZwIGQzyYSTpyuA7Mw7XOkwhe2dUZrdisafYs
	g5tZoLJ8HCoVHetDvqjsZH6IwI5TUfEuA4OkY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B303B524C2;
	Mon,  2 Dec 2013 13:18:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CAA2524C1;
	Mon,  2 Dec 2013 13:18:32 -0500 (EST)
In-Reply-To: <1385985997.2054.27.camel@localhost.localdomain> (Krzesimir
	Nowak's message of "Mon, 02 Dec 2013 13:06:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 270FE854-5B7E-11E3-94B4-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238641>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
>> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
>> <krzesimir@endocode.com> wrote:
>>=20
>> > Allow @additional_branch_refs configuration variable to tell gitwe=
b to
>> > show refs from additional hierarchies in addition to branches in t=
he
>> > list-of-branches view.
>> >
>> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
>>=20
>> Why not use %feature hash instead of adding new configuration variab=
le?
>> I think that this option is similar enough to 'remote_heads' feature
>> (which BTW should be 'remote-heads'), and could conceveilably enable=
d
>> on a per-repository basis, i.e. with repository configuration overri=
de,
>> isn't it?
>
> I'd like to see some consensus on it before I start changing the patc=
h
> again.

I missed the remote-heads which is an existing feature when I
commented; if this can be exposed to the users as an extension to
it like Jakub suggests, it may be a better direction.

>> Usually %feature hash is preferred over adding new configuration var=
iable
>> but this is not some hard rule. Note however that patches adding new=
 config
>> are met with more scrutiny, as it is harder to fix mistakes because =
of
>> requirement of backwards compatibility of configuration files.
>
> I don't know what kind of backwards compatibility you mention.

A patch adds new feature controlled by a configuration in one way
(e.g. as a totally new ad-hoc switch that is seemingly orthogonal to
all the existing features), people start using the feature using
that configuration method, and then later we find out that it is
better controlled by a different way (e.g. as a natural extension to
an existing feature, controlled by how the existing feature is
controlled, perhaps after extending it) because it allows more
flexibility in the future.

At that point, we can extend the way the existing feature is
controlled to trigger the new feature in a more uniform way, but we
cannot remove the new ad-hoc switch the patch originally added to
control this new feature because there already are people who are
using it, and we end up having to support the unified and extensible
way to configure, which we prefer to keep in the longer term, and
also the ad-hoc switch the patch added, which we wish we never had
in the first place.  The latter needs to be deprecated and removed
over time.
