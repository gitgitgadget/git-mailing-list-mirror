From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Alter parent ID of existing commit object
Date: Mon, 26 Apr 2010 16:34:12 -0700 (PDT)
Message-ID: <m31ve1eqm1.fsf@localhost.localdomain>
References: <n2xa1138db31004260313jcd22b2ebw403ca2bd547e784b@mail.gmail.com>
	<20100426103637.GA8896@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 01:34:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Xon-0006FZ-W5
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 01:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab0DZXeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 19:34:16 -0400
Received: from mail-fx0-f66.google.com ([209.85.161.66]:36507 "EHLO
	mail-fx0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab0DZXeP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 19:34:15 -0400
X-Greylist: delayed 128883 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2010 19:34:15 EDT
Received: by fxm18 with SMTP id 18so179680fxm.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 16:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=efKZlW0wA/WXobn1avs48tKUYCmBlmF6vDlSg1DktpU=;
        b=jFBWEr9Ahe4RoShQXyRyfi1CG4rNrFKGnLbheap76lzb+i/dKVsoy1qPTCwrNxnXPT
         qbrGVgAPVr8RxIdCSddkphcUesgVBKVmldkeaOLYTQUB3+JAcB3vjCOCU7CwGxNoB0hu
         9Itqc24dhX2vg3zDk0fglUP1xoJ3wMW9DxdO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=KWlCVYmYQ1CF8HBI+fCkxz98MTA+Yty0FSaum7iA5nDrPRtZM7xtmP33+r+VEx1Ax1
         wjOoEv2j+c2mV9zqcYbZ5hUAYP6VeMLIbtYRzWFInrp02IXd3RvWIMECg0fs753yQa6+
         neV9dLDQufkq5XYzbJTbqGLMMi6AOm4d/cCiE=
Received: by 10.103.78.10 with SMTP id f10mr2699133mul.126.1272324853918;
        Mon, 26 Apr 2010 16:34:13 -0700 (PDT)
Received: from localhost.localdomain (abwh49.neoplus.adsl.tpnet.pl [83.8.231.49])
        by mx.google.com with ESMTPS id j6sm19424359mue.44.2010.04.26.16.34.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 16:34:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3QNXiUM005173;
	Tue, 27 Apr 2010 01:33:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3QNXSse005169;
	Tue, 27 Apr 2010 01:33:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100426103637.GA8896@progeny.tock>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145860>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Paul,
>=20
> Paul Richards wrote:
>=20
> > Is it possible to edit an old commit object and only alter the ID o=
f
> > the parent commit but otherwise leave all the other information int=
act
> > (tree, message, authors, date, etc).
> >=20
> > I'd expect such a command to return the new hash of the modified co=
mmit.
>=20
> The standard answer to this question is to say =E2=80=9Cuse grafts an=
d
> filter-branch=E2=80=9D.  The git-filter-branch(1) man page explains t=
his
> approach.  It is very powerful, but sometimes I do not want to have
> that much power.

This also rewrites history up from the changed commit, which is
something that you need to take into account.  It is IMVHO best
solution if rewritten part of history was not published, e.g. in the
case of private repository / private development.

In the case of already published history you can use "git replace"
mechanism instead (with git-cat-file + git-hash-object).

Grafts _without_ using "git filter-branch" do not rewrite history, but
are not transferrable.  The modern 'refs/replaces/*' mechanism is.


Just FYI, as I guess in your situation grafts+git-filter-branch
would be best solution (after running git-filter-branch you can
remove graft).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
