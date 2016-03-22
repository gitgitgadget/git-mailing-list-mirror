From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name issues
Date: Tue, 22 Mar 2016 13:44:11 -0700
Message-ID: <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
	<56F18F5E.9090301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:44:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTA3-00014X-My
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbcCVUoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 16:44:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750696AbcCVUoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 16:44:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 678724ED3B;
	Tue, 22 Mar 2016 16:44:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=piVkymif87lY
	tmmLX6T2Z+Ag5Vo=; b=DWQVlpHNZHXmR30peOfRln8cpOg9YNks9YVmhOj83sBa
	K32ftCWVldrguPFsMfq915yC+ZpI04eZQjSlVV458hVsm38iGks4Q9N1rG2vJt1P
	mAfo8HaPn5aKgtMPk6KKS3FoqpE1YJytiUxmtS51iK88/ldyGIbOs8quWgx7u8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jPNwRy
	3/u3MNk+hdHj3l8GJdAzo2Voq5f/xGJj5/pTaHzp36/m6AUxLA0QX2mnOPHbQC55
	2yLCpndQ4Tq/YOfCpyDjfgiFi0j7C1OZ3aBmUkrJDlJNChBPr6pbYPam1cfn/Sau
	XpHbvqSprcpJ5LFw50gUJNVuT1oEUHsR4+T9U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EC024ED3A;
	Tue, 22 Mar 2016 16:44:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDC264ED38;
	Tue, 22 Mar 2016 16:44:12 -0400 (EDT)
In-Reply-To: <56F18F5E.9090301@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 22 Mar 2016 19:30:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5CB27A0-F06E-11E5-B8A5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289558>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2016-03-22 18.43, Johannes Schindelin wrote:
>> These two tests wanted to write file names which are incompatible wi=
th
>> Windows' file naming rules.
>>=20
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Is there a chance to squeeze in a precondition for HFS under Mac OS ?

So you want this squashed into it?

 t/t9115-git-svn-dcommit-funky-renames.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn=
-dcommit-funky-renames.sh
index 864395e..a87d3d3 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fr=
esh-cloned repository' '
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
 prepare_a_utf8_locale
-test_expect_success UTF8,!MINGW 'svn.pathnameencoding=3Dcp932 new file=
 on dcommit' '
+test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=
=3Dcp932 new file on dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
 	neq=3D$(printf "\201\202") &&
@@ -105,7 +105,7 @@ test_expect_success UTF8,!MINGW 'svn.pathnameencodi=
ng=3Dcp932 new file on dcommit'
 '
=20
 # See the comment on the above test for setting of LC_ALL.
-test_expect_success !MINGW 'svn.pathnameencoding=3Dcp932 rename on dco=
mmit' '
+test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=3Dcp=
932 rename on dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
 	inf=3D$(printf "\201\207") &&
