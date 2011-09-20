From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Tue, 20 Sep 2011 05:23:03 -0700 (PDT)
Message-ID: <m34o07s8sx.fsf@localhost.localdomain>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru>
	<1316506023-5098-1-git-send-email-zapped@mail.ru>
	<4E785DC6.80105@viscovery.net>
	<20110920104256.GA11656@zapped.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: zapped@mail.ru
X-From: git-owner@vger.kernel.org Tue Sep 20 14:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5zM2-0006f5-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 14:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab1ITMXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 08:23:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49347 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab1ITMXG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 08:23:06 -0400
Received: by eya28 with SMTP id 28so140027eya.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8vSFUxkR64j+oq6Fr8jyF6lYR/fuOxBb3yELptn9fAE=;
        b=Hj+Gq88uoIJD3cF+mFnkZeR7WCE7e6VKSM+/heQH1UOisP2YhQnN5+6Ov0Lr/vAK10
         4weoNIpHYOM9pMiLjiP/QUCPasg9NrMjHDftSdHMtIW4gguAn9ObB617LOfLKSUaO3Js
         td6yreSuc7q/yYByLEtp6tAJsCX5vc1sg1Spg=
Received: by 10.213.11.12 with SMTP id r12mr227575ebr.132.1316521384894;
        Tue, 20 Sep 2011 05:23:04 -0700 (PDT)
Received: from localhost.localdomain (abvd239.neoplus.adsl.tpnet.pl. [83.8.201.239])
        by mx.google.com with ESMTPS id x45sm4234633eeh.11.2011.09.20.05.23.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 05:23:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8KCMTv0026036;
	Tue, 20 Sep 2011 14:22:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8KCM7dw026022;
	Tue, 20 Sep 2011 14:22:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110920104256.GA11656@zapped.homeip.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181760>

Shumkin Alexey <zapped@mail.ru> writes:
> [ resent to mailing list ]
> On Tue, Sep 20, 2011 at 11:32:54AM +0200, Johannes Sixt wrote:
> > Am 9/20/2011 10:07, schrieb Alexey Shumkin:
[...]
> > > +# hooks.emailcharset
> > > +#   The charset used in Content-Type header. UTF-8, if not
> > > specified.
> >=20
> > How can you be sure that the output produced by git log etc. that a=
re
> > used in the script are in the encoding specified by this variable?
> > IOW, wouldn't log.outputencoding be the better choice to use in the
> > Content-Type header?
>
> Yes, you're right, we cannot be sure in UTF-8 encoding of output
> and using i18n.logoutputencoding would be a better choice
> instead of new config variable.
>=20
> But at the present
> 1. post-send-mail uses description file of a repo
> 2. gitweb also uses this file and AFAIK it assumes one to be in UTF-8
>   (I do not know whether it can be changed there but I tested gitweb =
once long
>     time ago)

I have thought that gitweb uses '--encoding=3Dutf8' explicitly, but as =
I
have checked it uses this only for git-format-patch invocation in
'patch' / 'patches' views.  Should be fixed.

--=20
Jakub Nar=EAbski
