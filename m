From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Roadmap for 1.7.9
Date: Tue, 6 Dec 2011 01:02:16 +0100
Message-ID: <CACBZZX6=eYaebLdQrLvvaXPKFLYj_-7QGrco7gnXPjh8hjOQ=w@mail.gmail.com>
References: <7vd3c2lr36.fsf@alter.siamese.dyndns.org> <CACBZZX6aC-E4DxaZzzhfGnK8ovBGCq_gNG3hPU7QjfAiNb3WrA@mail.gmail.com>
 <7vr50ik55n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 01:02:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXiUd-0001z5-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 01:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762Ab1LFACj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 19:02:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56978 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738Ab1LFACi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 19:02:38 -0500
Received: by eaak14 with SMTP id k14so4611096eaa.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 16:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SySYkihuuIhRCuL8sThsWZtk0sXHk1z8ySyQSrK7bkc=;
        b=XE4lkLfXqJr8zUT0+Dc9YcesuAJDsWOgsMBRKReA2PX/lMca+m8AaiFkN5odFuRPMh
         koDVLxBXRljrHjxf4Por0+pxJYIuu1t2Lp+YE+GlGWjy9Rl6A/QxeomNMw42RsmTr+Ya
         BAxP9skLgVM7LKhLWZgLqM8Q1E8nyZGz7slXY=
Received: by 10.213.29.202 with SMTP id r10mr1376089ebc.52.1323129757212; Mon,
 05 Dec 2011 16:02:37 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Mon, 5 Dec 2011 16:02:16 -0800 (PST)
In-Reply-To: <7vr50ik55n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186300>

On Mon, Dec 5, 2011 at 23:47, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Dec 5, 2011 at 21:07, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>>> Now, here are the biggies that we would want to try to have in reas=
onable
>>> shape before the next release.
>>
>> I'd like to get the i18n series into 1.7.9 as well. I think it's rea=
dy
>> as-is but some minor issues are sure to arise.
>
> Surely.
>
> My impression was that the part that can have interactions with the
> existing codebase is already in, and it is just the matter of updatin=
g
> what _() ans Q_() actually do, which can be reverted out quickly if i=
t
> turns out to be necessary, and that was why I didn't count it as part=
 of
> the "biggies" that make us worry.

That's the gist of it. But it's still a massive 1300 line patch,
which:

 * Calls setlocale(LC_MESSAGES)
 * Uses an evil trick to only call setlocale(LC_CTYPE) while loading
   message catalogs
 * Might have some portability problems on more obscure OS's.
 * Has some tests I've only tested on Linux, FreeBSD and Solaris

So it might have some little surprises, and it would be nice to have
it in master early on so we'll give it plenty of time to cook and
discover any issues before 1.7.9.
