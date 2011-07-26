From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: "git check-attr" lists macros as being "set" -- feature or bug?
Date: Tue, 26 Jul 2011 14:10:11 +0200
Message-ID: <4E2EAEA3.8000307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 14:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlgSu-0006Rm-2O
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 14:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab1GZMKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 08:10:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44357 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab1GZMKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 08:10:18 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6QCACsQ011032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Jul 2011 14:10:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177861>

I am doing some work on git-check-attr, and I noticed something funny:
If a macro is used to set or clear attributes on a file in
.gitattributes, then the name of the macro itself is listed as an
attribute on that file.  Example:

$ git init
Initialized empty Git repository in /tmp/foo/.git/
$ echo '[attr]notest !test' > .gitattributes
$ echo 'no notest' >> .gitattributes

# This is expected:
$ git check-attr test -- no
no: test: unspecified

# This I found surprising:
$ git check-attr notest -- no
no: notest: set

I don't see the correct behavior documented anywhere.  If this is
considered a bug, then I offer to fix it.  If it is considered a
feature, then I offer to document it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
