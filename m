From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 22:45:36 +0200
Message-ID: <E260F2DD-EA1E-4828-BAE4-62F7F18C5444@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost> <20100524124734.GD3005@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 22:46:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGeXA-0008HE-8k
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 22:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab0EXUpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 16:45:42 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45100 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0EXUpk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 16:45:40 -0400
Received: by ewy8 with SMTP id 8so378131ewy.28
        for <git@vger.kernel.org>; Mon, 24 May 2010 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=CEUxPLQFDPCwjEEeAspfZtKyqJPwFpJQTdNaX+t6W3c=;
        b=gTdeHDICFFBBm34n5UiUYRhVBpjrktCA3SLTfmlmx2XM2PFpFVO9w+tlFyNuTbTsAK
         B14HSA8dOdNzYcEzW2azXefNFHn9r0qbKu2aZXYD/Z2MD/qQVegwXMEzilsQ6gLQDtvo
         deEEtK6ixZP0Xhbw0BjVxL2ORzLkEBkIx90Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=EqLZlLFnrxzOa8EY5wWkOy/7VTwTBruKtJYGoJcs4H3jA9eE7BDU6ExJulgHsP1kPY
         ChtwHDZFpPvzWbATywyFrcLZ5zQmJCW+CwOoE51XatV8LuazC7RisFmOocDt3BObSvYg
         4p0KDBXaZ6eMNxP7WaFk/35Q9BThCCQQ+4Ajw=
Received: by 10.213.19.14 with SMTP id y14mr21816eba.29.1274733939022;
        Mon, 24 May 2010 13:45:39 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm2061018ewy.0.2010.05.24.13.45.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 13:45:38 -0700 (PDT)
In-Reply-To: <20100524124734.GD3005@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147647>

On 24. mai 2010, at 14.47, Dmitry Potapov wrote:

> On Mon, May 24, 2010 at 11:49:05AM +0200, Clemens Buchacher wrote:
>> With CRLF file in the repository, core.autocrlf=true and
>> core.eol=lf,
> 
> I wonder if this combination should be allowed. core.autocrlf=true
> always implied that the native EOL is CRLF. So I do not think any
> reasonable behavior can be deduced for this combination. Can you
> imagine _anyone_ who would want to have such settings? Otherwise,
> it is better to error out if this combination is encountered.

It errors out when core.autocrlf=input conflicts with core.eol, but allows an explicitly set core.eol to override (with no warning) when core.autocrlf=true.  That way, the meaning of core.autocrlf can later be changed to simply enable normalization without touching the output format--unfortunately removing any sense to the name.

Leaving core.autocrlf to mean what its name implies would require a new config variable (core.autotext?) for people who want automatic normalization but LFs in their working directory.

I'll be semi-offline for the next week or so, so any update of the series will have to wait until I get back.
-- 
Eyvind
