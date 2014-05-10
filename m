From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 19:09:37 +0530
Message-ID: <536E2C19.3000202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: milki <milki@rescomp.berkeley.edu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 10 15:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj7VD-00024X-3G
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 15:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbaEJNjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 09:39:43 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43226 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaEJNjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 09:39:42 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so1438390pad.11
        for <git@vger.kernel.org>; Sat, 10 May 2014 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=L22Fbbk/tSGQBOrxMOoe566a9kjkxnfq/nofhcTEb88=;
        b=dNKpbroztXiGf0rAiJhHlgGmHogUSpD2cvpF6nOu4kviBsw++mzBekn2P6ivfLFRV5
         WDNcy3obxWAgh3v4z3vXD7hjH/IVf2sujAIvaMbXTLlYoIqL9tul8T4BAbbkylHd11Ze
         HoLs1Oa0i4XxHGo5CA3k7pyDOQvokR6S0ImMuglTTKFzcMu/USYxKWiCzlPev4vAVJbG
         MXjEP7tvVq62r8m7y1ku6yFPoHzGFcuHD13Fqje5qqvSHenabny99ZUYfra1hBCWJOP7
         fone8Y/+2u2030nQFHa+hU1+cfSqhF6J8RnZOXJ6odI44XT1q1gpflr+WirwIkP+cs0Y
         GJUw==
X-Received: by 10.67.23.135 with SMTP id ia7mr32595740pad.5.1399729182462;
        Sat, 10 May 2014 06:39:42 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.221.195.4])
        by mx.google.com with ESMTPSA id sm8sm12912346pbc.92.2014.05.10.06.39.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 May 2014 06:39:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248657>

Hi,

Is there a trick to optimising a push by telling the receiver to pick up
missing objects from some other repo on its own server, to cut down even
more on network traffic?

So, hypothetically,

     git push user@host:repo1 --look-for-objects-in=repo2

I'm aware of the alternates mechanism, but that makes the dependency on
the other repo sort-of permanent.  I'm looking for a temporary
dependence, just for the duration of the push.  Naturally, the objects
should be brought into the target repo for that to happen, except that
this would be doing more from disk and less from the network.

My gut says this isn't possible, and I've searched enough to almost be
sure, but before I give up, I wanted to ask.

thanks
sitaram

Milki: I'm sure you won't mind the cc, since you know the context :-)
