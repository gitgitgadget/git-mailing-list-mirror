From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSoC] git-instaweb: Configure it to work with new gitweb  structure
Date: Sat, 22 May 2010 20:59:54 +0200
Message-ID: <201005222059.54995.jnareb@gmail.com>
References: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com> <201005221757.38376.jnareb@gmail.com> <AANLkTinbzlRsmQekpLlFQC3xOMB2ZUurLqJoyFCnHZFG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 21:00:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFtvs-0005PB-0n
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab0EVTAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 15:00:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab0EVTAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 15:00:03 -0400
Received: by fxm5 with SMTP id 5so1619799fxm.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OTNhbHdYFFjYqpV62gcAOXlnPrGBmS7TkWkRZd4ptJM=;
        b=JPQK2J9ZoLOWSPctxqr1mjXHefdJ5hKVB44pxq2DV3i7tiyON/+iUFWGoRsFSZ+fJf
         VBOUstclYHUWaHWVwjrDL6mzKYykBsUJsdMNfzHD/gA2snbQfBOT3w4+6QpAmfkfjbAV
         fCXb3c5DkymMKYGyohvWoBMzn8Ix02ERIa22o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f8cG2LyzWzEdQ76M34BOVli9zYb0zc7DjfbdlyKbcYMzXEI/wzK8tym80ehOahL4uE
         mK8R0e5x0hUad2UrC4Po6N53HWmItV5U0CfjPMcf93/ZcB9hkKy43FhwYsKrBvAPKGva
         X4KtGxdDDXjdgb/m8NahCBRMbyhc5DeDNtJ1I=
Received: by 10.103.81.29 with SMTP id i29mr2769425mul.109.1274554801049;
        Sat, 22 May 2010 12:00:01 -0700 (PDT)
Received: from [192.168.1.15] (abwk129.neoplus.adsl.tpnet.pl [83.8.234.129])
        by mx.google.com with ESMTPS id u26sm8594469mug.25.2010.05.22.11.59.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 11:59:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinbzlRsmQekpLlFQC3xOMB2ZUurLqJoyFCnHZFG@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147537>

On Sat, 22 May 2010, Pavan Kumar Sunkara wrote:
> 2010/5/22 Jakub Narebski <jnareb@gmail.com>:
>> On Sat, 22 May 2010, Pavan Kumar Sunkara wrote:

>> Acked-by: Jakub Narebski <jnareb@gmail.com>
>>
>> _If_ there is no problem with $(gitwebdir) and not $(gitwebdir_SQ),
>> see below for details.
[...]
>>> diff --git a/Makefile b/Makefile
>>> index caf2f64..91cd726 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1592,15 +1592,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.=
cgi gitweb/static/gitweb.css gitweb/
>>> =A0 =A0 =A0 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>> [...]
>>> + =A0 =A0 =A0 =A0 -e 's|@@GITWEBDIR@@|$(gitwebdir)|g' \
>>> =A0 =A0 =A0 =A0 =A0 -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>>> - =A0 =A0 =A0 =A0 =A0 =A0-e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' =
\
>>> - =A0 =A0 =A0 =A0 =A0 =A0-e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
>>> =A0 =A0 =A0 =A0 =A0 $@.sh> $@+ && \
>>> =A0 =A0 =A0 chmod +x $@+ && \
>>> =A0 =A0 =A0 mv $@+ $@
>>> @@ -1972,6 +1965,7 @@ install: all
>>> =A0 =A0 =A0 $(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
>>> =A0ifndef NO_PERL
>>> =A0 =A0 =A0 $(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DE=
STDIR_SQ)' install
>>> + =A0 =A0 $(MAKE) -C gitweb gitwebdir=3D$(gitwebdir) install
>>> =A0endif
>>
>> Have you checked that you can use $(gitwebdir) and don't need
>> $(gitwebdir_SQ) here? =A0Does git-instaweb installs and works correc=
tly
>> if 'gitwebdir' contains spaces and single or double quote characters=
?
>> But perhaps that doesn't matter in practice, and this is good enough=
=2E
>=20
> Nope. I didn't check it. But you are right.

Does it mean that after your patch git-instaweb works correctly if
'gitwebdir' is set to something like (for example):

  gitwebdir=3D"/home/local/some strange \"path'"

--=20
Jakub Narebski
Poland
