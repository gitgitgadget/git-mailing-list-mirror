From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: git alias question
Date: Wed, 28 Dec 2011 20:27:59 -0500
Message-ID: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 02:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg4mt-0004qu-UC
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 02:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab1L2B2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 20:28:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39585 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab1L2B2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 20:28:00 -0500
Received: by dajs34 with SMTP id s34so8059883daj.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=P8StIQW267Ael21q0Iq/MGZ63qvIg/vpSG/rhyEQkjQ=;
        b=CFJD8AM9czBIgX8nn/MasoxGKaYEkLOTvYFYYvJm2PKqRLRV4Fjr3oUw7GSQXqyD4s
         teJ5Xgsv/D+mKRFCWfd1zI8GcRGo58GGMjAsZAjlQIIgLE9BL9KWbq5ZRYn5KJM6TZzY
         lz0c1YAfMu9+CG9K+9Aj6lk2EcerzQocsKgRM=
Received: by 10.68.122.198 with SMTP id lu6mr47853263pbb.92.1325122079422;
 Wed, 28 Dec 2011 17:27:59 -0800 (PST)
Received: by 10.142.102.16 with HTTP; Wed, 28 Dec 2011 17:27:59 -0800 (PST)
X-Google-Sender-Auth: qAkFwkRaYaDmSqDH4F3KDjMTQFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187767>

Hello all,

I have been unable to find a solution to this, so I figured I would
post to this list...

I am trying to make an easy command to let me look at the last diff to
a specified file, either plain or with a diff tool, such as vimdiff.
This is the last actual change, not just HEAD^, because the file may
not have changed in many commits.

I was able to make the following 2 aliases, which work perfectly
except for one problem...

ldiff = "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
ldifft = "!git difftool `git rev-list --reverse -n 2 HEAD -- $1` -- $1"

The problem is the limitation that shell commands are always executed
at the top-level directory of the repository.  Normally I am in a
deeply nested directory, so if I specify the file name in that
directory, it doesn't work.  Having to specify the full path relative
to the top level makes these aliases more cumbersome to use than their
worth.

Is there a way to get around this, or even a completely different way
to do this that I am missing?  I want to avoid making a completely
separate shell script.

Thanks,

Mike
