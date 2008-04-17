From: skillzero@gmail.com
Subject: Best way to re-do a CVS repository with git?
Date: Wed, 16 Apr 2008 19:37:38 -0700
Message-ID: <2729632a0804161937w168aba8ahee742e182e50b4e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 04:38:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmK13-0006Kh-2Z
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 04:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYDQChj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYDQChj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 22:37:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:17001 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYDQChi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 22:37:38 -0400
Received: by wa-out-1112.google.com with SMTP id m16so4355096waf.23
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=850lIyq5vH3QpYo10sgXStwUWir7G1mJ+RU+l4bkB80=;
        b=GRNT9KYBr5Dk1+X6yvR/dxul25mkzo95QaRiFeoxEt2kImTLsHZWzOvVodQCfWJDvZo23jwlzhBKdgBgOYoeLY7R7hdO7eAm0FEJTLX7b1lbzxEmGRjbwE82QGczVl1d/n0wdoZfvi578VVBBv7otsTRZYulJyMOLv5UTAHfmzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iK2Ikyw4BJyFf01pI/edGLVGxeJXYxMb+cKVkD03vvkAOLnBVpwjMzVrGL7KrM187uAZ660MBUaKBIjGJ82AheHDuDAi95J8w6zfHHeTZPRpdh40pIrCPRenrRW9d5VlHc+2sC5Cv7m3t9XiB8FeyZ+D9EFZ5YPiAKP1vKBxZdo=
Received: by 10.114.197.1 with SMTP id u1mr780304waf.229.1208399858081;
        Wed, 16 Apr 2008 19:37:38 -0700 (PDT)
Received: by 10.114.193.9 with HTTP; Wed, 16 Apr 2008 19:37:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79765>

I have a large CVS repository (1.5 GB without its history) that I'd
like to convert to git, but I'm not sure about the right way to set it
up. If I need to change the way I'm thinking about source code
management, that's fine too, but here's what I have today in a single
CVS repository:

MyProject
   Apps                 # Only apps people use this.
   Common               # Everyone uses this.
   Firmware             # Only firmware people use this.
   External/ProjectA    # Only app people use this.
   External/ProjectB    # Everyone uses this.
   External/ProjectC    # Only firmware people use this. This is 1 GB
of code by itself.

I manage this today with CVS modules, one for apps people and one for
firmware people (and another CVS module with everything for people
like me that work on both).

I initially thought I'd create separate git repositories for each
piece, but I'm not sure how that would work when it comes to tagging
an entire release (i.e. a tag that spans multiple repositories). Or
how it would handle a git repository within a directory managed by
another git repository.

What's the best way to set up something like this with git?
