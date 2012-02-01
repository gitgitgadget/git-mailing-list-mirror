From: "Bryan O'Sullivan" <bryano@fb.com>
Subject: logging disjoint sets of commits in a single command
Date: Wed, 1 Feb 2012 00:15:46 +0000
Message-ID: <CB4DC432.72D%bryano@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:16:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsNrs-0006FD-1w
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab2BAAQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 19:16:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41825 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755533Ab2BAAQB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 19:16:01 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.4/8.14.4) with SMTP id q1109bG7006445
	for <git@vger.kernel.org>; Tue, 31 Jan 2012 16:15:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=from : to : subject : date
 : message-id : content-type : content-id : content-transfer-encoding :
 mime-version; s=facebook; bh=zNCLkiQzNymkS292l7ChSwCcNxI1+56mB9ZffUnE1bQ=;
 b=ptsg3g+JbNHm/+L5scSQipLuZou4himATyVTShgPqNXnaIVOxUgqlgxGKrQzyMBsJA2f
 FyDvxR9QuauOVFfK4uypwLcb5GhkGkmYfx2dkib8m7+XJ56GlJhrZ3mvVc9cbgq65unc
 IkiAi2yOneEkoDzKLfF4aGKdEZBEDUM58N4= 
Received: from mail.thefacebook.com (corpout1.snc1.tfbnw.net [66.220.144.38])
	by mx0b-00082601.pphosted.com with ESMTP id 12pqu5071v-3
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 31 Jan 2012 16:15:58 -0800
Received: from SC-MBX02-4.TheFacebook.com ([fe80::e1f0:42de:c867:1385]) by
 sc-hub03.TheFacebook.com ([192.168.18.198]) with mapi id 14.01.0355.002; Tue,
 31 Jan 2012 16:15:47 -0800
Thread-Topic: logging disjoint sets of commits in a single command
Thread-Index: AQHM4Hal0o4/+qLyk0uC5cG4lN8eDQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.18.252]
Content-ID: <65953389672F87448191C8474BA759BC@fb.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-31_09:2012-01-31,2012-01-31,1970-01-01 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189484>

I'm trying to use "git log" to display only a handful of commits, where
the commits are not necessarily linearly related to each other.
