From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] t7508-status: test all modes with color
Date: Wed, 09 Dec 2009 10:18:47 +0100
Message-ID: <4B1F6B77.80108@drmicha.warpmail.net>
References: <cover.1260266027.git.git@drmicha.warpmail.net> <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net> <hflc82$sf8$1@ger.gmane.org> <4B1E798C.5050204@drmicha.warpmail.net> <7vzl5sww3w.fsf@alter.siamese.dyndns.org> <7vmy1swvjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 10:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIIiY-0000FU-QM
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 10:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZLIJUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 04:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZLIJUD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 04:20:03 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54449 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752611AbZLIJT7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 04:19:59 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2E9C0C6336;
	Wed,  9 Dec 2009 04:20:06 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 09 Dec 2009 04:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WbM/dU8JV6Q1m/y3tGglDI4n9Bk=; b=hR8B2rnX7jtqawoS+XuXZA3a9x2k7xQFqL6tyVS24eEaZI6QpsvcZ7x6tNbd+pke0FEkBkVj2bz7rxLtoEusNrkwEwSpaJDWDjcLZEMnb0EzTqlzoLyjjjkB2javtlJTKD0V4ikKHcTpkMNMUiiKItIqeSMq/0ktBxxf23nAlS0=
X-Sasl-enc: lGW6uSc/kjA847/UCE0MFvWeWbnhum0STDd0/jYAGUjK 1260350405
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 296CC4A94C9;
	Wed,  9 Dec 2009 04:20:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <7vmy1swvjc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134951>

Junio C Hamano venit, vidit, dixit 09.12.2009 06:32/06:44:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> > Jakub Narebski venit, vidit, dixit 08.12.2009 12:10:
>>> >> Michael J Gruber wrote:
>>> >> 
>>>> >>> +decrypt_color () {
>>>> >>> +       sed \
>>>> >>> +               -e 's/.\[1m/<WHITE>/g' \
>>>> >>> +               -e 's/.\[31m/<RED>/g' \
>>>> >>> +               -e 's/.\[32m/<GREEN>/g' \
>>>> >>> +               -e 's/.\[34m/<BLUE>/g' \
>>>> >>> +               -e 's/.\[m/<RESET>/g'
>>>> >>> +}
>>> >> 
>>> >> Shouldn't this be better in test-lib.sh, or some common lib 
>>> >> (lib-color.sh or color-lib.sh; we are unfortunately a bit inconsistent
>>> >> in naming here)?
>> >
>> > Well, so far it's used in two places (and somewhat differently). I would
>> > say test-libification starts at 3 :)
> That is a pretty lame excuse and is a bad way to keep things maintainable.
> 
> Having two copies now means that you will *double* the chance for the next
> person to copy and paste one of the existing copies that are found in the
> non-library-ish part of the test script set to create the third duplicate,
> without even realizing that there already are two copies that should have
> been consolidated in the first place.  The worst part is that once that
> duplication is pointed out, s/he will use the existing two copies as an
> excuse for copy and paste.
> 
> Please don't.
> 

Okay okay, I guess I have to spell out my smileys better in the future.
The real question for us (Jakub and me) was where to put the code. I
think by giving that info I could have been easily convinced to do that
step...

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Jakub Narebski venit, vidit, dixit 08.12.2009 12:10:
>>>> Michael J Gruber wrote:
>>>>
>>>>> +decrypt_color () {
>>>>> +       sed \
>>>>> +               -e 's/.\[1m/<WHITE>/g' \
>>>>> +               -e 's/.\[31m/<RED>/g' \
>>>>> +               -e 's/.\[32m/<GREEN>/g' \
>>>>> +               -e 's/.\[34m/<BLUE>/g' \
>>>>> +               -e 's/.\[m/<RESET>/g'
>>>>> +}
>>>>
>>>> Shouldn't this be better in test-lib.sh, or some common lib 
>>>> (lib-color.sh or color-lib.sh; we are unfortunately a bit inconsistent
>>>> in naming here)?
>>>
>>> Well, so far it's used in two places (and somewhat differently). I would
>>> say test-libification starts at 3 :)
>> ...
>> Please don't.
> 
> I'll squash this in to fix it up.
> 
> I don't know where 36->BROWN mistake came from when color.h has a
> series of #define that can be used to make the decoding script
> mechanically, though ;-)

I don't know either, I didn't make it - I even corrected it in my copy -
which proves your former point, of course.

>  t/t4034-diff-words.sh |   23 ++++---------
>  t/t7508-status.sh     |   83 ++++++++++++++++++++++---------------------------
>  t/test-lib.sh         |   11 ++++++
>  3 files changed, 55 insertions(+), 62 deletions(-)
> 
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 4508eff..ea895b0 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -11,18 +11,9 @@ test_expect_success setup '
>  
>  '
>  
> -decrypt_color () {
> -	sed \
> -		-e 's/.\[1m/<WHITE>/g' \
> -		-e 's/.\[31m/<RED>/g' \
> -		-e 's/.\[32m/<GREEN>/g' \
> -		-e 's/.\[36m/<BROWN>/g' \
> -		-e 's/.\[m/<RESET>/g'
> -}
> -
>  word_diff () {
>  	test_must_fail git diff --no-index "$@" pre post > output &&
> -	decrypt_color < output > output.decrypted &&
> +	test_decode_color <output >output.decrypted &&
>  	test_cmp expect output.decrypted
>  }
>  
> @@ -47,7 +38,7 @@ cat > expect <<\EOF
>  <WHITE>index 330b04f..5ed8eff 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1,3 +1,7 @@<RESET>
> +<CYAN>@@ -1,3 +1,7 @@<RESET>
>  <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
>  <RESET>
>  a = b + c<RESET>
> @@ -68,7 +59,7 @@ cat > expect <<\EOF
>  <WHITE>index 330b04f..5ed8eff 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1,3 +1,7 @@<RESET>
> +<CYAN>@@ -1,3 +1,7 @@<RESET>
>  h(4),<GREEN>hh<RESET>[44]
>  <RESET>
>  a = b + c<RESET>
> @@ -104,7 +95,7 @@ cat > expect <<\EOF
>  <WHITE>index 330b04f..5ed8eff 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1,3 +1,7 @@<RESET>
> +<CYAN>@@ -1,3 +1,7 @@<RESET>
>  h(4)<GREEN>,hh[44]<RESET>
>  <RESET>
>  a = b + c<RESET>
> @@ -146,7 +137,7 @@ cat > expect <<\EOF
>  <WHITE>index 330b04f..5ed8eff 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1,3 +1,7 @@<RESET>
> +<CYAN>@@ -1,3 +1,7 @@<RESET>
>  h(4),<GREEN>hh[44<RESET>]
>  <RESET>
>  a = b + c<RESET>
> @@ -168,7 +159,7 @@ cat > expect <<\EOF
>  <WHITE>index c29453b..be22f37 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1 +1 @@<RESET>
> +<CYAN>@@ -1 +1 @@<RESET>
>  aaa (aaa) <GREEN>aaa<RESET>
>  EOF
>  
> @@ -187,7 +178,7 @@ cat > expect <<\EOF
>  <WHITE>index 289cb9d..2d06f37 100644<RESET>
>  <WHITE>--- a/pre<RESET>
>  <WHITE>+++ b/post<RESET>
> -<BROWN>@@ -1 +1 @@<RESET>
> +<CYAN>@@ -1 +1 @@<RESET>
>  (<RED>:<RESET>
>  EOF
>  
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 50554a0..cf67fe3 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -8,45 +8,36 @@ test_description='git status'
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> -	: > tracked &&
> -	: > modified &&
> +	: >tracked &&
> +	: >modified &&
>  	mkdir dir1 &&
> -	: > dir1/tracked &&
> -	: > dir1/modified &&
> +	: >dir1/tracked &&
> +	: >dir1/modified &&
>  	mkdir dir2 &&
> -	: > dir1/tracked &&
> -	: > dir1/modified &&
> +	: >dir1/tracked &&
> +	: >dir1/modified &&
>  	git add . &&
>  
>  	git status >output &&
>  
>  	test_tick &&
>  	git commit -m initial &&
> -	: > untracked &&
> -	: > dir1/untracked &&
> -	: > dir2/untracked &&
> -	echo 1 > dir1/modified &&
> -	echo 2 > dir2/modified &&
> -	echo 3 > dir2/added &&
> +	: >untracked &&
> +	: >dir1/untracked &&
> +	: >dir2/untracked &&
> +	echo 1 >dir1/modified &&
> +	echo 2 >dir2/modified &&
> +	echo 3 >dir2/added &&
>  	git add dir2/added
>  '
>  
> -decrypt_color () {
> -	sed \
> -		-e 's/.\[1m/<WHITE>/g' \
> -		-e 's/.\[31m/<RED>/g' \
> -		-e 's/.\[32m/<GREEN>/g' \
> -		-e 's/.\[34m/<BLUE>/g' \
> -		-e 's/.\[m/<RESET>/g'
> -}
> -
>  test_expect_success 'status (1)' '
>  
>  	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>  # On branch master
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
> @@ -72,12 +63,12 @@ EOF
>  
>  test_expect_success 'status (2)' '
>  
> -	git status > output &&
> +	git status >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   M dir1/modified
>  A  dir2/added
>  ?? dir1/untracked
> @@ -90,7 +81,7 @@ EOF
>  
>  test_expect_success 'status -s (2)' '
>  
> -	git status -s > output &&
> +	git status -s >output &&
>  	test_cmp expect output
>  
>  '
> @@ -112,8 +103,8 @@ cat >expect <<EOF
>  EOF
>  test_expect_success 'status -uno' '
>  	mkdir dir3 &&
> -	: > dir3/untracked1 &&
> -	: > dir3/untracked2 &&
> +	: >dir3/untracked1 &&
> +	: >dir3/untracked2 &&
>  	git status -uno >output &&
>  	test_cmp expect output
>  '
> @@ -258,7 +249,7 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
>  	test_cmp expect output
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>  # On branch master
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
> @@ -284,12 +275,12 @@ EOF
>  
>  test_expect_success 'status with relative paths' '
>  
> -	(cd dir1 && git status) > output &&
> +	(cd dir1 && git status) >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   M modified
>  A  ../dir2/added
>  ?? untracked
> @@ -301,12 +292,12 @@ A  ../dir2/added
>  EOF
>  test_expect_success 'status -s with relative paths' '
>  
> -	(cd dir1 && git status -s) > output &&
> +	(cd dir1 && git status -s) >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   M dir1/modified
>  A  dir2/added
>  ?? dir1/untracked
> @@ -319,7 +310,7 @@ EOF
>  
>  test_expect_success 'status --porcelain ignores relative paths setting' '
>  
> -	(cd dir1 && git status --porcelain) > output &&
> +	(cd dir1 && git status --porcelain) >output &&
>  	test_cmp expect output
>  
>  '
> @@ -330,7 +321,7 @@ test_expect_success 'setup unique colors' '
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>  # On branch master
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
> @@ -357,7 +348,7 @@ EOF
>  test_expect_success 'status with color.ui' '
>  
>  	git config color.ui always &&
> -	git status | decrypt_color > output &&
> +	git status | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
> @@ -366,12 +357,12 @@ test_expect_success 'status with color.status' '
>  
>  	git config --unset color.ui &&
>  	git config color.status always &&
> -	git status | decrypt_color > output &&
> +	git status | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   <RED>M<RESET> dir1/modified
>  <GREEN>A<RESET>  dir2/added
>  <BLUE>??<RESET> dir1/untracked
> @@ -386,7 +377,7 @@ test_expect_success 'status -s with color.ui' '
>  
>  	git config --unset color.status &&
>  	git config color.ui always &&
> -	git status -s | decrypt_color > output &&
> +	git status -s | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
> @@ -395,12 +386,12 @@ test_expect_success 'status -s with color.status' '
>  
>  	git config --unset color.ui &&
>  	git config color.status always &&
> -	git status -s | decrypt_color > output &&
> +	git status -s | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   M dir1/modified
>  A  dir2/added
>  ?? dir1/untracked
> @@ -415,7 +406,7 @@ test_expect_success 'status --porcelain ignores color.ui' '
>  
>  	git config --unset color.status &&
>  	git config color.ui always &&
> -	git status --porcelain | decrypt_color > output &&
> +	git status --porcelain | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
> @@ -424,7 +415,7 @@ test_expect_success 'status --porcelain ignores color.status' '
>  
>  	git config --unset color.ui &&
>  	git config color.status always &&
> -	git status --porcelain | decrypt_color > output &&
> +	git status --porcelain | test_decode_color >output &&
>  	test_cmp expect output
>  
>  '
> @@ -433,7 +424,7 @@ test_expect_success 'status --porcelain ignores color.status' '
>  git config --unset color.status
>  git config --unset color.ui
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>  # On branch master
>  # Changes to be committed:
>  #   (use "git reset HEAD <file>..." to unstage)
> @@ -461,12 +452,12 @@ EOF
>  test_expect_success 'status without relative paths' '
>  
>  	git config status.relativePaths false
> -	(cd dir1 && git status) > output &&
> +	(cd dir1 && git status) >output &&
>  	test_cmp expect output
>  
>  '
>  
> -cat > expect << \EOF
> +cat >expect <<\EOF
>   M dir1/modified
>  A  dir2/added
>  ?? dir1/untracked
> @@ -479,7 +470,7 @@ EOF
>  
>  test_expect_success 'status -s without relative paths' '
>  
> -	(cd dir1 && git status -s) > output &&
> +	(cd dir1 && git status -s) >output &&
>  	test_cmp expect output
>  
>  '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 5fdc5d9..d63ad2d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -208,6 +208,17 @@ test_set_editor () {
>  	export VISUAL
>  }
>  
> +test_decode_color () {
> +	sed	-e 's/.\[1m/<WHITE>/g' \
> +		-e 's/.\[31m/<RED>/g' \
> +		-e 's/.\[32m/<GREEN>/g' \
> +		-e 's/.\[33m/<YELLOW>/g' \
> +		-e 's/.\[34m/<BLUE>/g' \
> +		-e 's/.\[35m/<MAGENTA>/g' \
> +		-e 's/.\[36m/<CYAN>/g' \
> +		-e 's/.\[m/<RESET>/g'
> +}
> +
>  test_tick () {
>  	if test -z "${test_tick+set}"
>  	then

Regarding the larger part of your change: Is there a specific reason for
">output" rather than "> output" or just a style issue? I was simply
following the style which I found present in t7508 (same goes for empty
leading and trailing lines in the test bodies).

Michael
