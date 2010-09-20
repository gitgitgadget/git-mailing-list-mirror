From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] Re: compilation error: undefined reference to `set_tabsize'
Date: Mon, 20 Sep 2010 17:48:23 -0400
Message-ID: <AANLkTin6YnZTyfeKKoUtGvZx8rBvfYDPG98qYa0TXoW9@mail.gmail.com>
References: <20100920174200.GA13017@vidovic> <loom.20100920T203217-346@post.gmane.org>
 <20100920204344.GB13017@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@googlemail.com>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 23:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxoEE-0006wk-OB
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 23:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663Ab0ITVsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 17:48:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39889 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0ITVso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 17:48:44 -0400
Received: by iwn5 with SMTP id 5so4521777iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kIVaDuKfwLLxsdsKHZvV/Oep3D+FQxB1TqOdVe+2QH4=;
        b=wEkK/rhdrtQ5L3mU30d3NWu6n6ydI6cy0MxYH1AJcPoh1iFc7vMI/pQH8LMzBgZUXd
         zwoJ7VcqS5D0oS8GZBP7eDqWMG5kw7TMIGjRQ5IFRJaIF7xbj+sF4kD97v6NnbjAxueT
         EevBrHV7pQfgEvMawG4dBBK7B3V+gogkeptr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sCBK6YH2X/Lciv4fs4RM+9ILaA6u/ey491TtBiDR3ARo5HMDTOl2/209oDTpS5JYIB
         f9lxMRjS1QBHNLrQx8OSemCvEa5sxubLLSawYWDJDAPaDpHHzNvsROYtzlRqwhY8gnvD
         2tCWJJPh3QY3T8iQEeeWSBgBaZ+VmUpdENhvU=
Received: by 10.231.169.210 with SMTP id a18mr10817516ibz.5.1285019323842;
 Mon, 20 Sep 2010 14:48:43 -0700 (PDT)
Received: by 10.231.39.194 with HTTP; Mon, 20 Sep 2010 14:48:23 -0700 (PDT)
In-Reply-To: <20100920204344.GB13017@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156671>

On Mon, Sep 20, 2010 at 16:43, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> =
wrote:
> The 20/09/10, Stefan N=C3=A4we wrote:
>> Nicolas Sebrecht <nicolas.s.dev <at> gmx.fr> writes:
>>
>> > tig don't compile anymore here:
>> >
>> > =C2=A0 % make
>> > =C2=A0 gcc =C2=A0 tig.o =C2=A0-lncursesw =C2=A0-o tig
>> > =C2=A0 tig.o: In function `init_display': tig.c:7113: undefined re=
ference to
>> `set_tabsize'
>> > =C2=A0 collect2: ld returned 1 exit status
>> > =C2=A0 make: *** [tig] Error 1
>> > =C2=A0 %
>> >
>> > and bisected on
>> >
>> > commit f1fe753be71ef3ce5abcbb16c2a359f97e5c7e7d
>> > Author: Stefan Naewe <>
>> > Date: =C2=A0 Sun Sep 12 11:03:52 2010 +0200
>> >
>> > =C2=A0 =C2=A0 Use function set_tabsize()
>> >
>> > =C2=A0 =C2=A0 this fixes the following compile error on cygwin:
>> > =C2=A0 =C2=A0 tig.c: In function `init_display':
>> > =C2=A0 =C2=A0 tig.c:7112: error: invalid lvalue in assignment
>>
>> That change works for me on Cygwin, Ubuntu 10.04, Debian 5.0.6
>>
>> Maybe you should say something about your system/OS version ?
>
> Naturally. I'm running on Gentoo.

One possibility is to add a check to configure, but I don't know if
you are even using that. Alternatively, I think it would also be safe
to simply just delete the line in question, since tig expands all tabs
to strings since quite a few releases.

--=20
Jonas Fonseca
