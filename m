From: Pascal Obry <pascal@obry.net>
Subject: git-reflog infinite loop
Date: Tue, 10 Jun 2008 19:44:50 +0200
Organization: Home - http://www.obry.net
Message-ID: <484EBD92.8040603@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67us-0003NC-Ix
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbYFJRo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYFJRo7
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:44:59 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:20690 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYFJRo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:44:58 -0400
Received: by gv-out-0910.google.com with SMTP id e6so648121gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:44:57 -0700 (PDT)
Received: by 10.103.168.20 with SMTP id v20mr3563650muo.0.1213119895907;
        Tue, 10 Jun 2008 10:44:55 -0700 (PDT)
Received: from ?192.168.0.100? ( [90.35.55.221])
        by mx.google.com with ESMTPS id y37sm20345815mug.9.2008.06.10.10.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:44:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84531>


In one of my repository, "git gc" will never terminate.

I have traced to the underlying call git-reflog:

    $ git-reflog expire --all

It seems to heat a good amount of heap memory and will keep running 
using 100% of CPU.

Is that a known issue?

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
