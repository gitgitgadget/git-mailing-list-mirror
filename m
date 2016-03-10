From: Marcus Kida <marcus.kida@gmail.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out - Part 2
Date: Fri, 11 Mar 2016 09:43:59 +1100
Message-ID: <02FB9587-5849-4B3A-A199-6483377C3EED@gmail.com>
References: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com> <alpine.DEB.2.20.1603101313220.4690@virtualbox> <9EFA8642-FA02-4ADB-B37B-530E611C9C1F@gmail.com> <20160310224158.GA2772@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:44:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae9JR-0005Hz-L2
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 23:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbcCJWoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2016 17:44:05 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33500 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcCJWoE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 17:44:04 -0500
Received: by mail-pf0-f177.google.com with SMTP id 124so79497323pfg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 14:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tr4NnGWMA2Pwh8hYBWHfPFJLrDYzqHEZ1f2yk5/UahI=;
        b=DGWkU9g+8FeFy2YI6UK/thDP8Stl9yK6KhtmJfTnxVqYKSUyPNeO9aLGEJyPVuw5KW
         6xvUQuEZEaRSGyG2om/pStL5NLY9XLvoLQCkGfH6Qb6qa4mwh98Ra83sk27GHeorbikg
         TTUUvDoF9aiun8r8u+1bX9mRNKiL0BK5RLJYeHnfxRg0sLodqf5KI5z+OugdmxlLYayD
         VxduPLMmNz+UoOoXLRqJp4ulSDdc8R1JhP3fOF0Kojz7w2S1k9PbA8dgoXhkHwIgf316
         Y5C8OAncYmt5EfwBPpA5Q8aJhFw7IeMwDI4eT1deecad9zbk61UepZqgZ6NOTxDzndBK
         9aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tr4NnGWMA2Pwh8hYBWHfPFJLrDYzqHEZ1f2yk5/UahI=;
        b=gI8noR4ZCB/p0zw0rH/Q/2bMgxpD74HGAfhi5u5z7F5ymPTppStmlyOQqsIlnSTC/U
         2bpkXavJw5gUUiOQ01ZYXUgdWFmzuEO2mh9zdf1DTe7a/pKz4djPG1TMkMZxzqvRp09f
         pYGNqx9baZdCS0Q8D5qA2h/dACU3CZzvCGB3a4ouuSniu3XCSHt7KQOcbzGXnRrDbsAg
         7vVYVRDtLxyIt/zXVvdoXV5JjcBXDnHQypO9G5zmNLDIb1QN+3F9PARrPg58zdzZOwDL
         yn+jFHLebSKkh3B16lYFQxu5wul3eEZlf7b6o03ft4ibfHOB9UOKtE0tQQSoF23qU0yn
         c8Sg==
X-Gm-Message-State: AD7BkJJ7mx623WM3+xhMTv4wVqoLbIBQDrk5OMvgJ2+raL3SV1p2XQ8Sons6FsFxXImWmQ==
X-Received: by 10.98.0.11 with SMTP id 11mr8644270pfa.5.1457649843172;
        Thu, 10 Mar 2016 14:44:03 -0800 (PST)
Received: from mkida.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id ey7sm7817918pab.47.2016.03.10.14.44.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2016 14:44:02 -0800 (PST)
In-Reply-To: <20160310224158.GA2772@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288656>

=46air enough,

thank you. I=E2=80=99m going to take a look at the previous threads.
I=E2=80=99d also be keen to help working on those issues.

> On 11 Mar 2016, at 9:41 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Mar 11, 2016 at 05:30:00AM +1100, Marcus Kida wrote:
>=20
>> thank you for the feedback.
>> I will fix this, test it and send a patch.
>=20
> Unfortunately, I think this issue is a little more complicated.
>=20
> There's some prior discussion in
>=20
>  http://thread.gmane.org/gmane.comp.version-control.git/284022
>=20
> and
>=20
>  http://thread.gmane.org/gmane.comp.version-control.git/276456/focus=3D=
276506
>=20
> The latter, in particular, shows a case where this approach will do t=
he
> wrong thing. The fundamental issue is that refs are potentially store=
d
> in _two_ places: the filesystem, and the packed-refs file. And the
> latter is always case-sensitive, while the former sometimes is and
> sometimes isn't. But because the storage all happens behind the scene=
s,
> the user has no way of reliably disambiguating (e.g., does "foo" refe=
r
> to your checked-out "FOO", or are you intentionally trying to delete =
an
> extraneous "FOO" that ended up in the packed-refs file?).
>=20
> -Peff
