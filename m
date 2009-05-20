From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 11:15:31 +0200
Message-ID: <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
References: <4A136C40.6020808@workspacewhiz.com> <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 11:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6huM-0003XH-FT
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 11:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbZETJQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbZETJQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 05:16:09 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:45024 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbZETJQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 05:16:08 -0400
Received: from cuzco.lan (156.pool85-53-12.dynamic.orange.es [85.53.12.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n4K9FYNn026782
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 20 May 2009 05:15:36 -0400
In-Reply-To: <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119591>

El 20/5/2009, a las 5:35, Nicolas Pitre escribi=F3:

> Having a "trash" reflog would solve this unambiguously.  That could =20
> also
> include your index example above.  However, in the index case, I'd
> record a reflog entry only if you're about to discard a previously no=
n
> committed entry.  If you do:
>
> 	$ git add foo
> 	$ git add bar
> 	$ git commit
> 	$ hack hack hack
> 	$ git add foo
>
> then in this case there is nothing to be lost hence no additional =20
> entry
> in the "trash" reflog.

That's true in the example you provide, but it doesn't really handle =20
Jeff's initial example ("git add" twice on the same file), where it is =
=20
possible to throw away intermediate state (by overwriting).

I personally haven't been bitten by a mistaken use of "git reset" and =20
friends for a long time now, but I really like the ideas that have =20
been mentioned so far in this thread. This "trash" or "index" or =20
"reset" reflog would be a huge step forward in "idiot-proofing" Git.

Cheers,
Wincent
