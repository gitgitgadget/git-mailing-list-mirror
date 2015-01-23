From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Re: git: regression with mergetool and answering "n" (backport fix
 / add tests)
Date: Fri, 23 Jan 2015 14:19:07 +0100
Message-ID: <54C24A4B.3000909@thequod.de>
References: <5499BDB2.4070301@thequod.de> <20141226010023.GC14150@gmail.com> <549CB5ED.5040804@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="04vpDHqmw5wnMGsgd6Q3LClq20MCE4FSg"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEe8q-0007hQ-Sf
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbbAWNTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:19:13 -0500
Received: from hahler.de ([188.40.33.212]:36191 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbAWNTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:19:11 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id 94DCE620FC;
	Fri, 23 Jan 2015 14:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:in-reply-to:references:subject:subject
	:mime-version:user-agent:from:from:date:date:message-id:received
	:received; s=postfix2; t=1422019148; bh=Ro1YO2QNsZzykmsIIfyAimIf
	Bze0yv7c4TxM7ajkFQs=; b=W8Ag0ZJSt/3Xew0MhtjOKOTkx7sSHJSdCsIzXfRq
	Nub5qlPdTisgQeSVzC/LR6reI2ot9UuXrf59qr4nzEk0EOqjlB08oO0oFOHDEbYZ
	5Q5SIHDbeqlambs2inf5/FsopPO4OiFsDOehMTR9ymdIUyvuonXHEV0BnAuELRZ9
	GQM=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id 6Q30ia_4p4SL; Fri, 23 Jan 2015 14:19:08 +0100 (CET)
Received: from lenny.thequod.de (ip5b403898.dynamic.kabel-deutschland.de [91.64.56.152])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA;
	Fri, 23 Jan 2015 14:19:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <549CB5ED.5040804@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262919>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--04vpDHqmw5wnMGsgd6Q3LClq20MCE4FSg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I am a bit surprised that this bug still exists in "maint" / v2.2.2.

Cherry-picking/merging 0ddedd4 fixes it.


Regards,
Daniel.

On 26.12.2014 02:12, Daniel Hahler wrote:
> Hi David,
>=20
> sorry for the confusion - the patch / fix I've mentioned was meant to b=
e
> applied on the commit that caused the regression and not current master=
=2E
>=20
>=20
> Cheers,
> Daniel.
>=20
> On 26.12.2014 02:00, David Aguilar wrote:
>> On Tue, Dec 23, 2014 at 08:08:34PM +0100, Daniel Hahler wrote:
>>> Hi,
>>>
>>> this is in reply to the commits from David:
>>>
>>>     commit 0ddedd4d6b9b3e8eb3557d8ed28e1a0b354a25f8
>>>     Refs: v2.2.0-60-g0ddedd4
>>>     Merge: e886efd 1e86d5b
>>>     Author:     Junio C Hamano <gitster@pobox.com>
>>>     AuthorDate: Fri Dec 12 14:31:39 2014 -0800
>>>     Commit:     Junio C Hamano <gitster@pobox.com>
>>>     CommitDate: Fri Dec 12 14:31:39 2014 -0800
>>>
>>>         Merge branch 'da/difftool-mergetool-simplify-reporting-status=
'
>>>
>>>         Code simplification.
>>>
>>>         * da/difftool-mergetool-simplify-reporting-status:
>>>           mergetools: stop setting $status in merge_cmd()
>>>           mergetool: simplify conditionals
>>>           difftool--helper: add explicit exit statement
>>>           mergetool--lib: remove use of $status global
>>>           mergetool--lib: remove no-op assignment to $status from set=
up_user_tool
>>>
>>> I've ran into a problem, where "git mergetool" (using vimdiff) would =
add
>>> the changes to the index, although you'd answered "n" after not chang=
ing/saving
>>> the merged file.
>>
>> Thanks for the heads-up.
>>
>> Do you perhaps have mergetool.vimdiff.trustExitCode defined, or
>> a similar setting?
>>
>> If you saw the prompt then it should have aborted right after
>> you answered "n".
>>
>> The very last thing merge_cmd() for vimdiff does is call
>> check_unchanged().  We'll come back to check_unchanged() later.
>>
>> I tried to reproduce this issue.  Here's a transcript:
>>
>> ....
>> $ git status -s
>> UU file.txt
>>
>> $ git mergetool -t vimdiff file.txt
>> Merging:
>> file.txt
>>
>> Normal merge conflict for 'file.txt':
>>   {local}: modified file
>>   {remote}: modified file
>> 4 files to edit
>> #### Enter :qall inside vim
>> file.txt seems unchanged.
>> Was the merge successful? [y/n] n
>> merge of file.txt failed
>> Continue merging other unresolved paths (y/n) ? n
>>
>> $ git status -s
>> UU file.txt
>> ....
>>
>> That seemed to work fine.  Any clues?
>> More notes below...
>>
>>> This regression has been introduced in:
>>>
>>>     commit 99474b6340dbcbe58f6c256fdee231cbadb060f4
>>>     Author: David Aguilar <davvid@gmail.com>
>>>     Date:   Fri Nov 14 13:33:55 2014 -0800
>>>
>>>         difftool: honor --trust-exit-code for builtin tools
>>>        =20
>>>         run_merge_tool() was not setting $status, which prevented the=

>>>         exit code for builtin tools from being forwarded to the calle=
r.
>>>        =20
>>>         Capture the exit status and add a test to guarantee the behav=
ior.
>>>        =20
>>>         Reported-by: Adria Farres <14farresa@gmail.com>
>>>         Signed-off-by: David Aguilar <davvid@gmail.com>
>>>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>
>>>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>>>     index c45a020..cce4f8c 100644
>>>     --- a/git-mergetool--lib.sh
>>>     +++ b/git-mergetool--lib.sh
>>>     @@ -221,6 +221,7 @@ run_merge_tool () {
>>>             else
>>>                     run_diff_cmd "$1"
>>>             fi
>>>     +       status=3D$?
>>>             return $status
>>>      }
>>>
>>>
>>> My fix has been the following, but I agree that the changes from Davi=
d
>>> are much better in general.
>>>
>>>     diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>>>     index cce4f8c..fa9acb1 100644
>>>     --- a/git-mergetool--lib.sh
>>>     +++ b/git-mergetool--lib.sh
>>>     @@ -105,6 +105,7 @@ check_unchanged () {
>>>                             esac
>>>                     done
>>>             fi
>>>     +       return $status
>>>      }
>>
>> I don't think this fix does anything.
>> Here is all of check_unchanged() for context:
>>
>> check_unchanged () {
>> 	if test "$MERGED" -nt "$BACKUP"
>> 	then
>> 		return 0
>> 	else
>> 		while true
>> 		do
>> 			echo "$MERGED seems unchanged."
>> 			printf "Was the merge successful? [y/n] "
>> 			read answer || return 1
>> 			case "$answer" in
>> 			y*|Y*) return 0 ;;
>> 			n*|N*) return 1 ;;
>> 			esac
>> 		done
>> 	fi
>> }
>>
>> The addition of "return $status" after the "fi" in the above fix
>> won't do anything because that code is unreachable.
>> We either return 0 or 1.
>>
>>> I haven't verified if it really fixes the regression, but if it does =
it
>>> should get backported into the branches where the regression is prese=
nt.
>>
>> Also, the $status variable doesn't even exist anymore, so the
>> fix is suspect.
>>
>> What platform are you on?
>>
>>> Also, there should be some tests for this.
>>
>> I don't disagree with that ;-)
>>
>> Let me know if you have any clues.  I don't see anything obvious.
>>
>> cheers,
>>
>=20

--=20
http://daniel.hahler.de/


--04vpDHqmw5wnMGsgd6Q3LClq20MCE4FSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFUwkpLfAK/hT/mPgARAmLvAJ9/XR+FSp8eYMuZ9QWkl53qwqr43ACfaOxz
gAyGh5dsc905ni1CGiGIHfg=
=WyCL
-----END PGP SIGNATURE-----

--04vpDHqmw5wnMGsgd6Q3LClq20MCE4FSg--
