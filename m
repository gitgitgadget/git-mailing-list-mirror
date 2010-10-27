From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG?] t9500 --debug prints "sh: ++GIT_BINDIR++/git: not found"
Date: Wed, 27 Oct 2010 15:49:54 -0500
Message-ID: <20101027204954.GA31386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 22:50:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBCwj-0000o3-PX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999Ab0J0UuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 16:50:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46365 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab0J0UuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 16:50:03 -0400
Received: by iwn10 with SMTP id 10so1337413iwn.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=3mvwMEcSwgOa8hMXg6ttWL3pRkhIYMrIO0TR8H/H5+0=;
        b=IVTEaSXe9hSRYuWJSZFH0UlkImEkRqjWlKQz6ZA9FcOaC+I5Fb49RybCoz5hu/zG/E
         8EUAvLr/NA2Aqj2Jmr8bBRE4pE2NcB7j6/8j5Pkp3uf+XuWItaz6JS59vQGyeZvcUa0o
         3Gu27d1GvmXAiD7sleW1UtYwid+R8ick7GnUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=DtXr0pxtkeCckA0v1gsAQdC+9KS4vtjat8gYMpXUwW96Z3cWzhyGX7fRXYiTUc78cU
         Kwya+yGQhZlbQ9ejy7BDTOa4a64OeyXCAS3NY6N820VM5Effv/7m2Jo5lCbUxCRk/7H+
         TxnlFy74A6A9RThYLwlmkkY/nf+pxi5vvn/Fg=
Received: by 10.231.37.6 with SMTP id v6mr7133082ibd.147.1288212602595;
        Wed, 27 Oct 2010 13:50:02 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id gy41sm423906ibb.5.2010.10.27.13.50.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 13:50:01 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160123>

Hi,

Trying to run t9500-gitweb-standalone-no-errors.sh, I find:

 $ sh t9500-gitweb-standalone-no-errors.sh --debug
 ok 1 - no commits: projects_list (implicit)
 sh: ++GIT_BINDIR++/git: not found
 ok 2 - no commits: projects_index
 sh: ++GIT_BINDIR++/git: not found
 ok 3 - no commits: .git summary (implicit)
 [...]

config.mak reads:

 CFLAGS = -g -O2 -Wall -Wdeclaration-after-statement
 NO_OPENSSL=1
 NO_EXPAT=1
 COMPUTE_HEADER_DEPENDENCIES=1
 USE_NSEC=1
 ASCIIDOC8=1
 ASCIIDOC_NO_ROFF=1

and there is no config.mak.autogen or other source of build flags.

Ideas?  Is this expected behavior?
