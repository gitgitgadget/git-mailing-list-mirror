From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 08/16] t4019 (diff-wserror): add lots of missing &&
Date: Mon, 4 Oct 2010 02:52:35 +0000
Message-ID: <AANLkTinYGbAE6ymp-9nFN-OXe8-iL9=9Jkf7noDGQNg3@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-9-git-send-email-newren@gmail.com>
	<20101003143211.GD17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 04:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bAP-0006td-Qp
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 04:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab0JDCwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 22:52:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38676 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab0JDCwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 22:52:36 -0400
Received: by iwn5 with SMTP id 5so6339451iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 19:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PP3tsen/sbViMCRoo6uUx8JWwUpUjCThzkxUky1rzkY=;
        b=XKluAd6hpQS3iFwudLi4lRdoEJk7sB0Zor8gKlyR8yxwAh5JUtZDccvurcUsA+umu1
         2pg4Ji8Gt4HsM76Dlip/13zPeP/RVDcHJrd2j3kbRRiXu7EZ8wD8YRAc0bK55ssgjKl6
         MqfUB2u0JkA1gF3eSr+UPovlv/sGSkzT3Lp2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TNlMXZt13Jo3FIkUjeptXyXE7iQ47IUNcj96ot4KcHZBQKy6IeUwsCJGMwgJRIzpGb
         h1h6xZQ+kZ6evr5NXOOEUGB5AYIcTDd5tkkPyUoVEgrXuodSz5oTPq89ElEUu+ClSMCy
         K42Pd40MJsZO+4SdtFqxGDIfY5W4SIltLzpSU=
Received: by 10.231.35.77 with SMTP id o13mr9384924ibd.92.1286160755288; Sun,
 03 Oct 2010 19:52:35 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 19:52:35 -0700 (PDT)
In-Reply-To: <20101003143211.GD17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157960>

On Sun, Oct 3, 2010 at 14:32, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Elijah Newren wrote:
>
>> --- a/t/t4019-diff-wserror.sh
>> +++ b/t/t4019-diff-wserror.sh
>> @@ -40,7 +40,7 @@ prepare_output () {
>>
>> =C2=A0test_expect_success default '
>>
>> - =C2=A0 =C2=A0 prepare_output
>> + =C2=A0 =C2=A0 prepare_output &&
>
> As I asked before:
>
> The exit status from prepare_output is the exit status from its last
> command, which is "grep -v <something blue>". =C2=A0It seems that nev=
er
> fails in these test cases, but should we be relying on that?
>
> So I would be more comfortable with the following on top.
>
> ---
> diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
> index 36f06c7..afd74c8 100755
> --- a/t/t4019-diff-wserror.sh
> +++ b/t/t4019-diff-wserror.sh
> @@ -36,6 +36,7 @@ prepare_output () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff --color >output
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$grep_a "$blue_grep" output >error
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$grep_a -v "$blue_grep" output >normal
> + =C2=A0 =C2=A0 =C2=A0 return 0
> =C2=A0}
>
> =C2=A0test_expect_success default '
>

If we want to rely on that this would make more sense probably:

     prepare_output () {
    -       git diff --color >output
    -       $grep_a "$blue_grep" output >error
    +       git diff --color >output &&
    +       $grep_a "$blue_grep" output >error &&
            $grep_a -v "$blue_grep" output >normal
     }

But I don't know whether that makes sense.
