From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Mon, 14 Nov 2011 09:20:37 -0800
Message-ID: <CAOeW2eEUbvd0eJHjNfbvi9QnDiUO=mFA9rrKsjv8Yu0_QiPgSw@mail.gmail.com>
References: <1321044904175-6986736.post@n2.nabble.com>
	<4EBD9428.3030506@gmail.com>
	<4EBDBCA2.7070603@gmail.com>
	<7vlirlp1y6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, "J.V." <jvsrvcs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 18:20:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ0D5-0004wW-IV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 18:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab1KNRUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Nov 2011 12:20:39 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63474 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1KNRUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2011 12:20:38 -0500
Received: by ggnb2 with SMTP id b2so6389988ggn.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9qwpNmxuzQKsYBd6Na12CBmerIk3ivwS8AFCfbrod3g=;
        b=xZCBQM2WhVP5d9OsbVQupP0jz2xAW4kXhlxnqvfa/FolMLQf+579Rwh4RVmKlcr06V
         jELPqyIH/l3z5RIr9WVxaz0HLqtXnGVDmtMH9qTgIuCqWQFjyl9XuavBhgCd1CNuWj8q
         phvE/lgM2rhrA2MvAM+8Mc3PaPtDmb0e5hXc4=
Received: by 10.50.88.199 with SMTP id bi7mr24186449igb.45.1321291237815; Mon,
 14 Nov 2011 09:20:37 -0800 (PST)
Received: by 10.231.199.75 with HTTP; Mon, 14 Nov 2011 09:20:37 -0800 (PST)
In-Reply-To: <7vlirlp1y6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185392>

On Sat, Nov 12, 2011 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "J.V." <jvsrvcs@gmail.com> writes:
>
>> OK so "work tree" is a new term for me. =C2=A0I thought we were in i=
solated
>> sandboxes called "branches" and changes made in a branch would stay =
in
>> that branch regardless.
>
> Do not think of "branches" as isolated _sandboxes_.
>
> Rather, "branches" are where the independent states are to be _record=
ed_.

I think I was confused about this when learning Git too. I friend of
mine made the following argument, which I agree with and which I haven
seen on the list before:

Either you want the modifications to stay on the branch, or you want
them to carry over to the branch you are checking out. In the former
case, you would want Git to fail if there are modifications (that you
might have forgotten you made). In the latter case, you would want
"git checkout -m". The current behavior is somewhere in between. It is
not clear to me if there is a use case where the current behavior is
better (from the user's point of view) than either failing or
"checkout -m".

It is obviously too late to change this now, though.

Martin
