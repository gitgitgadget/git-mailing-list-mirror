From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] checkout,clone: check return value of create_symref
Date: Tue, 12 Jan 2016 05:09:07 +0100
Message-ID: <56947C63.8000507@alum.mit.edu>
References: <20160111154651.GA25338@sigill.intra.peff.net>
 <20160111154935.GA22778@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 05:16:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIqNZ-0003wh-4O
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 05:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760963AbcALEQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 23:16:17 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43443 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758771AbcALEQQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2016 23:16:16 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2016 23:16:16 EST
X-AuditID: 1207440d-f79136d00000402c-0f-56947c66f507
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 85.B9.16428.66C74965; Mon, 11 Jan 2016 23:09:10 -0500 (EST)
Received: from [192.168.69.130] (p4FC97D56.dip0.t-ipconnect.de [79.201.125.86])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u0C498wU015693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 Jan 2016 23:09:09 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <20160111154935.GA22778@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqJtWMyXM4Mg1TYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3BktS9oYC9ZzV/RNesHWwPiW
	o4uRk0NCwETi+539zBC2mMSFe+vZuhi5OIQELjNK7Pj4CMo5zySxetpFJpAqYQEfiR3b5rOB
	2CICRhI3PnwDs4UEsiUmXu0As5kF1CTaN01hBbHZBHQlFvU0M0FskJPo7Z7EAmLzCmhL/P9+
	lRHEZhFQldi36DxYjahAiMT7r89ZIWoEJU7OfAJWzylgLXGvoRdqvrrEn3mXmCFseYnmrbOZ
	JzAKzkLSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQ1
	7w7G/+tkDjEKcDAq8fAe4JwSJsSaWFZcmXuIUZKDSUmUtzkGKMSXlJ9SmZFYnBFfVJqTWnyI
	UYKDWUmE1ykIKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuB9UwXU
	KFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K4fhiYBSDpHiA9rJUg+wtLkjMBYpC
	tJ5iVJQS550PkhAASWSU5sGNhaWqV4ziQF8K864D2c4DTHNw3a+ABjMBDbaImwwyuCQRISXV
	wKg/LcP74erg6+deKivlBk7au74mJPto7sGrEo7MHu+FnnudM3FljPHp7J6XHjv5u9jSLpe/
	bmlTE+b72n7deDO1IbbWyvik33ffmcfWr/Vfeanps2LhxaOfee2CJpbZPXx6/tb1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283765>

On 01/11/2016 04:49 PM, Jeff King wrote:
> It's unlikely that we would fail to create or update a
> symbolic ref (especially HEAD), but if we do, we should
> notice and complain. Note that there's no need to give more
> details in our error message; create_symref will already
> have done so.
> 
> While we're here, let's also fix a minor memory leak in
> clone.
> 
> Signed-off-by: Jeff King <peff@peff.net>

LGTM.

> ---
> This patch could go to maint. I don't know if it's worth the trouble. I
> was unable to figure out a way to trigger this reliably (hence no
> tests). The two ways I considered were:
> 
>   - "chmod -w .git", but it results in a die() already
> 
>   - the bug I'm fixing in 2/2; but we don't want to rely on that in our
>     test suite, since I'm about to fix it. :-/

A locking conflict is an easy way to trigger this error:

$ git --version
git version 2.7.0.rc2.31.g396da8f
$ git branch foo
$ touch .git/HEAD.lock
$ git checkout foo
error: Unable to create '/home/mhagger/tmp/brokhead/.git/HEAD.lock':
File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
Switched to branch 'foo'
$ echo $?
0

After this patch, the above "checkout" command fails with retcode=128.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
