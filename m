From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Mon, 03 Feb 2014 21:21:10 +0100
Message-ID: <52EFFA36.8090305@web.de>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>	<52EEA5D3.9000502@web.de> <CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAQ1C-00078S-DV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbaBCUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:21:18 -0500
Received: from mout.web.de ([212.227.17.12]:49302 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbaBCUVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:21:17 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MJCR8-1W7erJ2sLi-002maI for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 21:21:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>
X-Provags-ID: V03:K0:WyybEq6WRhxSXzC+xYaTONZQqlN+qLBZJrgJQ/ahvipF29GaEU6
 4xxXh6O7I61YEKJr6+E4cY5S02hwoTaPV81DmMplAAEmBGzFiXYAxL2QqFwJTxFZcXqkac3
 KSfNCcHzRQcX163dUJdyYN5scC5MmLWSDiosoh4C66QBaxsxd+BGYOvDlL1UHXuLrJZ/RZ1
 HwecR1h7SXREC5X8iS5EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241473>

[]
> So to summarize, when fast-import uses strncmp_icase (what fast-import does now) import on a repository where ignorecase=true is wrong.  My patch, "fast-import.c: always honor the filename case" fixes this.  Can you verify?
>
> Thanks in advance,
> Reuben
>
Yes, I can verify. My feeling is that
a) the fast-export should generate the rename the other way around.
   Would that be feasable ?
   Or generate a real rename ?
  (I'm not using fast-export or import myself)

b)  As a workaround, does it help if you manually set core.ignorecase false ?

c)  Does it help to use git-hg-remote ? (could be another workaround)

And no,  50906e04e8f48215b0 does not include any test cases.
(try git show 50906e04e8)

This is only a short answer, I can prepare a longer answer about ignorecase the next days.
/Torsten
