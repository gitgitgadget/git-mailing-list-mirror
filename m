From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 01/13] refs: convert some internal functions to use
 object_id
Date: Tue, 13 Oct 2015 13:43:30 +0200
Message-ID: <561CEE62.4030403@alum.mit.edu>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net> <1444355039-186351-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 13:43:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlxzV-0000Mq-UY
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 13:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbbJMLne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 07:43:34 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61535 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559AbbJMLnd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 07:43:33 -0400
X-AuditID: 12074413-f79bd6d000007ac2-b3-561cee64c62c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A0.81.31426.46EEC165; Tue, 13 Oct 2015 07:43:32 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9DBhUUv027419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 07:43:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444355039-186351-2-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqJvyTibM4MtJFYuuK91MFt1T3jJa
	/GjpYbZom/mDyYHFY/nNv0weO2fdZfd41ruH0ePzJrkAlihum6TEkrLgzPQ8fbsE7oz3Vy6x
	FNxhr3hweTd7A+MSti5GTg4JAROJjnOzoGwxiQv31oPZQgKXGSUWbcjsYuQCss8ySdxZNIsZ
	JMEroC0xq3c+mM0ioCrx7tESJhCbTUBXYlFPM5gtKhAksWL5C0aIekGJkzOfsIDYIgJeEvMf
	zWAFsZkFqiX+XfsKtkxYIEzi2NlHUIv7GSUO90WA2JwCfhIXbywBmsMBVK8usX6eEESrvETz
	1tnMExgFZiHZMAuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcx
	QoJZeAfjrpNyhxgFOBiVeHhfRMqECbEmlhVX5h5ilORgUhLldbsKFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCm9QClONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDu
	fAPUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K0vhiYJyCpHiA9t4BaectLkjM
	BYpCtJ5i1OVY8OP2WiYhlrz8vFQpcd7FIEUCIEUZpXlwK2Cp6xWjONDHwrzGb4GqeIBpD27S
	K6AlTEBLjNilQJaUJCKkpBoY1zw4+k3n96zjq9oCPdNDS73jY7ikPY8ck59jaDa5Mj1D0PP8
	HM0Nxusa0mvZfh61qXf2Ct+waZ/n0pJvGkXr9mtzzni7l3v5jEt5Ph7vvd5/Cfb5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279497>

On 10/09/2015 03:43 AM, brian m. carlson wrote:
> Convert several internal functions in refs.c to use struct object_id,
> and use the GIT_SHA1_HEXSZ constants in parse_ref_line.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> [...]

I looked over this patch at the diff level and didn't find any problems.

This patch conflicts heavily with [1]. But I noticed that it is
independent of the rest of your series. I don't know when either patch
series will be ready, but see [2] for my take on the other one.

Assuming neither series is rejected, I think it would be much easier to
redo this patch on top of the first part of [1] than vice versa, so that
would be my suggestion. If it comes down to that, I am willing to help
redo this patch if you like.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/279423
[2] http://article.gmane.org/gmane.comp.version-control.git/279496

-- 
Michael Haggerty
mhagger@alum.mit.edu
