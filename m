From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Fri, 17 Jul 2009 09:29:25 +0530
Message-ID: <2e24e5b90907162059u5e3dfca1x16cd57b0a10a7204@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <7vbpnlbbln.fsf@alter.siamese.dyndns.org> <h3mpls$9dt$1@ger.gmane.org>
	 <e2b179460907160155g7c84b083u8a1dd6ba193f4531@mail.gmail.com>
	 <7vd4808iey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 05:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRebh-0000yy-9K
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 05:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbZGQD70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 23:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbZGQD70
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 23:59:26 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:60401 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716AbZGQD7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 23:59:25 -0400
Received: by gxk9 with SMTP id 9so1101171gxk.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 20:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KDasIXlIMfy3JRyYbbe/ljJ4dsUNAqBGCsZEc+/2Ja4=;
        b=LQVH6aWUl3C0IYRcaC1AfDGyVvlgu+yBJbx9qR41h/XsXawcfaUlFzvYSdqfpocrej
         ja2xTqE/N8wHuopdGaqhSxDW4VQ6KUyId69GYbG7Jw+6TjqIXPnFGaLB7T+W/0idFXnt
         hHfN2EMiRupmlfGEWiiKi01YrPfiXSCHdA+0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pMWLbp4eYQ1AiO2F2lil+djc6DhQ8w/4vYC5mqjvHQ5pzWj/cEMLLaVy31PqLHi6wZ
         ArQFjXhjTsMWqxhxJw/7zuepewhYXtrwStAeI8gdpH1TYseAIho6yDdi7rem0sSb/6NG
         Rx03l/Zx2bWu+xF3/+l5MQONXUKTVlSnEhtLU=
Received: by 10.90.91.9 with SMTP id o9mr437835agb.106.1247803165125; Thu, 16 
	Jul 2009 20:59:25 -0700 (PDT)
In-Reply-To: <7vd4808iey.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123442>

On Fri, Jul 17, 2009 at 2:17 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Mike Ralphson <mike.ralphson@gmail.com> writes:

>> http://git.or.cz/gitwiki/GitFaq#HowdoImakeexistingnon-barerepository=
bare.3F

> Somebody needs to promise to keep that entry up-to-date, or we should
> rewrite it so that we do not expose such an implementation detail.
>
> Even today core.bare is not the only difference between a repository =
with
> a work tree and a bare one. =A0We also set core.logallrefupdates thes=
e days
> for a repository with a work tree, so the procedure described there i=
s
> already stale. =A0And this kind of implementation details are bound t=
o
> change.

I wonder why core.logAllRefUpdates is not the default for bare repos.
I have taken to making that the _global_ default on any git/gitosis
server I install, so all my bare repos have it turned on.

My reason is that I do want to allow "push -f" (it _is_ sometimes
needed), but I also want to protect against such push happening in
error, and the reflog has always seemed like a good safety net to run
to when that happens.

Other than space (due to garbage collection delay until reflog expire)
what are the downsides?  Could someone enlighten me if I'm doing
something stupid here?

Thanks,

Sitaram
