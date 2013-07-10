From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Error
Date: Wed, 10 Jul 2013 19:15:59 +0400
Message-ID: <20130710191559.a0236010ffccbdd526d4d69c@domain007.com>
References: <632ECB1A-63EA-4334-8716-53A1F45B6E0B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chanakya Vattikuti <gk2cveragon1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 17:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uww7n-0000bZ-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 17:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab3GJPQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 11:16:06 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:59876 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab3GJPQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 11:16:05 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6AFFxv6001049;
	Wed, 10 Jul 2013 19:16:00 +0400
In-Reply-To: <632ECB1A-63EA-4334-8716-53A1F45B6E0B@gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230057>

On Tue, 9 Jul 2013 20:30:37 -0500
Chanakya Vattikuti <gk2cveragon1@gmail.com> wrote:

> I get this error message when trying to create a shared ssh key in
> Mac osx Lion

This problem has nothing to do with Git as it purely is about
transferring a public part of your SSH key to another host.
So try asking on the OS support channels.

> scp .ssh/id_rsa.pub cvattiku@cook.cs.uno.edu:~/
> ssh_exchange_identification: Connection closed by remote host
> lost connection

Since the public part of your key is not transferred to that remote host
yet, and it is not registered as a trusted key there, you have to use
an SSH authentication method other than "publickey".  Or, if you have
another SSH key which is registered as trusted on the remote host, you
might try to use it explicitly using the "-i <private_key_file_>"
command-line option to `scp`.

If this fails or not applicable, at least try to run `scp` with
multiple "-v" command-line options (like `scp -vvvv ...`) to get
extensive details about authentication protocols it tried with the
server and which of them were agreed upon by both sides and tried.

It might turn out that the server only accepts publickey authentication
mechanism, and so you are not able to upload and register your public
key yourself (chicken and egg problem).  In that case, contact the
server's system administrator for assistance.

If the server has certain "Git hosting" solution like Gitlab, you might
need to try registering your key using some other means like logging to
your Git account via some web interface and pasting the key there --
just like you'd do this on github.

If studying that information won't help you, provide it when you will
be asking this question on the Mac OS support channels.
