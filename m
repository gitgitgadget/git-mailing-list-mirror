From: Stefan Beller <sbeller@google.com>
Subject: git status during interactive rebase
Date: Wed, 20 Jan 2016 15:21:47 -0800
Message-ID: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM24Z-0004Q2-DE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 00:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598AbcATXVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 18:21:51 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37261 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbcATXVs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 18:21:48 -0500
Received: by mail-ig0-f175.google.com with SMTP id h5so22349210igh.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 15:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=2xpTh3TM8xSXQaLQeTZOPH0xxTDYy8pEBMtXz8IbVJw=;
        b=iYedGaOQBNhcz53oVeO+mzrqYfy6mG1A9k1wlVdBqrS7CUnQIX+lDP5LlqeUGlBPgU
         PIbHew76GMx7JucQTMdj1zElH7WUTKmycseD6Wd+Z+lv8uScF7PlakKclfEYHiAEM6vm
         nUQmcluWAtCE3qc+G4lsF4p/xx+4CRY6lFBWP0gK/hIB5PcC7iR7VOFtR82UoqlRSrr/
         TwLbvlBz4R4vczmq6JkGLnmAPap6irXwr5HA6D9j5JzdD377i3+JjqBQj0GPC0CbbDwc
         +Hyix3p7TPVYMmfqkcD7zvpSOdBkPsY7kGr+Q5+kqbUc28SC/yMKxA+W75MRAM2miqLQ
         0Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=2xpTh3TM8xSXQaLQeTZOPH0xxTDYy8pEBMtXz8IbVJw=;
        b=VxVgi1Twc6Mwixphxy9xgfz6yuzPHVJz8guoXqX/D413mP/91KFEKw7Mx6Y6akz3u/
         73kSSba8Uo39qMPubN1JcCkRUVv5/IZBFkXD04gr08JKTVeJrvx8TRVGxiwdfHT+u4tm
         CcBSMXfqJM7Z4FQ16m+xbZrLhARUABIKn1uqbSVuAEY0cQk24zFyRFZb3ClWCcqh7u2e
         rNAf64G+not3TSVRnRkcHbCLK2I0YXX8mlkl0UnhaQ+qA+/uksReSoujM6SmSJp2GBbT
         1Toc+VVkj6Mm33PoxHntfy/Dl/HZ2W6sC1qgSDKW7SclwlhNIBXnu+gdA/Gthf6A4gq3
         GCww==
X-Gm-Message-State: AG10YOTBFPppfmna627qJxjqVtwZmcshnBLFNRSIWym00N/NmQpcQWew1HdECmvawK5bGSsCsBGpy9wBNIgYLNP2
X-Received: by 10.50.28.105 with SMTP id a9mr270817igh.94.1453332107471; Wed,
 20 Jan 2016 15:21:47 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 15:21:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284482>

So I ran an interactive rebase, and while editing
.git/rebase-merge/git-rebase-todo I tried to run
`git status` in another terminal to inquire about a
filename of an untracked file.

However, I got:

$ git status
On branch submodule-groups-v3
fatal: Could not open file .git/rebase-merge/done for reading: No such
file or directory

Was this behavior always the case? (IIRC it worked a long time ago?)
Would it make sense to not abort completely but give a limited status?

Thanks,
Stefan
