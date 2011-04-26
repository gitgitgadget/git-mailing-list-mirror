From: David Deller <david@horizon-nigh.org>
Subject: [BUG] git pull does not understand --strategy-option
Date: Tue, 26 Apr 2011 10:06:36 -0400
Message-ID: <BANLkTinFcob1RrOxEDDG+B6UAZGYg-smtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 16:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEiug-0002ki-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 16:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab1DZOGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 10:06:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab1DZOGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 10:06:37 -0400
Received: by vws1 with SMTP id 1so474499vws.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=vCX7t8B/4LWJuSudm0xdMMKXDgnZXLNRBbSBDcYr5y4=;
        b=AnOIKN+ceUYKoeLtjs4RxdwTIoWUH1SvsaXfFPqXMxUa+c03nUdVdneDK6gMfQbxJE
         /Sca9CtZkQO2DCRT+8HDfkJzwmT6IXZt91NCT3FeR2B21Iczs2hbwxdR2QiDSS66gc/t
         x5fzNI3wco/N2oj0e7gPWF6YBZhdI6dGNzS+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=nut61O7cc/OLn60m6trSKtFsdqulZjRskueRQIZD/QcINA8brYEzTQvtLCVJa3TzJL
         UaoOVqYOm2zpuWLKY2j3HfTT+Zo//pULqi4g80Pf8X5VqLMymzDT3+qX6o6G9sx1gvpX
         c2Vbmlqpmq1Buu/jZ4rYFR3kZY2GHN8O066HY=
Received: by 10.220.193.1 with SMTP id ds1mr230494vcb.148.1303826796624; Tue,
 26 Apr 2011 07:06:36 -0700 (PDT)
Received: by 10.220.77.5 with HTTP; Tue, 26 Apr 2011 07:06:36 -0700 (PDT)
X-Google-Sender-Auth: 0vDYGqOAawcsFXruGbXcEsQj3pY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172096>

Works using short form (-X). Works with 'git merge' using either short
or long form.

Apologies, I do not have the current version of Git, but I did not see
any mention of a related fix in changelogs.

$ git --version
git version 1.7.4.1

$ git pull --strategy=recursive --strategy-option=theirs origin master
error: unknown option `strategy-option=theirs'
usage: git fetch [<options>] [<repository> [<refspec>...]]
   or: git fetch [<options>] <group>
   or: git fetch --multiple [<options>] [(<repository> | <group>)...]
   or: git fetch --all [<options>]

    -v, --verbose         be more verbose
    -q, --quiet           be more quiet
    --all                 fetch from all remotes
    -a, --append          append to .git/FETCH_HEAD instead of overwriting
    --upload-pack <PATH>  path to upload pack on remote end
    -f, --force           force overwrite of local branch
    -m, --multiple        fetch from multiple remotes
    -t, --tags            fetch all tags and associated objects
    -n                    do not fetch all tags (--no-tags)
    -p, --prune           prune remote-tracking branches no longer on remote
    --recurse-submodules  control recursive fetching of submodules
    --dry-run             dry run
    -k, --keep            keep downloaded pack
    -u, --update-head-ok  allow updating of HEAD ref
    --progress            force progress reporting
    --depth <DEPTH>       deepen history of shallow clone

$ git pull --strategy=recursive -X theirs origin master
From ssh://git.internal/repos.git
 * branch            master     -> FETCH_HEAD
Already up-to-date.


David
