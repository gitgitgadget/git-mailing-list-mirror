From: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@gmail.com>
Subject: A bug in gitview
Date: Sat, 7 Nov 2009 21:50:55 +0100
Message-ID: <20091107205055.GA2551@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 21:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6sGB-0001ob-Vr
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZKGUvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZKGUvh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:51:37 -0500
Received: from tur.go2.pl ([193.17.41.50]:54167 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbZKGUvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 15:51:36 -0500
Received: from mailout1.go2.pl (mailout1.go2.pl [193.17.41.11])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 6349F23042E
	for <git@vger.kernel.org>; Sat,  7 Nov 2009 21:51:41 +0100 (CET)
Received: from mailout1.go2.pl (unknown [10.0.0.105])
	by mailout1.go2.pl (Postfix) with ESMTP id B4C065F001E
	for <git@vger.kernel.org>; Sat,  7 Nov 2009 21:50:59 +0100 (CET)
Received: from unknown (unknown [10.0.0.142])
	by mailout1.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Sat,  7 Nov 2009 21:50:59 +0100 (CET)
Received: from host-81-190-251-27.elk.mm.pl [81.190.251.27]
	by poczta.o2.pl with ESMTP id EAQItt;
	Sat, 07 Nov 2009 21:50:59 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-O2-Trust: 2, 69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132378>

When I modified a html file, that was not utf-8
encoded and commited the changes, if I select
that particular commit in gitview, the content
isn't shown, an error is printed instead:

Traceback (most recent call last):
  File "/usr/bin/gitview", line 1002, in _treeview_cursor_cb
    self.message_buffer.set_text(unicode(message, self.encoding).encode('utf-8'))
UnicodeDecodeError: 'utf8' codec can't decode byte 0xa4 in position 4723: 
unexpected code byte:

That's of course correct, it's not utf8.
'git diff' simply shows that as hex values,
there's probably a way to do the same for
gitview.
