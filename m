From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [BUG] git-svn returning "Incomplete data: Delta source ended 
	unexpectedly"
Date: Wed, 14 Jul 2010 13:05:29 +0000
Message-ID: <AANLkTiljzOuaEToKscBxlc4qGilyNRiUtjoBxW1lJZlp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 15:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ1ei-0003vA-Hg
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 15:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0GNNFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 09:05:38 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40433 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0GNNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 09:05:37 -0400
Received: by gwj18 with SMTP id 18so3321522gwj.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=5YdiskyaSCdk+QMpyWzK+tNS+ZERTG22lyOgnGZEvLE=;
        b=DB0nIzWvMZDk1gUufmHKaPPGJ+PCOOGwYC0C6IGUlGys/UonGOK1a8ubl2CApXHBz9
         TEDVbNaCwGUIciYHIXTdZ+LOzSB/aoWTw8ZnV8oJg+zp/eG4aUTLq+YwoXftKLkb5/6p
         fzizN80vmH1iM4G1BFfoZWBqrC3hFkYp/XUxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KQHMcKOiHByflES3gkd+YcAbbIznc7mS54rnXb7IqlAQQoCHnUHtHDXm7osHun8HdU
         yTve5Xhqyi443X5elNHg0G0chivypQfqAmKRsYvie/PNSpp5RgN7CLhzDPehAGE88fad
         sigKZFzZKqD3JuU9qndFolgf1ExfYOnUrb920=
Received: by 10.101.201.37 with SMTP id d37mr18510360anq.62.1279112729364; 
	Wed, 14 Jul 2010 06:05:29 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 06:05:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150987>

I run a SVN -> Git mirror which fetches & rebases with git-svn and
pushes the result to GitHub:

    http://github.com/avar/openstreetmap-mirror/blob/master/josm-mirror.sh

Something about what that script is doing corrupted the git-svn
repository, likely due to a git-svn bug. Now when I do git svn fetch
on 1.7.1:

    $ git svn fetch
    Incomplete data: Delta source ended unexpectedly at
/usr/lib/git-core/git-svn line 5061

I re-cloned the repository and started running my mirror again from
that. But it would be nice if we could track this bug down.

Here's a copy of the repository:

    http://v.nix.is/~avar/josm.old.tar.gz

Unpacking it and running git svn fetch will yield the same error on
another box I have with 1.7.1.
