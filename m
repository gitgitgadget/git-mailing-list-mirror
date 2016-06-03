From: Julien Cretin <git@ia0.eu>
Subject: git check-ignore returns included files
Date: Fri, 3 Jun 2016 14:48:52 +0000 (UTC)
Message-ID: <loom.20160603T164532-641@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 16:55:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8qVK-000160-C3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbcFCOzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 10:55:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:59993 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbcFCOzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 10:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b8qV5-0000sn-Iq
	for git@vger.kernel.org; Fri, 03 Jun 2016 16:55:03 +0200
Received: from LFbn-1-801-11.w86-246.abo.wanadoo.fr ([86.246.37.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 16:55:03 +0200
Received: from git by LFbn-1-801-11.w86-246.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 16:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.246.37.11 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/50.0.2661.102 Chrome/50.0.2661.102 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296333>

SGVsbG8sCgpJcyBpdCBleHBlY3RlZCBmb3IgY2hlY2staWdub3JlIHRvIG91dHB1dCBpbmNsdWRlZCBmaWxlcyAodXNpbmcgYSAiISIKcHJlZml4KT8KClN0ZXBzIHRvIHJlcHJvZHVjZToKCiAgICBnaXQgaW5pdCBmb28KICAgIGNkIGZvbwogICAgdG91Y2ggYmFyCiAgICBlY2hvICcvYmFyXG4hL2JhcicgPiAuZ2l0aWdub3JlCiAgICBnaXQgYWRkIGJhciAuZ2l0aWdub3JlCiAgICBnaXQgY29tbWl0IC1tYmFyCiAgICBnaXQgY2hlY2staWdub3JlIC0tdmVyYm9zZSAtLW5vLWluZGV4IGJhcgoKQWN0dWFsIGJlaGF2aW9yOgoKICAgIC5naXRpZ25vcmU6MjohL2JhcgliYXIKCmV4aXQgY29kZSA9IDAKCkV4cGVjdGVkIGJlaGF2aW9yOgoKbm8gb3V0cHV0CgpleGl0IGNvZGUgPSAxCgpJIHRlc3RlZCB3aXRoIHRoZSBuZXh0IGJyYW5jaCwgd2hpY2ggaXMgY3VycmVudGx5IGF0CjhhMTkxZTE4N2E5ZGNhM2Q3ODZjMDE5N2Y5NjEwZTYyN2I0ZjQxMzcuCgpUaGUgbWFuIHBhZ2Ugb2YgY2hlY2staWdub3JlIHNheXM6CsKrIEZvciBlYWNoIHBhdGhuYW1lIFsuLi5dLCBjaGVjayB3aGV0aGVyIHRoZSBmaWxlIGlzIGV4Y2x1ZGVkIGJ5Ci5naXRpZ25vcmUgWy4u
 Ll0gYW5kIG91dHB1dCB0aGUgcGF0aCBpZiBpdCBpcyBleGNsdWRlZC4gwrsKYW5kOgrCqyBJZiB0aGUgcGF0dGVybiBjb250YWluZWQgYSAhIHByZWZpeCBvciAvIHN1ZmZpeCwgaXQgd2lsbCBiZQpwcmVzZXJ2ZWQgaW4gdGhlIG91dHB1dC4gwrsKClRoZSBtYW4gcGFnZSBvZiBnaXRpZ25vcmUgc2F5czoKwqsgQW4gb3B0aW9uYWwgcHJlZml4ICIhIiB3aGljaCBuZWdhdGVzIHRoZSBwYXR0ZXJuOyBhbnkgbWF0Y2hpbmcgZmlsZQpleGNsdWRlZCBieSBhIHByZXZpb3VzIHBhdHRlcm4gd2lsbCBiZWNvbWUgaW5jbHVkZWQgYWdhaW4uIMK7CgpJIGFtIG5vdCBzdXJlIGhvdyBJIHNob3VsZCB1bmRlcnN0YW5kIHRoaXMgc2l0dWF0aW9uLgoKQmVzdCByZWdhcmRzLApKdWxpZW4=
