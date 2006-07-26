From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 14:31:46 -0400
Message-ID: <9e4733910607261131q195defa7vbedd72cb0b938ba3@mail.gmail.com>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
	 <7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 20:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oAq-0007I1-Bi
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWGZSbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWGZSbt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 14:31:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:20369 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161025AbWGZSbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 14:31:48 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3300617ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 11:31:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ndfo88tm421kXq745a82VQrA5fa9IWqUv3FcSTkIdr+B8O3Mf/eeDRk7VimNuYejnx28ZaXwrh/ya9BA8l38BNqIqyf4RvdfUxyCki+hDUU4wQU+KmW9oT7ifeJKW2U5BGkbpA0HiVBK47n6GmG1CA3zs2zLu8FRbf7JHGgG5xY=
Received: by 10.78.156.6 with SMTP id d6mr3369454hue;
        Wed, 26 Jul 2006 11:31:46 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 11:31:46 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24232>

On 7/26/06, Junio C Hamano <junkio@cox.net> wrote:
> We should correctly handle cases that fit your general
> description (the test t/t4112-apply-renames.sh has a file in
> "klibc/arch/x86_64" which is renamed and copied to two different
> locations under "include/arch").  The above does not reproduce
> for me if I used "git diff HEAD >patch" in place of "cg diff" (I
> cannot make cg behave on my machine).

cg diff makes a patch this looks like this

diff --git a/gitweb/README b/zzz/gitweb/README
similarity index 100%
rename from gitweb/README
rename to zzz/gitweb/README
diff --git a/gitweb/gitweb.cgi b/zzz/gitweb/gitweb.cgi
similarity index 100%
rename from gitweb/gitweb.cgi
rename to zzz/gitweb/gitweb.cgi
diff --git a/gitweb/gitweb.css b/zzz/gitweb/gitweb.css
similarity index 100%
rename from gitweb/gitweb.css
rename to zzz/gitweb/gitweb.css
diff --git "a/gitweb/test/M\303\244rchen" "b/zzz/gitweb/test/M\303\244rchen"
similarity index 100%
rename from "gitweb/test/M\303\244rchen"
rename to "zzz/gitweb/test/M\303\244rchen"
diff --git a/gitweb/test/file with spaces b/zzz/gitweb/test/file with spaces
similarity index 100%
rename from gitweb/test/file with spaces
rename to zzz/gitweb/test/file with spaces
diff --git a/gitweb/test/file+plus+sign b/zzz/gitweb/test/file+plus+sign
similarity index 100%
rename from gitweb/test/file+plus+sign
rename to zzz/gitweb/test/file+plus+sign

git diff HEAD makes a much longer patch that deltas out the existing
files and delta in the new file.

It's applying patches in the extended git format that fails.

-- 
Jon Smirl
jonsmirl@gmail.com
