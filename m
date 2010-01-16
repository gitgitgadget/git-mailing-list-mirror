From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 09:08:33 +0100
Message-ID: <201001160908.33996.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <201001152349.06418.j6t@kdbg.org> <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 09:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW3iy-0001JF-1m
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 09:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab0APIJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 03:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968Ab0APIJc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 03:09:32 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:57876 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751004Ab0APIJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 03:09:32 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1812BA7EBD;
	Sat, 16 Jan 2010 09:09:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0F8F919F5EC;
	Sat, 16 Jan 2010 09:08:34 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137208>

On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> The problem with that is differentiating between pipes and sockets.
> GetFileType() returns FILE_TYPE_PIPE for sockets (ugh). I did find
> some code in gnulib that used WSAEnumNetworkEvents() to differentiate
> between them, but I find this quite hacky.

Wouldn't it be possible to call getsockopt(), and if it returns ENOTSOCK 
(WSAENOTSOCK), then it is a pipe?

-- Hannes
