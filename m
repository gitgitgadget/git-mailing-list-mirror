From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Refactor projects_list generation
Date: Tue, 10 Jun 2008 19:19:23 +0200
Message-ID: <200806101919.24242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 19:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67Z2-0003hF-4M
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480AbYFJRWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757473AbYFJRWO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:22:14 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:16808 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbYFJRWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:22:12 -0400
Received: by gv-out-0910.google.com with SMTP id e6so645892gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=8ZmeN2FtUNc7ztzFU4qkqu98uzinm+cu05SnsZsow9k=;
        b=WQgLu1t5vmwow7ajo22DsRs8GQN6Kkg9dSgVTd1PG2aHhIRz0+HYfiqQxTwKBFuC+y
         yZW2jNS0Qq4eJanw9AhRq6GMady8my30BBp7JQeQE4GE8oh9g7NHPUXfQtZl2xfnkZU7
         XbCKNlJEf6ZPskiISl5SRgUNY5UQi3TU+VipE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=xOR7VH7i9o/lxe04xSpsKuKII31GGZszUrK0+Y3ecEdmIQ9RRxbvWR3D8CjhIaH0fv
         nPtMFZoNGJi+jZ5hWtf19ptaeUcFeyOcRrDPmbejWX8DWgrZHPz24CMvtk7LdjiPYe+t
         LSzwTxALcf7TGjUztfnr19bmufi863bsdfBus=
Received: by 10.103.244.10 with SMTP id w10mr3516665mur.67.1213118518842;
        Tue, 10 Jun 2008 10:21:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id y2sm8498768mug.1.2008.06.10.10.21.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:21:57 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84527>

These two patches make code generating 'projects_list" view better.
This is resend of those patches, this time without following patches
which add new features like allowing 'description' field in
$projects_list file, searching for projects, and paginating projects
list page.

Those two patches should also make it easier for Lea to plug-in
caching in gitweb.  That's why I'm sending them even in the rc/freeze
period...

Shortlog:
=========
Jakub Narebski (2):
  gitweb: Separate filling list of projects info
  gitweb: Separate generating 'sort by' table header

Diffstat:
=========
 gitweb/gitweb.perl |  111 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 62 insertions(+), 49 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
