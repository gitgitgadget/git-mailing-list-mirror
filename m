From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Make format-patch produce UTF-8 `From:' header (was Re: git am
 should recognize >From)
Date: Sun, 19 Sep 2010 21:44:15 +0200
Message-ID: <AANLkTimivpZPJo-3OoFQ2OVqzO_8_RMEfUwjamScds7_@mail.gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
 <AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com> <87y6axshmt.fsf_-_@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Russ Allbery <rra@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 21:44:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxPoX-0005Wo-KU
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 21:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0ISTog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 15:44:36 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45336 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0ISTog convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 15:44:36 -0400
Received: by vws3 with SMTP id 3so2783625vws.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=zWae0PdL9FXNsAkw/rWcE1N+9phtM3TdS24JNMtAFdQ=;
        b=nb7dZ1ESQQjShqeZFt8TLV15mxY2Mk0VJIiZ5HQy9xWW6+D9eX6deEi3J3SfCHsR7e
         5+gggDOcSbYyohYF9hu+DPx35CRie8KidnEb/iObQ2/c1v7mJFkb9+uKEiU1XgGPF4Ck
         lo3ulzodcdJ2j5yerwNrxCPHC1uFrvlbsa0xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=jgk7oe37on25ujem+Rc0OmxIVjfbuVkZwaAzA/By20sThdzmix78CQjlGk/lcHpEZu
         iJQtgR0qJZkl7BwUp+9HFfOlKCCQywAXy6FjixX3rUtatW5BFgcDRyi5YuiarZMGgpAN
         TRrFdg7c1s1sD09wCEo08KIDAs8ZYqRdnkHYo=
Received: by 10.220.124.41 with SMTP id s41mr298336vcr.182.1284925475174; Sun,
 19 Sep 2010 12:44:35 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Sun, 19 Sep 2010 12:44:15 -0700 (PDT)
In-Reply-To: <87y6axshmt.fsf_-_@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156514>

On Sun, Sep 19, 2010 at 8:38 PM, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <step=
nem@gmail.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Maybe format-patch could provide another mode to produce patches tha=
t
>> do not include unnecessary headers (in particular, leaving out the
>> difficult "From " line and using UTF-8 instead of quoted-printable f=
or
>> the "From: " line).
>
> FWIW, the quoted-printable `From:' encoding has always annoyed me -- =
I
> replace it manually with my name & address in UTF-8 every time I send
> out a patch. What is the reason format-patch does that (and if there =
is
> a reason not to change the default, could an option to disable it be
> provided)?
>

I believe the reason is that RFC 5322 doesn't allow header-fields to
be encoded in other ways that by QP, but I could be wrong.

QP being used even when the "From:"-line is inlined in the message
body seems to be an artefact of the way it's done, and should be
possible to avoid.
