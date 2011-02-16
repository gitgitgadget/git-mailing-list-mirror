From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 17:13:15 -0500
Message-ID: <AANLkTimBExej1mF=4UuTszcSoKy_xnj7bB3BaT5ze2vH@mail.gmail.com>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
 <1297876835-70613-1-git-send-email-jaysoffian@gmail.com> <20110216214236.GC2615@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 23:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PppdA-0006ye-NT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 23:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab1BPWNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 17:13:48 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab1BPWNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 17:13:46 -0500
Received: by iwn9 with SMTP id 9so1813578iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=rdAhOhvsaSDlfNApogthUBzgvjBP+mosAKrOkcDlvU4=;
        b=BENlvJ/0apfxxRx9vDLQYBq7X+E1Vip/h8Op/YprW11OyT1EqkkBxB0cXrAG1ygHVV
         7Bua9c2UM4L78bYlMD0AsHL6xUboK1D5B8199v/Ls1VsYRQswFYB5lHkVwVEXjXjwQhu
         R9IgCLkk886RrBq39iDjjR2VUm4BTFciF57Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pq+a316KAuhutJ9bshTSOhYw4Ed+dbAaUW/Hxadhuqh+9hSqNvTxa6/zVsN9IOQND3
         8sV+SiU8M/ZzStcuRrQ8jLsnwkkFccUaLEQpLtwtK7q8nWzXbdYPSja/C4RerQOkkDl0
         k9yfheHPUfsMshth9VuxO18dtE3MlLCa8Gdas=
Received: by 10.231.37.138 with SMTP id x10mr939819ibd.192.1297894426031; Wed,
 16 Feb 2011 14:13:46 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 14:13:15 -0800 (PST)
In-Reply-To: <20110216214236.GC2615@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167011>

On Wed, Feb 16, 2011 at 4:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nit: GIT_CHERRY_PICK_HELP is not just for rebase --interactive but
> for arbitrary porcelain that wants to take care of the commit itself
> (see v1.5.4-rc0~106^2~1, revert/cherry-pick: Allow overriding the
> help text by the calling Porcelain, 2007-11-28).

What is the arbitrary porcelain you have in mind? :-)

> The conservative thing to do is indeed to remove CHERRY_PICK_HEAD in
> this case, I suppose. =C2=A0But I'd like to have the CHERRY_PICK_HEAD=
 to
> get the --amend safety when rebasing. =C2=A0I can send a separate pat=
ch
> for it if you'd like.

Please do, since I'm not really sure what you have in mind. If
CHERRY_PICK_HEAD is left-behind, it interferes with the eventually
commit done by rebase --continue. I suppose we could give commit.c
some additional logic to detect when it's being called by rebase
(setting whence =3D FROM_REBASE?).

In the mean time, I'll re-roll with your additional tests and Junio's
prior feedback.

Thanks,

j.
