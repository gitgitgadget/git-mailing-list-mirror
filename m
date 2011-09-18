From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Recovering from a bad object
Date: Sun, 18 Sep 2011 15:48:55 -0400
Message-ID: <CAKON4OzCYEQzKXwsNE59a-SOCHp=xibwk9oPmHs3_hMHCLaybg@mail.gmail.com>
References: <BANLkTindTWzeTFKYA3if4HYG3mj+NZX8oQ@mail.gmail.com>
	<7vy61ywjpa.fsf@alter.siamese.dyndns.org>
	<20110918193116.GB6334@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt@metux.de, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5NMO-0000Ol-FP
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203Ab1IRTs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 15:48:59 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:39266 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680Ab1IRTs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 15:48:58 -0400
Received: by wyg8 with SMTP id 8so8247483wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=cOc7Xp1niQ/5CsUtFgabaGANQj7aTCeKEOYDpq/mGlQ=;
        b=lPn/0axeUa/DoKyYUkPi/n3fqHiVdbuxszqczq9kSFi48cpdiTU9gr4fpzdi31cfyi
         HsN+nasGWER9vUOAvD8ZMnyeG06sEMn+gUz9ydegIVYEj+i2fP0d99gBytY6fMlEUeRn
         2EXawTovSRmdH5kWnOYpG8Eh2PreAeWRguQec=
Received: by 10.216.170.72 with SMTP id o50mr1730262wel.103.1316375336025;
 Sun, 18 Sep 2011 12:48:56 -0700 (PDT)
Received: by 10.216.18.148 with HTTP; Sun, 18 Sep 2011 12:48:55 -0700 (PDT)
In-Reply-To: <20110918193116.GB6334@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181631>

On Sun, Sep 18, 2011 at 3:31 PM, Enrico Weigelt <weigelt@metux.de> wrot=
e:
> * Junio C Hamano <gitster@pobox.com> wrote:
>
>> > The object is likely at kernel.org.
>> > Can git go fetch it somehow?
>>
>> The protocol is designed specifically to disallow "I guessed that th=
e
>> trade secret is contained within an object whose object name is this=
,
>> please feed me that object" kind of requests, so in general no.
>
> Maybe the local side (in some special repair mode) could check if
> some of the remote refs (and their referenced graphs) are broken
> and refetch them completely. If the remote side(s) got the objects
> you're missing (visibile to you), you'll be done after that.
>
> For example:
>
> A local branch "foo" is based on origin/master, somewhere in the
> line behind origin/master some objects are broken:
>
> It would find out that origin/master points to broken/missing objects
> and refetch it completely afresh (same as it would if they had never
> been fetched yet).
>

That's describes the lines I was thinking along.

>
> Perhaps it's not that hard to implement: just requires a special
> git-fetch operation mode that ignores locally existing objects,
> and a few lines of shell code that simply fetches the whole remote
> to some temporary namespaces (and drop that when done). Ends up in
> the same traffic as a fresh clone, but at least runs automatically.
>
>
> cu
> --
> ---------------------------------------------------------------------=
-
> =A0Enrico Weigelt, metux IT service -- http://www.metux.de/
>
> =A0phone: =A0+49 36207 519931 =A0email: weigelt@metux.de
> =A0mobile: +49 151 27565287 =A0icq: =A0 210169427 =A0 =A0 =A0 =A0 sky=
pe: nekrad666
> ---------------------------------------------------------------------=
-
> =A0Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
> ---------------------------------------------------------------------=
-
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
