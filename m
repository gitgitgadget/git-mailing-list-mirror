From: demerphq <demerphq@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 10:55:38 +0200
Message-ID: <AANLkTimqn18y8_fB0PCUNY3XTD8nneDsEz4Koimr-SxM@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
	 <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 10:55:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1Xe-0004yV-Kj
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab0ETIzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 04:55:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55669 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0ETIzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 04:55:40 -0400
Received: by fxm10 with SMTP id 10so3258519fxm.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YQht1St12E58ZgLNr5dqYHVCjR41LPak2IE5eC+enx0=;
        b=Hb3Y6HhnfuBwI6qMsRxwcCHGVhIl+BCG9esO0X1SNJUI0d0hHUQIVUHYTXkdINJCi0
         4CCTN5lwEt9s+uZm4MYcTc+HOqeHRhbUuYmxwWT6wS1QDSziK2w2J8qU0yzPkNFrYHux
         kh5Qcu3tHivB3gh3+nUfpruaQpYvGm/fsOqeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JemWiX9txF7q3cgjrjwltemYcDMU7jYrM06Y7QaMGDGRnG4XPdAFHWOditOozfDfYt
         6MxCZ5d+a8qJZp9KgpnRqwsFnEmG2rscKT1q8UkmYnRG1h4LqTMueGAJa5o96u/fOWqo
         QG7BrxZFXO78AoX5vhGNAQ2iPt32WwB8h+Bko=
Received: by 10.239.142.211 with SMTP id h19mr985559hba.211.1274345738923; 
	Thu, 20 May 2010 01:55:38 -0700 (PDT)
Received: by 10.239.169.83 with HTTP; Thu, 20 May 2010 01:55:38 -0700 (PDT)
In-Reply-To: <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147365>

On 20 May 2010 10:34, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> =
wrote:
> On Thu, May 20, 2010 at 07:26, Matthias Moeller
> <matthias.moeller@math.tu-dortmund.de> wrote:
>> I have been searching the web for help and found lengthy discussions
>> which state that this is a common problem of the HFS+ filesystem.
>> What I did not find was a solution to this problem. Is there a solut=
ion
>> to this problem?
>
> Is this problem particular to Git, or do you also get it if you
> e.g. rsync from the Linux box to the Mac OS X box?
>
>> # =A0 =A0 =A0 "U\314\210bersicht.xls"
>
> You probably have to configure your shell on OSX to render UTF-8
> correctly. It's just showing the raw escaped byte sequence instead of
> a character there.
>
> There isn't anything wrong with OSX in this case, filename encoding o=
n
> any POSIX system is only done by convention. You'll find that you hav=
e
> similar problems on Linux if you encode filename in Big5 or
> UTF-32.
>
> Linux will happily accept it, but your shell / other applications wil=
l
> render it as unknown goo because they expect UTF-8.

Except that isnt a normalized utf8 representation of capital U umlaut,
code point U+00DC, (utf8 c3,9c), instead presumably it has been
decomposed into a captial U followed by a combining character to add
in the umlaut, which IMO is pretty weird.

As far as i can tell the filename:

"=DCbersicht.xls"

Should be stored in utf8 as:

"\303\234bersicht.xls"

Also minor nit. UTF-32, as it contains nuls for latin-1 chars would be
much much worse than utf8 :-)

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
