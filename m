From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Tue, 03 Jul 2007 11:19:49 +1200
Message-ID: <46898815.6030607@vilain.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org> <20070702221639.GB20597@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:20:01 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5VBZ-00017Z-EP
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbXGBXT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756753AbXGBXT6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:19:58 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52351 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613AbXGBXT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:19:58 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0B21A13A4EA; Tue,  3 Jul 2007 11:19:55 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5912D13A3E1;
	Tue,  3 Jul 2007 11:19:51 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <20070702221639.GB20597@thunk.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51428>

Theodore Tso wrote:
> OK, so I've hacked together the following emacs-lisp snippet, which I
> propose would go in contrib/use-ediff-instead.el.  If placed in your
> .emacs.el file, it will cause you to use ediff instead of emerge when
> you call "git mergetool".  It does so by replacing the two functions
> emerge-files-command and emerge-files-with-ancestor-comand with ones
> that patch the necessary ediff hooks, and then calling the ediff
> package instead of the emerge package.
> 
> With this .el file, no changes are needed to git-mergetool.sh.  Does
> this meet your needs?
> 
> 					- Ted
> 
> ;; use-ediff-instead.el
 [...]

Thanks for that, it mostly works, however it doesn't seem to notice if I
abort without making the merge complete (on emacs21).  In my smartmerge
script (http://utsl.gen.nz/scripts/smartmerge) I detect this condition
based on the presence of merge markers, possibly dubious but pragmatic.

I still don't really understand why having to save the merged buffer and
exit is such a huge issue.  Already I have to select "-t emerge" to get
emerge.  I would have thought it would be better to just make the other
mode available, and let the user figure it out.

Sam.
