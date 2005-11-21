From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Make grafts versionable
Date: Mon, 21 Nov 2005 13:04:20 -0800
Message-ID: <43823654.2060904@zytor.com>
References: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeIqT-0005Px-4T
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKUVE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKUVE6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:04:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6297 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750702AbVKUVE5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:04:57 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALL4QOO030217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 13:04:27 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12482>

Johannes Schindelin wrote:
> ... by moving the location from .git/info/grafts to .gitgrafts. This 
> allows checking it in like .gitignore, and sure enough also pulling it (as 
> well as knowing who the heck added that particular graft anyway).

This is problematic, because it means something that isn't in GIT_DIR 
affects its interpretation.  I would say that that is a showstopper.

One could even argue that it's incorrect, since it would mean different 
points on the history have different grafts.

Now, CVS has a reserved namespace (CVSROOT/) for things under version 
control which are still significant to CVS.  The logical equivalent to 
git would be to have .git/ be such a namespace, if it makes sense.

	-hpa
