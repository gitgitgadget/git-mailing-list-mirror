From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Q: description of file name encoding approach used by git
Date: Wed, 11 Feb 2009 14:56:24 +0300
Message-ID: <85647ef50902110356l19870259t9de22fd8827ac144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 12:57:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXDj1-0000aT-OK
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbZBKL42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 06:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbZBKL42
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 06:56:28 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:57396 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZBKL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 06:56:27 -0500
Received: by fxm13 with SMTP id 13so391949fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 03:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=z2d4SC2oCAHL2d9fdIxCP5yxNiEjaQa4IGrsQv3mSr4=;
        b=Gv3UyB8NrVJX8cWfpl+d6H/OXNZUfKSE2w6Kt9vTs8rTcLNqnjS78GGbIgrwBA7EZL
         8egI7WIU06vDTNJO08kg9zYUrp5rjvwzr+Z0mZwe/IMdQmnVUAeHhfX2exgQ/K+7fZaO
         GC1oy4WWqXwq5gVKMjwXu9aXOzgOQIUZMLKqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mcZ1R4UabDcQYBCxcsy01GmNEZDHgekQ9Ej049bnF2kg7I+NeSw2efemKxvZAoHcHm
         sEzHu8aQYvY8XZpFYA4Fp015TNDMxhoNYqI4RfTzfPX43E/iOCjvQTMXuGX8DSFnodYC
         3iEK+/w2JhuuS3awOsNgOBJ/D+Gj76coJmFWg=
Received: by 10.181.146.11 with SMTP id y11mr1133873bkn.60.1234353384387; Wed, 
	11 Feb 2009 03:56:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109411>

I'm interested if there is some document that specifies the approach
of encoding non-ASCII file names used by the git and related issues.
I'm particularly interested in cross-platform issues, since I'm
writing plugin for cross-platform tool.

My understanding based on previous discussions of the issue is that
GIT saves file names as bytes in the tree objects without specifying
actual encoding used. And there will be problem if different clients
use different system encoding.

The list of issues known to me is:
1. All Linux and Unix machines that use the same git repository should
use the same encoding (ru_RU.KOI-8 and ru_RU.UTF-8 are not
compatible).
2. On windows UTF-8 codepage should be specified for msys git in order
to force it using UTF-8 if any cross-platform support is wanted. (I do
not known about cygwin git).
3. As I understand, there is an unresolved problem with Mac OSX HFS+
case insensitive file system due to file name normalization.
4. Git log seems to ignore encoding specified on the command line when
printing file names (for example in case of --name-status).

Are these issues still open?
Are there other issues?

Regards,
Constantine
