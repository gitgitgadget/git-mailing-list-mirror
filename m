From: Kartik Agaram <ak@akkartik.com>
Subject: how to keep git-fetch from running out of memory?
Date: Sat, 14 May 2011 22:24:00 -0700
Message-ID: <BANLkTinnOTr+PUzBMpx1DLcxs8CVWjy33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 07:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLToH-0002ID-8X
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 07:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab1EOFYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 01:24:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57226 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1EOFYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 01:24:02 -0400
Received: by wya21 with SMTP id 21so2724057wya.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 22:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=/7iEOzYt2RrLo2ye1lTw6d6FYrw/1N2FYqt+QQaxS6s=;
        b=Q4HrzYcnzEvTIIsKSbDWIeBYuUWNnpQmizok846EQzMo0pyYbsW0p78XO5UQwGFYqs
         u1jxH/ztiuOZO769KKJXLxP4juU0grYdieot1rog6nKSI4qM41sXNlicGyILXlG8FJRX
         8s7Lt9uIpq4owQpV4ugOr0hJnX3M5s1flak40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=cGXupm3sUttfprHb5+JLD1TFmAAyorSIgidnrQj7TfY2HhCmwjPvsogvxsOvfTOHaS
         N2DZhaV9Tvqc9+ouHShsznvDYlRBQ7UG0dv3Tn1mY1nrz57fnCarHjk2J5wsvsvoU545
         XKKAAKFHgUccYkZBU7YX6rTzPS3tUur6CPHWo=
Received: by 10.216.140.140 with SMTP id e12mr1023212wej.69.1305437040688;
 Sat, 14 May 2011 22:24:00 -0700 (PDT)
Received: by 10.216.24.199 with HTTP; Sat, 14 May 2011 22:24:00 -0700 (PDT)
X-Google-Sender-Auth: z5OxuAnh-RYoZ1DvpL6w6MRLajs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173622>

I have a git repo with some large files that I'm no longer able to
update. git fetch keeps running out of memory:

  fatal: Out of memory, malloc failed
  fatal: unpack-objects died with error code 128

Anybody know how to keep it from compressing the refs into packfiles?
I've experimented with core.compression, pack.compression,
pack.windowMemory, pack.packSizeLimit, all without luck :(
