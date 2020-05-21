Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D71C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665FB206BE
	for <git@archiver.kernel.org>; Thu, 21 May 2020 13:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lUMALW9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgEUNbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 09:31:42 -0400
Received: from mout.web.de ([212.227.15.4]:54775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgEUNbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 09:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590067888;
        bh=mpaRBhaXpDJTQ3OO9a27ll5WiumZM9c7TpDnCw+nV0s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lUMALW9FBwJk0G4yZPllduFlEb2onG/gHDONm9hFDXRMhzRIyCFyy6V/vk/N7FBMk
         5Z1gSpSJpg/DGyvM8AwdXHpK5xkhOzFcEtSIO74kL3J88S0zs2CHw3DxMyuKHucGBs
         9ZbiIM+DE/yMccKNHOP0cCxd8WrTFsq8gnZJYzZ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwD3G-1iyhvN3FzK-0186iV; Thu, 21
 May 2020 15:31:27 +0200
Subject: Re: [PATCH 2/4] t1450: increase test coverage of in-tree d/f
 detection
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
 <106c58e1-9c74-46e3-c83a-88eee114d9d6@web.de>
 <20200521102053.GA578930@generichostname>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1f982a11-358c-195d-21f4-0299f5b60ff2@web.de>
Date:   Thu, 21 May 2020 15:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521102053.GA578930@generichostname>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lKkq8BP0eaiWXcHXBx+eHUW1xynPOCk3kdN8iBW/yPYLSupPMSZ
 qQnDM6clYMJbl+O9BS1kC5C14XLQwWt1xl1S0tI0Tl+xQb3li4n98RejYTR92eAvs4WX4q1
 miIba6Bss+vHOD2aea2T+uSNDGxX8d93cTq1BOQmGJ9bLBNI+sF2Yp+DUZUDkyyreyc4xlz
 N30iHpUk3f2dZdckACyAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vhHygpkwzSM=:Ew3Uo7peKvPQHHmWrozPZC
 chHDm4j18d9XQv6AlzJdj8AsUjRvd7kEZQy2iKPsPF85wdRMCuWQ5Lik8uYjgWDHmOxd/bWZC
 8oDRdV9n1CmVHEqKQrHxoQN7YSMih2L/Iq04kpFM9glWgboBmFPGF4wY8KsXNRGPVVpWZmsp6
 7xl6PFD473tpPeQU6VlyNRT+EOqBMzxLacUN3nm1t5UBM0cKGyXWuUzTSoHXflCi4+jI2hg6I
 M0TA8VpXduuJcKleooNF4x1/FF70D8hxFb/5PItwlRsauzKuFjquJqGpDwLZhrgH+nHDECfXI
 y8w7fkkT723OnD9HWUjjhJ46EVKuQvShI7/FJKF0bVWrvdADpbCa+J0idc0tgtaOSa7n0NC8+
 dKLXHnULv82VpQdNdpVCTQENHEdZPsYPFzJNkO+taUwTNTa7Z8xxVwYBrqS7A5bDvSlHuo+Xd
 5EkL7s+gk1j9tLRGqeU8637mI0zLDtOI98YlKyhxOwHSsmCGG8feqJR9ppgLgxHbPR0UhAXBH
 2cjKUmv/9bcnHXh9tHGUAuBp301XNB57knw9aJ+PEVfpBvOdlZNxTzGDEYBpcHVEn9jKEkNQD
 oFuoGsy/pWAB5nOjbZFM6tATy5h9URlEHnt8V8TDK4pnv0374gbTJES6OlHQXDQD0YWuxMHcb
 czFTdm3Zw+oOuFnwd6RymQH3/IEP7m2aZfJSYLgZXx21FUV/DXSXqW5ApvqjVr1HzoLtmtz02
 i/erqYWbuHtdYvqURzz+Hh3ux2eDxdo8OM05TQ4pJyEhzIjw264XtatqvSA5nb7jHZ5e3I2Db
 L5a4aZC6mfLn4DAepW4sSLDi6Xkk74pNXZR9oHoKSy7dFjDmAtvuKb2e1aKGwaPJ3e3w3r5G+
 J+g2WN/IlAp2jUpG5nsdSvXGmOTe5PY9qDXBG63IVVZ3LjwBEWRhBVqVdhx0tNvkqnbdRFCjE
 GurwqY6B28xsolu8D5vF5zOTSgmHyqFso6aNfnf2bGUoLe7EAckRILxBprInNOONgoZHthmhN
 CmQE9wGO8sTWJ1v0DSjhAcf7r7ECNkTmDa9uO4cB/6UspCmdqHplnM9CkGIPSSclNKbTKqHJ+
 MBvIrDQSDpZjrhDMycoNfYpGO7C4Vou1TKDLa+yJ6hv49O81+7qocdX72XKooai1XBY5BWio0
 POvxQRvwHTl0/CYR1fM3VJSBQ/N3CARp/wjaKttWngN+x0hNVjHGj2Qzk1NjIhxm2IYOlZckg
 JX1Xn0goyA7yNCiEJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.20 um 12:20 schrieb Denton Liu:
> Hi Ren=C3=A9,
>
> On Thu, May 21, 2020 at 11:52:28AM +0200, Ren=C3=A9 Scharfe wrote:
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index 91a6e34f38..9640ac8ff2 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -257,21 +257,33 @@ test_expect_success 'tree object with duplicate e=
ntries' '
>>  	test_i18ngrep "error in tree .*contains duplicate file entries" out
>>  '
>>
>> -test_expect_success 'tree object with dublicate names' '
>> -	test_when_finished "remove_object \$blob" &&
>> -	test_when_finished "remove_object \$tree" &&
>> -	test_when_finished "remove_object \$badtree" &&
>> -	blob=3D$(echo blob | git hash-object -w --stdin) &&
>> -	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
>> -	tree=3D$(git mktree <tree) &&
>> -	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
>> -	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
>> -	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
>> -	badtree=3D$(git mktree <badtree) &&
>> -	test_must_fail git fsck 2>out &&
>> -	test_i18ngrep "$badtree" out &&
>> -	test_i18ngrep "error in tree .*contains duplicate file entries" out
>> -'
>> +check_duplicate_names () {
>> +	expect=3D$1 &&
>> +	shift &&
>> +	names=3D$@ &&
>
> It doesn't really make sense to use $@ here since we're not using the
> argument list behaviour of $@; we're just expanding it normally. I would
> replace this with $* instead.

The assignment to $names flattens the list, so $@ and $* behave the same
here.  I didn't think much about it, but it would be nice to support names
that contain spaces, which we could do by writing the arguments to a file.
And if we go that route then support for names with newlines would be nice
as well.  I'm not sure it's worth it, but a patch for that is below.

At least I'd like to keep the $@ as kind of a reminder that we want to
pass on arguments (full names), not words.

>
>> +	test_expect_$expect "tree object with duplicate names: $names" '
>> +		test_when_finished "remove_object \$blob" &&
>> +		test_when_finished "remove_object \$tree" &&
>> +		test_when_finished "remove_object \$badtree" &&
>> +		blob=3D$(echo blob | git hash-object -w --stdin) &&
>> +		printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
>> +		tree=3D$(git mktree <tree) &&
>> +		for name in $names
>> +		do
>> +			case "$name" in
>> +			*/) printf "040000 tree %s\t%s\n" $tree "${name%/}" ;;
>> +			*)  printf "100644 blob %s\t%s\n" $blob "$name" ;;
>> +			esac
>> +		done >badtree &&
>> +		badtree=3D$(git mktree <badtree) &&
>> +		test_must_fail git fsck 2>out &&
>> +		test_i18ngrep "$badtree" out &&
>> +		test_i18ngrep "error in tree .*contains duplicate file entries" out
>> +	'
>> +}
>> +
>> +check_duplicate_names success x x.1 x/
>> +check_duplicate_names success x x.1.2 x.1/ x/
>>
>>  test_expect_success 'unparseable tree object' '
>>  	test_oid_cache <<-\EOF &&
>> --
>> 2.26.2

=2D- >8 --
Subject: [PATCH 5/4] t1450: support names with spaces in check_duplicate_n=
ames()

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1450-fsck.sh | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 344a2aad82..b1766c8e11 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -257,10 +257,20 @@ test_expect_success 'tree object with duplicate entr=
ies' '
 	test_i18ngrep "error in tree .*contains duplicate file entries" out
 '

+names_to_tree () {
+	awk -v blob=3D"$1" -v tree=3D"$2" -v RS=3D'\0' -v FS=3D'/' '
+		NF =3D=3D 1 {printf "100644 blob %s\t%s%c", blob, $1, 0}
+		NF =3D=3D 2 {printf "040000 tree %s\t%s%c", tree, $1, 0}
+	'
+}
+
 check_duplicate_names () {
 	expect=3D$1 &&
 	shift &&
-	names=3D$@ &&
+	for name in "$@"
+	do
+		printf "%s\0" "$name"
+	done >names &&
 	test_expect_$expect "tree object with duplicate names: $names" '
 		test_when_finished "remove_object \$blob" &&
 		test_when_finished "remove_object \$tree" &&
@@ -268,14 +278,8 @@ check_duplicate_names () {
 		blob=3D$(echo blob | git hash-object -w --stdin) &&
 		printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
 		tree=3D$(git mktree <tree) &&
-		for name in $names
-		do
-			case "$name" in
-			*/) printf "040000 tree %s\t%s\n" $tree "${name%/}" ;;
-			*)  printf "100644 blob %s\t%s\n" $blob "$name" ;;
-			esac
-		done >badtree &&
-		badtree=3D$(git mktree <badtree) &&
+		names_to_tree $blob $tree <names >badtree &&
+		badtree=3D$(git mktree -z <badtree) &&
 		test_must_fail git fsck 2>out &&
 		test_i18ngrep "$badtree" out &&
 		test_i18ngrep "error in tree .*contains duplicate file entries" out
=2D-
2.26.2
