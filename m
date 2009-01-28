From: Alec Clews <alec.clews@gmail.com>
Subject: How to install and use a custom merge driver
Date: Wed, 28 Jan 2009 14:10:18 +1100
Message-ID: <497FCC9A.9080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 04:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0qG-0005GH-Eu
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZA1DK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbZA1DK1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:10:27 -0500
Received: from rn-out-0910.google.com ([64.233.170.184]:11080 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbZA1DK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:10:27 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2403219rnd.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 19:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=IBusZh6TmaklbsENl0NPJ4fqP/OVtmPC4Vv7Q7ARkLM=;
        b=h66nWNdctCABwXWW9iMYeUFAY6f5qnIvf5G0q4YUz4rl1Zw/mtsSPnh0S9BhiSeTyS
         JQtp/MusIGQRJAJiSje6lybDExrlQVXezLbxCKTp7D0s69WrDoG7UHOAyrbJBcq3lQyI
         rZ+2gnk7SrcWuOq3fMxGHJrmkRTli5hv7ZZ0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=lDRFqVpm+2plRYyGdppjHuLClhURs9uv0u7vbKXmy/P/gU7eaCpttuqsQBRKdR10rS
         r9KyugOMMmtayLoyAzMUZR+4CYfAzdZBw497cL30mcrvEcUT+79dYqFww9Pe2kHZXQWP
         S0xLijzEQm1Zjf2ez5eJ+abL7yyYdZVsOCKj4=
Received: by 10.231.19.198 with SMTP id c6mr107798ibb.46.1233112225109;
        Tue, 27 Jan 2009 19:10:25 -0800 (PST)
Received: from ?120.16.235.97? ([120.16.235.97])
        by mx.google.com with ESMTPS id s27sm235524qbs.31.2009.01.27.19.10.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 19:10:24 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107459>

Background:

I want to use git to track the delivery of patch files into existing 
file trees. This means that new files will need to be copied over 
existing files (especially in the case of binary files or textual conflicts)

To this end I want to use a custom merge driver (actually the cp command)

Setup:

I have set up my ..git/info/gitattributes as follows

*      merge=overwrite

I have defined in .git/config

[merge "overwrite"]
    name = overwrite using cp
    driver = cp %B %A

Problem:

However when I perform a git merge the default merge is being called. Is 
there something else needed to make git perform the copy operation?


Many thanks

-- 
Alec Clews
Personal <alec.clews@gmail.com>			Melbourne, Australia.
Jabber:  alecclews@jabber.org.au		PGPKey ID: 0x9BBBFC7C
Blog  http://alecthegeek.wordpress.com/
