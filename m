From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 3/6] Test file for git-remote-mediawiki clone
Date: Wed, 13 Jun 2012 09:20:33 +0200
Message-ID: <4FD83F41.3050101@ensimag.imag.fr>
References: <20120611230954.Horde.inb-aHwdC4BP1l6iLlHhZgA@webmail.minatec.grenoble-inp.fr> <1339535563-18958-1-git-send-email-simon.cathebras@ensimag.imag.fr> <1339535563-18958-3-git-send-email-simon.cathebras@ensimag.imag.fr> <20120612233448.Horde.yFmTWnwdC4BP17X4iOBVZrA@webmail.minatec.grenoble-inp.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.imag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed Jun 13 09:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sehsr-000690-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 09:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab2FMHUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 03:20:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44206 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab2FMHUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 03:20:47 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5D7BYTL015702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jun 2012 09:11:34 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5D7KV5H008057;
	Wed, 13 Jun 2012 09:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120612233448.Horde.yFmTWnwdC4BP17X4iOBVZrA@webmail.minatec.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Jun 2012 09:11:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5D7BYTL015702
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340176299.03088@yPznBkfk95kSKE0B767D1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199875>



On 12/06/2012 23:34, konglu@minatec.inpg.fr wrote:
>
> Simon Cathebras <simon.cathebras@ensimag.imag.fr> a =E9crit :
>
>> From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>>
>> This patch provides some tests for the clone in use by
>> git-remote-mediawiki.
>>
>> Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
>> Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
>> Signed-off-by: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>> Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
>> Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
>> Signed-off-by: Matthieu Moy <matthieu.moy@imag.fr>
>> ---
>>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 238=20
>> +++++++++++++++++++++++++++
>>  1 file changed, 238 insertions(+)
>>  create mode 100755 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
>>
>> diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh=20
>> b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
>> new file mode 100755
>> index 0000000..07e1270
>> --- /dev/null
>> +++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
>> @@ -0,0 +1,238 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (C) 2012
>> +#     Charles Roussel <charles.roussel@ensimag.imag.fr>
>> +#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
>> +#     Julien Khayat <julien.khayat@ensimag.imag.fr>
>> +#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>> +#     Simon Perrat <simon.perrat@ensimag.imag.fr>
>> +#
>> +# License: GPL v2 or later
>> +
>> +
>> +test_description=3D'Test the Git Mediawiki remote helper: git clone=
'
>> +
>> +. ./test-gitmw-lib.sh
>> +. $TEST_DIRECTORY/test-lib.sh
>> +
>> +
>> +test_check_precond
>> +
>> +
>> +test_expect_success 'Git clone creates the git log expected with on=
e=20
>> file' '
>> +    wiki_reset &&
>> +    wiki_editpage foo "this is not important" false -c cat -s "this=
=20
>> must be the same" &&
>> +    git clone=20
>> mediawiki::http://'"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"' mw_dir_1 &&
>> +    (cd mw_dir_1 &&
>> +    git log --format=3D%s HEAD^..HEAD > log.tmp ) &&
>> +    echo "this must be the same" > msg.tmp &&
>> +    diff -b mw_dir_1/log.tmp msg.tmp
>> +'
>
> It's clearer to put it this way:
>
>         git clone [...] &&
>         (
>                 cd ... &&
>                 ....
>         ) &&
>         ....
>

Okay, we are modifiying it right now.

> And, about style:
>     "echo one >one" and not "echo one > one"
>
>
>
same.


Simon C.

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
