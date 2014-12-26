From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Re: git: regression with mergetool and answering "n" (backport fix
 / add tests)
Date: Fri, 26 Dec 2014 02:12:13 +0100
Message-ID: <549CB5ED.5040804@thequod.de>
References: <5499BDB2.4070301@thequod.de> <20141226010023.GC14150@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GmAgpGMoQQAWub7qkoleXLt4ivbWJihsu"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 02:17:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4JWp-0000Wx-7A
	for gcvg-git-2@plane.gmane.org; Fri, 26 Dec 2014 02:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbaLZBMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2014 20:12:17 -0500
Received: from hahler.de ([188.40.33.212]:57456 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbaLZBMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2014 20:12:16 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 84F8F6204B;
	Fri, 26 Dec 2014 02:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:in-reply-to:references:subject:subject
	:mime-version:user-agent:from:from:date:date:message-id:received
	:received; s=postfix2; t=1419556333; bh=+awj9hVoN3FEk3OCdbNBhqST
	QIOFjsTUabuOaEXydRw=; b=d8ja7m7yc2YhvLuHFZE/UAUaPalpQmUTHFYa9GZ/
	0sUV3kF7+umZZC9P1f7+qt7/Xfz47geIoca8kLHdmWX5J+O6aSPfpE3dGFPvplSC
	HSQ9kRKgWJR8l8AjknG68vUdPWwojtn+lTnOCOaXi0S+anKdlP1SXTy+MU7QGUtk
	Gm8=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id AtoF_NOTYSkQ; Fri, 26 Dec 2014 02:12:13 +0100 (CET)
Received: from lenny.thequod.de (p5DE6FC4C.dip0.t-ipconnect.de [93.230.252.76])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA;
	Fri, 26 Dec 2014 02:12:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141226010023.GC14150@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261825>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GmAgpGMoQQAWub7qkoleXLt4ivbWJihsu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

sorry for the confusion - the patch / fix I've mentioned was meant to be
applied on the commit that caused the regression and not current master.


Cheers,
Daniel.

On 26.12.2014 02:00, David Aguilar wrote:
> On Tue, Dec 23, 2014 at 08:08:34PM +0100, Daniel Hahler wrote:
>> Hi,
>>
>> this is in reply to the commits from David:
>>
>>     commit 0ddedd4d6b9b3e8eb3557d8ed28e1a0b354a25f8
>>     Refs: v2.2.0-60-g0ddedd4
>>     Merge: e886efd 1e86d5b
>>     Author:     Junio C Hamano <gitster@pobox.com>
>>     AuthorDate: Fri Dec 12 14:31:39 2014 -0800
>>     Commit:     Junio C Hamano <gitster@pobox.com>
>>     CommitDate: Fri Dec 12 14:31:39 2014 -0800
>>
>>         Merge branch 'da/difftool-mergetool-simplify-reporting-status'=

>>
>>         Code simplification.
>>
>>         * da/difftool-mergetool-simplify-reporting-status:
>>           mergetools: stop setting $status in merge_cmd()
>>           mergetool: simplify conditionals
>>           difftool--helper: add explicit exit statement
>>           mergetool--lib: remove use of $status global
>>           mergetool--lib: remove no-op assignment to $status from setu=
p_user_tool
>>
>> I've ran into a problem, where "git mergetool" (using vimdiff) would a=
dd
>> the changes to the index, although you'd answered "n" after not changi=
ng/saving
>> the merged file.
>=20
> Thanks for the heads-up.
>=20
> Do you perhaps have mergetool.vimdiff.trustExitCode defined, or
> a similar setting?
>=20
> If you saw the prompt then it should have aborted right after
> you answered "n".
>=20
> The very last thing merge_cmd() for vimdiff does is call
> check_unchanged().  We'll come back to check_unchanged() later.
>=20
> I tried to reproduce this issue.  Here's a transcript:
>=20
> ....
> $ git status -s
> UU file.txt
>=20
> $ git mergetool -t vimdiff file.txt
> Merging:
> file.txt
>=20
> Normal merge conflict for 'file.txt':
>   {local}: modified file
>   {remote}: modified file
> 4 files to edit
> #### Enter :qall inside vim
> file.txt seems unchanged.
> Was the merge successful? [y/n] n
> merge of file.txt failed
> Continue merging other unresolved paths (y/n) ? n
>=20
> $ git status -s
> UU file.txt
> ....
>=20
> That seemed to work fine.  Any clues?
> More notes below...
>=20
>> This regression has been introduced in:
>>
>>     commit 99474b6340dbcbe58f6c256fdee231cbadb060f4
>>     Author: David Aguilar <davvid@gmail.com>
>>     Date:   Fri Nov 14 13:33:55 2014 -0800
>>
>>         difftool: honor --trust-exit-code for builtin tools
>>        =20
>>         run_merge_tool() was not setting $status, which prevented the
>>         exit code for builtin tools from being forwarded to the caller=
=2E
>>        =20
>>         Capture the exit status and add a test to guarantee the behavi=
or.
>>        =20
>>         Reported-by: Adria Farres <14farresa@gmail.com>
>>         Signed-off-by: David Aguilar <davvid@gmail.com>
>>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>>     index c45a020..cce4f8c 100644
>>     --- a/git-mergetool--lib.sh
>>     +++ b/git-mergetool--lib.sh
>>     @@ -221,6 +221,7 @@ run_merge_tool () {
>>             else
>>                     run_diff_cmd "$1"
>>             fi
>>     +       status=3D$?
>>             return $status
>>      }
>>
>>
>> My fix has been the following, but I agree that the changes from David=

>> are much better in general.
>>
>>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>>     index cce4f8c..fa9acb1 100644
>>     --- a/git-mergetool--lib.sh
>>     +++ b/git-mergetool--lib.sh
>>     @@ -105,6 +105,7 @@ check_unchanged () {
>>                             esac
>>                     done
>>             fi
>>     +       return $status
>>      }
>=20
> I don't think this fix does anything.
> Here is all of check_unchanged() for context:
>=20
> check_unchanged () {
> 	if test "$MERGED" -nt "$BACKUP"
> 	then
> 		return 0
> 	else
> 		while true
> 		do
> 			echo "$MERGED seems unchanged."
> 			printf "Was the merge successful? [y/n] "
> 			read answer || return 1
> 			case "$answer" in
> 			y*|Y*) return 0 ;;
> 			n*|N*) return 1 ;;
> 			esac
> 		done
> 	fi
> }
>=20
> The addition of "return $status" after the "fi" in the above fix
> won't do anything because that code is unreachable.
> We either return 0 or 1.
>=20
>> I haven't verified if it really fixes the regression, but if it does i=
t
>> should get backported into the branches where the regression is presen=
t.
>=20
> Also, the $status variable doesn't even exist anymore, so the
> fix is suspect.
>=20
> What platform are you on?
>=20
>> Also, there should be some tests for this.
>=20
> I don't disagree with that ;-)
>=20
> Let me know if you have any clues.  I don't see anything obvious.
>=20
> cheers,
>=20

--=20
http://daniel.hahler.de/


--GmAgpGMoQQAWub7qkoleXLt4ivbWJihsu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFUnLXtfAK/hT/mPgARAliUAKDcPZ89efsfaU3lBnlP7VwqqEy1DACeI0ie
Ide7drZ9SZ2jzKv3gN4OsJ8=
=Djq0
-----END PGP SIGNATURE-----

--GmAgpGMoQQAWub7qkoleXLt4ivbWJihsu--
