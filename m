From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Blaming diffs
Date: Mon, 17 Sep 2007 06:59:15 +0200
Message-ID: <200709170659.15655.chriscool@tuxfamily.org>
References: <20070916163829.GA6679@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX8an-0007PU-6T
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 06:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbXIQEwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 00:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXIQEwK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 00:52:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:47477 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbXIQEwJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 00:52:09 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 314B51AB2B9;
	Mon, 17 Sep 2007 06:52:08 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1B2741AB2C3;
	Mon, 17 Sep 2007 06:52:08 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070916163829.GA6679@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58386>

Le dimanche 16 septembre 2007, Mike Hommey a =E9crit :
> Hi,
>
> It seems to me there is no tool to "blame diffs", i.e. something to k=
now
> what commit(s) is(are) responsible for a set of changes.

I don't know if that's what you are looking for but perhaps you could=20
use "git bisect run". You just need to pass it a script that returns 1 =
when=20
it finds the changes and 0 otherwise. (See git-bisect man page.)

Sometimes ago I sent a patch that would allow "!" after "git bisect run=
",=20
but it seems to have been forgotten. This patch makes it possible to us=
e:

git bisect run ! grep some_stuff file1 file2...

This would give you the commit where some_stuff was introduced in file1=
 or=20
file2...

Regards,
Christian.
