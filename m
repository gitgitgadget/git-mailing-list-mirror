From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Thu, 26 Nov 2009 12:23:19 -0500
Message-ID: <76718490911260923l1d22012cyf62904d14cde4198@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 18:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDi43-0002vP-LL
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 18:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760706AbZKZRXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 12:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760736AbZKZRXP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 12:23:15 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:52491 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760706AbZKZRXN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 12:23:13 -0500
Received: by iwn1 with SMTP id 1so552322iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5HbL2Q4sKVWiPFhYkn0UC9XCikPuR8bjVqK/Wyx2FCg=;
        b=WQ+7x4DCMt4M7D6J/22bQ9PIK4w/w9+/A0Adq1e0ZijAn4qTLVJ1jwO+o6dcBrBqE4
         oTF52LPsjXAv+EN98VaInyS+2Tb8QVdmPfW4cifhr4rb//sqHSQe8Gpml09jcD/OHM/h
         InAo9DA0VrXdGT8A/p6s58idoUgddYEEo2tPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vI54nZ4VfBSDuvieFl4ylFCeF/ViiV9zSRIu8s4H/w9gWKrmMmGVxNAGZivMo6u/1c
         GEP3FB2rGcV4wzZHZib4W15C1FVWsV8CNPoTe/gciLNrF3sklVDD7ADtB4z2nmB/Lwx9
         OtObKne2b0xduA1YAlCvGSct/0aeF+HR86k5M=
Received: by 10.231.10.16 with SMTP id n16mr3316177ibn.24.1259256199477; Thu, 
	26 Nov 2009 09:23:19 -0800 (PST)
In-Reply-To: <4B0ABA42.1060103@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133813>

On Mon, Nov 23, 2009 at 11:37 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
> I'm on an English OS X 10.6.2 and I created a sample file with umlaut=
s in
> its name (=C3=9Cberl=C3=A4nge.txt). When I try to stage the file in t=
he terminal, I
> can't complete the file name by typing the =C3=9C and hitting the tab=
 key, but I
> can complete it by typing an U and hitting the tab key. Unfortunately=
, after
> executing
>
> =C2=A0git stage =C3=9Cberl=C3=A4nge.txt
>
> I invoked
>
> =C2=A0git status
>
> and it still shows the file as new file. Should I set some environmen=
t
> variable to be able to work with files containing umlauts in the name=
?

Works for me on 10.6.2:

kore:~/foo (master)$ echo =C3=9Cberl=C3=A4nge.txt > =C3=9Cberl=C3=A4nge=
=2Etxt
kore:~/foo (master)$ git stage =C3=9Cberl=C3=A4nge.txt
kore:~/foo (master)$ git st
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   "U\314\210berla\314\210nge.txt"
#
kore:~/foo (master)$ git commit -m initial
[master (root-commit) f23e23f] initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 "U\314\210berla\314\210nge.txt"
kore:~/foo (master)$ git st
# On branch master
nothing to commit (working directory clean)

Doesn't matter whether LANG and/or LC_* are set or not for me.

j.
