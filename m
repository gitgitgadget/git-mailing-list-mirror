From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Sat, 14 Apr 2012 05:06:17 +0300
Message-ID: <CAMP44s2zEsvChCVOaCKYoOtU-ny5=zkHwHg8tCjWjL27UX4n8A@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
	<7v62d32z1a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 04:06:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIsNc-0003VT-39
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 04:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab2DNCGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 22:06:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab2DNCGS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 22:06:18 -0400
Received: by eaaq12 with SMTP id q12so897938eaa.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 19:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oKkpvieB/6M9Zk/oQzfufhKxw4s9wQ1W7Mh0F9rEw3k=;
        b=MBmz72h72xlU6OtMcgzIpPmmNg6dHtIsUsaqci3lyYiT/qum3knis1sFIhGvZZKWqy
         plNeCmPw166L/afKErvcDktvw9cFooOFntkalQ/95AXJbg+sWOPk28UzVhEkip9yu5VQ
         P7NuwXTGnOzXdE4woWMSMkQIVr09DjPYeYzCG9BttvcLdrPvHCAtyEbI/nLVmfxkJqRa
         Qs23eSg6H79eilBmJmMICJblIh/et35A8g1Pt7CUySkwdYrti0tdrQqaPLRUwdUAa9N5
         5mt2CAVP7qXGw88ftugxFonFDmTpfp9yb5ALvInDKdgcwRuVjwGWBNE8ax6oGumZ2c7x
         9Kvw==
Received: by 10.213.6.195 with SMTP id a3mr291352eba.78.1334369177378; Fri, 13
 Apr 2012 19:06:17 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 19:06:17 -0700 (PDT)
In-Reply-To: <7v62d32z1a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195462>

2012/4/13 Junio C Hamano <gitster@pobox.com>:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>>> +_get_comp_words_by_ref ()
>>> +{
>>> + =C2=A0 =C2=A0while [ $# -gt 0 ]; do
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$1" in
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cur=3D${_words[_cword]}
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0prev=3D${_words[_cword-1]}
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0words)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0words=3D("${_words[@]}")
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cword)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cword=3D$_cword
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0;;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shift
>>> + =C2=A0 =C2=A0done
>>> +}
>>
>> Git's completion script already implements this function. =C2=A0Why
>> override it here?
>
> It is not "already implements" that I am worried about, but it implem=
ents
> it differently without explaining why, which is worrying. =C2=A0I agr=
ee it
> needs to be explained before the function.
>>> + =C2=A0 =C2=A0# plumbing
>>> + =C2=A0 =C2=A0! grep -q "^ls-files \$" out
>>
>> The && is missing here at the end of the line.
>
> True.
>
>>> + =C2=A0 =C2=A0run_completion "git f" &&
>>> + =C2=A0 =C2=A0! grep -q -v "^f" out
>>
>> grep is not a git command, so I'm not sure, but shouldn't these use
>> 'test_must_fail grep' instead of '! grep'?
>
> "! grep" is fine. =C2=A0We are not trying to catch the case where we =
break the
> implementation of "grep" to cause it to segfault.

--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -27,6 +27,9 @@ complete ()

 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"

+# We don't need this function to actually join words or do anything sp=
ecial.
+# Also, it's more clean to avoid touching bash's internal completion v=
ariables.
+# So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
        while [ $# -gt 0 ]; do
@@ -77,7 +80,7 @@ test_expect_success 'basic' '
        # script
        grep -q "^filter-branch \$" out &&
        # plumbing
-       ! grep -q "^ls-files \$" out
+       ! grep -q "^ls-files \$" out &&

        run_completion "git f" &&
        ! grep -q -v "^f" out

--=20
=46elipe Contreras
