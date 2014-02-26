From: Lee Hopkins <leerhop@gmail.com>
Subject: Branch Name Case Sensitivity
Date: Wed, 26 Feb 2014 16:06:54 -0500
Message-ID: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 22:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlgy-0004nP-0q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 22:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbaBZVG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 16:06:56 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:50892 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaBZVGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 16:06:55 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so1036937qac.13
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=h7zgjF/R1XltEII8DL9nWpvJThWXm/0tDtInNopbeQc=;
        b=bT/rX9B9nthLi6inPWxEPOP6GM+xgzFsoW+jc6xP9d1xZf9EULsko4OeRvJlJWfaqZ
         h+tsyPf8Y27x+hUtauFn47kn6mPZIGi7nJJNk6JApiFs0krSfmHLFhsAxQfaZgVsdYcq
         jekzIB9ayZqSVfNrI4DH3+FW1ggPFUF5VFEorYX9+6fzDN1XOEPzJLRxZxNX6CDW2cSU
         peRhUbBtUza+66jgHYBWYzuNsZLeYnzkAVafkjDIwa1RfcwL5ZwCzmhKnqt7whcX8cmk
         DhEYENZnrQMYzVgJqYnAwIsGXcPaEFM4uRlicrliW2exbmx7/3R8G39iZSK8a1zakctb
         Xtgw==
X-Received: by 10.140.108.116 with SMTP id i107mr2401585qgf.80.1393448815011;
 Wed, 26 Feb 2014 13:06:55 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Wed, 26 Feb 2014 13:06:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242768>

Hello,

Last week I ran across a potential bug with branch names on case
insensitive file systems, the complete scenario can be found here:

https://groups.google.com/forum/#!topic/msysgit/ugKL-sVMiqI

The tldr is because refs are stored as plain text files except when
packed into packed-refs, Git occasionally cannot tell the difference
between branches whose names only differ in case, and this could
potentially lead to the loss of history.

It sounds like this is a known issue, and after some more digging I
did find some older threads related to this topic, but nothing recent.
So I guess I just wanted to bring this to the attention of the Git
devs and maybe restart some discussions.

Thanks,
-Lee
