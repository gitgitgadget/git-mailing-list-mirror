From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 13:18:16 -0700
Message-ID: <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <4FE4C0F7.2080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAJV-0006RI-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab2FVUSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 16:18:37 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54678 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2FVUSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 16:18:37 -0400
Received: by gglu4 with SMTP id u4so1882741ggl.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XrQVk/qndVbQE8IAEXRv52qcLtZXozJ1znP4hr1weN0=;
        b=aRYY4ntNSKHKO+PeDsz5B4j9MAWE8ux3uDe5yF22zJUbWbdHwHVSdVt7W3wmP2SxpN
         0ii/nrOGhQ1M4+L0nApyNKH06hci6Eg7xf176o+iojjph2x/0B+EGrvT7338rGqmqSpH
         VurYdDZ6awxv9egCQSCmloJvWNZ8RYfqGmktgSq00ILWhaHePOMSauXwvBjToXCwEXaA
         lQoGfjUSVNNEEwWSNTAsEdecJOPgwKwdyX0Tu9l0VQjLzogaJKYZIMGaPnHM8/jwpFCG
         8FE7zK6JIWG/sKb2oycg3iPZQ0WAVyccb3jxaV+v20ACbNymD4wkFT5JqEqtZVMy2WmG
         xI7g==
Received: by 10.236.197.100 with SMTP id s64mr3853880yhn.39.1340396316597;
 Fri, 22 Jun 2012 13:18:36 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Fri, 22 Jun 2012 13:18:16 -0700 (PDT)
In-Reply-To: <4FE4C0F7.2080309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200466>

Hi Neal,

On 22 June 2012 12:01, Neal Kreitzinger <nkreitzinger@gmail.com> wrote:
> On 6/22/2012 12:53 PM, Hilco Wijbenga wrote:
>>
>> Hi all,
>>
>> One of my developers managed to push something that somehow "diverge=
d"
>> origin/master from everyone else's local master.
>>
>> A --> B --> C --> D (everybody's local master)
>> |
>> \--> B' --> C' --> D' --> E (origin/master)
>>
>> (i.e., A is the commit where things diverged; everyone's local maste=
r
>> points to D but the new commit (E) that was pushed to origin/master
>> uses different SHA1s for B, C, and D). I hope I explained it clearly
>> enough.
>>
>> Now running git pull creates a merge commit joining D and E.
>>
>> When I asked the developer what he had done he told me everything ha=
d
>> looked normal. No Git warnings, nothing strange in gitk (i.e. normal
>> linear history). So I do not understand what went wrong.
>>
>> Does anyone have any idea as to what might have happened? Perhaps if=
 I
>> understand how this happened I might be able to prevent it from
>> happening again.
>>
> Some ways you can prevent it from happening again:
> (1) setting your canonical repo config to deny non-ff, and deny delet=
es:
> [receive]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0denyDeletes =3D true
> =C2=A0 =C2=A0 =C2=A0 =C2=A0denyNonFastforwards =3D true

I would *really* like to do that but I need access to the server for
that, right? Unfortunately, we use Unfuddle and that means no such
access. So no server config changes and no Git hooks.

> (2) have your devs do git pull --ff-only

Is this something that can be set in git config? I looked but didn't
see anything obvious. Actually, I guess what I really want is
something for git push, right?
