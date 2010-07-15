From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] gitmodules.5: url can be a relative path
Date: Thu, 15 Jul 2010 02:41:55 -0500
Message-ID: <20100715074155.GA22244@burratino>
References: <4C3DD7EF.6010805@panasas.com>
 <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jul 15 09:43:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZJ6Z-0001DX-JY
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586Ab0GOHmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:42:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53896 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577Ab0GOHmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:42:46 -0400
Received: by iwn7 with SMTP id 7so706848iwn.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=m4P7QavzJVrb3MPRX7RKUt2ika2vzEQpA2TJukHjIMs=;
        b=mXFbDc12SGTxW4Xvi0P1oXurGHEgxMO724vuY8tISMzDyA/4zfy/ZfH+x8LgRxARJ1
         PWq6TX6GveQFQukCyJGE/gMuGah6vnVmwtmDQrVJfJr9FwlOLfh1N1aHDC1Ghl8kTtda
         /adQl0V2POpkgxAH/jURMPzVc4w8YDwnO+bNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=s65ajO5ImBACvIil3C2txLnzL2+XZdwYdHB0LBpVxPFgOVrKc3afknUm6/wfQPJPP2
         mGwlYvcj+dSAPfTZ2KLmIXGXS6weSvBXNBi9/RPbo7dhFwa5bLH1KS2Bj9rOaGqx6hOg
         KxxH6F8nshAuqKLfhZDfGWsy2rRunsP+J7BdA=
Received: by 10.42.1.16 with SMTP id 16mr5995671ice.97.1279179765605;
        Thu, 15 Jul 2010 00:42:45 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm3311728ibi.0.2010.07.15.00.42.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:42:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151060>

There is already excellent documentation for this facility in
git-submodule.1, but it is not so discoverable.

Relative paths in .gitmodules can be useful for serving the
same repository over multiple protocols, for example.
Thanks to Peter for pointing this out.

Cc: Peter Krefting <peter@softwolves.pp.se>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitmodules.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 5daf750..72a13d1 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -29,6 +29,9 @@ submodule.<name>.path::
 
 submodule.<name>.url::
 	Defines an url from where the submodule repository can be cloned.
+	This may be either an absolute URL ready to be passed to
+	linkgit:git-clone[1] or (if it begins with ./ or ../) a location
+	relative to the superproject's origin repository.
 
 submodule.<name>.update::
 	Defines what to do when the submodule is updated by the superproject.
-- 
1.7.2.rc2
