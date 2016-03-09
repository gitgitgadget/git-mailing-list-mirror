From: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Subject: url.<base>.insteadOf used for server-side redirection?
Date: Wed, 9 Mar 2016 16:33:36 +0700
Organization: Linaro
Message-ID: <20160309163336.42161c01@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 10:34:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adaVC-0001hT-Me
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 10:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcCIJdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 04:33:55 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34046 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcCIJdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 04:33:51 -0500
Received: by mail-pf0-f180.google.com with SMTP id 129so35942325pfw.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 01:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=r0Bts3PyaWVQzYPiAmmPqnkhTsB48mBS9uuke+KQc4o=;
        b=hD3Sj0qKxyxem4+mHGdx7ORTiyWGiuFZ7aBEE34hUqKt8ZQgFUQuRZxM2HRWIOCavh
         8KylfOIMAeluNtz8zDyJ4DiJP8Q9k/l7vV8/7RLaSSWQAxaIDJqmb5IF7E/GRotN5/tD
         Gwb5iwH+I5mf3ypIq0RQU8jPVQLhyaT6IMxGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=r0Bts3PyaWVQzYPiAmmPqnkhTsB48mBS9uuke+KQc4o=;
        b=cnpjvkfcoD9by7QV7V3MK/ZS6tzVHxNKxFgY0ReMy1tFi09z/4dH5ZAuNfiEPeJ2pO
         HfUbragq+i2LoUGYiMgOQuPgI1A/r75kiEswY5fvth6rmVmMoQbHnZK5apyQBYXLD44j
         FU1SjKqH8Jbj33sz+n6UBT31Sn0cpaPz4cMIYogApDVUHk4/llatD/Pf9ZYETcQJiNUe
         p7cah0Ewewa8IGV2vqL61Nci59RKC8yo19TOhKA9xZcMfcH8d36ZAYNCNJ7zQWGgCv3k
         2RSM280LaSkJ4yaxyLPIkaObxB/SRXGvP8rSKkoJuN8v9BBTpN1934hs38oavrE+qLL4
         LC9A==
X-Gm-Message-State: AD7BkJKQfpQQ77VR1NyLgsSByHjvYwByNGt6GXtefN1WGwZ4dlF7WuaFa6KOnahHpQWyq4IF
X-Received: by 10.98.31.79 with SMTP id f76mr2052700pff.92.1457516031314;
        Wed, 09 Mar 2016 01:33:51 -0800 (PST)
Received: from x230 (110-170-137-3.static.asianet.co.th. [110.170.137.3])
        by smtp.gmail.com with ESMTPSA id q72sm6989116pfa.70.2016.03.09.01.33.49
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 01:33:50 -0800 (PST)
X-Google-Original-From: Paul Sokolovsky <Paul.Sokolovsky@linaro.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288476>

Hello,

There's a nice git config directive url.insteadOf
(https://www.kernel.org/pub/software/scm/git/docs/git-config.html ,
search for "insteadOf"). However, than man doesn't make it explicit if
it can be used in server-side repository config, and all examples on
the net appear to be about its usage on user's local side.

So, is the remote use supported? Like a user issues a git clone with one
URL, but gets redirect to another URL and git client proceeds to clone
from it. Our usecase is to redirect git:// clones to http:// to
avoid some scalability issues.

If it's not supported, any chance it could be? Maybe it was discussed
and voted down? Or voted up and someone has it in their queue? Note
that the talk is about git-specific redirects, like redirecting one git
protocol to another.


Thanks,
Paul

Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
