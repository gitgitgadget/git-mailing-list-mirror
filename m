From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: add infrastructure for translating Git with
 gettext
Date: Tue, 15 Nov 2011 00:04:14 -0800
Message-ID: <7vlirhx14x.fsf@alter.siamese.dyndns.org>
References: <1321191835-24062-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:04:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQE0F-0005UH-8t
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 09:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1KOIES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 03:04:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab1KOIES convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 03:04:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2E73070;
	Tue, 15 Nov 2011 03:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P5mcQbgvM42y
	iEyYHgtuVYXPtV4=; b=I3ZiZkdyA6RKdCnWS4PrvVG3y6HvWb49F36Rk8ft3OOg
	ZwHvqW0pkp+BPQfn9B/4ElOkGa1ddQvN/19gtO70vE+T3GllQRTC3GJ82QGIUSY7
	PgT5SetyTNBSHoRLLJiU9yDmnME2c5Vp/KqEZyIn7qAi8pRuTU/ya5iQnM1RrZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Pgs3dR
	0ITHDisYP/ZjPxAXmI0yIIWMI7AG7vVBEGLAF6h/obAOCY2Zk4qGmYcP7VhgWnI+
	9VjqDvhDtxA6LwuCntfixAGVA9qZ8PH22Kfo2HaJaKMZJzt2bp3gOi+oKlGJgKsf
	Nch6IT2jATBHugD+b9j0eyZv3IdXgSpq9r/7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31381306F;
	Tue, 15 Nov 2011 03:04:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BC58306E; Tue, 15 Nov 2011
 03:04:16 -0500 (EST)
In-Reply-To: <1321191835-24062-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 13 Nov
 2011 14:43:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69EB30E6-0F60-11E1-B974-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185441>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the skeleton implementation of i18n in Git to one that can sho=
w
> localized strings to users for our C, Shell and Perl programs using
> either GNU libint or the Solaris gettext implementation.

Happy ;-).

Isn't it libintl, though?

> This new internationalization support is enabled by default. If
> gettext isn't available, or if Git is compiled with
> NO_GETTEXT=3DYesPlease, Git fall back on its current behavior of show=
ing

s/fall/falls/;

> This change is somewhat large because as well as adding a C, Shell an=
d
> Perl i18n interface we're adding a lot of tests for them, and for
> those tests to work we need a skeleton PO file to actually test
> translations.

You _could_ split it up this way, I think, if you really wanted to:

 * The mechanism, i.e. integration with libintl and gettext, without an=
y
   translated strings but with the .pot file, with tests to make sure i=
n a
   locale that is missing *.mo files for it, we get the default output;

 * Sample translation for is_IS locale, with tests to make sure that we
   get translated output in a locale that has *.mo files for it.

But I am not sure if that is better.

> diff --git a/.gitignore b/.gitignore
> index 8572c8c..c47f3a8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -224,3 +224,4 @@
>  *.pdb
>  /Debug/
>  /Release/
> +/share/

I somehow find it distasteful that this is overly wide; same with the
change in Makefile to "rm -rf share/". I suspect it wouldn't be the cas=
e
if it were limited to share/locale/ or something.

But perhaps we would never ship anything in share/ and things in there
will always come from elsewhere.

> diff --git a/Makefile b/Makefile
> index ee34eab..896f5fd 100644
> --- a/Makefile
> +++ b/Makefile
> ...
> @@ -2435,6 +2507,7 @@ clean:
>  	$(RM) $(TEST_PROGRAMS)
>  	$(RM) -r bin-wrappers
>  	$(RM) -r $(dep_dirs)
> +	$(RM) -r po/git.pot share/

It seems "distclean" tells us to clean po/git.pot, which hints at me th=
at
normal "clean" shouldn't?
