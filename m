From: Thomas Kieffer <ThomasKieffer@web.de>
Subject: Bug in shallow clone?
Date: Wed, 28 May 2014 16:02:03 +0200
Message-ID: <5385EC5B.8050400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 16:02:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpeQn-0007Kq-0M
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbaE1OCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:02:08 -0400
Received: from mout.web.de ([212.227.15.4]:49364 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaE1OCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:02:07 -0400
Received: from [10.179.5.214] ([138.246.2.184]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LiCXL-1WTmDH13Rb-00nQod for <git@vger.kernel.org>; Wed,
 28 May 2014 16:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Provags-ID: V03:K0:RKhEcNC7/AweaHad5c/oUTL1rlAP7w1a3zOXl1UmGMKlVpLnLah
 FaO84X30iC+eXq68BuutJ9uFIN/KImZay6XEbu3VrzREvBOurnTl37jpTPcnPPuKbzeWaWR
 nyiCi4iPl8ttzus9S38lH5N8DIFh7M4Gh3liTWsEuJvi1n45dOlpsH+HfFKe7YBVI87hr1A
 aA4OZtt11nE2bfhn0lNTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250281>

Hi there Git developers,

I'm not sure if I found a bug in the command

git clone repo.git cloned_repo --depth 1

I follow these steps:

git init
echo "First commit" >> test.txt
git add -A
git commit -am "First commit"

echo "Second commit" >> test.txt
git commit -am "Second commit"

echo "Third commit" >> test.txt
git commit -am "Third commit"

git clone --bare . ./bare.git

I then clone the bare repository with --depth 1.

git clone file:///path/to/bare.git ./clone --depth 1

It always returns the last two commits. If I specify --depth 2 it 
returns the last 3 commits.

If I use --depth 1 on a Github repository it works as expected.

Am I doing something wrong or is it really a bug?

Kind Regards,

Thomas Kieffer


BTW.: Git is amazing and I love it :)
