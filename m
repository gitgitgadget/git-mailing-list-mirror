From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH v4 6/6] send-email: add option --cite to quote the message
 body
Date: Thu, 16 Jun 2016 00:21:47 +0200
Message-ID: <f049d7cd-d178-8a8e-3672-98e5113afd3a@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130833.32274-1-samuel.groot@grenoble-inp.org>
 <vpqvb1ir38m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, gitster@pobox.com,
	aaron@schrab.com, e@80x24.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:21:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDJC9-0003ZV-CG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 00:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbcFOWVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 18:21:53 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:37639 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbcFOWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 18:21:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F1F0520AD;
	Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7h9ihLkoMHL; Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D597820A7;
	Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C99AF2066;
	Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mp8wVQ5IaykC; Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
Received: from [192.168.1.14] (LFbn-1-1723-208.w90-65.abo.wanadoo.fr [90.65.92.208])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 58AA02064;
	Thu, 16 Jun 2016 00:21:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpqvb1ir38m.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297405>

Le 09/06/2016 =C3=A0 13:49, Matthieu Moy a =C3=A9crit :
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>=20
>> If used with `in-reply-to=3D<email_file>`, cite the message body of =
the given
>> email file. Otherwise, do nothing.
>=20
> It should at least warn when --in-reply-to=3D<email_file> is not give=
n
> (either no --in-reply-to or --in-reply-to=3D<id>). I don't see any
> use-case where a user would want --cite on the command-line and not w=
ant
> --in-reply-to=3D<email_file>. OTOH, it seems a plausible user-error, =
and
> the user would appreciate a message saying what's going on.

You're right. We'll warn the user with the next version.

>> @@ -56,6 +57,8 @@ git send-email --dump-aliases
>>      --subject               <str>  * Email "Subject:"
>>      --in-reply-to           <str>  * Email "In-Reply-To:"
>>      --in-reply-to          <file>  * Populate header fields appropr=
iately.
>> +    --cite                         * Quote the message body in the =
cover if
>> +                                     --compose is set, else in the =
first patch.
>>      --[no-]xmailer                 * Add "X-Mailer:" header (defaul=
t).
>>      --[no-]annotate                * Review each patch that will be=
 sent in an editor.
>>      --compose                      * Open an editor for introductio=
n.
>=20
> Just wondering: would it make sense to activate --cite by default whe=
n
> --in-reply-to=3Dfile is used, and to allow --no-cite to disable this?
> This is something we can easily do now without breaking backward
> compatibility (--in-reply-to=3Dfile doesn't exist yet), but would be =
more
> painful to do later.

Indeed, it can be more intuitive especially for a user who is used to
cite messages.

>> @@ -640,6 +644,7 @@ if (@files) {
>>  	usage();
>>  }
>> =20
>> +my $message_cited;
>=20
> Nit: I read "$message_cited" as "Boolean saying whether the message w=
as
> cited". $cited_message would be clearer to me (but this is to be take=
n
> with a grain of salt as I'm not a native speaker), since the variable
> holds the content of the cited message.

Sorry, French habits.. :-)

>> +sub do_insert_cited_message {
>> +	my $tmp_file =3D shift;
>> +	my $original_file =3D shift;
>> +
>> +	open my $c, "<", $original_file
>> +	or die "Failed to open $original_file: " . $!;
>> +
>> +	open my $c2, ">", $tmp_file
>> +		or die "Failed to open $tmp_file: " . $!;
>> +
>> +	# Insertion after the triple-dash
>> +	while (<$c>) {
>> +		print $c2 $_;
>> +		last if (/^---$/);
>> +	}
>> +	print $c2 $message_cited;
>=20
> I would add a newline here to get a blank line between the message ci=
ted
> and the diffstat.

Agreed.

> I think non-ascii characters would deserve particular attention here
> too. For example, if the patch contain only ascii and the cited part
> contains UTF-8, does the generated patch have a proper Content-type:
> header?
>=20
> I can imagine worse, like a patch containing latin1 character and a
> cited message with another 8-bit encoding.

I tried to manage them with the built-in Base64 module but there is
still work in progress.

>> +test_expect_success $PREREQ 'correct cited message with --in-reply-=
to and --compose' '
>> +	grep "> On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wro=
te:" msgtxt3 &&
>=20
> I would prefer to have the full address including the real name here =
(A
> <author@example.com>) in this example. Actually, after a quick look a=
t
> the code, I don't understand where the name has gone (what's shown he=
re
> is extracted from the From: header).

Agreed, I'll figure out where the problem is.
