From: demerphq <demerphq@gmail.com>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 12:55:26 +0200
Message-ID: <9b18b3110907180355s5bf08f8did180caa0c55b3389@mail.gmail.com>
References: <4A611CE1.3080709@pobox.com>
	 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
	 <4A6176E6.4060708@pobox.com>
	 <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
	 <20090718104631.GA27307@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael G Schwern <schwern@pobox.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 12:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS7Zm-0008NO-Q4
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 12:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbZGRKz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 06:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbZGRKz1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 06:55:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:20595 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZGRKz0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 06:55:26 -0400
Received: by wf-out-1314.google.com with SMTP id 26so424772wfd.4
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uLSR69lZjAyyFbyR3r2U4wAYAfWaXroIjKyKXUilO2Q=;
        b=CXdefzT6wvpSZdPbC3yVgD2b+WShMUdCqpuLY7J+swMd32nGRmKpT8pGxj4/I3f44n
         GffKmOx5lT8JkKccQeQLg4aHKjT+yFbOSgDvuxgH9efuWIPUaCoYD1Fqqa5IUwlo4jnI
         Q71qmZB1I/CyvcpQ9s769TToMEj1HuU4Zb/Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KCutAsuQRd8OG9BiVu0zxE10/55AWxHsVwRoEoPT1V++ZQtYCG5wCDFOw3BM+4GBAG
         sSfkBPgOpFbD9w8xEQpx4A7ZGkZlI9ogNYITHcVTcSnNjkp6RSBA/yUyFp1EIzVzSKXC
         TdVMsnpZoGvR76Co3IDBZuFzfjrylhShHOnW4=
Received: by 10.142.47.13 with SMTP id u13mr487307wfu.157.1247914526243; Sat, 
	18 Jul 2009 03:55:26 -0700 (PDT)
In-Reply-To: <20090718104631.GA27307@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123515>

2009/7/18 Jeff King <peff@peff.net>:
> On Sat, Jul 18, 2009 at 11:30:25AM +0200, demerphq wrote:
>
>> Yeah it seems reasonable that if its going to be ignored it should n=
ot
>> be silently ignored.
>
> I agree that there should be a warning. However, it's hard to do with
> the code structured as it is now; we don't know that a command exists
> as an external command until we try to exec it. And if it succeeds, w=
e
> don't get to execute any more code.
>
> It's certainly possible, but sadly it is more surgery than just
>
> =A0if (alias_lookup(cmd))
> =A0 =A0warn("you also have an alias defined");
>
>> Especially given that the silentness effectively means there cant be
>> any new git tools added without possible breakage of installed setup=
s.
>
> The silentness makes it harder to diagnose problems, but even with a
> warning, we can break things by creating new commands. If you have an
> alias "foo" and we ship "git-foo" in a newer version of git, your ali=
as
> will just stop working.

That was my point. At least if there were warnings about this the risk
would be mitigated.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
