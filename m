From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Commit 140b378d07229e breaks gitk highlighting
Date: Tue, 9 Sep 2008 08:31:19 -0400
Message-ID: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 14:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd2OU-0005a0-4J
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 14:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbYIIMbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 08:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbYIIMbW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 08:31:22 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52988 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYIIMbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 08:31:21 -0400
Received: by gxk9 with SMTP id 9so10189748gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MZFN6QhbgswBHipIRhQwiaIioxpJu0kHcwefJOk2TXA=;
        b=OSjDL5iLgjqrE7cFGNmYL6zHW6tTFuH83oyaDK6JheOCZWEfamA+J6a/a3FrAhF5WB
         2jrEgT3ExeHIKm+Z+dwoYychQKEn0VUfi2N+E7II7s6/J5d4xlv6O9w02gd7V3QRa2Zs
         299ap/yc9UKVVGgZpjO2ktzY8l/siJlW+wW4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=EYgd62/hsEe+JF5ERcxzfb7JVk5DGouR1nZ15fODBtiLcCa7cmp5xM/vp+IT3k0TtR
         xepxK8FUuX6L1yg3L0Msath6fADIkcYffAxGDVgDApj5KBo0/p9rem5Lveu9HhN0teEZ
         QoPE7F+AaV/hG5aAOQtivKAG2bR5BBOERcqxc=
Received: by 10.187.195.7 with SMTP id x7mr3061885fap.46.1220963479107;
        Tue, 09 Sep 2008 05:31:19 -0700 (PDT)
Received: by 10.187.158.14 with HTTP; Tue, 9 Sep 2008 05:31:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95377>

gitk since the above commit ("Teach git diff-tree --stdin to diff
trees") fails to reliably highlight commits matching a given path
specification. For an example of the problem,

   $gitk ec3a4ba519c001

   and select commit "touching paths" with "t" in the entry bar

The 4'th commit down (t9124: clean up chdir usage) is NOT highlighted,
though it clearly touches t. Reverting commit 140b378 restores the
correct behavior. This gets into parts of the code I don't understand,
so I decline to try to offer a patch.

Mark
