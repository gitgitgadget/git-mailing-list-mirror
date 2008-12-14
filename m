From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] The description of pickaxe in git-blame(1) is wrong
Date: Sun, 14 Dec 2008 22:33:48 +0100
Message-ID: <200812142233.49669.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 22:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBycJ-00029P-NG
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 22:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYLNVdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 16:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbYLNVdy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 16:33:54 -0500
Received: from ik-out-1112.google.com ([66.249.90.180]:31560 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbYLNVdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 16:33:53 -0500
Received: by ik-out-1112.google.com with SMTP id c29so557152ika.5
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=nG73SVFSqKUcWUDI45a3HCibpZkgn4WhOaMi2h4oRgA=;
        b=UA/Ll1U0EcGA5IxQ5HGeWcCNBFTGBnvcKOhbBGHTX0WnMRFrKckBJGvK+afSLenntO
         Btq8pGUy7zG2vdAN7KNie3PpUOglZteACH6EIPlPkQ5fX50e5mr74qjCBQjaGJrreZK0
         uvG4YvB+kwCQiC+L0EQBEGXBol2IhdkOwSWdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=lmxx6oHp9xXhuw0XA/oegVpJoFWCwd6Es53/f4bNSx2dtbLs9sccEOzuiX8HamdhxX
         N1+p3UJ2KsR9COAvDBaf1x5al2Xqid7iqi8vslOXaYY3mZ3hiVY2yf749ANnlx870owJ
         +Z94DjUdHgOGNJ3iy9XDMTy+W1w9ZyC4IuNQQ=
Received: by 10.210.78.16 with SMTP id a16mr6916581ebb.122.1229290430935;
        Sun, 14 Dec 2008 13:33:50 -0800 (PST)
Received: from ?192.168.1.11? (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 7sm827564eyb.11.2008.12.14.13.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 13:33:50 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103099>

I think that the description of how 'pickaxe' feature works in
Documentation/git-blame.txt is wrong. It says:

  Apart from supporting file annotation, git also supports searching the
  development history for when a code snippet occurred in a change. This makes it
  possible to track when a code snippet was added to a file, moved or copied
  between files, and eventually deleted or replaced. _It works by searching for
  a text string in the diff_. A small example:

The part "It works by searching for a text string in the diff" is,
if I remember correctly, wrong. Actually it (I think) compares how
many matches are in pre-image and in post-image, and shows these
commits where those number differ.

This for example means that pickaxe would not pick commit which
moved a fragment from one place to other without change, I think.

-- 
Jakub Narebski
Poland
