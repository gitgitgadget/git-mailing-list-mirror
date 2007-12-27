From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: checkout without touching HEAD
Date: Fri, 28 Dec 2007 11:22:41 +1300
Message-ID: <46a038f90712271422o7a831c09s463735ec41356b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8189-0005Dq-Vi
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbXL0WWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbXL0WWo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:22:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:8614 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbXL0WWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:22:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1718542ugc.16
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Rw0gQ66aWp1gaQK5FESciAXXSFOZnkJR/G2uoZA6O9I=;
        b=dGLIGqK9w6rL7Hl1MnaI7xmWXK4cva+bLzq/NAkO02nZPX4E3eZXq6Tu3wN3XEGXDY6gqM3LA3NzLd4B3M6zzuiqIqAeJEtCJDoPhRUzCFtuAcucW3Fe3iz0va4OqRegZxk6I/zW21Sx7A3F6TmkEKJW0mQVi2KA6uUOsjmUHzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X6EPX/F7F9UphMq8zP4vMg94iOasgvO8ssm9HaG2qmgF+YKtFPzE4uJVKN2lgmRJ+tADcUH9SkPL4uHRCviC1taeJH29XmKrYJ5M1fzyBSxwHj2eDX/+ePnaRjve7pMYwJZmiQpJEYNipkQ+QJtqWPQfteO7eYvaKDmV8rWM4J4=
Received: by 10.66.254.19 with SMTP id b19mr7627782ugi.7.1198794161981;
        Thu, 27 Dec 2007 14:22:41 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 27 Dec 2007 14:22:41 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69267>

Is there a way to get a 'checkout' of a treeish _directly_ from git to
an empty (or 'no conflicting paths'-guaranteed) directory, without
touching HEAD?

Using `git-archive ... | tar -x` is a waste of time and resources -- I
do want this to be fast for large datasets. I have hacked it a bit by
backing up HEAD, using git checkout with a temporary index, and then
restoring HEAD, which I can do because my script has a big fat lock
around it. But it's very un-gittish to need a big lock around me.

Maybe there's a command I'm missing? Or a zikrit option to checkout I
haven't found?

cheers,


m
