From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 17:59:42 +0200
Message-ID: <1de9d39c0905120859r67a04376g99092d3e8c1403a9@mail.gmail.com>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
	 <m38wl3n3zj.fsf@localhost.localdomain> <4A08A291.2060009@gmail.com>
	 <200905120036.06965.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uOr-0007Cm-9x
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbZELP7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 11:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756497AbZELP7o
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:59:44 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:51974 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbZELP7n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 11:59:43 -0400
Received: by gxk10 with SMTP id 10so105003gxk.13
        for <git@vger.kernel.org>; Tue, 12 May 2009 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k5XpNKSmH9N1B7KJ05JwMuColy9LSNqmTX0Cns+fbXg=;
        b=a+9ECbCRexDGHt9/IKfQUWjvY+Kn8MzhYw+KT2SilXCTRsT8VTz0ms1SEBSbuTN4OC
         fu9yah0P30JAZbL7CBdiQF/27kPaInW1NyY3I+vI2xAWjFRSupk2mU6jCnGT45VzIowT
         aF7oIP9D28BsD3cJfST95CtDl0sZeJCOTDg2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NJ/X6FJYdvj+Bz+goP8KoB7Ot7+bOVjEyeFRhst6PwbgaP33+PIZVS0Z+K1IlQBzhJ
         +/LWeDcwebQmb9knGcoSkrHjjOE4QB76atTZAT1IzE51bB3k0HcztLR67XrUu15NSAYq
         rH133NR9PKBJlJGKLiqR+ePKOirW8K0BH96Bc=
Received: by 10.90.70.6 with SMTP id s6mr3591003aga.74.1242143982911; Tue, 12 
	May 2009 08:59:42 -0700 (PDT)
In-Reply-To: <200905120036.06965.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118909>

hello
seems that I don't use the right way....
I chechouted my lastest branch, then do a git rebase --interactive
9ce8f6940a50d87e4f6503ff237bd1b1ff560660
where 9ce8f6940a50d87e4f6503ff237bd1b1ff560660 is the commit I want to =
start...
I modified the file and marked the commit I wanted to squash... and
well it keep continue to find me conflicts.... even where there shall
not be

so I said I have to start from the root and rebase my branch on it....
created a branch on root, checkout it, git rebase --interactive
b52ea8c36188b05de246d5717781ab90710078d5
huh?! nothing to do... ok fine

so I tried to put branch just after the nodes I wanted to squash....
and git rebase --interactive thesha1rigthbeforewhatiwantedtosquash....
ah! here it works! huh?! well quite not! it replayed the range of
commit fine, removed the squashed one... fine... but do created
another independant branch... what I don't want I just want to remove
a set inside the current tree
so I'm not doing it right?

thanks
JLM

On Tue, May 12, 2009 at 12:36 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Tue, 12 May 2009, MALET Jean-Luc wrote:
>> Jakub Narebski wrote:
>>> jean-luc malet <jeanluc.malet@gmail.com> writes:
>
>>>> I often commit "useless" code, for example before going into weeke=
nd
>>>> or for saving some state during a dev process
>>>> often thoses commit are simply useless and the commit message look=
s
>>>> like "COMPILE ERROR - temporary save .... "
>>>> at the end I have LOT of theses commits that are useless and I wan=
t to
>>>> save some space/time/tree complexity merge multiple sequential com=
mits
>>>> (without branch) into one
>>>> is it possible?
>
>>>
>>> It is possible; one solution would be to use "git rebase --interact=
ive"
>>> and its 'squash' command...
>
> =C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
>
>>>> according to my knowledge of git, removing the commit and rewritin=
g
>>>> the last commit log so that it better reflect the modification wil=
l do
>>>> the job but I'm not sure git allow it...
>>>>
>>>
>>> ...but you can simply pick up where you saved snapshot by using "gi=
t
>>> commit --amend" (or doing soft or mixed reset to previous commit
>>> before comitting changes).
>>>
>>>
>> hi! thanks for your answers!
>> I didn't knew about --amend for commit, will certainly use it...
>> however it seems that I get missunderstood...
>> A-o-o-o-o-o-B-o-o-o-o-C
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 \-o-o-D-/
>> let say I have the above tree, o are temporary unbuildable commits, =
A B
>> C D are usable versions
>> I want as posteriory remove the o to get the following tree
>> A-B---C
>> =C2=A0 =C2=A0 =C2=A0\-D/
>> in fact I just wanna clean a little my tree since I forgot to amend =
;)
>> is this possible?
>> ok I know, the best is to prevent! not to cure! so I'll amend ;)
>
> As I wrote above, you can use interactive rebase to clean up history.
>
> --
> Jakub Narebski
> Poland
>



--=20
KISS! (Keep It Simple, Stupid!)
(garde le simple, imb=C3=A9cile!)
"mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des chos=
es
simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
-----------------------------
"Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce s=
oit,
essayez donc de dormir avec un moustique dans votre chambre." Betty
Reese
http://www.grainesdechangement.com/citations.htm
