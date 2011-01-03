From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2 0/3] fast-import: add 'ls' command
Date: Mon, 3 Jan 2011 02:01:30 -0600
Message-ID: <20110103080130.GA8842@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 09:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZfMU-0004Cg-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 09:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab1ACIBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 03:01:44 -0500
Received: from mail-gw0-f66.google.com ([74.125.83.66]:60076 "EHLO
	mail-gw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1ACIBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 03:01:43 -0500
Received: by gwj18 with SMTP id 18so3200367gwj.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B7naAZxmOTFbUR77wMEi04PmzyBV6hjB6S7+8TE2U70=;
        b=HdeJwM217q4YQ7hud9zbzXNDKF2TH12LzRAjwO1miWCaOYpMZ8OY5Jhq+DuYqbgZKe
         +SW/Hzfg8nVpU7vYh0Z/QfslQOogDuxeU7i6ffhMwTg5G+xZHLmoHqwIT8mnVXUEbWDN
         Pw18edawI34Xd8ZZu3EH8rGqcit26i7i9RrAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fgw/0fiG91fGzzZUb+pvZ1N/aO1tw97fluUWMJZEGGMxEsoVkrVbmUSK0OHh6GwtDC
         jV2Mne1LydwWTBBmTYHBZXyityrOQwKN+5Mtigyk4PksKmvsQRqAsK68+UgVRbrlLkhc
         hYKO4Kdr8AiZVxmv5HXp7PJVbKjxTFPRIoCwk=
Received: by 10.90.69.13 with SMTP id r13mr12437889aga.65.1294041703032;
        Mon, 03 Jan 2011 00:01:43 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id 3sm12116632yhl.0.2011.01.03.00.01.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 00:01:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164445>

David Barr wrote:

> This patch is by no means complete - I still need to consider the edge cases.
> It does achieve the basic requirements for simplifying svn-fe.

It really does do that.  About time for a reroll.

Patches 1 and 2 are nearby fixes noticed while hacking at this.
Changes in patch 3 from v1 will be mentioned in the same message as
the patch.

Thoughts, improvements, especially tests welcome.  Let's get this
feature ready for wide use.

David Barr (1):
  fast-import: add 'ls' command

Jonathan Nieder (2):
  fast-import: clarify handling of cat-blob feature
  fast-import: treat filemodify with empty tree as delete

 Documentation/git-fast-import.txt |   49 ++++++++++-
 fast-import.c                     |  181 +++++++++++++++++++++++++++++++++++--
 t/t9300-fast-import.sh            |  158 ++++++++++++++++++++++++++++++--
 3 files changed, 371 insertions(+), 17 deletions(-)

-- 
1.7.4.rc0
