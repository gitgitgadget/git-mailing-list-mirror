From: "Ian Brown" <ianbrn@gmail.com>
Subject: How to omit/alter the sigend-off line in a patch set?
Date: Mon, 16 Jun 2008 13:24:58 +0300
Message-ID: <d0383f90806160324j3f1b2a09tbb4caa1e934c7635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 12:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8BuQ-0001XC-B2
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 12:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYFPKZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 06:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbYFPKZD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 06:25:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:1673 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYFPKZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 06:25:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3218326fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=W70PeLyUE6fXbDMF87gv+ZuhPaCPnp2g+7FZN+JChck=;
        b=uHM7WpqPVyiF70rMfvKIE4Ikna8rXrkZ5bDbNWxJjjQYs47Hfm860e7ze3iaYhVWDI
         sr3Crq4anFo/gQO0+c64/DzJHpEM2oXbc5yqN7+ry8BvIZ8oZfhvobd1vIVLLTM8nqK4
         fSu2sybuC8tlfqeWqa+U3TY9CcsRUc3oWn6OU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ZSwUBq8D7QBba1S7s7joyPb7/tyOlTWoSBNez7Krq0EknYz6JQopE8QlXNzr/SlONe
         ZpDamXOq1aiQvO72o2UrXlH3n5hSFya6HuCHWghXEQGqxi/60t9v5GIXj90Fl3e7oqZa
         5E3XGtEB6ME/6Gn4gAy04kQI9TOaPxCNzmqoM=
Received: by 10.86.82.16 with SMTP id f16mr7752617fgb.9.1213611898021;
        Mon, 16 Jun 2008 03:24:58 -0700 (PDT)
Received: by 10.86.33.13 with HTTP; Mon, 16 Jun 2008 03:24:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85173>

Hello,

  I am creating a patch set in this way:
I make a change in one file, than commit it. (git commit file1)
Then I make a change in a second file, than commit it. (git commit file1)
and so on.

Then I create a patch set thus:

git-format-patch -M -s -n -o patchdir origin

And a number of patch files are created, according to the number of commits
I had made.


Now, in each created patch file there is a line saying:
Signed-off-by: root <root@hostName.(none)>


Which is caused as I am doing this patches as root, and the machine name is
hostName (and the domain name is none).

Now, is there a way to cause git-format-patch to omit this
Signed-off-by: root <root@hostName.(none)> line ?
Or, altetnatively, is there a way to cause the git-format-patch to
generate a differnet
signed off by line (like signed off by ianbrn@gmail.com)?

I had tried using the --signoff option for  git-format-patch , in
these two ways,
but got an error:

git-format-patch --signoff=ianbrn@gmail.com -M -n -o patchdir origin
fatal: unrecognized argument: --signoff=ianbrn@gmail.com

git-format-patch --signoff ianbrn@gmail.com -M -n -o patchdir origin
fatal: ambiguous argument 'ianbrn@gmail.com': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions

I also tried to use the -a flag for commit
git-commit -a ianbrn@gmail.com
but again it did not help either.

Any ideas?

Any help will be appreciated,


Regards,
Ian
