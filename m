From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 10:15:51 +0200
Message-ID: <4AAA0737.1030005@gmx.ch>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Aloisio <aloisiojr@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 10:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm1IW-00074S-V4
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 10:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZIKIPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 04:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbZIKIPu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 04:15:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:59461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753471AbZIKIPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 04:15:49 -0400
Received: (qmail invoked by alias); 11 Sep 2009 08:15:51 -0000
Received: from adsl-89-217-188-115.adslplus.ch (EHLO [192.168.123.204]) [89.217.188.115]
  by mail.gmx.net (mp032) with SMTP; 11 Sep 2009 10:15:51 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19i+CpCwqViVNZTw7JWjjIzCu0EVvS3csrdv6h9KH
	9JtjBAxLcrSma2
User-Agent: Thunderbird 2.0.0.22 (X11/20090628)
In-Reply-To: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128183>

Hi list!

Aloisio wrote:
> this doesn't:
> git clone -n git://gitorious.org/qt/qt.git repo >log
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed

What are you trying to store in that file?  The only line I
observe being printed to stdout while cloning is this one:

    Initialized empty Git repository in [...]/repo/.git/

Everything else (progress status) is printed to stderr and I
presume that any error messages would also go to stderr too, if
any.  So possibly you would be happy with this:

    git clone -n git://gitorious.org/qt/qt.git repo 2> log

which works fine here with git-1.6.4.2.  Though I agree that I
would expect redirecting stdout to work.

Cheers,
jlh
