From: Nathan Broadbent <nathan.f77@gmail.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Sun, 13 Nov 2011 01:53:32 +0800
Message-ID: <CAPXHQbMo0VadLPQNV5=PtFQ8yneDeJ+rB1x+23d0iyALPF=PdA@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
 <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
 <7vehxgu0fy.fsf@alter.siamese.dyndns.org> <4EBB78C7.101@viscovery.net>
 <CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
 <20111110151412.GA11479@goldbirke> <CAKmUPx6TpbLL2GZq6G1nWPPBe=_SsqJmqXs1o9x5BxqR8y9h2Q@mail.gmail.com>
 <CAKmUPx67GMmF=dbFvYGq4x3NdfhWDE++dSSzbCqL9LYAF+j9ww@mail.gmail.com>
Reply-To: nathan.f77@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Bronson <bronson@rinspin.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 18:53:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPHmA-0002CD-Ar
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab1KLRxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 12:53:54 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46854 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1KLRxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 12:53:53 -0500
Received: by vws1 with SMTP id 1so4193745vws.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=p/VXLIq5XqEsnftokLskIeSXGbZ09xarcYk7BmC2EX8=;
        b=lPSnfXLMqWeXpqA+gWWJzD+C7y+7zjf7eRvwiMZWbtS+YIKy0F6pkcxUDiqgZC4zYP
         aNBqq7FLkF+HiangWlrATtLnpPKipXgq0tF1zXfsQXEvbLs5BOt83up06VmSYTNwk30/
         FW08L/BycY1TE5J2Lz36GiksLhVCvfuVdD9pQ=
Received: by 10.52.37.165 with SMTP id z5mr26981679vdj.117.1321120433041; Sat,
 12 Nov 2011 09:53:53 -0800 (PST)
Received: by 10.52.184.229 with HTTP; Sat, 12 Nov 2011 09:53:32 -0800 (PST)
In-Reply-To: <CAKmUPx67GMmF=dbFvYGq4x3NdfhWDE++dSSzbCqL9LYAF+j9ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185310>

2011/11/13 Scott Bronson <bronson@rinspin.com>
>
> 2011/11/12 Scott Bronson <bronson@rinspin.com>:
> > 2011/11/10 SZEDER G=E1bor <szeder@ira.uka.de>
> >> > On Thu, Nov 10, 2011 at 3:09 PM, Johannes Sixt <j.sixt@viscovery=
=2Enet> wrote:
> >> > > Am 11/10/2011 4:21, schrieb Junio C Hamano:
> >> > > > Nathan Broadbent <nathan.f77@gmail.com> writes:
> >> > > >> Dear git mailing list,
> >> > > >> I'm assigning the `_git_fetch` bash tab completion to the a=
lias `gf`,
> >> > > >> with the following command:
> >> > > >> =A0 =A0 complete -o default -o nospace -F _git_fetch gf
> >> > > >> The tab completion then works fine in git 1.7.0.4, but brea=
ks on git
> >> > > >> 1.7.7.1, with the following error:
> >> I didn't actually tried, but I guess this is a side-effect of da49=
02a7
> >> (completion: remove unnecessary _get_comp_words_by_ref() invocatio=
ns,
> >> ...
> >> Alternatively, you could easily create your own wrapper function
> >> around _git_fetch(), like this:
> > Very true. =A0But if you tweak the completion variables, you can fo=
ol
> > _git_fetch into working perfectly:
> > * If I had more time, I'd be tempted to write a function that
> > would define all the wrapper functions.
>
> I couldn't stop thinking about it last night, I had to try it. =A0Her=
e's the
> result, seems to work great:
>
>
> =A0 =A0__define_git_completion () {
> =A0 =A0eval "
> =A0 =A0 =A0 =A0_git_$2_shortcut () {
> =A0 =A0 =A0 =A0 =A0 =A0COMP_LINE=3D\"git $2\${COMP_LINE#$1}\"
> =A0 =A0 =A0 =A0 =A0 =A0let COMP_POINT+=3D$((4+${#2}-${#1}))
> =A0 =A0 =A0 =A0 =A0 =A0COMP_WORDS=3D(git $2 \"\${COMP_WORDS[@]:1}\")
> =A0 =A0 =A0 =A0 =A0 =A0let COMP_CWORD+=3D1
>
> =A0 =A0 =A0 =A0 =A0 =A0local cur words cword prev
> =A0 =A0 =A0 =A0 =A0 =A0_get_comp_words_by_ref -n =3D: cur words cword=
 prev
> =A0 =A0 =A0 =A0 =A0 =A0_git_$2
> =A0 =A0 =A0 =A0}
> =A0 =A0"
> =A0 =A0}
>
> =A0 =A0__git_shortcut () {
> =A0 =A0 =A0 =A0type _git_$2_shortcut &>/dev/null || __define_git_comp=
letion $1 $2
> =A0 =A0 =A0 =A0alias $1=3D"git $2 $3"
> =A0 =A0 =A0 =A0complete -o default -o nospace -F _git_$2_shortcut $1
> =A0 =A0}
>
> =A0 =A0__git_shortcut =A0ga =A0 =A0add
> =A0 =A0__git_shortcut =A0gb =A0 =A0branch
> =A0 =A0__git_shortcut =A0gba =A0 branch -a
> =A0 =A0__git_shortcut =A0gco =A0 checkout
> =A0 =A0__git_shortcut =A0gci =A0 commit -v
> =A0 =A0__git_shortcut =A0gcia =A0commit '-a -v'
> =A0 =A0__git_shortcut =A0gd =A0 =A0diff
> =A0 =A0__git_shortcut =A0gdc =A0 diff --cached
> =A0 =A0__git_shortcut =A0gds =A0 diff --stat
> =A0 =A0__git_shortcut =A0gf =A0 =A0fetch
> =A0 =A0__git_shortcut =A0gl =A0 =A0log
> =A0 =A0__git_shortcut =A0glp =A0 log -p
> =A0 =A0__git_shortcut =A0gls =A0 log --stat
>
>
> On Github:
> https://github.com/bronson/dotfiles/blob/731bfd951be68f395247982ba1fb=
745fbed2455c/.bashrc#L81
>
> It would be nice to see the __define_git_completion function merged
> upstram. Possible?
>
> =A0 =A0- Scott


You are amazing!!! Thanks so much for this!


Nathan
