From: "Jonas Fonseca" <fonseca@diku.dk>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Sun, 9 Nov 2008 19:52:22 +0100
Message-ID: <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com>
	 <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com>
	 <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Piotr Findeisen" <piotr.findeisen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:53:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzFPp-0005cU-9d
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbYKISwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 13:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYKISwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:52:25 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:15310 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbYKISwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2008 13:52:24 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2770105fkq.5
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=NqbIBLC0nGF2FgmT0oTGJ2qnDpF6AqzHwGFOoChB9C8=;
        b=ZumILBP+h9eWt2R79LfmuQ9t+Qlf04CHZWmfTe3g754QItnbUazZFIM/RqMBvVsj/y
         Rdxdem5KyUse+SZFIfVBxf0KKWNe+UKs1TX7oqipPY/wjpYjltA1vBw+g0rehIjcezOw
         P5ZIpEykHCrTrA0PQt3NyW1REUBmAz1yJikEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=tQbRr8Qc/eEjN/O3Vmb1QxHHR/cXWtufwnkPnCzJXmMEHl6kPUXKOq6/yae60+hMKI
         Hh9EaArM6OGSgESVE+EztnmYVgmP67fcoP90S97q2K/yGqSQVwR+IXCzowG0hVevZOV3
         pFZ0G7xDCJ2DJimC2vCW1vBaJCC9M5RUYOvG4=
Received: by 10.180.252.8 with SMTP id z8mr1813912bkh.158.1226256742800;
        Sun, 09 Nov 2008 10:52:22 -0800 (PST)
Received: by 10.181.197.15 with HTTP; Sun, 9 Nov 2008 10:52:22 -0800 (PST)
In-Reply-To: <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 8949963735d2164b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100461>

> On Fri, Nov 7, 2008 at 04:09, Piotr Findeisen <piotr.findeisen@gmail.=
com> wrote:
>> Hello!

Hello,

>> The attached file is a result of running `git diff HEAD~1`.

Please read Documentation/SubmittingPatches for the preferred way to
contribute patches.

>> Asciidoc replaces "--" with "=97" when not in verbatim mode. This is
>> sometimes unwanted -- especially when citing command line options li=
ke
>> "git diff --cached". This commit includes proper quotes in user-manu=
al.txt.

Newer asciidoc versions have the following "workaround". Maybe adding
something like this to Documentation/asciidoc.conf would be more
future proof.

# -- Spaced and unspaced em dashes (entity reference &mdash;)
# But disallow unspaced in man pages because double-dash option name pr=
efixes
# are pervasive.
ifndef::doctype-manpage[]
(^|[^-\\])--($|[^-])=3D\1&#8212;\2
endif::doctype-manpage[]
ifdef::doctype-manpage[]
(^|\s*[^\S\\])--($|\s+)=3D\1&#8212;\2
endif::doctype-manpage[]
\\--(?!-)=3D--

--=20
Jonas Fonseca
