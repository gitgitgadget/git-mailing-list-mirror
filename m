From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to manage merges from one line while excluding its merges
 from another
Date: Fri, 25 Jun 2010 19:51:52 -0500
Message-ID: <20100626005151.GA12401@burratino>
References: <4C252D1C.4010702@brooks.nu>
 <20100626000358.GA11473@burratino>
 <4C254B62.6020108@brooks.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Yann Dirson <ydirson@altern.org>
To: Lane Brooks <lane@brooks.nu>
X-From: git-owner@vger.kernel.org Sat Jun 26 02:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSJe8-0003bJ-OI
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 02:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0FZAwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 20:52:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0FZAwH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 20:52:07 -0400
Received: by iwn41 with SMTP id 41so2546887iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tjwVJdDPhjkahhdIXhq/rY6CKzJWS6iK+pBhwjzOC+s=;
        b=MTaDqCdMyPj8ZtS7z/TABxcpHwmLBPXFUAc02pnrDXN81YTM44Iv8dUE4a9xMfYyZp
         482X1Ry/a8GzfonMD2fl5XEmSYj051byyrWmJJ/GXIE2IhALs013RUJo3VN9N1ggAApC
         FyejBuG4GJv5KlRWfwVV7q6ve/nKYQ1VzSkvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aeVywjptBuQpFYJlVL+uv6a9mJQ2zawzMJwMPqsD4EeWxC1YKnNEAnPJN9dwrLjeDk
         fkXkVrv90BMk0c725JsbwNN4qpZOdJRa76pa9ENKCuMrioQ9cQzb/lNXfxYT1Y6r+9vn
         x5TpTv1SVHLXdlX51G/i2ataHcDO5k/UYvNcE=
Received: by 10.231.32.129 with SMTP id c1mr1518270ibd.112.1277513524650;
        Fri, 25 Jun 2010 17:52:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v23sm3124769ibp.21.2010.06.25.17.52.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 17:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C254B62.6020108@brooks.nu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149724>

Lane Brooks wrote:

> I'll take a look at your suggested cherry-pick script. Can it be
> rerun multiple times or is it run one-time only. In others, as
> 'devel' continues to grow can I run it again and will it cherry-pick
> intelligently or will it try to reapply commits already
> cherry-picked?

Good point.

  git cherry my devel main |
  grep -v ^- |
  while read mark rev
  do
	git cherry-pick $rev ||
	{
		echo >&2 cherry-pick failed
		break
	}
 done

I hadn=E2=80=99t known about the third argument to =E2=80=98git cherry=E2=
=80=99 before.
Thanks for the example.
