From: Bron Gondwana <brong@fastmail.fm>
Subject: Why /var/cache/git?
Date: Mon, 25 Oct 2010 21:30:06 +1100
Organization: brong.net
Message-ID: <20101025103006.GA18782@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pape@smarden.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 12:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAKJn-0003hH-GP
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 12:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab0JYKaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 06:30:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58264 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361Ab0JYKaK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 06:30:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B8310301;
	Mon, 25 Oct 2010 06:30:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 25 Oct 2010 06:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=smtpout; bh=TxtUds+FvcICE+pns2O9g2dNJOc=; b=Ww+qu3iq9iblM97jGVgLGWiUTcgVW9SE7VbvqAYMkc/ZF4J/wzZjgNAgl3mf+nvdkfPKNkwABkTtlI5u62UTXRjhl9+9NCc6dOjMAbx+XBfLxWXJ9JYG10T3XUFDEFVaqnwmkeLNzTWveosRmWRIwb0M2vfGlegh7y8VKZPy4d8=
X-Sasl-enc: 9v3T5PqGV6/735zuKv+CEuV1kPLNDSpE3q0SACeSkuCn 1288002609
Received: from launde (124-168-121-62.dyn.iinet.net.au [124.168.121.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 455F8400EFA;
	Mon, 25 Oct 2010 06:30:09 -0400 (EDT)
Received: by launde (Postfix, from userid 1000)
	id 5D52B403AC; Mon, 25 Oct 2010 21:30:06 +1100 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159938>

(resent - correct address for git list!)

(Gerrit: you're CC'd as the attribution in README.Debian
 which in the one place I can see /var/cache/git mentioned
 in the docs - without a justification for why it was
 chosen...)

I'm setting up shared repositories on a machine, and I notice
all the examples I can find on the web, and also the 
auto-created directory from the packages are /var/cache/git/

So I looked at the FHS, because that seemed odd to me:

http://www.pathname.com/fhs/pub/fhs-2.3.html#VARCACHEAPPLICATIONCACHEDATA

    /var/cache is intended for cached data from applications.
    Such data is locally generated as a result of time-consuming
    I/O or calculation. The application must be able to regenerate
    or restore the data. Unlike /var/spool, the cached files can
    be deleted without data loss.

I guess in theory, someone else has all those commits in their
local git repository somewhere.  Still, it feels to me that
/var/lib/git is the correct location.  Is there any reason why
/var/spool/git was chosen?

(I'm running Debian Lenny with the 1.7.1 backport packages, but
I see examples from Fedora with the same paths as well)

Bron.
