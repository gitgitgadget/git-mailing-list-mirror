From: "Jack O'Connor" <oconnor663@gmail.com>
Subject: Bug: version 2.4 seems to have broken `git clone --progress`
Date: Mon, 11 May 2015 15:51:10 -0400
Message-ID: <CA+6di1=Qvp3oaw0moMg8XMFd5vgc0v1L0CC2ppEDOF8QA9N6Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 11 21:51:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrtjt-0007qY-MD
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 21:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbbEKTvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 15:51:41 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33615 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbEKTvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 15:51:40 -0400
Received: by obblk2 with SMTP id lk2so108514793obb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qPc1dAYDx26kWRXiAjTpjb1cfUYZwyyOTTpiYjVWymU=;
        b=uRRmyi9s0264byp+f2LsHfC7+H035lBqBW2VQMx2ohGew5CTZLsdPcT6kAY8nUZoYX
         pUv4jbb3f0kfO6bHXZ/foBDmdQjZK1N9hO/FJOj4NxXJOOFir71RmRrinfVy4kO1dUTg
         TnqmqqFopUgkkZPnaabg2alqUZtOBQFLl2KFkG+GvTtbLwDUbp3WUolE4aau/m8MtwL/
         gkcaP8pJrHNVYTvvW0KuIJJsz3MsEfKWm1fc3rbjQHpZujxDtZ3AmP4idkpzZDdpq+xW
         9IMQap4gER3iuVSoS3uBdBiX5LbTxe4tWA4GUoP3lwlCjZCmif87iE747Td3C4wW5lHc
         Zq4g==
X-Received: by 10.202.108.132 with SMTP id h126mr8784676oic.5.1431373900449;
 Mon, 11 May 2015 12:51:40 -0700 (PDT)
Received: by 10.202.225.2 with HTTP; Mon, 11 May 2015 12:51:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268821>

In git 2.3.7 I could run the following command and see progress in the
terminal, despite the redirection of stdout and stderr:

    git clone https://github.com/oconnor663/dotfiles --progress 2>&1 | cat

As of 2.4, that command no longer shows progress. When I bisect, the
responsible commit is 2879bc3b0c3acc89f0415ac0d0e3946599d9fc88
("transport-helper: ask the helper to set progress and verbosity
options after asking for its capabilities"). Can anyone suggest a
workaround?

-- Jack O'Connor
