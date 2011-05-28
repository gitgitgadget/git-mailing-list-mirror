From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: git send-email --body <file> ?
Date: Sat, 28 May 2011 12:22:16 -0600
Message-ID: <BANLkTinPHjON73a37CQD-oT3XWxW4V6=jw@mail.gmail.com>
References: <BANLkTi=28buKWVZeAHZs3xB4ry+njDDuuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 28 20:22:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQOA0-0005WL-4e
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 20:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab1E1SWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 14:22:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63837 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab1E1SWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2011 14:22:46 -0400
Received: by pvg12 with SMTP id 12so1155829pvg.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=0U6lZfNRLpS+OTZLO4ex0rsHYSCYC9pxRe4ZdijVWPs=;
        b=Un4YqflCTXgInYeY7nZ1lR3vGTJBwa0cOpGYhM7jbmsSqLs5jh6ObWQi4rrg1Exc4t
         Z8qYQtyMhC5swb0OBIc7k5yoXsUpP7s68GL6yV/1Qa+Ld/YCBXREwB9HRS2ucDHZM4AN
         WtxVOygv94NNJHA7dE4ezXrwImTANvHqG/UZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=a/0nPNul+RDLkfW3SO/K8nh9KIls7kKNW8OmhHPiPlfuBH7TJmM69+7YE0Kgok2sWF
         YPelEO6S6cGPeAmFod/21l2ZlV9ltk4eoOl6wFCbD6W4c++HM5R0b0Yu12USCUDD0UFR
         aFnpIO3wyd0mOomDoojWCDPupNZoMxf+xsB6M=
Received: by 10.142.222.14 with SMTP id u14mr475281wfg.446.1306606966208; Sat,
 28 May 2011 11:22:46 -0700 (PDT)
Received: by 10.143.59.18 with HTTP; Sat, 28 May 2011 11:22:16 -0700 (PDT)
In-Reply-To: <BANLkTi=28buKWVZeAHZs3xB4ry+njDDuuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174669>

On Fri, May 27, 2011 at 1:56 PM, Jim Cromie <jim.cromie@gmail.com> wrot=
e:
> The perlbug tool is increasingly used by perl community to send patch=
es,
> it has options to save report (perlbug.rep by default)
>
> Ive started hacking it to use git send-email when used from inside th=
e git repo
> (theyve switched to git :-), and Id like to just use the file it writ=
es.
>
> I tried just passing file in as 1st arg, tool was unhappy:
>
> [jimc@groucho perl]$ git send-email --dry-run =A0perlbug.rep 0001-*
> fatal: perlbug.rep: 61: patch contains a line longer than 998 charact=
ers
> warning: no patches were sent
>

Nevermind.

perlbug was doing some odd stuff - it wasnt writing headers to saved fi=
le,
so when I went to send it, git-send-email complained.

Ive now hacked perlbug to call git-send-email $rptfile @patchfiles,
without --compose, and things work.

sorry for the noise.
