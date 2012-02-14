From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 07:54:39 +0100
Message-ID: <20120214075439.14f1d2b7@mkiedrowicz.ivo.pl>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<m339aivn4z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxCIH-0000FL-64
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 07:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab2BNGyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 01:54:43 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61035 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2BNGym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 01:54:42 -0500
Received: by eekc14 with SMTP id c14so2137120eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 22:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=EJFLXJVoLSTPit0PLrqQDtjHr0rvjhgQvDE1I9CtgbI=;
        b=o+7nHyQXCI/ypFRSRFqy7K7PeRnOySejvljGjuUixVKehDfymNrd3sLi4umP1biy/6
         Hw8DKFX5vS90YMBSpe5A7WaiStrBWhtrVwUguKu94Xhylr4gSXo+Bx+6L/7SIAvtbHjm
         tfGKJ+3fHC2tZkvEalkIS9UyaRyMlZHItJ5n4=
Received: by 10.213.30.10 with SMTP id s10mr3229604ebc.53.1329202481458;
        Mon, 13 Feb 2012 22:54:41 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id n52sm10583155eea.5.2012.02.13.22.54.40
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 22:54:41 -0800 (PST)
In-Reply-To: <m339aivn4z.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190704>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > The code that comares lines is based on
> > contrib/diff-highlight/diff-highlight, except that it works with
> > multiline changes too.  It also won't highlight lines that are
> > completely different because that would only make the output
> > unreadable. Combined diffs are not supported but a following commit
> > will change it.
>=20
> I was thinking that if gitweb were to support "diff refinement
> highlighting", it would either use one of *Diff* packages from CPAN,
> or "git diff --word-diff" output.
> =20

I just started to wonder if we couldn't use output from Jeff's
diff-highlight for gitweb. We could tech diff-highlight to produce diff=
s
marked with -{} and +{} (this is the notation used by Jeff in one of hi=
s
recent patches) or something like this and then just convert that into
HTML markup. Changes in gitweb would be minimal, we would reduce
redundancy and could focus on improving matching algorithm in one place=
=2E
