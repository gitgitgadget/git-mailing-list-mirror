From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Big repository cannot be reduced
Date: Wed, 16 Jul 2014 08:52:10 -0700
Message-ID: <53C69FAA.10306@alum.mit.edu>
References: <a45d5548-b577-4588-92db-75339498034d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Woody Wu <woody.wu@vip.163.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 17:52:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7RVE-0003Lk-6H
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 17:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965523AbaGPPwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 11:52:16 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46908 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964915AbaGPPwN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2014 11:52:13 -0400
X-AuditID: 12074413-f79ed6d000002501-2f-53c69face4e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CE.22.09473.CAF96C35; Wed, 16 Jul 2014 11:52:12 -0400 (EDT)
Received: from [10.199.111.103] ([208.181.190.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s6GFqAAU009271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Jul 2014 11:52:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <a45d5548-b577-4588-92db-75339498034d@email.android.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1F0z/1iwwcQXBhZdV7qZLJ71Bzgw
	eXzeJOfxq/M+awBTFLdNUmJJWXBmep6+XQJ3xu6eM4wFb1krDpx6wdzA+JCli5GDQ0LARGJH
	D1MXIyeQKSZx4d56ti5GLg4hgcuMEhNuv2CBcDYxSRw91cAG0sAroClx4koASAOLgKrEgsd7
	GUFsNgFdiUU9zWCDRAWCJGZ/nscOYvMKCEqcnPkEbJeIgIXEliXcIGFhoPJDM3aygdhCAi4S
	307dZAGxOQVcJS6c7WaHOE1coqcxCMRkFlCXWD9PCKSCWUBeYvvbOcwTGAVmIZk/C6FqFpKq
	BYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCglN4B+Ouk3KHGAU4GJV4
	eBNajwULsSaWFVfmHmKU5GBSEuWN6wUK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGdNgsox5uS
	WFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4P04D6hRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhSf8cXACAVJ8QDtXQzSzltckJgLFIVoPcWoKCXOywKSEABJ
	ZJTmwY2FpZxXjOJAXwrzHgWp4gGmK7juV0CDmYAGl9ccBhlckoiQkmpgVMk7KSsVpqN55inv
	1uNBIrplGwRsw1sWH/5Zo7L1Q+SJWXlq7EsDN8Q/Y1gVw+16SS3niqhqRsB7W4E7i87935nC
	f/Gqyayl1sa5YZflqnfNPH1NRP9lgna50FuxEinzvCNLmdde/vap8MoUo/B/z17V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253669>

On 07/15/2014 09:43 AM, Woody Wu wrote:
> I have tried some methods introduced in the network, but always
> failed.  Some big files committed by me to a very old branch then the
> files deleted and new branches were continuously created. Now the
> checkout directory has grown to about 80 megabytes.  What's the right
> way to permenently erase those garbage big files?

You probably need to use "git filter-branch" or maybe BFG
(http://rtyley.github.io/bfg-repo-cleaner/) to rewrite history as if the
big files had never been committed.  But beware of the warnings about
rewriting history--for example, any collaborators will have to rebase
their branches onto the new history.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
