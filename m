From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 13:58:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com> <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com> <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr> <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Janusz Harkot <janusz.harkot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 13:58:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujpsb-000352-NT
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 13:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab3FDL6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 07:58:18 -0400
Received: from giant.haxx.se ([80.67.6.50]:44560 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278Ab3FDL6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 07:58:16 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r54Bw7NV015029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jun 2013 13:58:07 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r54Bw7Vi015025;
	Tue, 4 Jun 2013 13:58:07 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226342>

On Tue, 4 Jun 2013, Janusz Harkot wrote:

>> Which libcurl version and SSL backend is this? (curl -V usually tells)
> $ curl -V
> curl 7.24.0 (x86_64-apple-darwin12.0) libcurl/7.24.0 OpenSSL/0.9.8r 
> zlib/1.2.5

>From what I can tell, that OpenSSL version supports SNI fine and libcurl has 
supported it since 7.18.1.

> here is a log (with GIT_CURL_VERBOSE=1)
>
> https://gist.github.com/anonymous/8f6533a755ae5c710c75
>
> Initial connection is correct (line 10 - shows that it reads correct 
> certificate), but then subsequent call to the server (line 68) shows that 
> the defat server certificate is used.
>
> It looks like the second call was without hostname (?).

What makes you suggest that's what's happening? Sure, if it would've sent no 
or the wrong host name it would probably have that effect.

Any chance you can snoop on the network and the SSL handshake to see who's to 
blame? I can't but to think that is is a very common use case!

-- 

  / daniel.haxx.se
