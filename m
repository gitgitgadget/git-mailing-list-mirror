From: Luke Diamand <luke@diamand.org>
Subject: BUG: git-p4: can't add files with special chars
Date: Mon, 12 Dec 2011 20:48:10 +0000
Message-ID: <4EE6688A.2030105@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 21:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaCnK-00082X-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 21:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab1LLUsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 15:48:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48997 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1LLUsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 15:48:13 -0500
Received: by bkcjm19 with SMTP id jm19so1911002bkc.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 12:48:12 -0800 (PST)
Received: by 10.204.152.3 with SMTP id e3mr11341020bkw.70.1323722892535;
        Mon, 12 Dec 2011 12:48:12 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fa8sm34996960bkc.14.2011.12.12.12.48.11
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 12:48:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186946>

I just noticed this today. You can't add a file from git to perforce 
that contains a p4 special character (@,#,% or *).

There is code to cope going the other way round (p4 file with special 
character in it) but if you create a file in git and then try to git-p4 
submit, it fails.

I've just tried a quick and simple fix, and it turns out that it's not 
that easy as the special characters get expanded to %40, %2A and so-on. 
The % seems to get further expanded by python...

Luke
