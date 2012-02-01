From: "Bryan O'Sullivan" <bryano@fb.com>
Subject: Re: logging disjoint sets of commits in a single command
Date: Wed, 1 Feb 2012 22:01:52 +0000
Message-ID: <CB4EF5E8.7A0%bryano@fb.com>
References: <20120201030300.GA9969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:02:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsiFu-0000Ik-N8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969Ab2BAWCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:02:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44869 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755019Ab2BAWCM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 17:02:12 -0500
Received: from pps.filterd (m0004060 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q11LwYgm013961;
	Wed, 1 Feb 2012 14:02:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : cc : subject :
 date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WJAVfsjhgT6T5UeNOuZT71WL3uaZOzUMJBP3c8bKIjk=;
 b=actGHz1qJzeixV7FWJZfUym0FSmi2A4s6gNJJFfZrjtxuV+OesLJycaEpfeFDyrgnFxS
 JL1DaTgEVKvH+bZ+rmLGOqd4Q3bWV8d0fJhL89JJdzMRzhPfueROwzpKNm6RGxls20db
 uaQbKDEuW5g6vmwIavCrUaIuBw/lfp239jI= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 12qbm18592-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 01 Feb 2012 14:02:06 -0800
Received: from SC-MBX02-4.TheFacebook.com ([fe80::e1f0:42de:c867:1385]) by
 sc-hub04.TheFacebook.com ([192.168.18.212]) with mapi id 14.01.0355.002; Wed,
 1 Feb 2012 14:01:53 -0800
Thread-Topic: logging disjoint sets of commits in a single command
Thread-Index: AQHM4Hal0o4/+qLyk0uC5cG4lN8eDZYnLqsAgACKbYCAAAPugP//fISAgACnqICAALgVAA==
In-Reply-To: <20120201030300.GA9969@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
Content-ID: <E3522580EE8936428C4B2A925F6EC3B7@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.260,0.0.0000
 definitions=2012-02-01_08:2012-02-01,2012-02-01,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189543>

On 2012-01-31 19:03 , "Jeff King" <peff@peff.net> wrote:
>
>That sounds kind of slow. Is your repository really gigantic?

Bigger than a kernel tree, but not as many commits. Beyond that, can't say.

> Have you packed
>everything?

Yep.

> I'm just curious if there's some other way to make things
>faster.

It would be nice if there was, but the fundamental problem is the lack of
an index from filename to commit. Walking every commit is the limiting
factor, I believe.

> Is the repository publicly available?

No, sorry.
