From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Fri, 21 Dec 2012 16:58:50 +0100
Message-ID: <50D4873A.6060501@gmail.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm50k-0000mj-RF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 16:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab2LUP7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 10:59:08 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57152 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab2LUP65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 10:58:57 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so2230813wgh.7
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 07:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=ing3fTusCJQPbqsvK3ha8tqWpEH8/zmQGMuCTGk2xoY=;
        b=vcnLEqktJ7Y+CI5sGDQxhzm2I494dnJL6YTm8E8aWEHDhJ+aFTiGDcL2/uNq9Slpje
         vSQ/PUuMjBORy9knOq2AmW1RUHrS+ve9qM+yJiBQRp3tGguLFckSXlS2wOPkQs7p+pFd
         leOGKHpTBdG8jcngj27dCR3V+/HZBRHAwws7Vk711Ia2kfg3QuMxut2uxWlcZLIYeoP6
         9rMfKkhv8jZ6EFkqwjR2LsROjedjYFv8N8Pd6BY6p/XCxoPQnv9RgTWcU5QP+5s5dyYx
         cVS28kO/r0ODsSvn0wEf9PWNrYX6vNJyQlqmzMTJWSgRiCk/bl/H8PBzG1wdT5rrBvbg
         6XTQ==
X-Received: by 10.180.84.131 with SMTP id z3mr16378030wiy.25.1356105535417;
        Fri, 21 Dec 2012 07:58:55 -0800 (PST)
Received: from [192.168.0.3] ([151.70.200.164])
        by mx.google.com with ESMTPS id hg17sm30367693wib.1.2012.12.21.07.58.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 07:58:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <20121220141855.05DAA44105@snark.thyrsus.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211979>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 20/12/2012 15:13, Eric S. Raymond ha scritto:
> Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
> ---

Just my two cents.
Isn't it better to have some core Python support inside a "python/"
directory in the git source tree (e.g. e simple python/git.py), and have
*all* python code import that module?

Then you can impose a reasonable version limitation (e.g. Python >= 2.5)
inside that module (and/or inside its setup.py file).

Another advantage is that the python/git.py module can contain some very
base support for interfacing git plumbing commands, instead of having
all internal (and external) modules reinventing the wheel.

I'm writing an external command for Git, and I do plan to write such a
package, so that I don't have to reimplement all the base support in my
command source code.



Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDUhzoACgkQscQJ24LbaUQFuQCfb6QgkJHdxQSEB7nLXMN8TSmI
6/IAn3svylllaIBQfZKf0lEzNBtZJQMK
=Ar20
-----END PGP SIGNATURE-----
