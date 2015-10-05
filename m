From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 3/4] git-p4: Fix t9815 git-p4-submit-fail test case on
 OS X
Date: Mon, 5 Oct 2015 05:08:43 +0200
Message-ID: <5611E9BB.5070000@web.de>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
 <1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: luke@diamand.org
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 05:09:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ziw94-0004sa-8R
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 05:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbbJEDIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 23:08:54 -0400
Received: from mout.web.de ([212.227.17.12]:57839 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbJEDIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 23:08:53 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LqlSQ-1aEAMa45hq-00eLdK; Mon, 05 Oct 2015 05:08:51
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1443981977-64604-4-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:O+Ak0/O+vC6v3X1AH8quwQAqQJ0n/08G5igfBVXHIJLP7DyW5fv
 hqpY2/RLJdbdqvLQIGcGlrEf9IE5YvShaNaecw4TVTroq1S48EM05HGMRzPxn1jkGcEVjr2
 E00b9+i/tMaMI7iraUyf61FdsuyGOQzHIiiR6yPRE7vUiKRKtkQw+OUU5XegWYssA2WzLYN
 uxT6lkwG1exLxciCN8Ylg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PpOnGlRGFIk=:dvA52sAkpNx85HxkfPWdhf
 RNDbszb6ag3iuAAV5gfI0lwf+q31ALtIJgHXvmbl86ndqbmlyVdaEwn5z05skdvTGeu1NPGz2
 h0mMZPcC+mpS1QRMD2Br5FLqBojpQLzrI3xf+1COVI2LFd6TPeO8pgeheKvqaO82p35svPjbe
 RPPOwjNToP79D2mPYWJPF+QoO3JlifRNpWRDLql9MDE5shvM3armG1d8PdTxJKittMoY5rYba
 UWRgr/ifGhbl59VGT3M7a6MhdxfEuWtdedaQzdQT5C9ntGFJU2WQ02u/nmewNgcPIEG1Bux8N
 c6aSEI0qUhlaT61nZCaolkV8cyq5l6bPu86uUDwjec/WjYYmQDejyIgN+bDXpdh0IgvJlb9gt
 0J1nXNqyKGz3Goq0pOFZ/h649oiXRB9geOrDN30ufEaSXOiSFm7wgS34g5LIqxLZRARIwt9MH
 Tuj+4KjcoscTRlu8ImSI/+QXrR4Y5JHzFlXxBJnHS5sjCgaQl62jPQWDtYfYRKkr7cbInJkR3
 jNLDh3BbmoERW6vMVaNLoVsKKGcxaaNSbiRJCiLaemI6a2bjp6y9G7JZUj7MyW0OcnVoePGxr
 mngmWY09F1S9TdOY95RZzHwRhsUzkGe2pdlb+oNnvSWAmfdhHcbHcS0nD97g0pr9KTEfvofyN
 TJu23zuhyLCNJBIEY7EVEsQygHMGlrb0W1acoKN4nY7KEChwFnnN3QRBiz4GLpSotWGK8B4xx
 ZNqCs1MbmpQgTbR5oyBMnBvJB+gEH+Ai+yvNTl+JGSzxUk7G6OaJOFvq1xlGkoEZHOdXY8tM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279029>

On 04.10.15 20:06, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The stats command works differently on OS X compared to Linux. Detect
> OS X and execute the appropriate assertions.
> 
Is there a special need to use the stat() function at all ?

That's what I read in t1301-shared-repo.sh:

modebits () {
	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
}
