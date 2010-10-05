From: Eric Raible <raible@gmail.com>
Subject: git push <branch-name>
Date: Tue, 5 Oct 2010 13:29:50 -0700
Message-ID: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EAM-0003IU-TD
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab0JEU3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:29:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37177 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309Ab0JEU3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:29:51 -0400
Received: by pwj5 with SMTP id 5so1544527pwj.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=AZRCFsF+X1yDXzg7voXQtw3yMNLvyB7NlwY0bNQB/4I=;
        b=kaA8RTgUwNEeviyb3O+iGTTWDRTMacimKzkFdd3UyvrYRLsqI0n3r2Pt+Ug7KivwnC
         /Cq/nFWX7DtC/9g1C7bMFH8E5UhccBWFXkl9MAIDhVBH5gzKihEVitxsO0V9fMqBA5uk
         StrM9C8jB+7INSaVW6A4GQiYYYaAVKmSi6anc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wgDWs+2lPI/4LCXqceQYlyyESPe/7VHz+hMTDJ8iaR5yQimgnQU5TItLbUK8rFbh+6
         UoECXHhDZ+vA4cy5l6Kg2oOtn4eCCBRaGpAqI54H1bqeLU/3Sy4tfx9JEIeLxrLVfQxo
         rOOSENbj3LE23hlQtdqZ1TmZl1dZS3B8z8aGg=
Received: by 10.142.204.14 with SMTP id b14mr10763977wfg.286.1286310590490;
 Tue, 05 Oct 2010 13:29:50 -0700 (PDT)
Received: by 10.220.163.85 with HTTP; Tue, 5 Oct 2010 13:29:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158235>

A newbie colleague asked why: "git push <branch>" didn't work.

Although I know that "git push <repo> <branch>" is the correct
syntax, I think that he has a point.  If branch.<branch>.remote
is defined it seems unambiguous to me.

So I can't see any reason NOT to dwimify

    git push <branch>

into

    git push $(git config branch.<branch>.remote) <branch>

What am I missing?
