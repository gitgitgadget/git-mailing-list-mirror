From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such
 ref: ''" for branches without an upstream
Date: Thu, 16 Jan 2014 18:47:38 -0800
Message-ID: <52D899CA.5050409@fb.com>
References: <52D8827E.3060007@fb.com> <20140117022152.GB12444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zTS-0004np-PB
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaAQCr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:47:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46299 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751557AbaAQCry (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 21:47:54 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0H2lpAZ016949;
	Thu, 16 Jan 2014 18:47:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=s/AEXu6RP9HP0O46oGLrL0kxKPhkP6VQsbwsFVDD2Es=;
 b=FAK8zuFm16PR3gafwSAKM+KfAAzxHGn0AexkloZbqGWiqNCyzirawuNjxB/S0VxMlsAO
 TAqPAHwtFUmKgj3unmSA7fQRGO/ot2QWPsi3/AGhmGncT3bpTZgtqDaOZjW/fDvAYu8y
 DZOPhbtTwNWhPvlXQF+eUAS/jKW4cGF0qnU= 
Received: from mail.thefacebook.com (prn1-cmdf-dc01-fw1-nat.corp.tfbnw.net [173.252.71.129] (may be forged))
	by mx0b-00082601.pphosted.com with ESMTP id 1heqq7s2ry-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 16 Jan 2014 18:47:51 -0800
Received: from [172.25.68.250] (192.168.16.4) by mail.thefacebook.com
 (192.168.16.22) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 16 Jan
 2014 18:47:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117022152.GB12444@sigill.intra.peff.net>
X-Originating-IP: [192.168.16.4]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-17_01:2014-01-16,2014-01-17,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240567>

On 01/16/2014 06:21 PM, Jeff King wrote:
> On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:
>
>> With git-next, where git pull --rebase can print out "fatal: No such
>> ref: ''" if git pull --rebase is run on branches without an upstream.
> This is already fixed in bb3f458 (rebase: fix fork-point with zero
> arguments, 2014-01-09), I think.

If I'm reading the patch correctly, that only fixes it for git rebase, 
not for git pull --rebase. git-pull.sh contains a separate invocation of 
git merge-base --fork-point.
