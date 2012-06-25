From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Editing the root commit
Date: Mon, 25 Jun 2012 10:22:05 -0700
Message-ID: <CAOeW2eGnz6d6XdLneH1CQJ+ziD_YJ7yN1N5_YWvULX3nxFsewQ@mail.gmail.com>
References: <20120619091657.GA28005@arachsys.com>
	<7vy5nj1uld.fsf@alter.siamese.dyndns.org>
	<20120619111709.GC10692@arachsys.com>
	<20120620093205.GB10579@arachsys.com>
	<7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 19:22:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjCzN-0006V3-8f
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 19:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab2FYRWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 13:22:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57277 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757253Ab2FYRWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 13:22:07 -0400
Received: by dady13 with SMTP id y13so5603094dad.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rNdWdvebhdTQXJgKc9FjDLhIKaiHLNFsLXKqH3NcnIw=;
        b=Yu0ncBMrss1JyDtlbzYzz7Nla5VTdM9h9BoIzqSPWblG8WvIGS2vQ3X7kYW61iO4v3
         RUIQe6lLrgnbV8b1H4rsmQT83roNG7iAH9kknUs2P85FSH7MQCS7Hnu5jvBlCcstmg2k
         8m9yUxlCe1SBPYR0jzNd4GPN+8A4I5utmC4e1CHESdJZtTreJXUnpJrPIatXjH/wSdCE
         TDu63Q6UIckJaWWjrLRgOH6Ti68g4mi03UVsQChJhhTVZFkxsSA8xbBxW96PkmDYDUgF
         touR/XqR8QTM/qAtygS86REDeseGRB43kZAaAH+w4nYLSqW+/47YZcQHcpq3YlEAbVeR
         OCyg==
Received: by 10.68.212.102 with SMTP id nj6mr43655218pbc.15.1340644926011;
 Mon, 25 Jun 2012 10:22:06 -0700 (PDT)
Received: by 10.68.218.98 with HTTP; Mon, 25 Jun 2012 10:22:05 -0700 (PDT)
In-Reply-To: <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200587>

On Wed, Jun 20, 2012 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> =C2=A0 =C2=A0$ git rebase [-i] --root --onto nitfol
>
> looks at the entire history leading to where you are, and replays
> everything you have done onto the tip of 'nitfol'.
>
> What if we do not say --onto here?

Or even leaving out the --onto for that matter. If I understand
correctly, "git rebase --root --onto nitfol" is (more-or-less) just
syntactic sugar for "git rebase nitfol", see
http://thread.gmane.org/gmane.comp.version-control.git/181024/focus=3D1=
82054.

I have an old branch from around the time of that thread that make
this fact (that "--root --onto" is syntactic sugar) a little clearer
in the code. I'll try to finally send out some of those patches as
soon as I can.

> =C2=A0What _should_ this command mean to a na=C3=AFve user?
>
> =C2=A0 =C2=A0$ git rebase [-i] --root
>
> I think it should mean "replay all my history down to root". =C2=A0Th=
e
> original root commit should become the new root commit in the
> rewritten history.

I agree, and in this case, the --root flag would not just be syntactic =
sugar.

Martin
