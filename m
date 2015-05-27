From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] config: add options to list only variable names
Date: Wed, 27 May 2015 23:34:29 +0200
Message-ID: <20150527233429.Horde.PBcL7R4evwj_kC7y78ZSIA2@webmail.informatik.kit.edu>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
 <20150527210438.GB22815@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 23:35:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxiyc-0002aE-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbbE0Ve5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2015 17:34:57 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38407 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922AbbE0Ve5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:34:57 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YxiyQ-0003UY-8P; Wed, 27 May 2015 23:34:50 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Yxiy5-0005du-G4; Wed, 27 May 2015 23:34:29 +0200
Received: from x590c2e9c.dyn.telefonica.de (x590c2e9c.dyn.telefonica.de
 [89.12.46.156]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 27 May 2015 23:34:29 +0200
In-Reply-To: <20150527210438.GB22815@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1432762490.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270100>


Quoting Jeff King <peff@peff.net>:

> On Wed, May 27, 2015 at 10:07:19PM +0200, SZEDER G=C3=A1bor wrote:
>
>> Help the completion script by introducing the '--list-names' and
>> '--get-names-regexp' options, the "names-only" equivalents of '--lis=
t' and
>> '--get-regexp', so it doesn't have to separate variable names from t=
heir
>> values anymore.
>
> Thanks, this sounds like the best solution. It should be a tiny bit m=
ore
> efficient, too, though I doubt it matters much in practice.
>
>> -'git config' [<file-option>] [-z|--null] -l | --list
>> +'git config' [<file-option>] [-z|--null] -l | --list | --list-name
>
> s/list-name/&s/, to match the code (and your commit message).

And note how I added an extra 's' to the other option in the commit mes=
sage!

>>  cat > expect << EOF
>> +beta.noindent
>> +nextsection.nonewline
>> +123456.a123
>> +version.1.2.3eX.alpha
>> +EOF
>> +
>> +test_expect_success 'working --list-names' '
>> +	git config --list-names > output &&
>> +	test_cmp expect output
>> +'
>> +
>> +cat > expect << EOF
>
> We usually avoid the extra space after redirection operators. But we
> also usually match existing code. I'm not sure which is more evil in
> this case. ;)
>
>> +test_expect_success '--get-name-regexp' '
>> +	git config --get-name-regexp in >output &&
>> +	test_cmp expect output
>> +'
>
> This one is the odd man out if you are following existing style,
> though.

Heh, in both cases I simply copied the existing "name-less" test, and =20
only adjusted the expected output and the name of the option to test. :=
)

Will reroll.

G=C3=A1bor
