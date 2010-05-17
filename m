From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global 
	server root and projects list
Date: Tue, 18 May 2010 01:52:37 +0530
Message-ID: <AANLkTinj6sgWDm6yUVDCT6kwg-bcQRh1QCSlyLjEFtls@mail.gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
	 <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
	 <1273969019.1169.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-1?Q?D=E9vai_Tam=E1s?= <devait@vnet.hu>
X-From: git-owner@vger.kernel.org Mon May 17 22:22:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE6pq-0007ZB-WC
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 22:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0EQUWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 16:22:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40201 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab0EQUWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 16:22:39 -0400
Received: by gwaa20 with SMTP id a20so743150gwa.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jdZtEfXha9+nfvdzFn9KTxfVe8552e52sWoEM+wa+rA=;
        b=LzOM4mVmRhoSVT/xz5FMG47DwWvBl7D/HC9YfR52Zr3fK6wl/DC8nwAGzuW14/icO9
         9zGm3IdV2T/RxHbFlk2aofvp3VgCf+PDMbc+a1GJo74B46S2CTnpgr6CI/1cyt2bjf1b
         Q4I/8JvSwKetc8pmklmOQ1f4MsywotvIeS4ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gga5B8pH2SfktVfNoVniFTjGls8TEn4bQOr2HbC4EimgrC7JlUl/kT5iphfV1t86AZ
         VPd0jYc7MnJ9jFG296N7y3pPRy9hWoxxwNQvFm2sYHslD2CtErQ/7EPeQD9G+3Z+gFIV
         lscsFf+r1p/nHZ3HhwV76fH2bIhWpr7X2jMXw=
Received: by 10.91.129.4 with SMTP id g4mr2285363agn.11.1274127757985; Mon, 17 
	May 2010 13:22:37 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Mon, 17 May 2010 13:22:37 -0700 (PDT)
In-Reply-To: <1273969019.1169.16.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147257>

Thanks Devai. It's great.

- pavan

On Sun, May 16, 2010 at 5:46 AM, D=E9vai Tam=E1s <devait@vnet.hu> wrote=
:
>> +# Default is /usr/share/gitweb
>> +test -z "$root" && root=3D'/usr/share/gitweb'
>
> Just one question: what happens, when one installs to /usr/local (or =
any
> other directory) instead of /usr? I'd use the $(gitwebdir) variable f=
rom
> the Makefile as default, such as
>
> =A0# if installed, it doesn't need further configuration (module_path=
)
> =A0test -z "$httpd" && httpd=3D'lighttpd -f'
>
> -+# Default is /usr/share/gitweb
> -+test -z "$root" && root=3D'/usr/share/gitweb'
> ++# Default is @@gitwebdir@@
> ++test -z "$root" && root=3D'@@gitwebdir@@'
> =A0+
> =A0# any untaken local port will do...
> =A0test -z "$port" && port=3D1234
>
> and in the Makefile
>
> =A0 =A0 =A0 =A0 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> =A0 =A0 =A0 =A0 =A0 =A0 -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> =A0 =A0 =A0 =A0 =A0 =A0 -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> ++ =A0 =A0 =A0 =A0 =A0 -e 's|@@gitwebdir@@|$(gitwebdir)|g' \
> =A0- =A0 =A0 =A0 =A0 =A0 -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
> =A0- =A0 =A0 =A0 =A0 =A0 -e '/@@GITWEB_CGI@@/d' \
> =A0- =A0 =A0 =A0 =A0 =A0 -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
>
> Hope that you find it reasonable.
> --
> D=E9vai Tam=E1s
>
>
