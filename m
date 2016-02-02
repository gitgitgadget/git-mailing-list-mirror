From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: git log -g bizarre behaviour
Date: Tue, 02 Feb 2016 21:22:12 +0100
Message-ID: <1454444532.2713.1.camel@kaarsemaker.net>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	 <xmqqegcwt32j.fsf@gitster.mtv.corp.google.com>
	 <1454401738.32711.7.camel@kaarsemaker.net>
	 <xmqqsi1asyai.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:22:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhSy-0004wy-S2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbcBBUWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2016 15:22:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33561 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbcBBUWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:22:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so4071258wmr.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=MzryDb/3RJ0m6EJ/Mzlm3uvXAaMlf5liOpy8Yoa29nc=;
        b=vWhpZ4Ka7lKPlbIjAlS95QwCtqVf/KHZulEvEnmTc0E3kVY2g0dXYBG3xLwe9c3dzn
         RpPQgxg7zLQPZdXvyD/8PgeDIj3biW8oYAvcm0ad5hEBTWld7AmStWPh7xNZSqyi22Dt
         goG7uSvBK4agU4ZcG5jxqDVn1afupn65CGcRdMFhbX1Q4BxFOfSklgibE5tWXccsrWRP
         B2ZuYXUoXki9psDs9+THiPdIArkUoOmmk+6xlu22P7YX8LxDilb4/dN5bafmZaqmN/4h
         lYVFoFTvBo2TN79a6/pZYxX0k6Fr0EGNWXZ1lPZ/2OkQBo8Q5Ak1gZKkuGI7HyTwzqMx
         pv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=MzryDb/3RJ0m6EJ/Mzlm3uvXAaMlf5liOpy8Yoa29nc=;
        b=dDdeVpxA1sr3YR3rtfYgJ2RO+OAkVh/ea1boiWBnKWxTVAJqHO7fkiqQZKog9vFCid
         7pelgnjj0XS0lp2D+/2+2fvv9GTtuH7mZO0yrI1yihM5U/6oW8Fm9snVYPSzA9f9d+HK
         2KxQKhfbHeo4ee/Zr6NVdKXEPy8/T7U05uFmiAyiVQIbWBA7vim5TaE1+tM3MGeKs8Xj
         GHgW+ofSEJ5r3Q+arY+wVT2tInq8OkNgoD+sdvAxctbKZ8XJTU+aBndzH+DlAnT+QX4+
         QnpwlCrmwxwkcdmMClDh8mdz9N89BmWlVpCYz9QC19ze6dKJIltYoj/WOD2VVt9t1hXx
         K1hg==
X-Gm-Message-State: AG10YORUiIPNhc+5ajuG3+Qw+jrf3McZhDIgCBfFg4VgFlLuOWAhnXk3nkWShC1cEvHoHg==
X-Received: by 10.194.243.103 with SMTP id wx7mr33719748wjc.136.1454444534425;
        Tue, 02 Feb 2016 12:22:14 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w8sm3085811wjx.21.2016.02.02.12.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 12:22:13 -0800 (PST)
In-Reply-To: <xmqqsi1asyai.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.3-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285303>

On di, 2016-02-02 at 11:32 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>=20
> > On ma, 2016-02-01 at 15:37 -0800, Junio C Hamano wrote:
> >=20
> > > Do you mean
> > >=20
> > > 	$ git checkout -b testing
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ rm -f .git/logs=
/refs/heads/testing
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ git log -g test=
ing
> > >=20
> > > will be changed from a silent no-op to an abort with error?
> > >=20
> > > I do not see a need for such a change--does that count as an
> > > objection?
> >=20
> > No, I'd like to change:
> >=20
> > $ ls .git/logs/refs/tags/v2.7.0
> > ls: cannot access .git/logs/refs/tags/v2.7.0: No such file or
> > directory
> > $ git (log -g|reflog) v2.7.0
> > From the bizarre behaviour above to a silent noop.
>=20
> When there is nothing to show, we do not show anything,=20

As I demonstrated in the text that you cut: that is not true.
git log -g v2.7.0 and git reflog v2.7.0 are *not* silent, but buggy. I
would like to make them silent.

> and that is just like "git log v2.7.0..v2.7.0" is silent.
>=20
> I do not find the silence bizarre at all.

I'll take that as an agreement then :)
--=20
Dennis Kaarsemaker
www.kaarsemaker.net
