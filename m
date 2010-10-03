From: Gabriel Filion <lelutin@gmail.com>
Subject: remote-bzr status
Date: Sun, 03 Oct 2010 17:17:37 -0400
Message-ID: <4CA8F2F1.5090407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:17:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VwK-0001ro-LI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab0JCVRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:17:42 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53667 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111Ab0JCVRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:17:42 -0400
Received: by qyk36 with SMTP id 36so2190961qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Nhn67SQccfMply5TlklwMcBdEzXFyEy6Urn3MluyjkA=;
        b=Mn4SqQIzq9ZH07TFgF0FAvsYYF6udKHYOSaISHcJ0wv+bfJ2JkygA5IC2caVu5bBKS
         Ed2NrugP0IprU0FnOCNMJ1xBwAxAUx6sG12WOAZ/wM/FnPNBWrUKbzYMpAvm/wXTT+lh
         OAdBmEYG5Y5+G3gcN7aPgfsjlbF5O8nvN4s/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Vw/LAs49rbxZxlGhyUn5kz1/JMGdHXT1J6fQ0yNIjyQgZCYB8z3+C9xzy2ltLxIWDp
         xGO/L2sBbtHRAGCJQjt1pzu/Fls8JP6mKjKPhpnyIgQhkqfNG5TrjWQrq7qiPXalM5SA
         6aplKHq8t1edUPIcGPnMBXaKY+dnNWS/jJ44k=
Received: by 10.224.46.15 with SMTP id h15mr6282552qaf.59.1286140661590;
        Sun, 03 Oct 2010 14:17:41 -0700 (PDT)
Received: from [192.168.2.202] (dsl-150-76.aei.ca [66.36.150.76])
        by mx.google.com with ESMTPS id r36sm4483145qcs.27.2010.10.03.14.17.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:17:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Iceowl/1.0b1 Icedove/3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157925>

Hi,

It's been a very long time now since I talked about this on the list.
The project (integration with Bazaar through a remote helper) is not
dead, it's just stalled because of bugs in the chosen "backend".

The remote helper code was done in python (mostly based off of Sverre's
remote-hg code) and relies on the "bzr-fastimport" tool. It can be found
on my github repository:

http://github.com/lelutin/git-remote-bzr


First off, what was done for now?

- The remote helper is able to pull in changes in Git repos and to
create tags.
- It is possible to push changes back _but_ only in some situations. The
"bzr-fastimport" tool currently has bugs [1] that prevent it from doing
what we want. I have included a patch in the remote helper repository to
fix one issue on the fix that was proposed but the whole thing is not
completely fixed.

[1]: https://bugs.launchpad.net/bzr-fastimport/+bug/347729


Why did I lag this much on this project?
Mostly because of lack of time. My $dayjob was far too demanding. But
since I am now self-employed, I want to find some time to work on this
and get it through.


I tried tinkering directly with "bzrlib" to make my own tool to
import/export information from/to Bazaar, but it is a tremendous PITA
(unstable API, bad documentation, exceptions thrown are not always easy
to understand).


I have been working on the bzr-fastimport bugs but I didn't receive any
feedback from maintainers. So I currently am wondering if I need to be
pushing for this tool to be fixed or if I should reimplement it.

Any help and/or support would be appreciated. I'll keep posting status
updates when I have new info or progress on the project.

-- 
Gabriel Filion
