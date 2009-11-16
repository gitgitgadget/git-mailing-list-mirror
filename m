From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Mon, 16 Nov 2009 13:00:36 +0100
Message-ID: <38b2ab8a0911160400w8eaf3afjf53077e969e8c0f5@mail.gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
	 <4AFF3D4D.7000308@gmail.com> <m2my2noo0g.fsf@gmail.com>
	 <4B005AEC.1000002@gmail.com> <7vlji7k0dm.fsf@alter.siamese.dyndns.org>
	 <4B006549.8050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Johan 't Hart" <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA0GE-0004i1-Vr
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 13:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZKPMAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 07:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbZKPMAd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 07:00:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:20071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbZKPMAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 07:00:32 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1177895fga.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vO+M1NOLTSuszezAAOowBXdt7MgIbevSkLIqDj9Gjho=;
        b=q+SaM9tQ+deh+CzgaxAUmmdI+4iiYtE62QkoKsBLK3I75b610iykFvfVPUGXm64pgG
         mxl+sLIMM2I0PWDVdJ9Xg7rxKO/yD4B5wtMaW6q+2y1IbavHvdm5kYViFu675J3cXf4A
         19MOPqB9HvKwkYylZ3qeKTt1AqVMq8Pdz9oNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eOFQ6ji5cX7GzABaZbaiTI2I4drlEANgZ0UH/Hi896KvcKwRIfS1ToFHFbeKteanQ3
         mglyM8JgoAbqsJZck8ljKirZvAUYjX/wdopuGAMwduEkO+Tmd6G9bAPa0GMUB3FpeShZ
         lWG8iQLEtOjBzoAAgzyYyQdj88hRbSDx0ghwI=
Received: by 10.239.143.219 with SMTP id l27mr770200hba.162.1258372836854; 
	Mon, 16 Nov 2009 04:00:36 -0800 (PST)
In-Reply-To: <4B006549.8050803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133003>

On Sun, Nov 15, 2009 at 9:32 PM, Johan 't Hart <johanthart@gmail.com> w=
rote:
> Junio C Hamano schreef:
>>
>> Johan 't Hart <johanthart@gmail.com> writes:
>>>>
>>>> I've been somehow confused by the git-pull man page, which says:
>>>>
>>>> =A0A parameter <ref> without a colon is equivalent to <ref>: when
>>>> =A0pulling/fetching, so it merges <ref> into the current branch wi=
thout
>>>> =A0storing the remote branch anywhere locally
>>>>
>
>> Thanks for clearing it up.
>>
>> I was puzzled by the above pointing-finger because I wanted to see w=
here a
>> misinformation originated from to fix it at the source. =A0But still=
 don't
>> see anything wrong with it.
>>
>
> My guess is that he was confused by '<ref>:' not meaning '<ref>:<ref>=
'. But
> I can't speak for him ofcource :)
>

Well, I don't remember how I started to think that:

<src>:

was equivalent to

<src>:<current-branch>

so, assuming I'm on branch 'foo':

$ git pull --rebase origin master:

was equivalent to

$ git pull --rebase origin master:foo

hence my confusion, which certainly due to my lack of attention
(sorry) when reading the man page.

> Refspecs confused me too at the beginning... But knowing more and mor=
e about
> git, it seems that this part of the docs look OK to me.. At most an e=
xample
> might make things a little more clear, but I doubt it is necessary.

Perhaps, the definition of a refspec with an empty string for <dst>
might be clearer if defined on its own. For example, doing this in the
git-pull man page:

      <refspec>
           The format of a <refspec> parameter is an ....

           The remote ref that matches <src> is fetched,

                  if <dst> is not empty string, the local ref that
matches it is fast
                  forwarded using <src>. If the optional plus + is
used, the local ref is
                  updated even if it does not result in a fast forward =
update.

                  if <dst> is an empty string the fetched <src> is
merged into the
                  current branch without updating any local refs. In
this case the
                  optional + has no meaning.

           Note
                  ....

           Some short-cut notations are also supported.

               . A parameter <src> (<ref> without the ':<dst>' part)
is equivalent
                 to '<src>:' (a ref with an empty string for <dst>).


--=20
=46rancis
