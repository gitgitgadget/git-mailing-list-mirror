From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Tue, 09 Dec 2014 09:30:58 +0100
Message-ID: <5486B342.8090800@drmicha.warpmail.net>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org>	 <1417878270-4364-2-git-send-email-philipoakley@iee.org> <1418096636.19104.31.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: =?ISO-8859-15?Q?S=E9rgio_Basto?= <sergio@serjux.com>,
	Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:31:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyGCL-0002iU-Bs
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 09:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbaLIIbE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 03:31:04 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60671 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825AbaLIIbD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 03:31:03 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 21D6D209E9
	for <git@vger.kernel.org>; Tue,  9 Dec 2014 03:31:00 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 09 Dec 2014 03:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=GolLEhln6hCq4cW4qs9GXr
	J9tgE=; b=MVFi5NvftT+QFuzvUIus0RfefFAgz8ch0L7dwEmroGzJuSL9rgvZ0c
	nmBzKYagcHv0DQ6PvMALVmRi/r9koXG9qlkW4wp4Gq2qkp9Ub+JFPVHc24z61PFW
	oKeP3qBfqZaybO6IU7UQUKRDYJc8+DFscMv1phdXawQXOrrnyW+VI=
X-Sasl-enc: Vnkoc29Z9ltpGeQMVNpwLqUfgmeHxfNjd7Lptk14xOfl 1418113859
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2B3DEC00281;
	Tue,  9 Dec 2014 03:30:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1418096636.19104.31.camel@segulix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261114>

S=E9rgio Basto schrieb am 09.12.2014 um 04:43:
> On S=E1b, 2014-12-06 at 15:04 +0000, Philip Oakley wrote:=20
>> Many users misunderstand the --assume-unchanged contract, believing
>> it means Git won't look at the flagged file.
>>
>> Be explicit that the --assume-unchanged contract is by the user that
>> they will NOT change the file so that Git does not need to look (and
>> expend, for example, lstat(2) cycles)
>>
>> Mentioning "Git stops checking" does not help the reader, as it is
>> only one possible consequence of what that assumption allows Git to
>> do, but
>>
>>    (1) there are things other than "stop checking" that Git can do
>>        based on that assumption; and
>>    (2) Git is not obliged to stop checking; it merely is allowed to.
>>
>> Also, this is a single flag bit, correct the plural to singular, and
>> the verb, accordingly.
>>
>> Drop the stale and incorrect information about "poor-man's ignore",
>> which is not what this flag bit is about at all.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/git-update-index.txt | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-=
update-index.txt
>> index e0a8702..da1ccbc 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -78,20 +78,18 @@ OPTIONS
>>          Set the execute permissions on the updated files.
>> =20
>>  --[no-]assume-unchanged::
>> -	When these flags are specified, the object names recorded
>> -	for the paths are not updated.  Instead, these options
>> -	set and unset the "assume unchanged" bit for the
>> -	paths.  When the "assume unchanged" bit is on, Git stops
>> -	checking the working tree files for possible
>> -	modifications, so you need to manually unset the bit to
>> -	tell Git when you change the working tree file. This is
>> +	When this flag is specified, the object names recorded
>> +	for the paths are not updated.  Instead, this option
>> +	sets/unsets the "assume unchanged" bit for the
>> +	paths.  When the "assume unchanged" bit is on, the user
>> +	promises not to change the file and allows Git to assume
>> +	that the working tree file matches what is recorded in
>> +	the index.  If you want to change the working tree file,
>> +	you need to unset the bit to tell Git.  This is
>>  	sometimes helpful when working with a big project on a
>>  	filesystem that has very slow lstat(2) system call
>>  	(e.g. cifs).
>>  +
>> -This option can be also used as a coarse file-level mechanism
>> -to ignore uncommitted changes in tracked files (akin to what
>> -`.gitignore` does for untracked files).
>>  Git will fail (gracefully) in case it needs to modify this file
>>  in the index e.g. when merging in a commit;
>>  thus, in case the assumed-untracked file is changed upstream,
>=20
> I don't understand why you insist that we have a contract,=20

Buy setting the bit, you are making the promise to Git: "You can assume
the file is unchanged without even checking."

> when :=20
> "git diff .", "git diff -a" and "git commit -a" have a different
> behavior of "git commit ." , this is not about any contract this is
> about coherency and be user friendly .=20

Git does not make the promise that it will not check.

> At least if you want keep things like that, wrote in doc, clearly, th=
at
> assume-unchanged flag *is not*, to git ignoring changes in tracked fi=
les
> and currently not ignore files for git commit <path> and may not work=
 in
> other cases .=20
>=20
> Also don't understand why --assumed-untracked shouldn't deal with
> changed files instead fallback in "the user promises not to change th=
e
> file" and sometimes works others not.=20
>=20
> Also if this is the contract when a file is different from commit,
> should warning the user that is not in contract (modify files that ar=
e
> assumed-untracked )=20
>=20
>=20
> Thanks,=20
>=20

git update-index is a plumbing command, not a user frontend. If you use
it and bring workdir/index into an inconsistent state it's simply the
wrong use of a plumbing tool. Things tend to break when you use a
plumbing tool incorrectly ;)

That being said, there is some wrong advice in gitignore.txt that we
should remove.

In git-update-index.txt, we could try and spell this out even more clea=
rly:

=2E.allows Git to assume... in the index; nonetheless Git may check the
working tree file under some circumstances.

And maybe we could specify in all man pages the category of a command,
or a warning for plumbing commands ("plumbing - use at own risk").

Michael
