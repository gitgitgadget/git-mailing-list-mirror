From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: failed to push
Date: Tue, 2 Mar 2010 12:44:26 +0100
Message-ID: <40aa078e1003020344v5316dad4h5a53ea59ea9f0758@mail.gmail.com>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com>
	 <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
	 <4B8C38E5.7090305@gnu.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: bkorb@gnu.org
X-From: git-owner@vger.kernel.org Tue Mar 02 12:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmQWg-00053W-Np
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 12:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab0CBLo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 06:44:29 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0CBLo2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 06:44:28 -0500
Received: by wya21 with SMTP id 21so75287wya.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 03:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e859evzO22M4Q4R6VGhn5fyAayGe/1M1REoqR9JQ7QA=;
        b=YKEwNi/32EwFB3/k2NPH8Q/Cw6G4o3BgZVI9k1iB0X3+th2WXBz0PQUQAZt58AHuQY
         +oKFIxaZFTF2MlDtYujbRCdLcycSHTzZz7dZoI8Y9hw8NUPowinzeNCAOxCv+wCtJUnZ
         jyWu4zg05avLlaGjY5D375TpQpn23f3eWB3BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=l16eM79VOmdYPSvftLWaxcG1cQwtsz7wIdpw6NCopMFLY97JiW5XkwmElRbRbVV/Gj
         J4zj37DDBdS0YdqtTz52Hxv5PGs72rYWAZf8eHf6oIYQSMke9Im6AAkEgOcU/B8VZ/nf
         PBBiq3X4VeqtA6Ef3vJmIhtd+iyoC+nhWyA2g=
Received: by 10.216.86.148 with SMTP id w20mr3763557wee.112.1267530266824; 
	Tue, 02 Mar 2010 03:44:26 -0800 (PST)
In-Reply-To: <4B8C38E5.7090305@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141388>

On Mon, Mar 1, 2010 at 11:00 PM, Bruce Korb <bkorb@gnu.org> wrote:
> Hi,
>
> Thank you-all for your replies.
>
> Chris Packham wrote:
>>>> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
>>>> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast forward)
>>>> error: failed to push some refs to 'ssh://bkorb@autogen.git.source=
forge.net/gitroot/autogen/autogen'
>
> CF:
>> It tells you right there at the end of the rejected line. The push
>> would have resulted in a non-fast-forward update of the branch.
>
> "non-fast forward" is not very helpful either.
>

How so? "git help glossary" gives you a description of what a
fast-forward is. In my installed copy, it's spelled without a dash,
though. But that's a minor nit, I still found it easily.

>> This basically means that the push you have attempted is not a simpl=
e
>> fast forward. This basically means that the commit your work is base=
d
>> on is not present in the remote or that there have been other pushes
>> to the remote and you need to pull them into your repository to hand=
le
>> any merging.
>
> Since the sequence was:
> =A0git commit
> =A0git push
> =A0<more editing>
> =A0git commit --amend
> =A0git push
>
> the neophyte (me) is not going to know that this produces an un-pulle=
d
> delta.
>

"git help commit" gives a warning about this when documenting --amend,
and links to the full description in the rebase-documentation.

>> In a DVCS like git all commits happen locally, the only time commits
>> are sent to the remote repo are when you've pushed so 'git commit
>> --amend' or 'git gui' with the amend box ticked only makes the chang=
e
>> locally it won't implicitly figure out that a commit has been pushed
>> out into the ether. One rule of thumb with git (I think it applies t=
o
>> most DVCSes) is not to amend a commit that has been pushed for this
>> very reason.
>
> Then please be kind enough to put a *CAUTION* button next to
> the amend button and have it bring up something that gives you
> a little warning.

That sounds to me like a good idea. Care enough to make a patch.

> GIT *could* have been written in a way that
> causes the remote repo to become synced with my local repo,
> but apparently it was not and there was not adequate warning.
>

That would have caused problems for anyone who cloned. But yes,
git-gui might benefit from a warning here.

>> =A0- or -
>>
>> =A0 git push -f
>
> This fails with the same "non-fast forward" rejection message. =A0:(

I've seen this on sourceforge as well, it seems they have some extra
checks (hooks?) to disallow pushing rebased branches. The best thing
would be not to rewrite it. But if you INSIST, what worked for me was
to delete the branch and then re-pushing it. Something like this "git
push remote-name :branch-name && git push remote-name branch-name"


--=20
Erik "kusma" Faye-Lund
