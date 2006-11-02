X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git and "dumb protocols"
Date: Thu, 2 Nov 2006 11:48:48 +0100
Message-ID: <20061102104848.GH20017@pasky.or.cz>
References: <vpqu01i16g8.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 10:49:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <vpqu01i16g8.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30711>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfa7x-00077p-MJ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752551AbWKBKsv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbWKBKsu
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:48:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:8622 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752551AbWKBKst (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:48:49 -0500
Received: (qmail 3627 invoked by uid 2001); 2 Nov 2006 11:48:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

  Hi,

Dear diary, on Thu, Nov 02, 2006 at 11:36:07AM CET, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> Is it possible with git to push to a server on which git is not
> installed, and if so, how?

  yes, you can push using HTTP DAV - just push to an HTTP URL; make sure
you have git-http-push compiled, it is sometimes not compiled because it
unfortunately adds dependencies on couple of more libraries.

  Beware that this is inherently not safe for anonymous push access,
since malicious client with write access can destroy the repository. You
will want to protect write access to the repository by .htaccess file.

  I think a patch that would add support for pushing over sftp or some
other dumb protocol would be welcome. One problem is with proper locking
of ref updates (not sure how well would sftp cope with that), another is
that you will need to do git-update-server-info's job on the server
side.

  If you already have SSH access to the server, why not compile Git
there and install it to your $HOME, though?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
