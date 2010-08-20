From: Richard MICHAEL <rmichael@leadformance.com>
Subject: git-filter-branch : LANG / LC_ALL = C breaks UTF-8 author names
Date: Fri, 20 Aug 2010 15:20:09 +0200
Message-ID: <4C6E8109.5030202@leadformance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 15:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRc0-0002qi-Gv
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab0HTN0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:26:07 -0400
Received: from office01.leadformance.com ([88.191.95.206]:55161 "EHLO
	office01.leadformance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab0HTN0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:26:05 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2010 09:26:05 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by office01.leadformance.com (Postfix) with ESMTP id 040EA4E001
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 15:20:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at leadformance.com
Received: from office01.leadformance.com ([127.0.0.1])
	by localhost (office01.leadformance.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BiFFVz5LS8gx for <git@vger.kernel.org>;
	Fri, 20 Aug 2010 15:20:10 +0200 (CEST)
Received: from aluminum.local (lns-bzn-51f-62-147-243-253.adsl.proxad.net [62.147.243.253])
	by office01.leadformance.com (Postfix) with ESMTPSA id 6151819BA2CE
	for <git@vger.kernel.org>; Fri, 20 Aug 2010 15:20:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2pre Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154033>

  Hello all,

I am filtering our repo with git-filter-branch, but as the sed script 
runs with LANG=C LC_ALL=C (7 bit US ASCII), it dies on commits authored 
by our team members with accented names. Why are the locales "C"?  For 
compatibility with older sed?  I've changed to LANG=en_US.UTF-8, will my 
change will cause other git-breakage?


git-filter-branch

95: LANG=C LC_ALL=C sed -ne "$pick_id_script"

95: LANG=en_US.UTF-8 sed -ne "$pick_id_script"


Regards,
Richard
