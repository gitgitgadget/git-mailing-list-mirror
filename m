From: Blaisorblade <blaisorblade@yahoo.it>
Subject: git-unpack-objects < pack file in repository doesn't work!
Date: Tue, 7 Mar 2006 02:13:02 +0100
Message-ID: <200603070213.02805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 07 02:13:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGQlH-00050y-6f
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 02:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWCGBNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 20:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWCGBNL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 20:13:11 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:2405 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932537AbWCGBNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 20:13:10 -0500
Received: (qmail 44390 invoked from network); 7 Mar 2006 01:13:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cvtwPCD/H2Ts6FRP0lwkfCYgF774+eYViyr5YJ7vEO8JkulI0v99KkYlNyvTvtqCsus1/FyyPqIcEYizrHPPS/iCMRh4Ml75MZ6ggNMExFn+4ezxrt5S4qqh3KsCEEMovpubwL9nyzku6zGfyS3wIJQnnoxRztJqmsleDKfYOMA=  ;
Received: from unknown (HELO ?151.97.230.41?) (blaisorblade@151.97.230.41 with login)
  by smtp002.mail.ukl.yahoo.com with SMTP; 7 Mar 2006 01:13:08 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17313>

It's not a bug, it's an undocumented feature. It should be documented as 
"git-unpack-objects < $pack; rm $pack" is something one would deem correct at 
first glance (luckily I just moved the pack away and did git-fsck-cache).

To write an object, git-unpack-objects ends in

unpack-objects.c:write_object -> sha1_file.c:write_sha1_file:

        /* Normally if we have it in the pack then we do not bother writing
         * it out into .git/objects/??/?{38} file.
         */

This indeed works, so the files aren't unpacked.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
