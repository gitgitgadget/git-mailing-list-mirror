From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Pass amend to pre-commit hook
Date: Sun, 27 Sep 2015 22:09:02 +0000 (UTC)
Message-ID: <loom.20150928T000850-141@post.gmane.org>
References: <55F6BA1C.7080507@teamwpc.co.uk> <20150914144727.GA25003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 00:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgK8f-0002Qr-74
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 00:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbbI0WJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 18:09:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:58466 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbbI0WJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 18:09:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZgK89-0001Yn-NW
	for git@vger.kernel.org; Mon, 28 Sep 2015 00:09:13 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 00:09:13 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 00:09:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 *  2.6 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  2.8 BASE64_LENGTH_79_INF BODY: BASE64_LENGTH_79_INF
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278711>

SmVmZiBLaW5nIDxwZWZmIDxhdD4gcGVmZi5uZXQ+IHdyaXRlczoKCj4gCj4gT24gTW9uLCBTZXAgMTQsIDIwMTUgYXQgMDE6MTQ6MjBQTSArMDEwMCwgQWxhbiBDbHVjYXMgd3JvdGU6Cj4gCj4gPiBQYXNzIGEgc2luZ2xlIHBhcmFtZXRlciAnYW1lbmQnIHRvIHRoZSBwcmUtY29tbWl0IGhvb2sgd2hlbiBwZXJmb3JtaW5nIGEKPiA+IGNvbW1pdCBhbWVuZC4KPiAKPiBJIHRoaW5rIHRoaXMgaXMgYSBzZW5zaWJsZSB0aGluZyB0byB3YW50LCBhbmQgaXQgaGFzIGNvbWUgdXAgYSBmZXcKPiB0aW1lcy4gSSdtIG5vdCBzdXJlIHdoeSB0aGUgbGFzdCByb3VuZCBkaWRuJ3QgZ2V0IG1lcmdlZCwgdGhvdWdoLiBMb29rcwo+IGxpa2UgaXQganVzdCBzbGlwcGVkIHRocm91Z2ggdGhlIGNyYWNrcy4KPiAKPiBIZXJlIGFyZSB0aGUgcmVsZXZhbnQgdGhyZWFkczoKPiAKPiAgIGh0dHA6Ly90aHJlYWQuZ21hbmUub3JnL2dtYW5lLmNvbXAudmVyc2lvbi1jb250cm9sLmdpdC8yNjAxMjIKPiAKPiAgIGh0dHA6Ly90aHJlYWQuZ21hbmUub3JnL2dtYW5lLmNvbXAudmVyc2lvbi1jb250cm9sLmdpdC8yNjAyNDUKPiAKPiBMb29rcyBsaWtlIHRoZXJlIHdhcyBzb21lIHF1
 ZXN0aW9uIG9mIHdoYXQgdG8gcGFzcyBpbiB0aGUgbm9ybWFsLAo+IG5vbi1hbWVuZCBjYXNlLiBJJ3ZlIGFkZGVkIGludGVyZXN0ZWQgcGFydGllcyBmcm9tIHRoZSBvcmlnaW5hbCB0aHJlYWQKPiB0byB0aGUgY2MgaGVyZS4KPiAKPiAtUGVmZgo+IAoKVGhlcmUgd2VyZSBzbyBtYW55IGRpZmZlcmVudCB3YXlzIG9mIHNvbHZpbmcgdGhlbSB0aGF0IHdlIHdlcmVuJ3QgYWJsZQp0byBkZWNpZGUgYmV0d2VlbiB0aGVtOgoKQXNzdW1pbmcgd2UgZ2l2ZSB0aGUgc3RyaW5nICJhbWVuZCIgYXMgdGhlIGhvb2sncyBhcmd2WzFdLCB3aGF0IHRvIGRvCndoZW4gLS1hbWVuZCBpcyBub3QgdXNlZD8gV2UgY2FuIHBhc3Mgbm90aGluZywgb3IgdGhlIGVtcHR5IHN0cmluZywgb3IKdGhlIHN0cmluZyAibm9hbWVuZCIuIFRoZW4gdGhlcmUgd2FzIHRoZSBzdWdnZXN0aW9uIG9mIGV4cG9ydGluZwpHSVRfQU1FTkQ9MSBvciBzb21ldGhpbmcgbGlrZSB0aGF0LiBJbiBhbnkgY2FzZSwgd2hhdCB0byBkbyB3aGVuIHdlIHdhbnQKdG8gcGFzcyBtb3JlIGFyZ3VtZW50cz8gU2hvdWxkIHdlIGxldCB0aGUgaG9vayBjaGVjayBhcmd2WzFdIHRvIGRlY2lkZQp3aGV0aGVyIC
 0tYW1lbmQgd2FzIHVzZWQsIGFyZ3ZbMl0gdG8gY2hlY2sgd2hldGhlciB7c29tZSBzY2VuYXJpbyBoZXJlfQppcyB0aGUgY2FzZT8gT3IgbWFrZSB0aGUgaG9vayBhdXRob3IgZWZmZWN0aXZlbHkgaW1wbGVtZW50IG9wdGlvbnMKcGFyc2luZz8KCkFuZCB0aGVuIGl0IGRpZWQgb3V0Li4uCgpJbiBteSB0b3RhbGx5IHVucHJvZmVzc2lvbmFsIG9waW5pb24gYW55dGhpbmcgbW9yZSBjb21wbGV4IHRoYW4gbWF5YmUKcGFzc2luZyAiYW1lbmQiIGluIGFyZ3ZbMV0gaXMgdW53YXJyYW50ZWQuIFNpbmNlIEkgcG9zdGVkIG15IGZpcnN0IHBhdGNoCmFsbW9zdCBhIHllYXIgYWdvIHRoZXJlIGhhcyBiZWVuIG5vIGRpc2N1c3Npb24gcmVnYXJkaW5nIHBhc3Npbmcgb3RoZXIKaW5mb3JtYXRpb24gYWxvbmcgdG8gcHJlLWNvbW1pdC4gRnVydGhlcm1vcmUgLS1hbWVuZCBpcyB0aGUgb25seSB0aGluZyBJCmtub3cgb2YgdGhhdCBhIHByZS1jb21taXQgaG9vayBjYW5ub3QgZGlzY292ZXIgb24gaXRzIG93bi4gT24gdGhlIG90aGVyCmhhbmQgdGhlIGRlc2lyZSBmb3IgdGhpcyBoYXMgcG9wcGVkIHVwIGF0IGxlYXN0IHR3aWNlIG9uICNnaXQgaW4gdGhlCnNhbWUg
 dGltZSBzcGFuLgoKQWxhbiBDbHVjYXMnIHNvbHV0aW9uIGxvb2tzIGZpbmUgdG8gbWUuIEl0IGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIGFzCm1pbmUuIEJ1dCBtaW5lIGhhZCB0ZXN0cyBhbmQgd2hhdG5vdCA7LSkKCsOYc3NlCgo=
