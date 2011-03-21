From: Dun Peal <dunpealer@gmail.com>
Subject: Weird behavior of shell variables in git aliases
Date: Mon, 21 Mar 2011 09:39:43 -0700 (PDT)
Message-ID: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 18:25:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1irE-0003Kt-2d
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 18:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab1CURZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 13:25:27 -0400
Received: from mail-yx0-f184.google.com ([209.85.213.184]:45925 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab1CURZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 13:25:26 -0400
Received: by yxn35 with SMTP id 35so5924449yxn.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 10:25:25 -0700 (PDT)
Received: by 10.91.33.25 with SMTP id l25mr619519agj.47.1300725583632; Mon, 21
 Mar 2011 09:39:43 -0700 (PDT)
Received: by k15g2000prk.googlegroups.com with HTTP; Mon, 21 Mar 2011 09:39:43
 -0700 (PDT)
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US;
 rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169615>

It seems that a variable is available only once?!  How can the
following shell session be explained:

    $ git config alias.test0
    !echo $1
    $ git test0 foo
    foo
    $ git config alias.test1
    !echo $1 && echo $1
    $ git test1 foo

    foo
    $ git config alias.test2
    !BRANCH=$1 && echo $BRANCH && echo $BRANCH
    $ git test2 foo

    foo

Thanks, D.
