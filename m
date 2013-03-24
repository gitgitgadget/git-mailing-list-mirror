From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Why does 'submodule add' stage the relevant portions?
Date: Sun, 24 Mar 2013 23:08:40 +0530
Message-ID: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 24 18:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJotG-0002Tk-8P
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 18:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab3CXRjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 13:39:01 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60395 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab3CXRjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 13:39:00 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so6693767ieb.29
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=3wVFTE+vG/T+fA2WmPbLZXHGZdmr8coaiIuvI1FJrsM=;
        b=xmmBYQlnXwIWPmf3BH3F6xQAIJna4MzNMRMavnhudUmmsVN07QsaEHAyEAgPOKoMiS
         jdXCoqEBRcalyFonU5rCUTAW0nPD/ChxHhdMdskRm+MgYxwI4EVT6w7utHd+Az+qdWuI
         05YH41OhXwa2IToG4raQokHgCPPrsLTp2iGyfUjq8fNIaP9WEaLMaGHc2lyi74dulAxP
         sFRy75MedCWF7xXUReXdX8ad7CovtViMt3H/8Nye1NU9Ke0aHNN7acLtBEbole3nTueA
         KPfLHPESvmn9cuwLhT3LPdWceauH829onGkil9RbcXEDAKd05DpMxnThjNo2+9O4BX/U
         FYGw==
X-Received: by 10.50.17.166 with SMTP id p6mr9489263igd.12.1364146740330; Sun,
 24 Mar 2013 10:39:00 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 24 Mar 2013 10:38:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218961>

Hi,

I find this behavior very inconsistent and annoying.  Why would I want
to commit the submodule change immediately?  Maybe I want to batch it
up with other changes and stage it at a later time.  Why should I have
to unstage them manually now?  I get the other side of the argument:
what if the user commits the .gitmodule change at a different time
from the file change?  In other words, the user should have a way of
saying 'submodule stage' and 'submodule unstage'.

Now, for the implementation.  Do we have existing infrastructure to
stage a hunk non-interactively?  (The ability to select a hunk to
stage/ unstage programmatically).  If not, it might be quite a
non-trivial thing to write.

Git 2.0 is coming soon, so I'm excited about breaking a lot of
backward compatibility ;)

Thanks.

Ram
