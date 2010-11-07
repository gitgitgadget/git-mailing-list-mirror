From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: gitweb can help with lack of resumable clone
Date: Sun, 7 Nov 2010 23:52:47 +0530
Message-ID: <AANLkTimcdXKXn-L25_1dhAQ2AZwoguvHBc9iKFbbPqTD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 07 19:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF9tI-000665-3V
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 19:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0KGSWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 13:22:49 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45410 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0KGSWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 13:22:48 -0500
Received: by gyh4 with SMTP id 4so2989154gyh.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 10:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=GzDAJuyy5LIT6sFRyGWTW3tRK0Mp/xUjaCdlYTnMqRQ=;
        b=grH9BzRWVWbIvhZMsfIlo1MsyL/maVNPadziltsTzbWHcG/Nb+FVUEvG9i6yGX2C48
         jOwLs+ZslpyGkTRKX5yKsZkPBxTQiCHo5Fk+bUg1atF0n3tQZX7tRUFamF3ebFJ2aubu
         0J7z5vySkWFwV78VYTt/efGJ1361JFczHmWhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=HYpakOtiglP3/0RNWqG0OLfAuwOPZ+5d8XdNL2TQB+QQILw1TlSbTexRpe50m9Bodb
         uPlJPrcX1Aqfnqp0E9tG8BsjeFtJvzYOZg6Rm7E3NSlY1kjK+kWPI97qBIj25+9BzfXQ
         6FmxntDj4GIeguy0BngaidHhGy5qui2LBPoTA=
Received: by 10.90.57.3 with SMTP id f3mr4152193aga.120.1289154167811; Sun, 07
 Nov 2010 10:22:47 -0800 (PST)
Received: by 10.90.52.8 with HTTP; Sun, 7 Nov 2010 10:22:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160893>

Hello,

Over on #git someone asked about this, and I realised I'd been using a
bundle file to solve this problem, albeit manually.

So I started wondering.  What if gitweb had, along with "summary",
"shortlog", etc., a "bundle" button.  This button would link to a
static bundle file.  The bundle file can be generated once a day by
cron or some other means, and that should actually be quite sufficient
-- you should not need more frequent updates to the bundle file.

A user faced with the need for a resumable clone would then download
the bundle (using say wget -c or curl -C, resumable), clone from it,
and then *fetch* from the repo.

The user would still have to take a couple of extra steps (wget,
clone, git remote --set-url, fetch) instead of just clone, but it's
not too bad.

Thoughts?  Has this been discussed before?

-- 
Sitaram
