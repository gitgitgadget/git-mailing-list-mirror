From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Testing for commit reachability through plumbing commands
Date: Thu, 6 Mar 2014 12:17:34 -0500
Message-ID: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLbvl-0003GL-1d
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbaCFRR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:17:57 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:65397 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbaCFRR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:17:56 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so2938014vcb.11
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Je/pu308Jsn2kRdeCP875fBNAJ0kYzDcezUk/7kuy80=;
        b=TMZE4+PcoP6RX/kk8LIEezcDpMABx14gL3gaPhhK6o2qRNpHxFgy7+roJyd6tWdX2Y
         BkDHQPPvw9hqfAjyx7BkLhrBcIJ0XfoDhMTgJVtEw/nS8SHvjnwVqqcobxV8Ffx3r8d+
         92FuRIei67AWHm9C9Mdlx4H/btAktLNHni3VCrkTpTgG9KvQyeecwXHR6wTr5kjHWs6H
         CAZkhA1ZDq0Acr1id7GgOfTJhDsz5BPk+vi1MNxupP58tcQeix/TMhGD8rAQeT8ucl4A
         AIltTIvdgRR2B8MR5DTDvUQsvBnaRjZXTubpWXfQalhVw+HSHLN1eGLeXqdCpX0zoc3d
         Lc1Q==
X-Received: by 10.58.40.47 with SMTP id u15mr22423vek.71.1394126275366; Thu,
 06 Mar 2014 09:17:55 -0800 (PST)
Received: by 10.220.183.138 with HTTP; Thu, 6 Mar 2014 09:17:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243523>

I have a shell script that trims old history on a cronjob. This is for
a repo that is used to track reports that have limited "life" (like
logs). Old history is trimmed with grafts pointing to an empty "root"
commit.

Right now, info/graft grows unbound. I am looking for a way to trim
unreachable grafts, I would like to be able to say something like:

 git is-reachable treeish

Grepping through docs and existing code hasn't helped, but perhaps I'm
missing something obvious...

This repository has a couple hundred branches (one per server
tracked). For a single branch, I can picture a relatively easy
approach with git merge-base.

thanks!



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
