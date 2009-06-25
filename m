From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 15:21:33 -0400
Message-ID: <76718490906251221j7e6df642o5dafce5b6f69f14c@mail.gmail.com>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
	 <m33a9oxogk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuW1-00011Y-VT
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbZFYTVd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZFYTVb
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:21:31 -0400
Received: from mail-yx0-f186.google.com ([209.85.210.186]:64700 "EHLO
	mail-yx0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZFYTVb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 15:21:31 -0400
Received: by yxe16 with SMTP id 16so243953yxe.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e0bkDwmDrB+X6/Mb/LFGJi12SVdz1h8S9a1Daq3U+iY=;
        b=rZSUJs1LMFQA1RxMB6sTJQ+uham4BycN1EPpyKQdMl/+eKVdIkgt3AGeT66PilNIwb
         TMK/UWmQYwEjQIQadiZaN//nBNmNMXJNO+Y6m60c45ancevZptWa7IXC44enuiGE4P6l
         CpaSriHe9rbMeW376vqis8KoAnv4ttHLzPlZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ssaiZXLShHKRQ3P1YZtPknr3CjJdq2N4iFTxAWFEyPAY9+//LxHLjmswyNSlHZSMMc
         C/CMBdeIpDyJcxmatRmQLoAAnDx25jfzseLiwGMOSsB5AptxdUSOQ2zedWmE7Rs4uO/G
         c8gnKNwtx1gSgX4IMM/SCWGoKqP4lir4YaPXc=
Received: by 10.151.122.5 with SMTP id z5mr5286783ybm.93.1245957693896; Thu, 
	25 Jun 2009 12:21:33 -0700 (PDT)
In-Reply-To: <m33a9oxogk.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122239>

On Thu, Jun 25, 2009 at 12:33 PM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> Tim Visher <tim.visher@gmail.com> writes:
>
>> Can git display a list of all of your current aliases like bash's
>> `alias` command?
>
> In ~/.gitconfig:
>
> =C2=A0[alias]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0alias =3D config --get-regexp ^alias\\.
>
> Then you can simply use "git alias" to get list of all of your curren=
t
> aliases.

I have a considerably more insane alias alias that is to my liking:

        # emit an alias if given one, else pretty prints all aliases
        alias       =3D "! sh -c 'case $# in \
                       0) git config --get-regexp \"^alias\\.\" \
                          | sort | sed \"s/^alias\\.//; s/=3D/ /\" \
                          | while read n v; do \
                             printf \"%-16s\" \"$n\"; \
                             echo \"$v\" | fmt -sw 63 | sed \"2,$ s/^/\=
t\t/\" ;\
                          done ;; \
                       1) git config \"alias.$1\" | fmt -sw 78 ;; esac'=
 -"

:-)

j.
