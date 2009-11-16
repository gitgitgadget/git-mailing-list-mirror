From: Liu Yubao <yubao.liu@gmail.com>
Subject: how to make gitk to use specified history information
Date: Mon, 16 Nov 2009 15:51:54 +0800
Message-ID: <4B01049A.5090402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 08:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9wMI-0006OC-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 08:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZKPHub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 02:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZKPHua
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 02:50:30 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:64001 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbZKPHua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 02:50:30 -0500
Received: by gxk26 with SMTP id 26so562431gxk.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 23:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=1y5EjrIWE2IJN5/uhBlGjEcZdWzesem8lgiFShUcM5Y=;
        b=UURI5KPMBJCFw61NUrdnEXajYAP4+XnlXuw5irCaKHuI2Rz0wNt91TKYPaAbCbv4mf
         hHRX5b+fRYL1lofmfQq/skEWaUFfdnoNFBqrJjL8qqLbpTi/s6sXt0b+0P1R01IYx0Q8
         06H3eYeFztQKtFxFuel2wMwbEw4O2ZO3NM9/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Biwvm7Rep5lJezzNBLhm/Q1tEHu7J0gK0nT+oUafArJ+PLLMvL4rP1lBGfUN3uZrpZ
         nNzDLWwUQ+bmKcmbiGdaGJHqsRiXFQUvrdJLsXn63GJizfUwrBaEwH69zYP/7/xU/M0M
         OQ7XG+p9Lsrr6kPKIkAzahhgQ3e8xzL0u63Lo=
Received: by 10.150.17.37 with SMTP id 37mr12920204ybq.285.1258357832866;
        Sun, 15 Nov 2009 23:50:32 -0800 (PST)
Received: from ?10.64.1.88? ([211.157.41.194])
        by mx.google.com with ESMTPS id 7sm139294ywc.21.2009.11.15.23.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 23:50:32 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132989>

Hi,

I want to obtain an outline of history information, for example:

  a - b - c - d - h -i -j
   \         /
    e- f - g

I simplify the graph like this:

  a - c - d - j
    \    /
      g

That's to say, I skip all commits that

  * have only one parent, and
  * have only one child, and
  * its child has only one parent

I checked `git help rev-list` but didn't find this feature, so I
write a little script[1] to parse output of `git rev-list --parents
--full-history --sparse --all` and get the simplified history:
j d
d c g
c a
g a

Now how can I make gitk to show this simpilified history? I have tried
GraphViz but the history information is still so large that GraphViz
crashes.


[1] http://jff.googlecode.com/svn/trunk/utils/git-branch-graph.pl

Best regards,

Liu Yubao
