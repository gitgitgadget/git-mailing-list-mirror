From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 7/8] reflog_expire(): never update a reference to null_sha1
Date: Thu, 12 Feb 2015 12:51:02 +0100
Message-ID: <54DC93A6.7080003@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-8-git-send-email-mhagger@alum.mit.edu> <CAPig+cTksvo2A9nazpeg=BThOSPv7DsJ6hz51h=U_yvSNBGn5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLsPf-0000Oz-1H
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbbBLL6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:58:16 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48844 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752691AbbBLL6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:58:16 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2015 06:58:16 EST
X-AuditID: 1207440c-f79376d00000680a-63-54dc93a89eaf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 19.4D.26634.8A39CD45; Thu, 12 Feb 2015 06:51:04 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBp27r004588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAPig+cTksvo2A9nazpeg=BThOSPv7DsJ6hz51h=U_yvSNBGn5A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqLty8p0Qg3PaFl1XupksGnqvMFu8
	vbmE0aJ7yltGi96+T6wWmze3s1icedPI6MDusXPWXXaPBZtKPS5eUvZY/MDL4/MmuQDWKG6b
	pMSSsuDM9Dx9uwTujKcf9zMX9DBX7N6zlb2BcRtTFyMnh4SAicSLx2dZIGwxiQv31rN1MXJx
	CAlcZpRoetcJ5Zxnklh5eCMrSBWvgLbEmSsLwLpZBFQltp3dB2azCehKLOppBrNFBYIkDp1+
	zAJRLyhxcuYTMFsEqPfDhk2MIEOZBZYxSfxau5q9i5GDQ1jAX+LVTxuIZQcYJV6duMgI0sAp
	ECix6tAtsMXMAuoSf+ZdYoaw5SW2v53DPIFRYBaSHbOQlM1CUraAkXkVo1xiTmmubm5iZk5x
	arJucXJiXl5qka6hXm5miV5qSukmRkjQ8+xg/LZO5hCjAAejEg9vgPGdECHWxLLiytxDjJIc
	TEqivFytQCG+pPyUyozE4oz4otKc1OJDjBIczEoivL5NQDnelMTKqtSifJiUNAeLkjiv6hJ1
	PyGB9MSS1OzU1ILUIpisDAeHkgSvADC6hQSLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktL
	MuJB0RpfDIxXkBQP0N73k0D2Fhck5gJFIVpPMepyLGjfP5NJiCUvPy9VSpyXF2SHAEhRRmke
	3ApYinvFKA70sTCvNMgoHmB6hJv0CmgJE9CSiTNugywpSURISTUw5mi9Ur3EIz9ronOHpn2d
	fdwexZBm13+qnC8iI8/e+Mrdu3z+9mfdnurnnYqvPJbcox1/7Wd2xpE/J0sOa/mV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263730>

On 02/09/2015 09:55 PM, Eric Sunshine wrote:
> On Mon, Feb 9, 2015 at 4:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> But we don't want the repository in an invalid state even temporarily,
>> and we don't want leave an invalid state if other callers of "git
> 
> s/want/want to/
> [...]

Thanks; will fix.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
