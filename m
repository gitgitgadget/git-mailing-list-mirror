From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Mon, 09 Mar 2015 10:47:14 +0100
Message-ID: <54FD6C22.4020808@drmicha.warpmail.net>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com> <20150308220424.GD4245@vauxhall.crustytoothpaste.net> <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com> <20150309012214.GE4245@vauxhall.crustytoothpaste.net> <E72F95BF-BE00-433E-9D05-0DDF1CACCCC1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUuHS-0004P8-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 10:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbbCIJrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 05:47:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55417 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753531AbbCIJrQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 05:47:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B86902163F
	for <git@vger.kernel.org>; Mon,  9 Mar 2015 05:47:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 09 Mar 2015 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=EPkCdhcHJAqxN6rjytElJb
	2/L7I=; b=rge6X3HgFNFG3pI+8vaO5uzF97rVdmoW1GhVCyIGq5h1hyiUYwQtGj
	i5Nh8kItXwhZqcXXWeq4xuQEVFlkpasQogTV674J9rLPPF6YGZUjVJMzSYLG+4fN
	KTaVyagdE3ttxXHJnC5O/SG7cWvnTUXRXJRmzsp6XShsmrJhwGoFo=
X-Sasl-enc: +ySr5I7lZLt6u8UGTRSuOpzGGlAPANyKV3o1Ic+n84Jy 1425894435
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4AD1C680123;
	Mon,  9 Mar 2015 05:47:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <E72F95BF-BE00-433E-9D05-0DDF1CACCCC1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265140>

Kyle J. McKay venit, vidit, dixit 09.03.2015 06:32:
> On Mar 8, 2015, at 18:22, brian m. carlson wrote:
>=20
>> On Sun, Mar 08, 2015 at 06:15:55PM -0400, Eric Sunshine wrote:
>>> On Sun, Mar 8, 2015 at 6:04 PM, brian m. carlson
>>> <sandals@crustytoothpaste.net> wrote:
>>>> Perhaps this is better?
>>>>
>>>> Unfortunately when running the test, that message is found in the =
 =20
>>>> standard
>>>> output of git show -s --show-signature, but in the standard  error=
 =20
>>>> of git
>>>> verify-commit -v causing the comparisons of both standard  output =
=20
>>>> and
>>>> standard error to fail.
>>>
>>> That doesn't help me parse it any better.  It's the "but" without a
>>> corresponding "not" which seems to be throwing me off. Typically, o=
ne
>>> would write "this but not that" or "not this but that". I can't tel=
l
>>> if there is a "not" missing or if the "but" is supposed to be an =20
>>> "and"
>>> or if something else was intended.
>>
>> The intended meaning is "and" with the additional sense of contrast.=
 =20
>> The sentence, if read with verbal emphasis, is, "=85is found in the =
=20
>> standard *output* of git show -s --signature, but in the standard =20
>> *error* of git verify-commit -v", thus demonstrating why the test =20
>> fails: the pairs of output files don't match up.
>>
>> Maybe you can suggest a less confusing wording.
>=20
> I like Brian's wording, but how about this slight variation, does thi=
s =20
> parse any better for you?
>=20
> Unfortunately when running the test, while that message is found in
> the standard output of git show -s --show-signature, it is found in
> the standard error of git verify-commit -v causing the comparisons
> of both standard output and standard error to fail.
>=20
> -Kyle
>=20

That still makes it sound as if we'd rather fix "git show" than adjust
the test to such surprising behavior.

But in fact, "git verify-commit" uses stdout and stderr to separate its
output appropriately, whereas "git show" lumps everything together on
stdout, so that the test has to split it up again.

Now, if I read it correctly, the patch suggests ignoring the insecure
memory warning from both outputs rather than putting it on the correct
side of the split.

I'd rather put it on the correct side (or silence gpg by setting its
config).

Michael
