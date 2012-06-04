From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Mon, 4 Jun 2012 21:55:11 +0800
Message-ID: <CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
	<1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
	<CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 15:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbXkk-0008Ej-B1
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 15:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab2FDNzP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 09:55:15 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37623 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2FDNzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 09:55:12 -0400
Received: by ghrr11 with SMTP id r11so3314267ghr.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DRJYPZfFyMQ/eXIAQNJu6RXHU+qIwVR7ASvoM7oPdKg=;
        b=07tFNE/yyMvZ9LLYFQ4tA4FA3LJT9I6XOPOy8l6RpKGn4XxONICqE1NTkzKWdsNO8r
         Wy9iaGtZppq3n1QKqaF64JBatta5QT8f0PqtnkZJlX9VwUkqnsmL0dn+xsGns0BjSk9i
         fdEg//pyi7QCL2X61quX0IjZ2WyZ8rNShV5RsQjval0QW5iW1wZZ5lMgc6OoAkP3+iZH
         g/KbR+5xI90IBqOwPikJ2QCsf0ZHuMZDwTZIMGlggJyWvR3aX2F0c5KLGd3a5CVpPrYD
         WWK3sSYiamya6w0myVzqt2cqlPoeaD67jAhdDSQxgxJ6CIr8EH2G+tc9OekDPVlXA78/
         /YGg==
Received: by 10.50.180.225 with SMTP id dr1mr7944157igc.52.1338818111639; Mon,
 04 Jun 2012 06:55:11 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Mon, 4 Jun 2012 06:55:11 -0700 (PDT)
In-Reply-To: <CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199137>

2012/6/4 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> I think a better solution to this is to just apply this patch:
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(gettext -- "--cached cannot be u=
sed with --files")"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "$(gettext "the --cached option is =
incompatible
> with the --files option")"

The rewrite message is a bit odd for there are 40 more alike
messages (extracted from C files) start with "--=94, such as:

    msgid "--delete only accepts plain target ref names"
    msgid "--all and --tags are incompatible"
    msgid "--all can't be combined with refspecs"
    msgid "--mirror and --tags are incompatible"
    msgid "--mirror can't be combined with refspecs"

> I think changing the only message suffering from this
> issue (or likely to suffer from it) beats a solution where starting a
> message with -- only works for some of the xgettext
> commands/functions.

If I had not changed like this, I would not find out there are 27
marked messages (by gettext wrappers) have not been
extracted to "po/git.pot". ;-)

--=20
Jiang Xin
