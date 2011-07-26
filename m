From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: listing changesets on a branch
Date: Tue, 26 Jul 2011 04:46:17 -0700 (PDT)
Message-ID: <m38vrls1sy.fsf@localhost.localdomain>
References: <4E2E9676.5000307@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Tajti_=C1kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 13:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlg5h-00062n-QM
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1GZLqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 07:46:21 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:56962 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1GZLqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 07:46:20 -0400
Received: by eye22 with SMTP id 22so495444eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=r+9kX/osHvoDs4mUMSV0ezTnvE3AgrWlNesTmdYizio=;
        b=ql+bVs174d9IBTqzqp5B3+Epazv2kjfKpuavbFZO9ZkY4Lhfai1TAw4XiyOq/OkJBU
         Jti5ORwd6VijlkKibOlYYO01qPkwn/0JrWU5tq14iiNOJh2bgcocVaVqvuFOZFmkBlBe
         kRr2yDc3Tj3QsKba84e80d94aVQ+cWFFFlJL0=
Received: by 10.213.21.8 with SMTP id h8mr2176354ebb.83.1311680779028;
        Tue, 26 Jul 2011 04:46:19 -0700 (PDT)
Received: from localhost.localdomain (abvw23.neoplus.adsl.tpnet.pl [83.8.220.23])
        by mx.google.com with ESMTPS id e48sm304556eeb.3.2011.07.26.04.46.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 04:46:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6QBjiVj018159;
	Tue, 26 Jul 2011 13:45:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6QBjXjM018149;
	Tue, 26 Jul 2011 13:45:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E2E9676.5000307@intland.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177859>

Tajti =C1kos <akos.tajti@intland.com> writes:

> I'd like to list the changesets between two commit ids, but only
> those, that were committed on a specific branch. I tried to use the
> following command:
>=20
> git log --branches=3D*/master rev1..rev2
>=20
> But the result is not what I expected: i see sommits that were made o=
n
> an other branch and were not merged to master. Could you please tell
> me what I am doing wrong?

In Git there isn't such thing like "commits made on a specific branch".
Branches are simply references to DAG, and "on branch" means commits
reachable from branch tip (branch head).

Anyway, try `--ancestry-path` option (in git-log(1) manpage), which
make Git show only those commits that are on line joining rev2 to
rev1.  I guess it is what you really want.

HTH
--=20
Jakub Nar=EAbski
