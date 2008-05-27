From: "John J. Franey" <jjfraney@gmail.com>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 09:33:27 -0400
Message-ID: <1211895207.7877.4.camel@isidore.myhome.westell.com>
References: <17476529.post@talk.nabble.com>
	 <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
	 <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
	 <g1gq3u$jb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Barra Mac =?ISO-8859-1?Q?Math=FAna?= <barrymac@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 15:35:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zJr-0000jg-W8
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbYE0Ndg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 09:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbYE0Ndg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:33:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:14950 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbYE0Ndf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:33:35 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1938880wxd.4
        for <git@vger.kernel.org>; Tue, 27 May 2008 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=WRwxHeOyDwv90TkuzuGn1p6Ox/MjxYyxEl1ZTqxygiY=;
        b=G7WbkaIE5PPl5VwbBn/QhF6XtTVDSbJx84ZGLMawEVikf8yi8VjICoeqyqj4dag2+NMzDFX64C1VhKrFJg+Cy4QjUTcm5C6sfyeKDsmBFRXYxEe2OFL0/W3Y56N3KLfYXcDiSqGaQPyS0la5gQZ2msQDE5/W6HxKFbcCtS1eZFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=e5PgXUFTvN5gY/4WkilPYj2gDTnXqkVfB5NkKtDyjvGYUAOCQ2Byw3AsvXkfdPqyhE33MJdbxagcQTAvExYdmOMHr3MMUChcMdBGXmDylYBCLXd9RACdyaesvmBBV/mG9xkdp3nCC4ayEFd9mUNBdzztcdSa/PsRZmfGNJfT7To=
Received: by 10.70.20.10 with SMTP id 10mr1662390wxt.36.1211895214896;
        Tue, 27 May 2008 06:33:34 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id i20sm24591034wxd.32.2008.05.27.06.33.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 06:33:28 -0700 (PDT)
In-Reply-To: <g1gq3u$jb$1@ger.gmane.org>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83013>

On Tue, 2008-05-27 at 13:08 +0200, Michael J Gruber wrote:
> Barra Mac Math=C3=BAna venit, vidit, dixit 27.05.2008 12:45:
> > Thanks Martin,
> >=20
> > Nice to know how to log the progress! Good tip to try normal cvs ov=
er
> > ssh, which works fine.
> >=20
> > I wish it was possible to get more verbose output from the git
> > cvsimport command. The connection refused error seems to me to be
> > misleading. I would expect at least some output from cvsps but it
> > doesn't even get to the first step.
> >=20
> > So if everything works at the command line, what significant things
> > can be different in a cron job?
>=20
> The environment! Put "env" in your cron job and compare the output to=
=20
> "env" on the command line. cvs or cvsps may be in $PATH on the comman=
d=20
> line but not in cron, or $PERL5LIB might be different.
>=20
> Cheers,
> Michael
>=20

Great suggestion!

I am also having this problem.  To debug, I inserted env as you
suggested.  (Doh, why didn't this occur to me weeks ago?).  I compared
the output of cron and login-shell runs.

So what is the critical env diff between cron run and login run?

The answer is:  CVS_RSH=3Dssh

Be sure to export.

Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
