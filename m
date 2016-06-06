From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION
Date: Mon, 6 Jun 2016 19:31:38 +0300
Message-ID: <CABr9L5CQeL6iaTh-=G8sfWuygqgpj50mxBaOSL6ihS6x91F3UA@mail.gmail.com>
References: <1464078713-3220-1-git-send-email-ville.skytta@iki.fi> <xmqqshx75psw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:32:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xRd-000100-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbcFFQcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:32:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34647 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcFFQb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 12:31:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id n184so17820055wmn.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CIJ/iCG5glQSEkjKXGSTuat1KtMlXkeK9eH99xF3Yzw=;
        b=Krq7Dmq2Bc0wkaONW4kfyjZWHfVUSfSX9pEIGLmK+dx3rQNwyVIlvbeS4L/dHaG+yH
         qIIaC7wt+a7eU/z12XNS7JS0TdAbB7oo5QpnHGJ5LJeEP/uEV0Si9j8PyuRImpUQiYjM
         WKfDDAj3w27//U/RAC+3cPQuOXKV4MaIdmEeeiYaON+KNDDZlDjl9AjerLfF88uTKJ7t
         DNNlyab1qh0aijNFAf93D66EjLOe2n5xFq1vqH0flyTjcexDID4j9O5haoQ7ApLdGRvU
         A8vfcM/niOTNFo+KVwlXoDo1qsvqDZyK3QQd5C8pNCAzKtpaPTl1zbNy4YQ+5a8jIaq5
         NUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CIJ/iCG5glQSEkjKXGSTuat1KtMlXkeK9eH99xF3Yzw=;
        b=kBZk4foOIvj5zlZFbMaaxOEF8kjVgjB88qCXR7J7wL08GpZ5vb2MyjzNrJGKHoKzaS
         5UQfX2J16LCy3t8uASdk0Lv07/LaMnomGjN49LMa+RCd29NwtAIRn4lZdqKIc2A9zqcA
         WSfqeRznSwzRh7B4uEQpyujJjF0PmupO871hLrdfbfkgrvy1iVwOc8uOIabN6vTLdNeX
         oeSwkWG+GhBjQmYj5iqTrjmF9Lr+uYEpXED4Kg39PHtHsVo0pT/2w9RrcOit/Ise0bb/
         oWbOF1BwmwbrZ18abWjvUDxPKQniAI5u7CTduWpY+5L/50mBRB31UPn0vU2PAODByJxU
         9yug==
X-Gm-Message-State: ALyK8tLlBQj4NuKLsnqeONbyWcuZ9a7PesZVKlIaQlChZoCzqFTMRd51/o9P2DWKZmYVV45zlgTSM2qk32F+bA==
X-Received: by 10.194.248.97 with SMTP id yl1mr19027395wjc.130.1465230718334;
 Mon, 06 Jun 2016 09:31:58 -0700 (PDT)
Received: by 10.194.9.195 with HTTP; Mon, 6 Jun 2016 09:31:38 -0700 (PDT)
In-Reply-To: <xmqqshx75psw.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 5wWDl0kL8Cf3dWwsxSUYMXW75EM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296530>

On Tue, May 24, 2016 at 8:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>
>> When the shell is in "nounset" or "set -u" mode, referencing unset o=
r
>> null variables results in an error. Protect $ZSH_VERSION and
>> $BASH_VERSION against that.
>>       local ps1_expanded=3Dyes
>> -     [ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=
=3Dno
>> -     [ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3D=
no
>> +     [ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expan=
ded=3Dno
>> +     [ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expand=
ed=3Dno
>
> I wonder if we can teach t9903 to run (at least) some parts of the
> completion script under "set -u" to catch these automatically without
> a report from an end user.
>
> With the attached "just started to scratch the surface" patch to
> test-lib.sh and fix by Ville to the git-prompt.sh script, we find
> another one.
>
>     ...contrib/completion/git-prompt.sh: line 481: short_sha: unbound=
 variable
>
> Ville, I think you want to take the "git-prompt.sh" part from the
> following and replace it with your patch.

Hm, I'm not entirely sure what I was expected to do, but I took the
short_sha bit, added it to my patch (modifying to be in line with the
style of the rest of the file), and submitted a superseding patch with
the subject "[PATCH 1/2] git-prompt.sh: Don't error on null
${ZSH,BASH}_VERSION, $short_sha" (and there's no part 2/2 coming, that
was a user error).
