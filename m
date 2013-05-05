From: Jed Brown <jed@59A2.org>
Subject: git describe not showing "nearest" tag
Date: Sat, 04 May 2013 23:48:51 -0500
Message-ID: <877gjeav64.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 05 06:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYqsr-0000Bp-PG
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 06:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab3EEEsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 00:48:55 -0400
Received: from mail-gh0-f181.google.com ([209.85.160.181]:45708 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3EEEsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 00:48:54 -0400
Received: by mail-gh0-f181.google.com with SMTP id z12so530596ghb.40
        for <git@vger.kernel.org>; Sat, 04 May 2013 21:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:user-agent:date:message-id
         :mime-version:content-type;
        bh=+Y6TuNwbq+Q2/HmI6QF8vuSm6JKcrQweD3FpLFIixZI=;
        b=eZQLqJj/C0YKEvDFMhT5lebl+1XMRFr4kPyQllW3t+ZTfAH1a/BQOHy8Ge4VizjUzq
         kLKe4PswILSwsljnwK/GneqyXfEqyOR022R/oIXh/wEZj3FW1K4/uj/P70vCHA3b1YbP
         FDGv7KdVPUINqB0K51NMztR86Xa8LWK76EFAFgCgROg1PqZ92dZHbFFLJgWAwX2OueKE
         xJfz1dP5cYqOKlEfmcDWDAkuriFZUA2mi58ZhNr8qNg4bngjfpzUa1CmzDnff/gI1lgo
         /WpFw0BYzzAiuXKIZa7ywrgQ8WvMp+qIlD2n1/46A1k7keHmZDwodsS8O7dgZbLpBhIP
         Sugw==
X-Received: by 10.236.113.194 with SMTP id a42mr14253108yhh.139.1367729334180;
        Sat, 04 May 2013 21:48:54 -0700 (PDT)
Received: from localhost ([38.69.41.96])
        by mx.google.com with ESMTPSA id g24sm35820669yhm.0.2013.05.04.21.48.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 04 May 2013 21:48:53 -0700 (PDT)
User-Agent: Notmuch/0.15.2+84~gfa8aadf (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223392>

$ git rev-list --count v3.2..master
9651
$ git rev-list --count v3.3..master
6378
$ git describe --tags master
v3.2-9651-ga018267

I would have expected to see v3.3-6378-ga018267, given the documentation:

  If multiple tags were found during the walk then the tag which has the
  fewest commits different from the input committish will be selected
  and output. Here fewest commits different is defined as the number of
  commits which would be shown by git log tag..input will be the
  smallest number of commits possible.


What's going on here?


The repository: https://bitbucket.org/petsc/petsc

This repository currently uses only lightweight tags.  As an experiment,
I replaced both v3.2 and v3.3 with annotated tags, but it did not affect
the 'git describe' output.
