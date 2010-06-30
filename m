From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Dangers of reset --hard (Re: Implicit stashes)
Date: Wed, 30 Jun 2010 00:13:26 -0500
Message-ID: <20100630051326.GA17497@burratino>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 07:14:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTpcV-0003AU-9I
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 07:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab0F3FNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 01:13:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40471 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0F3FNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 01:13:52 -0400
Received: by iwn7 with SMTP id 7so474650iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 22:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9nGF1ixDGYaziNU6Jj1Ia/H1SkglJq24G8XZOQDSr84=;
        b=CkQm3gZcH6BhcK2t6YFBnBMKoSBDz7m7XPGqOqzTy34d+iGg83p/8QikpGeNXtkD+Z
         Xr3HEY7UjRj9bOszOKuKoyzYURcRv7439Rt460Pg0yhMtOYAO2nmnHJKr6fPPYFBA7wj
         B5KYvkywrPN4LQaqRVr5DpfSBA+7vSzHHpHcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Tlv6pLl7o4ARrto/b/7m7lGr3tpuOa1Eb2FT0fRG++g0hmRK8U0y1eWwgSoeD6IRzN
         DdJSYj+bV775+rgVtfOHGBI3J0liVCzK80nOXQECFMZt4+bVyajd1qgcCDc0Z3NQn3Xo
         IO+eAICzwXx6AiUkkeY9RScC/d99nZNa84+gs=
Received: by 10.231.125.87 with SMTP id x23mr7780611ibr.88.1277874831996;
        Tue, 29 Jun 2010 22:13:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g8sm18058263ibb.23.2010.06.29.22.13.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 22:13:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149944>

John Tapsell wrote:

> $ git reset --hard
>
> I know this seems very explicit to delete changes, but I myself have
> done this and accidentally lost changes.  For example, I write a unit
> test and don't commit it in on purpose because I know that it
> currently fails and I want to test it against older versions.  I
> carefully git checkout older versions to find if the unit test fails,
> then in stupidity reset back to origin/master ..

Aside: I assume you already know about it, but still I cannot help but
take the opportunity to advertise =E2=80=98git reset --keep=E2=80=99.  =
I was added
fairly recently (1.7.1 rc0) and I find myself annoyed when on machines
without it because of almost exactly this use case.

Stephan and Christian: thanks for writing it.
