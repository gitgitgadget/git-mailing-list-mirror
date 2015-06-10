From: "Bossert, Andre" <anb0s@anbos.de>
Subject: "git difftool" is not working as expected during MERGING
Date: Wed, 10 Jun 2015 15:12:21 +0200
Message-ID: <CALzBCsGSJJZhWRoSVW6-tb+grxnFTOWSQ8kQFmwk05sC-30Q6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 15:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2fnw-0004HU-0q
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 15:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbbFJNMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 09:12:24 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33868 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbbFJNMW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 09:12:22 -0400
Received: by qgf75 with SMTP id 75so15785508qgf.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 06:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=ZvjZz2GCLgYtG1qz2hkgYxDzTysJkBL0fZBZ0b03JJg=;
        b=LCv3Z9OlCOI1XO5olJdPqJ9xK6G5ivmwxWOnxn+zLnHDn7fuX1VzWNzSQyDfMd1pbN
         mESHpggMUyC9+E3KBdfXYN+/cyZbO1yBhJed2mNLurPS+9wJchdsCd1DN8kAYN55FBFV
         intWzQTarIG9dpzjG/cgZeptcsi+UKuva8wJ7Q7lqdYp+ifYdc6e1BayoyVhskXgtCUx
         LkKvELP9QV72+Fzk0sBFg/MazITr3dx5DS9hKu0uS0RJm4CNRlA50qti7JcTRVSnmQ/U
         dtMcqdeoau4CfdBiGwcnajyL2BYUhNNpMKVAmdclJz7Efcn/9CnzW3UJbQ8yUJIxPp76
         inWg==
X-Gm-Message-State: ALoCoQk0znloAqOMqQI35J6Mlyp/mOTSz8dtJ6WS0R2ZOTa1kxZlBfObj6cbWNfFgPiMzAY1IyWt
X-Received: by 10.140.41.134 with SMTP id z6mr3636034qgz.40.1433941942063;
 Wed, 10 Jun 2015 06:12:22 -0700 (PDT)
Received: by 10.96.159.229 with HTTP; Wed, 10 Jun 2015 06:12:21 -0700 (PDT)
X-Originating-IP: [194.138.39.52]
X-Google-Sender-Auth: NEJvDK7I4JukbEPQJxFFvYQb3Qc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271286>

Hello,

i've tested "git difftool" with -t --ext-cmd and other options to see
my diff with external tools, but it always show internal text-diff in
console. The same tests with "git mergetool" working as expected. I've
compared (nanually reviewed) git-mergetool.sh with git-difftool.pl and
see that difftool is mixed / shared implementation with normal "git
diff" command. So during MERGING state there is no possibility to call
external difftool with this command. Any ideas why this was
implemented this way?

-- 
Regards
Andre (anb0s)
eMail: anb0s@anbos.de
