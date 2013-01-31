From: =?UTF-8?B?wqA=?= <porpen+git@gmail.com>
Subject: [feature request] git-daemon http connection filtering of client types
Date: Thu, 31 Jan 2013 07:46:55 -0500
Message-ID: <CAANzHtT83JXhQ8XRifdK5ah7NrnD6hvrCjBO4PnPx=qC=DTT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 13:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0tY2-0004RN-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 13:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab3AaMq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 07:46:58 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:61074 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab3AaMq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 07:46:57 -0500
Received: by mail-bk0-f44.google.com with SMTP id j4so1315728bkw.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=jnUM516FfS36k8dKJzRYK+cYqE/b9/ToJiiSuFXhCW0=;
        b=GvCxEw5b1fu0YC4v8tKWPXGwyJ6BSxaU4cJX412sm/GRKlc48J1gVUC1ut2vcZQfRN
         IRgP9oonPnCVUJ6B2N7T1kTZ1GvJ5lUKsFzdZkRlHq8cyIPjO1e4H/SKicaKdiVrQ+rE
         ZFklz3E1Z3A3Q2QMRkF0mZsXQVOd4u8Yro5RDhz76dc+HVFczjHqQlyTxkHqqXGJMD+C
         8ufFX0sEPERHt55yYjQwzy+U+kbQj1tr34fk3nekPm0lDwxeITesBS4WDl5I/K4OUoJG
         PbBPqqEdVavA6qaT6c6CzP2SVjpN4Dwi2k59EQRVoe6FdVtuBFW5r9dIid/uaBwqBG0G
         BGJQ==
X-Received: by 10.204.148.199 with SMTP id q7mr2166312bkv.134.1359636416134;
 Thu, 31 Jan 2013 04:46:56 -0800 (PST)
Received: by 10.205.39.9 with HTTP; Thu, 31 Jan 2013 04:46:55 -0800 (PST)
X-Google-Sender-Auth: 9DyWfENNeVLiA3Lp-M1evULvsGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215113>

Hey folks,

When I checked for false positives in my spam this morning, I spotted
an interesting malformed img link at the top of a spam message.

{snip}
> <http://git.{snip}.n2.nabble.com/file/{snip}/t3.jpg>
>
> Employ a medal tiffany bracelet  <{snip}> a is
{snip}

So, apparently git-daemon's http features are being used by spammers.
In most cases, spam filters will correctly identify this junk.

I wonder if there is a better way...  In my mental sandbox, git-daemon
http could have a set of deny/allow rules for incoming connection
client types.
e.g.:

git: allow
git-http: allow
thunderbird: deny
outlook express: replace linked file with rickroll.jpg

and so on..  An out-of-the-box install probably should default to
allow all to keep backward compatibility.

While I'd love a chance to hack something out, I sadly doubt I'll ever
have the time for it.  Perhaps there is a student hacker looking for a
project.

Cheers!
-phil

p.s. appologies to anyone who now has Astley's song stuck in their
head.  This was not intentional.
