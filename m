From: "Crabtree, Andrew" <andrew.crabtree@hp.com>
Subject: Plumbing version of 'git branch --contains' ?
Date: Wed, 22 Oct 2014 20:19:07 +0000
Message-ID: <B82B660D4887C042850326C2BC65FE035D58B11E@G9W0757.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:20:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh2OM-0003lF-W0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 22:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbaJVUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 16:20:19 -0400
Received: from g4t3426.houston.hp.com ([15.201.208.54]:7797 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbaJVUUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 16:20:18 -0400
Received: from G9W0364.americas.hpqcorp.net (g9w0364.houston.hp.com [16.216.193.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3426.houston.hp.com (Postfix) with ESMTPS id 6381171
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 20:20:17 +0000 (UTC)
Received: from G9W3613.americas.hpqcorp.net (16.216.186.48) by
 G9W0364.americas.hpqcorp.net (16.216.193.45) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Wed, 22 Oct 2014 20:19:07 +0000
Received: from G9W0757.americas.hpqcorp.net ([169.254.5.107]) by
 G9W3613.americas.hpqcorp.net ([16.216.186.48]) with mapi id 14.03.0169.001;
 Wed, 22 Oct 2014 20:19:07 +0000
Thread-Topic: Plumbing version of 'git branch --contains' ? 
Thread-Index: Ac/uNIk5DO1yqv7DQa6EOOdb+kxJKw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.216.65.175]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I need to get a list of refs that can reach a certain SHA in in a script.

git branch --contains SHA 

would be great (runs in ~2 seconds), but not my preferred option for scripting.

I tried
 
for br in $(git for-each-ref --format='%(refname:short)' refs/heads/)
do
    git merge-base --is-ancestor $1 ${br}
    if [ $? -eq 0 ]
    then
            echo "${br}"
    fi
done

Which gives me perfect output, but takes 82 seconds to run in my environment.  

Is there an alternative I'm missing to give me the run time performance of 'git branch --contains' but with stable output suitable for parsing?

Thanks in advance,
-Andrew  
