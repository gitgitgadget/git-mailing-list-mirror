From: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
Subject: [BUG] difference of info from diff and blame again
Date: Sun, 23 Jan 2011 13:33:58 +0300
Message-ID: <4D3C0416.7000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 23 11:34:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgxGi-0003uv-NK
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 11:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1AWKd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 05:33:56 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59355 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1AWKdz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 05:33:55 -0500
Received: by ewy5 with SMTP id 5so1514204ewy.19
        for <git@vger.kernel.org>; Sun, 23 Jan 2011 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=INtQWz+tQL05aDsBq1F36Bp0DToZdSWz8uKnHI6xCbI=;
        b=KieTwAN8oJWL1uRufPmbHcNgTamjEKayNsjLsU9Kx8u1YXwWc1spimZeN2x2qjtdM4
         ElXNkNzFMd37f/MACr6vOmoBWNSDWo4fg8WmjBM1QkzUxUO9zZPl1KUidRoQqCDCqR4q
         57sNglNfumj3oPyHHnMwu8ZXeb/5lXmKAOfxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=WO0Z1b0dLNaodfJK7PyQOVNpci+0qam/YHJoedM3MT6GrmAViKtYRf3bWDSv5wm/7E
         9xT/6PjkJdxFAV+qmlKfnAoR/4LE8o0aBbNiODgH2RBafEyLTo4BWNnL+9ZwrSt6VkRX
         n/TKaMUJwK77dKHMRemey7G1NGgYovmWFbSB8=
Received: by 10.213.17.147 with SMTP id s19mr2437606eba.89.1295778832770;
        Sun, 23 Jan 2011 02:33:52 -0800 (PST)
Received: from [46.147.35.91] ([46.147.35.91])
        by mx.google.com with ESMTPS id b52sm9145666eei.1.2011.01.23.02.33.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 23 Jan 2011 02:33:52 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165422>

Hi.

I have to repost about diff and blame difference problem.
The initial discussion ends here:
http://permalink.gmane.org/gmane.comp.version-control.git/165012

I have the same problem on git repo. The problem is some line is marked 
in diff as added, but in blame it is marked as added in some older 
revision. And vice versa line is not marked as added in diff but it is 
marked in blame. And now it's about non-whitespace lines. Here are 
several examples:

revision: 711cf3a026a539f68ab647e012f145a03e12a5e7
file: update-cache.c
line: 127

revision: 40469ee9c6a6f4c85df5520ef719bba3d38a64f0
file: sha1_file.c
line: 234

Diff error in revision 198b0fb635ed8a007bac0c16eab112c5e2c7995c in file 
date.c.
Line 184: added in diff, but blame say otherwise.
Line 215: added in diff, but blame say otherwise.
Line 219: added in diff, but blame say otherwise.
Line 259: added in diff, but blame say otherwise.
Line 260: added in diff, but blame say otherwise.
Line 193: not added in diff, but blame say otherwise.
Line 212: not added in diff, but blame say otherwise.
Line 222: not added in diff, but blame say otherwise.
Line 300: not added in diff, but blame say otherwise.
Line 315: not added in diff, but blame say otherwise.
