From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Git thinks a failing command doesn't exist
Date: Wed, 11 Aug 2010 19:12:38 +0000
Message-ID: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGjH-0000YW-EF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab0HKTMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 15:12:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42187 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab0HKTMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:12:39 -0400
Received: by fxm13 with SMTP id 13so362424fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Pb4Z3PpU1LX5Xv3Hde9OyUBrWBZG5Wf4/vXVnwP4RK8=;
        b=ULlQZxOliv8I6Nfgwx8lKMaXgn5Z9qX3ChU0ggQ6mBrcrqzlAXGo74Xi9QQPbgJkrw
         jHwI0rBcKolMiy7poWhDOMv14s7K6uF3w4Dx1+fTm2tH/ukX0tUNrfPKUtLskljPkDKs
         oQYxpsmY0x2zoda29gy2tSH15znGZGQNf0Ssk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nlOO+/mgY3ULrC3k5OFxq5z5UCqZ0F/jQWnglRuhkqNRQsxzgQ0d1q3q+s52oUEHPR
         5bBiPhqMo2BlHWn3WmtxfPDl9h5TnNl5b/YVz+FptQGb7xroU+h/f5Lx+dpCMWBwIOJO
         2vLS2bOZqMxLOpV8cbOAyeh2C7ZB+CeZibl8Q=
Received: by 10.223.122.6 with SMTP id j6mr20588549far.78.1281553958086; Wed, 
	11 Aug 2010 12:12:38 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 12:12:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153289>

Has this been noted before:

    $ git rebase --continue
    .: 986: Can't open /home/avar/g/git/.git/rebase-merge/author-script
    git: 'rebase' is not a git command. See 'git --help'.
    Did you mean this?
            rebase

Rebase failed, but the help mechanism seems to just test the exit
code, or something similar.

Perhaps help_unknown_cmd could just check if the command it's
suggesting == what it says doesn't exist, if so the command probably
failed, but maybe there's a better solution.
