From: "Ping Yin" <pkufranky@gmail.com>
Subject: [RFC] Configurable name(s) for .gitmodules
Date: Sat, 8 Dec 2007 00:00:12 +0800
Message-ID: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 17:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0fd0-0006Md-Rk
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbXLGQAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbXLGQAR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:00:17 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:50876 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXLGQAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 11:00:15 -0500
Received: by py-out-1112.google.com with SMTP id u77so1545844pyb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CF/VxAUtX4XZcOhJLsUtIj6+3oMKcXnUqsVzqLuMW2c=;
        b=MN1rHhzdlar4ScAGHZoCbdW0j8/WlMO9+oFWjOtGgPyI6uMwOT6tJpMoljnh69drsgX/mBpOQ05IeilNxaiVnr1wQe3bWempYueUhIJq4GLVE7/sU61mkTH+u7AckD2gFp733ZFWO1IgObLm+F8hrhS/0XDSB2GcnDR1cgFFu8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oK4O6O5zJrACPfobVlxjM6ixxMbrU1KskgNdOJP/VMotvY9EaIQ488PYzbEJaq4Q1IQm/ekp+AgnMuieNrVfup9U76e8xs8nwohBsHjrgkwxwrFGVxEoYENDJLj372Z5XwkRsibKJZf+8QLYcmGr5yn0b3jyY/fDNY/1AKquVok=
Received: by 10.35.21.9 with SMTP id y9mr3599213pyi.1197043212545;
        Fri, 07 Dec 2007 08:00:12 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Fri, 7 Dec 2007 08:00:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67430>

I have a super project with many submodules. Each kind of role may
check out different set of submodules. There are some common modules
which are almost checked out by every role.

Here comes my question: how to implement this elegantly? If all
submodules are put in the same .gitmodules, every role has to in the
command line manually designate all submodules to be checked out.
However, it's hard to remember which submodules is required by which
role, not to mention the so huge .gitmodules. Maybe a script for each
role can help, but it's a little ugly.

If the name for '.gitmodules' is configurable, we can check in
modules.roleA and modules.roleB, etc. Then role A can designate the
corresponding modules.roleA as .gitmodules. Furtherly, if mutiple
names are allowed,  for common modules, we can have modules.common and
then submodule.defaultnames="modules.common, modules.roleA"  to avoid
duplicated module name entires in both modules.roleA and
modules.roleB.

I have gone deeply into git-submodule.sh and see
"GIT_CONFIG=.gitmodules" is used. However, configuable multiple names
can't be implemented in this way.

Recap:
1. configurable name for '.gitmodules'
2. better to allow mutiple names
3. the implementation issue for mutiple names

-- 
Ping Yin
