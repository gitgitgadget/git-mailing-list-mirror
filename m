From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/6] read-cache: use sha1file for sha1 calculation
Date: Mon, 6 Feb 2012 15:36:27 +0700
Message-ID: <CACsJy8DR2rPtC_2PDp=ZEm-3B-mzh+AxaDmXxxzJ_VY5M-0oVw@mail.gmail.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com> <7vsjio8leo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:37:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuK4N-0001FC-8y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab2BFIg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 03:36:58 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34211 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab2BFIg6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 03:36:58 -0500
Received: by werb13 with SMTP id b13so4081216wer.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 00:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5XSj1hYAJhNrI3Z7OY2Ro/IXWh+I2An449MWvfRqYrg=;
        b=orKHecriLBxUduXfGosEQ5vp+B7/nUgc4R115LKdMrwxE0tfrIut8oHnNtVEDeLR3G
         7DUUPUfeq9sT0jLUhyw0vmbg3mc3ux7Gq3LAMXMvJ6Badsy2CNkFoB4Szh+iPfoWO1oQ
         UCbadApI5W/iUQ/zVVyrXCrQZim3071MKb47s=
Received: by 10.216.52.198 with SMTP id e48mr2965526wec.18.1328517417236; Mon,
 06 Feb 2012 00:36:57 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 00:36:27 -0800 (PST)
In-Reply-To: <7vsjio8leo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190048>

2012/2/6 Junio C Hamano <gitster@pobox.com>:
> This is open source, and I wouldn't stop you from spending time on an=
ything
> that interests you.

Well fun stuff is more interesting to do.. but I guess that's about
it. More time cut down requires bigger changes that does not fit in a
few hours of work.

> But having said that, if you have extra Git time, I would still rathe=
r see
> you spend it first on tying up loose ends of your topics in flight an=
d
> on helping others that touch parts that are related to areas that you=
 have
> already thought about, namely:
>
> =C2=A0(1) nd/commit-ignore-i-t-a, which I think should be marketted a=
s fixing
> =C2=A0 =C2=A0 an earlier UI mistake and presented with a clean migrat=
ion path to
> =C2=A0 =C2=A0 make the updated behaviour the default in the future; a=
nd

Yeah, I was avoiding the deprecation procedure (plus providing a
convincing argument to push it forward). Need to look up old emails..

> =C2=A0(2) the negative pathspec thing that resurfaced in disguise as =
Albert
> =C2=A0 =C2=A0 Yale's "grep --exclude" series.

This is pure headache. Can't avoid it forever, I guess.

> *1* A possible approach might be to stuff unmodified trees in the ind=
ex
> without exploding them into its components, and as entries are modifi=
ed,
> lazily expand these "tree" entries, while ensuring the "unmodified" p=
arts
> remain unmodified by turning the files in the working tree read-only =
and
> requiring the user to say "git edit" or "git open" or something befor=
e
> starting to edit. =C2=A0But as I said, I consider this not an ultra-u=
rgent
> issue, so I haven't thought things through yet.

A sparse index is something that may be achieved with narrow clone (or
narrow checkout in full clone) because by nature we can't have full
index in narrow clone. That may be the right way to go.
--=20
Duy
