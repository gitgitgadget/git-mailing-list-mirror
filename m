From: Karthik Nayak <karthik.188@gmail.com>
Subject: [GSoC] Week 1: Unification of 'for-each-ref', 'tag -l' and 'branch
 -l'
Date: Tue, 02 Jun 2015 22:08:57 +0530
Message-ID: <556DDC21.5050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:39:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzpDd-0000Sn-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 18:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbbFBQjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 12:39:04 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36248 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbbFBQjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 12:39:03 -0400
Received: by pdjm12 with SMTP id m12so53563489pdj.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=UYvo4mC8lpoj07m4DAdr4F7t0oho3dPSwhhpNZS0W8I=;
        b=KHiewtJC8Dvqj+AbmbpSnwurnr+1wqcEEEEIIpBv0WUgAKdwnZI7ZhsfeDFc+EyrkN
         iFG67Qf492lC/Fz8B14x/KWye3edCjX2eJxz4+6yefGawgPOwMOUfaUxD0xVkKxR/NDC
         3Vg1cVLEyxnt9ekjzrpvKa8wvLcI5zG5z9wZJT8Gn8v8mwCEEGlnd8r1UUbz8SmFcpzX
         WGGDAuA8l/Ia/OXnSHuy6I7iGySKVyg4YKJJYllucUbVLR0PLl32ZCohLHIVEI2DRfvR
         H9iEermG8bCNLfmLnyUIUuw18c1gF9owSJ+Rzd4vuaGtgrUINgtrqvjdY6puTziQ2TnQ
         TKtA==
X-Received: by 10.66.102.65 with SMTP id fm1mr50826037pab.25.1433263142972;
        Tue, 02 Jun 2015 09:39:02 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ae9sm18398020pac.25.2015.06.02.09.39.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 09:39:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270562>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'. I will update the list on my weekly progress in an effort
to keep everyone updated.

Current Progress:
Currently I have been working on moving all code from 'for-each-ref' to an
independent library called 'ref-filter' which would serve as a common 
library
for the unification process. 'for-each-ref' supports printing the commits
in a specified format and also various sorting optins. This would serve as a
good base for porting over these options for 'tag -l' and 'branch -l'.
I have sent v4 of my patch to the list and it can be found here:
http://article.gmane.org/gmane.comp.version-control.git/270293
I have been working on this after suggested changes, will post the next
version soon.

Work In progress:
You can follow my current progress on Github:
https://github.com/KarthikNayak/git
For now I got the '--points-at' option (prints only refs pointing to given
commit) and also '--merged' option (prints only refs whose heads are 
reachable
from the given commit). These shall be forwarded to the list soon.

What to do next:
Implement '--contains' option, but the problem to be faced here is that both
'tag -l' and 'branch -l' have different implementations of the '--contains'
options.  Matthieu Moy suggested that I work on the unification of these 
commands
let both the implementations stay where the user can select the 
implementation
to be used and that I may work on unification of these two algorithms after
the main objective of GSoC is met.

Any suggestion/changes are welcome.

-- 
Regards,
Karthik
