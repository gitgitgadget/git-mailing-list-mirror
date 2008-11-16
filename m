From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Conflict-free merging (i.e. concat) of conflicting branches?
Date: Sun, 16 Nov 2008 14:50:34 +0100
Message-ID: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: markus.heidelberg@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 15:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1iB0-0001ZF-MQ
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 15:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbYKPNug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYKPNuf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:50:35 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:9629 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYKPNuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:50:35 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1743034rnd.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=lwDLMYbRFf88YdLyObcaeMJmrDu4HQBXdbWzUZHISV0=;
        b=iTb5BBU/8dI/gYTcOuX6RTV+VadaPziukDDKNw6zrbthtPEhuHXqVcEzQ0wmhpRhRY
         K+9jpqIhd/WhPVgx+7ZLfiri0EthRsg6dbo7ewasGaiHnZy1BTFeVzmPY7kBE6CWRfYM
         b4r/2UjbSF909KBYlV7K3KbEv54ln41Y63eu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=LZecJwNJMI2rcPY41cApWM3H7FzpIXWAM/xYi+8Sg6Uz56Nmdwg2yttSND6+mfYCky
         eJiMwr7E3TxtpewOJGHxqeb49FAb9U0Neq934F00hBjOVnuu38+xqKYEFbbAn+vw4VdM
         6eowAa87eQv6BgAUxi3ec4BlOBhi6jKVowlpo=
Received: by 10.100.240.9 with SMTP id n9mr1234003anh.125.1226843434119;
        Sun, 16 Nov 2008 05:50:34 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Sun, 16 Nov 2008 05:50:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101130>

Please keep the CC intact if possible.

Hi all,

the vim_extended repo, a collection of patchsets against Vim,
allows users to merge different patchsets on top of a current
vanilla Vim. To keep track of which patches are merged, we
would want to use a special variable designated by Vim for
this purpose.

For example, branch a would have file foo with line 100:

$patches .= " with_patch_a";

branch b would have file foo with line 100:

$patches .= " with_patch_b";

etc, etc.

The question is if there is a way to to merge these
branches in a way that is conflict-free and includes
all lines. Obviously, the order of the lines is irrelevant
and can be random.


Thanks for all thoughts,
Richard
