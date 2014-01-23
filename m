From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: WIth git-next, writing bitmaps fails when keep files are present
Date: Thu, 23 Jan 2014 12:36:32 -0800
Message-ID: <52E17D50.5030301@fb.com>
References: <52E080C1.4030402@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6R0x-0006tI-5o
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaAWUgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:36:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36516 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbaAWUge (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 15:36:34 -0500
Received: from pps.filterd (m0044012 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0NKLj6Q003694
	for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:36:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : subject : references : in-reply-to : content-type :
 content-transfer-encoding; s=facebook;
 bh=1tIw2ehn/krhJA3Jy/ePvwfudxt0Xmtw/2F9HsY+fmg=;
 b=QtKuhPzTLPcfsVpIkz2iZRHGIYUYP3eRaVSaRk++0nb59FU57h4ZRHkatrxbnfRGSVyC
 GQeM+TkNMQOGnx6iBnp45XWU0OqcQIMcm+KDyLvZW2gEN1NP5vewOXpsQWVySmcMyv2f
 l1SeOZu+FO1YWZyy37DMcGfpIPWMmT9ryVY= 
Received: from mail.thefacebook.com (prn1-cmdf-dc01-fw1-nat.corp.tfbnw.net [173.252.71.129] (may be forged))
	by mx0a-00082601.pphosted.com with ESMTP id 1hk5vfh0r4-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:36:34 -0800
Received: from [172.25.68.250] (192.168.57.29) by mail.thefacebook.com
 (192.168.16.22) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 23 Jan
 2014 12:36:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52E080C1.4030402@fb.com>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-23_05:2014-01-22,2014-01-23,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240948>

On 01/22/2014 06:38 PM, Siddharth Agarwal wrote:
> In our case we have .keep files lying around from ages ago (possibly 
> due to kill -9s run on the server). It also means that running repack 
> -a with bitmap writing enabled on a repo becomes problematic if a 
> fetch is run concurrently.

We briefly discussed locking our repos while the repack was run, but the 
repo that would benefit the most from repacks cannot be locked to pushes 
for even a tenth of the time that repack takes on it.
