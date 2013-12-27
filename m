From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 17:36:55 +0400
Message-ID: <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 14:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXb4-0002se-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab3L0Ng7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:36:59 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41505 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab3L0Ng6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:36:58 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rBRDasHS015394;
	Fri, 27 Dec 2013 17:36:55 +0400
In-Reply-To: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239726>

On Fri, 27 Dec 2013 18:59:00 +0600
Sergey Sharybin <sergey.vfx@gmail.com> wrote:

> Quick question is, is it possible to use git:// protocol over
> SSL/TLS/other secure transport?

The Git protocol does not implement it itself but you can channel it
over a TLS tunnel (via stunnel for instance).  Unfortunately, this
means a specialized software and setup on both ends so if the question
was about a general client using stock Git then the answer is no, it's
impossible.

> Or the recommended way to do secure anonymous checkout is to simply
> use https:// ?

Yes, but it will only be secure if you've managed to verify the
server's certificate and do trust its issuer (or a CA higher up the
cert's trust chain) -- people tend to confuse "encrypted" with
"secure" which is not at all the same thing.
