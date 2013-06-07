From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/18] Put long code into a submodule
Date: Thu, 06 Jun 2013 21:51:52 -0700
Message-ID: <7v38suwmjb.fsf@alter.siamese.dyndns.org>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-11-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cT+H2gqVjeBvR7iZ9mKz1+H1w7kt3htKOZxWHgkfq2mNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukoed-0002bE-MX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3FGEv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 00:51:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab3FGEvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 00:51:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2331200BD;
	Fri,  7 Jun 2013 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KKesP3Cf6TSD
	Dhv5uRql0ixns88=; b=OUvhQnjVk5bzC6f+737yNgWu1w0DOkjbZbwF0jdvdWvp
	aWe6EBHppfCcKgjxxQ2ZHyEFBcy5TbI0w4ynAeX6OxezLOuR5wMTtx3i4H8XuoTB
	vdLm6C70pRnsb0WkUz5R0roC/g7HvoPkestheasNr2tQ9ft9Thf39/Zit+2soso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xyCtuS
	ulCQD8qB+1bV9HX90O/X3ZomyLbFqcxCiRp/nW3NTCPs5+6BrmPoRv4iDhziM98t
	U426GOkTjQb+LhMgxTxIjuu09v/OUEulAIxGJgUHjRPuPcpr+NU89a3DndA+PItS
	sSZifPSS0K9yDdPZ6GZYBMFNXOqKbDUkmbkzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D98E5200BC;
	Fri,  7 Jun 2013 04:51:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20C1F200BB;
	Fri,  7 Jun 2013 04:51:54 +0000 (UTC)
In-Reply-To: <CAPig+cT+H2gqVjeBvR7iZ9mKz1+H1w7kt3htKOZxWHgkfq2mNA@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 7 Jun 2013 00:01:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F987E80A-CF2D-11E2-A7DB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226590>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jun 6, 2013 at 3:34 PM, C=C3=A9lestin Matte
> <celestin.matte@ensimag.fr> wrote:
>> Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
>> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> ---

s/into a submodule/into a sub/; or "subroutine".

>>  contrib/mw-to-git/git-remote-mediawiki.perl |   44 ++++++++++++++++=
-----------
>>  1 file changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/m=
w-to-git/git-remote-mediawiki.perl
>> index 1c34ada..1271527 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -133,24 +133,7 @@ while (<STDIN>) {
>>         @cmd =3D split(/ /);
>>         if (defined($cmd[0])) {
>>                 # Line not blank
>> -               if ($cmd[0] eq "capabilities") {
>> -                       die("Too many arguments for capabilities\n")=
 if (defined($cmd[1]));
>> -                       mw_capabilities();
>> -               } elsif ($cmd[0] eq "list") {
>> -                       die("Too many arguments for list\n") if (def=
ined($cmd[2]));
>> -                       mw_list($cmd[1]);
>> -               } elsif ($cmd[0] eq "import") {
>> -                       die("Invalid arguments for import\n") if ($c=
md[1] eq "" || defined($cmd[2]));
>> -                       mw_import($cmd[1]);
>> -               } elsif ($cmd[0] eq "option") {
>> -                       die("Too many arguments for option\n") if ($=
cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
>> -                       mw_option($cmd[1],$cmd[2]);
>> -               } elsif ($cmd[0] eq "push") {
>> -                       mw_push($cmd[1]);
>> -               } else {
>> -                       print STDERR "Unknown command. Aborting...\n=
";
>> -                       last;
>> -               }
>> +               parse_commands();
>>         } else {
>>                 # blank line: we should terminate
>>                 last;
>> @@ -168,6 +151,31 @@ sub exit_error_usage {
>>      die "ERROR: git-remote-mediawiki module was not called with a c=
orrect number of parameters\n";
>>  }
>>
>> +sub parse_commands {
>> +       if ($cmd[0] eq "capabilities") {
>> +               die("Too many arguments for capabilities\n")
>> +                   if (defined($cmd[1]));
>> +               mw_capabilities();
>> +       } elsif ($cmd[0] eq "list") {
>> +               die("Too many arguments for list\n") if (defined($cm=
d[2]));
>> +               mw_list($cmd[1]);
>> +       } elsif ($cmd[0] eq "import") {
>> +               die("Invalid arguments for import\n")
>> +                   if ($cmd[1] eq "" || defined($cmd[2]));
>> +               mw_import($cmd[1]);
>> +       } elsif ($cmd[0] eq "option") {
>> +               die("Too many arguments for option\n")
>> +                   if ($cmd[1] eq "" || $cmd[2] eq "" || defined($c=
md[3]));
>> +               mw_option($cmd[1],$cmd[2]);
>> +       } elsif ($cmd[0] eq "push") {
>> +               mw_push($cmd[1]);
>> +       } else {
>> +               print STDERR "Unknown command. Aborting...\n";
>> +               last;
>
> In the original code, 'last' lived directly in the enclosing 'while'
> loop, but after this patch, it is inside parse_commands(). With 'use
> warnings' enabled, you are going to see an "Exiting subroutine via
> last" diagnostic.
>
>> +       }
>> +       return;
>> +}
>> +
>>  # MediaWiki API instance, created lazily.
>>  my $mediawiki;
