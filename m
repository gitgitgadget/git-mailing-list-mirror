From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: git-p4 using notes
Date: Fri, 16 Dec 2011 11:07:10 -0500
Message-ID: <CAFLRbori1Dinc2epputWfjgCOWp7M2f=+TA0w2jHq_fmRC=y3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 17:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbaJY-0004I5-Qn
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 17:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090Ab1LPQHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 11:07:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39326 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759429Ab1LPQHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 11:07:11 -0500
Received: by pbdu13 with SMTP id u13so791546pbd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=Kq6iiylyybOpI8RzY39HP4EE+ZDFkiuyIeQpjEuY6E0=;
        b=jAhhgnlWw6rv5XjIDfeVVTm1p7C0QJoxB5zAaSA1c8pmFdO1/RTtptGbZ1TUx/zXPJ
         3MDCajoQUcmIxgXte0cKMkcAlB2j3Ubqo4gbHIJACK5rOuYcd+wiuCMHERPYTy8zugSg
         HZ8syroIlGVhKY8aLyQG736pV4ozaHf3qRS10=
Received: by 10.68.74.132 with SMTP id t4mr17290930pbv.22.1324051630655; Fri,
 16 Dec 2011 08:07:10 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 08:07:10 -0800 (PST)
X-Google-Sender-Auth: 09DA7hNSjy2VnY8IyP6RjNHmCzs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187284>

For those of you using git-p4 because of a company requirement to use
Perforce, but really wish you could use git only, the most frustrating
part is the fact that when changes are submitted, the commit message
is rewritten to include a reference to the P4 change number which is
used by the sync.  When syncing back changes, this causes the commit
hash to be different, and so blows away your old commit and any parent
commit references and such.

I read someplace, I can't remember where at this point, that if git-p4
used notes to write the P4 change information, that would not impact
the commit hash, so when merging back, things would not be
overwritten, and you can maintain branches and commit history properly
in git.

I just ran into this project, where it seems that someone has
re-written git-p4 to use notes: https://github.com/ermshiperete/git-p4

I was wondering if any of the maintainers of git-p4 has considered
this, and might want to leverage this work to merge into the main git
repo, possibly with an option to choose between the two behaviors.

Thanks,

Mike
