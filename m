From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 19 Feb 2015 19:40:50 +0000
Message-ID: <20150219194050.GA5021@vauxhall.crustytoothpaste.net>
References: <54BD3D14.90309@web.de>
 <20150122200702.GA96498@vauxhall.crustytoothpaste.net>
 <54C17429.1090403@web.de>
 <20150122234117.GD96498@vauxhall.crustytoothpaste.net>
 <xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com>
 <54E61285.5070600@web.de>
 <xmqq386123df.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 20:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOWy9-00011N-Gv
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 20:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbBSTk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 14:40:58 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49003 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131AbbBSTk5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 14:40:57 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e5aa:2c88:b0cf:ba1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ED3CB2808F;
	Thu, 19 Feb 2015 19:40:54 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
Content-Disposition: inline
In-Reply-To: <xmqq386123df.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264111>

On Thu, Feb 19, 2015 at 09:54:52AM -0800, Junio C Hamano wrote:
>I can see that you do not agree with the "If we accept it" part
>(where "it" refers to "allowing [...] was a bug.")---past acceptance
>was not a bug for you.
>
>Brian is for that "If we accept it", and sees it as a bug.
>
>So let's see what he comes up with as a follow-up to the "we should
>explicitly document it" part.

Here's what I propose:

-- >8 --
Subject: [PATCH] Documentation: note deprecated syntax for IPv6 SSH URLs

We have historically accepted some invalid syntax for SSH URLs
containing IPv6 literals.  Older versions of Git accepted URLs missing
the brackets required by RFC 2732.  Note that this behavior is
deprecated and that other protocol handlers will not accept this syntax.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/urls.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9ccb246..2c1a84f 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -38,6 +38,10 @@ The ssh and git protocols additionally support ~username expansion:
 - git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
 - {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
 
+For backwards compatibility reasons, Git, when using ssh URLs, accepts
+some URLs containing IPv6 literals that are missing the brackets. This
+syntax is deprecated, and other protocol handlers do not permit this.
+
 For local repositories, also supported by Git natively, the following
 syntaxes may be used:
 
-- 
2.2.1.209.g41e5f3a
