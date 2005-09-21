From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: StGIT cannot import properly from stdin
Date: Wed, 21 Sep 2005 09:12:07 +0200
Message-ID: <433107C7.60901@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 21 09:13:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHymD-0004kL-9a
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 09:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVIUHMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 03:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVIUHMK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 03:12:10 -0400
Received: from [85.8.12.41] ([85.8.12.41]:54658 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751078AbVIUHMJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 03:12:09 -0400
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Wed, 21 Sep 2005 09:12:08 +0200
  id 00062716.433107C8.00004E59
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9027>

The import command of stgit does not handle stdin in a very sane way.
The logic expects to be able to read the patch several times which isn't
possible with stdin. So for it to work you have to give it the patch twice.

A simple solution would be to store it to disk and then handle it the
same way as if a file had been given on the command line.

Rgds
Pierre
