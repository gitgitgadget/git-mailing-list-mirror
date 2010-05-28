From: Tor Arntsen <tor@spacetec.no>
Subject: Re: cvs update vs. git pull
Date: Fri, 28 May 2010 11:46:12 +0200
Message-ID: <AANLkTinw1rlvcdHB8kEbpt-kK5Bjzf1aLGPhlPwDz6GC@mail.gmail.com>
References: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Moser?= <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Fri May 28 11:46:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHw8x-0001BQ-BD
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 11:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971Ab0E1JqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 05:46:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab0E1JqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 05:46:13 -0400
Received: by fxm10 with SMTP id 10so564572fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Sw7jUpGz0oKALoZulEixxRMIfOX7g2paWI7MIglQ/CA=;
        b=xvGR/4j1t++QrkwCrNYn5QyJ4wsCz2wiBd0WLFjJlA5i2JKpPnNkhlYpFrIIVbYqK/
         CPyq52M3Zt3gLcY0HzGJkXDIA0CCadjI3+3c56GaPdTZHCdkn2T0NQv3Q6kTA7T8V6G6
         1N+9V4tgkQeeRc/SvADsusIWeBVybHYCbjaDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sgheudtPypdTfJzUE6gbVYn/2mD2/pkj6qMl7R2iTHro8rY3UTsHtXNrUzrGTWv+H7
         6hmdoFfGujjaOMoXOFK0Q4iiR41eUOygRn+Yy4Pl2iDb8mj7/T+JSU7o6lVvuyeM19Tt
         EHyJ5n4/a9DPcnB5E5i0hT0elzpn435TjSNhk=
Received: by 10.239.189.147 with SMTP id t19mr2879hbh.64.1275039972056; Fri, 
	28 May 2010 02:46:12 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Fri, 28 May 2010 02:46:12 -0700 (PDT)
In-Reply-To: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
X-Google-Sender-Auth: B0_XOiUGUebDyZkKJDSgq09Wcck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147922>

On Fri, May 28, 2010 at 11:21, Ren=E9 Moser <mail@renemoser.net> wrote:
> Hi
>
> I use git since a while for my own projects (how surprise).
>
> The company I work for still uses a CVS(nt), and this sucks, time to
> changed that. We have a use case we often have problems with. If git =
would
> solve this problem, I would really have a good arg for the managers.
>
> The codebase managed by CVS is quite huge and therefore we have daily=
 and
> nightly builds.

So do we, where I work.

> One problem we have is, that if there is a commit to cvs while the cv=
s
> update of the build job is running (and this takes 20 minutes), then =
we
> get some inconsistence, the build will fail.

Yes. That's how it works with CVS. We try to work around that problem
by using automatic tags ('nightly'-something) set individually on each
module, common for the whole repo, and then we 'cvs export' by tag
instead of cvs update. This works reasonably well (and is reproducible
due to the tag), but is not anywhere as fast as git would be.

> So the question is, if we would use git, this inconsistence would not=
 be
> possible because the git pull will get the state of the sha1. Right?

Git commits are atomic, so you won't see that inconsistency problem
with git. So, Right.


-Tor
