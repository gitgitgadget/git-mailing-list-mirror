From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Sat, 7 Mar 2009 20:31:45 +0100
Message-ID: <1de9d39c0903071131pdb2b125hce7c49642843c9f8@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
	 <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
	 <7v63imqhcz.fsf@gitster.siamese.dyndns.org>
	 <76718490903061756g4ca88c21h8bf786048d4ad05@mail.gmail.com>
	 <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2Gq-0004KS-JI
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbZCGTbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbZCGTbs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:31:48 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:42704 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbZCGTbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 14:31:47 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1154490wfa.4
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8E9XcCUHpCxv8d9spW0OcADTOtylFNjYBZ7M7Ba3wUA=;
        b=khsE8QR/DHSGq6Ud7yPF8tP+218fsIsRgjeC8kZg53s7yXdtuTYzRdRg8siTqmJK7E
         egCSfsDLX9klDMCrcFJ9NpArR7tsWMrHOvEJzRMG2HGLrzxN26ouVNk8hoNXZ+naWh7z
         Kh+2xQ8WZvIIyOOhsloyiKt7A4qw67yGUQ3ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RIbvnyAC5C99dtsHTW2SxMVY18Z7d8JtYTnidzrT/Z6La1M7HDHNDYFZEaoiWtp7hy
         kpd1ay0Nh4g4GY2DM9kaByEDkYAYbi67BqQh3VA/RdBhbOpaaN9MTkOwdstvdhl29CsO
         ksR3uN6XeUfyQ52hFOKizygyyyG59Zk+mlpY4=
Received: by 10.142.199.16 with SMTP id w16mr1711353wff.4.1236454305681; Sat, 
	07 Mar 2009 11:31:45 -0800 (PST)
In-Reply-To: <7vzlfxpzqq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112565>

as a user,
1) I looked how to override defaults, since merge seems to use --ff as
default, I looked if there was any global config to override that.
nothing found... so go back to google
2) I found on the web that we can set it using
branch.branchname.mergeoptions so I said "what if I use a branch named
*, the config file was correct and git didn't insult me so.... but not
the expected result...

since the commands have allready defaults builtin, why not storing
thoses defaults in the config file? like this it's easier to update
them or change the way git behave....
JLM

On Sat, Mar 7, 2009 at 8:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> On Fri, Mar 6, 2009 at 7:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> I think it would be much better if you did not introduce a new
>>> configuration merge.options which is not consistent with everything=
 else
>>> to begin with.
>>>
>>> Instead, if your addition was literally to allow saying things like=
 this,
>>> it would be much easier to understand.
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[branch "*"]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mergeoptions=
 =3D ...
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remote =3D o=
rigin
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rebase =3D t=
rue
>>
>> Okay. That's probably a more invasive patch, because a lot more code
>> paths look at [branch ...], but I'll look into it.
>
> Note that you do not have to cover branch.*.remote and other things i=
n the
> same patch. =C2=A0The first one could just handle branch.*.mergeoptio=
ns and you
> can let later patches to implement the fallbacks for other variables.
>
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
