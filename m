From: Luben Tuikov <ltuikov@yahoo.com>
Subject: gitweb: using quotemeta
Date: Thu, 28 Sep 2006 14:15:59 -0700 (PDT)
Message-ID: <20060928211600.97412.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 28 23:16:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT3Ej-0005XI-AC
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 23:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWI1VQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWI1VQB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 17:16:01 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:47697 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750855AbWI1VQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 17:16:00 -0400
Received: (qmail 97415 invoked by uid 60001); 28 Sep 2006 21:16:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v6Gfdowv5zLHXMzUl4e0yCsH1w8zbYo4BBZLfVCa7hhz+yNAswgucd47NiYGZSNFzaAlDhiPEPp+2J1+LLAC6VTntPgApecST2pzO1S5lf8pX55Bh8ktX729LYgAgzNkuTYyWlrmisijinybap+o70afThE+CWqo4GQiP2izsuU=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 14:15:59 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28050>

Commit ab41dfbfd4f3f9fedac71550027e9813b11abe3d introduces
the use of quotemeta to quote the $filename of the snapshot.
The commit message explains:

    Just in case filename contains end of line character.

But quotemeta quotes any characters not matching /A-Za-z_0-9/.
Which means that we get strings like this:
    
    linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz

Is this the desired behavior?  FWIW, the backslash character
is not part of of the name, but ended up when the snapshot was written
to the filesystem.

Thanks,
   Luben
