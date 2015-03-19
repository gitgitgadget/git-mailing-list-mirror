From: Sundararajan R <dyoucme@gmail.com>
Subject: [GSoC Project Help] Unifying git branch -l, git tag -l and git for-each-ref
Date: Thu, 19 Mar 2015 11:22:19 +0000 (UTC)
Message-ID: <loom.20150319T121328-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 12:23:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYYXS-0001yn-3i
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 12:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbbCSLWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 07:22:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:49743 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbbCSLWw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 07:22:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YYYX8-0001la-I7
	for git@vger.kernel.org; Thu, 19 Mar 2015 12:22:42 +0100
Received: from 202.3.77.220 ([202.3.77.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 12:22:38 +0100
Received: from dyoucme by 202.3.77.220 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 12:22:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.3.77.220 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 *  2.6 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  2.8 BASE64_LENGTH_79_INF BODY: BASE64_LENGTH_79_INF
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265798>

SGkgYWxsLAoKSSBhbSBhIENvbXB1dGVyIFNjaWVuY2Ugc29waG9tb3JlIGF0IElJVCBLYW5wdXIuIEkgYW0gaW50ZXJlc3RlZCBpbiAKY29udHJpYnV0aW5nIHRvIGdpdCBpbiBHU29DIDIwMTUuIEkgaGF2ZSBiZWVuIHVzaW5nIGdpdCBmb3IgdGhlIHBhc3Qgb25lIHllYXIgCmFuZCBhbSBwcmV0dHkgY29tZm9ydGFibGUgd2l0aCBpdHMgY29tbWFuZHMgd2hpY2ggaXMgd2hhdCBtYWRlIG1lIHRoaW5rIGFib3V0IApjb250cmlidXRpbmcgdG8gZ2l0LiBJIGhhdmUgYXR0ZW1wdGVkIHRoZSBtaWNyb3Byb2plY3Qg4oCcYWRkaW5nIOKAmC3igJkgYXMgYSAKc2hvcnRoYW5kIHRvIEB7LTF9IGluIHRoZSByZXNldCBjb21tYW5k4oCdIFsxXSBbMl0gZnJvbSB3aGljaCBJIGxlYXJudCBhYm91dCAKaG93IGNvZGUgaXMgcmV2aWV3ZWQgaW4gdGhlIGNvbW11bml0eSBhbmQgaG93IGEgc2VlbWluZ2x5IHNtYWxsIGNoYW5nZSBjYW4gCmVuZCB1cCBiZWluZyBtdWNoIG1vcmUgZGlmZmljdWx0LiBCdXQgdGhlIHRoaW5nIEkgbGlrZWQgdGhlIG1vc3QgaXMgdGhlIHdhcm0gCmFuZCB3ZWxjb21pbmcgYXR0aXR1ZGUgb2YgZXZlcnlvbmUgaW4gdGhlIGNvbW11bml0eSB0
 b3dhcmRzIGEgbmV3Y29tZXIgbGlrZSAKbWUuIEkgd2lzaCB0byB0YWtlIHVwIHRoZSBwcm9qZWN0IGlkZWEg4oCcVW5pZnlpbmcgZ2l0IGJyYW5jaCAtbCwgZ2l0IHRhZyAtbCAKYW5kIGdpdCBmb3ItZWFjaC1yZWbigJ0uIEkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgcmVhZGluZyBhbmQgdW5kZXJzdGFuZGluZyB0aGUgCmNvZGVzIG9mIHRoZXNlIHRocmVlIGNvbW1hbmRzIGFuZCBmaWd1cmluZyBvdXQgc2ltaWxhcml0aWVzIGFuZCBkaWZmZXJlbmNlcyAKaW4gdGhlbS4gSSBoYXZlIGdvbmUgdGhyb3VnaCBzb21lIG9mIHRoZSBkaXNjdXNzaW9ucyByZWdhcmRpbmcgdGhpcyBvbiB0aGUgCmFyY2hpdmUgYW5kIGhhdmUgYWxzbyByZWFkIEp1bmlv4oCZcyByZXBseSB0byBBbWF0ZSBZb2xhbmRlIFszXSwgYnV0IEkgaGF2ZW7igJl0IApiZWVuIGFibGUgdG8gZmluZCBwYXRjaGVzIHdoaWNoIGF0dGVtcHQgdG8gdW5pZnkgdGhlIHNlbGVjdGlvbiBwcm9jZXNzIGFzIAptZW50aW9uZWQgaW4gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBpZGVhLiBJdCB3b3VsZCBiZSBncmVhdCBpZiBzb21lb25lIGNvdWxkIApwb2ludCBtZSB0b3dhcmRzIHRoZXNlIHBhdGNoZX
 Mgd2hpY2ggd291bGQgaGVscCBtZSB3aGVuIEkgc3RhcnQgZGVzaWduaW5nIHRoZSAKZGV0YWlscyBvZiB0aGUgdW5pZmllZCBpbXBsZW1lbnRhdGlvbi4gVGhhbmtzIGEgbG90IGZvciB5b3VyIHRpbWUuCgpSZWdhcmRzLApSIFN1bmRhcmFyYWphbi4gCgpbMV0gOiBodHRwOi8vbWFyYy5pbmZvLz9sPWdpdCZtPTE0MjY2Njc0MDQxNTgxNiZ3PTIKWzJdIDogaHR0cDovL21hcmMuaW5mby8/bD1naXQmbT0xNDI2NjY3NzMzMTU4OTkmdz0yClszXSA6IGh0dHA6Ly9hcnRpY2xlLmdtYW5lLm9yZy9nbWFuZS5jb21wLnZlcnNpb24tY29udHJvbC5naXQvMjY0OTY2
