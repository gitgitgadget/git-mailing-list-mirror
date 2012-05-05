From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: broken bash completion
Date: Sat, 5 May 2012 15:11:15 +0200
Message-ID: <CAMP44s0q_zeVwzhgeda1=9+Psjr5PaO1QtHT1QC0RwyCpfd=rg@mail.gmail.com>
References: <4FA14016.8050503@rolf.leggewie.biz>
	<20120504233213.GF2164@goldbirke>
	<4FA4AB86.8020108@rolf.leggewie.biz>
	<20120505121319.GG2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rolf Leggewie <foss@rolf.leggewie.biz>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat May 05 15:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQele-0007tB-9f
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 15:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab2EENLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 09:11:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34507 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686Ab2EENLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 09:11:16 -0400
Received: by eaaq12 with SMTP id q12so1042045eaa.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=w2/vSCe7BYbQ4xd2U0Z5DvAjwbEwbptnz/tN8uAmSLU=;
        b=BeMZIQHpQUsxt4MU2mghH7I+iR088oBGbK4+pd4WgGD8du45QvSAoIETtfABZHNzn3
         A+now9mZNGTTbuABcW2kE4sEsz4tm07lFa5F+OhHml11BS8N+pv9TEjbDChn/tnMRIKG
         w6ywvydPLlokLfvLpap2GxJiVlXWVhDKcL9yiAdBiyOHSyGyRwBEZKViSBzoiWZ9X3Yf
         dBEkrz1XSTam37rtMFuJXS0rDL7crwfM1NdWVfn8G+DA6LusJao81ZFK0hfWloqOVUg6
         TQVWF0ypiSaRsqJMkFGqzlXs87fN/jiYiNcdw/1uJ96uPNkhdaykGUIlQNVyh7AfeOls
         J8Ww==
Received: by 10.14.187.137 with SMTP id y9mr1643595eem.89.1336223475111; Sat,
 05 May 2012 06:11:15 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 06:11:15 -0700 (PDT)
In-Reply-To: <20120505121319.GG2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197112>

On Sat, May 5, 2012 at 2:13 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:

> But you miss an important point here: users expect the completion to
> be pretty fast, because delays are quite noticeable and annoying whil=
e
> typing a command. =C2=A0So there's a trade-off between correctness an=
d
> usability. =C2=A0Unfortunately, in the real world all that filtering =
costs
> a great deal, so git's completion script does that only if it can be
> done cheaply (e.g. 'git rebase --<TAB>' won't offer you '--abort' and
> '--continue' if you're not in the middle of an ongoing rebase). =C2=A0=
And
> as pointed out above, something might be nonsense for a command, but
> still be useful for the user.

Completely agree with this.

The reason I started to use the bash completion in zsh is that the zsh
completion goes for 100% correctness, that means 'git checkout <TAB>'
took literally *minutes* in my machine on the Linux kernel repo. The
zsh developers said that was OK, and my patch to solve the problem was
not, because it would make the result less than 100% correct.

The whole point of completion is to avoid typing as much as possible,
and if typing something is faster than doing the completion; the
completion is pointless. It has to be fast.

Cheers.

--=20
=46elipe Contreras
