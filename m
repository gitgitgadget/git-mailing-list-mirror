From: Jay Soffian <jaysoffian@gmail.com>
Subject: git log: why are --full-diff and --pickaxe-all separate options?
Date: Wed, 24 Mar 2010 11:52:13 -0400
Message-ID: <76718491003240852m2a2c12afjca2c71f6c78b2047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 16:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuSwm-0007xE-2J
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 16:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab0CXPwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 11:52:16 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:45010 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab0CXPwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 11:52:14 -0400
Received: by pzk38 with SMTP id 38so946035pzk.33
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=H1iYjehgWl1AjGlKoAYZfBPp3J0Jmdkb9iGdKlLtqqQ=;
        b=Cu8o+l11vrM+J3bnmxEV1OXn2hbEUIi/RBZdIViW5lVvmJU5NfExLY6+dbiJSaBj2i
         V859RYDJ9wJBTvXHItx8Ux1BCYtmC1xDkfri/MOsxdq9lnPjf1eq+6WYyNI6Z9FhgFmH
         5F1LB9b5iMRhol9I56MPbs/KYWrVUL0cMgXbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XnW+Tn5I6RQZlEkHxktQubGZzkK2p8WzjG4iolr+VkyTiouk2BViTym8Qw4Dno245v
         wn9lJN5mSzUX+ee/Rn1tDxxxqR+ZWQipKhUnJvAijbX1xxoaMvW0iuLXlkJ1Dd+9OCC/
         twycn8LMqqrDMb04IaZf2aghx4WBoR1OcWPM4=
Received: by 10.114.186.33 with SMTP id j33mr4947357waf.172.1269445933240; 
	Wed, 24 Mar 2010 08:52:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143090>

I just did this:

$ git log -p -- /some/path

And didn't get the full commit. I know about the --pickaxe-all option,
so I optimistically tried:

$ git log -p --pickaxe-all -- /some/path

Which of course, does not do what I want. Eventually I found in the
man page that I can do this:

$ git log -p --full-diff -- /some/path

But now I wonder why these are separate options. Is there any reason
they shouldn't be unified?

Regardless, perhaps --pickaxe-all without -S and --full-diff without
-p should be errors?

j.
