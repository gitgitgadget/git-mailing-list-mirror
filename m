From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: utf8 BOM
Date: Sat, 15 May 2010 22:23:52 +0200
Message-ID: <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com> <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com> <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com> <20100514101648.GB6212@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 15 22:28:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODNyW-0001op-7L
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 22:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab0EOUX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 16:23:58 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57727 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0EOUX5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 16:23:57 -0400
Received: by ewy8 with SMTP id 8so1255926ewy.28
        for <git@vger.kernel.org>; Sat, 15 May 2010 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=a0tF8o7mCINZSFdYJHZJWKqcJdydM9ArzIIk/1lEOpw=;
        b=vZnK40+Aujpbry9ME4W2vmyhpq1tEsSACPLXOdT9x+DQf/Ohy3zRSVPdG8QE+4Q96d
         XH22HoS+ffZ1OLZEKIBwEjVlX2d3xmtFr1c9bz8ee56/amu3Uqkxd2yYuoaLDtHJ1/iL
         h3KUJeUUaNlEqNdzyigW+eCrA/XE+Nmc61UJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=UuOsaVjPzRtek97urzqIpWziUgZ78mG6fU5iJi8lSID7geDTe+c2IibgUYPfyoNU0l
         HJH4M8GiafGPtYw66i7ksXaQ98HMnm6sKhuE71HOEhsLdi600d6aiI1tJJro8yN+wOjS
         E4dNypqYaOuo5/NA45vyoN5uBbpuFoc4q6aq8=
Received: by 10.213.80.140 with SMTP id t12mr1203641ebk.7.1273955034915;
        Sat, 15 May 2010 13:23:54 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1950803ewy.9.2010.05.15.13.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 13:23:54 -0700 (PDT)
In-Reply-To: <20100514101648.GB6212@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147163>

On 14. mai 2010, at 12.16, Dmitry Potapov wrote:

> Probably, ability of automatic add utf8 BOM on Windows to text files
> (which are marked as "unicode") can be helpful, but it is just a part
> of the problem of how to deal with text files in "legacy" encoding,
> which are still widely used on Windows.

Sounds like something a clean/smudge filter should be able to do.  The clean filter converts legacy encoded text to utf8 and strips any utf8 BOM before checking the file in, and the smudge filter writes the file out as utf8 with a BOM (which hopefully works no matter what your code page is?  I don't know much about Windows i18n).

Adding this to convert.c would be more difficult, at least politically, since I assume it would be Windows-specific code.
-- 
Eyvind
