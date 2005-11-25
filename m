From: Andreas Ericsson <ae@op5.se>
Subject: git-send-mail in sh
Date: Fri, 25 Nov 2005 10:45:41 +0100
Message-ID: <4386DD45.6030308@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020006090903090803060503"
X-From: git-owner@vger.kernel.org Fri Nov 25 10:49:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efa9V-0004dE-Qh
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 10:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVKYJpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 04:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVKYJpn
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 04:45:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:2973 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751414AbVKYJpn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 04:45:43 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 1A9C46BCBE
	for <git@vger.kernel.org>; Fri, 25 Nov 2005 10:45:42 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12730>

This is a multi-part message in MIME format.
--------------020006090903090803060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Finally giving up on git-send-email (I won't install the 6 perl-modules 
it requires and I don't know perl enough to remove the need for them), I 
hacked up a replacement in sh. It's more aptly named as well. ;)

It tries to be fairly newbie-friendly in what it accepts so that new 
developers on a project easily can submit patches upstream in the 
desired format.

This is just a draft. If anyone thinks it's a good idea then say so and 
I'll write the man-page and re-submit it as a proper patch.

It's better than the perl version because;
1. It doesn't have any requirements other than normal unix-commands and 
"mail" being in the path.
2. It can generate the patches on the fly, using git-format-patch.

It's worse than the perl version because;
1. It doesn't thread the patch-series (which I personally prefer anyway 
since it's easier to follow a thread on a particular patch that way).
2. The patches sent within the same second arrive in random order.

Sorry about the attachment btw. Thunderbird seems to wrap lines no 
matter what I tell it.

Thoughts? Comments?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------020006090903090803060503
Content-Type: application/x-shellscript;
 name="git-send-patch.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-send-patch.sh"

IyEvYmluL3NoCiMKIyBTdWJtaXQgYSBwYXRjaCB0byBhbnkgbnVtYmVyIG9mIGVtYWlsLWFk
ZHJlc3NlcywgYnV0IHdpdGhvdXQKIyB0aGUgY3VtYmVyc29tZSBkZXBlbmRlbmNpZXMgaW50
cm9kdWNlZCBieSB0aGUgZ2l0LXNlbmQtZW1haWwuCiMKIyBJbnN0ZWFkIG9mIGFwcGx5aW5n
IHRoZSA4OTQyIGNoYXJzIGxvbmcgUkZDLWV4YWN0IHJlZ2V4IHRvCiMgbWF0Y2ggcmVjaXBp
ZW50cyBlbWFpbCBhZGRyZXNzZXMgYWdhaW5zdCwgd2UncmUgc2F0aXNmaWVkIHdpdGgKIyBh
IHNpbXBsZSBAIHNvbWV3aGVyZSBpbnNpZGUgYW4gYXJndW1lbnQgYW5kIGp1c3QgYXNzdW1l
IHRoYXQKIyBwZW9wbGUgd29uJ3QgdHJ5IGFueXRoaW5nIG9idmlvdXNseSBzdHVwaWQKIwoK
ZnVuY3Rpb24gdXNhZ2UoKSB7CgllY2hvICJVc2FnZTogZ2l0IHN1Ym1pdCB1cHN0cmVhbUBl
bWFpbC5vcmcgPGNvbW1pdC1pc2g+IFs8Y29tbWl0LWlzaD5dIgoJZXhpdCAxCn0KCmZ1bmN0
aW9uIGFib3J0KCkgewoJZWNobyAiQWJvcnRpbmcuIgoJZXhpdCAwCn0KCmVtYWlsPSBjb20x
PSBjb20yPSBwYXRjaGVzPQp3aGlsZSBbICIkIyIgLWd0IDAgXTsgZG8KCWNhc2UgIiQxIiBp
bgoJKkAqKQoJCWVtYWlsPSIkZW1haWwgJDEiCgk7OwoJKikKCQlpZiBbIC1mICIkMSIgXTsg
dGhlbgoJCQlwYXRjaGVzPSIkcGF0Y2hlcyAkMSIKCQllbGlmIFsgIiRjb20xIiBdOyB0aGVu
CgkJCWNvbTI9IiQxIgoJCWVsc2UKCQkJY29tMT0iJDEiCgkJZmkKCTs7Cgllc2FjCglzaGlm
dApkb25lCgpjb21taXRzPTAKaWYgWyAiJGNvbTEiIF07IHRoZW4KCWlmIFsgLXogIiRjb20y
IiBdOyB0aGVuCgkJY29tMj0iJGNvbTEiCgkJY29tMT1IRUFECglmaQoKCWNvbW1pdHM9JChn
aXQgcmV2LWxpc3QgJGNvbTEgXiRjb20yIHwgd2MgLWwpCmZpCgpbICRjb21taXRzIC1lcSAw
IC1hIC16ICIkcGF0Y2hlcyIgXSAmJiB1c2FnZQojIFsgIiRlbWFpbCIgXSB8fCBnaXQgcmVw
by1jb25maWcgLS1nZXQgcGF0Y2hfZW1haWxfYWRkcmVzcwpbICIkZW1haWwiIF0gfHwgdXNh
Z2UKClsgJGNvbW1pdHMgLWd0IDEgXSAmJiBvcHRzPS1uCgpmb3IgcGF0Y2ggaW4gJChnaXQg
Zm9ybWF0LXBhdGNoICRvcHRzICRjb20yICRjb20xIHwgc2VkICdzL14qIC8vJyk7IGRvCglw
YXRjaGVzPSIkcGF0Y2hlcyAkcGF0Y2giCmRvbmUKCmVjaG8gIlNlbmRpbmcgdGhlIGZvbGxv
d2luZyBwYXRjaGVzOiIKc2VkIC1zbiAnMXMvXlN1YmplY3Q6IC8vcCcgJHBhdGNoZXMKZWNo
bwplY2hvIC1uICJUbyB0aGVzZSBuaWNlIHBlb3BsZTogIgplY2hvICIkZW1haWwiIHwgc2Vk
IC1lICdzL14gLy8nIC1lICdzLyAvLCAvZycKZWNobwplY2hvICJQcmVzcyBlbnRlciB0byBj
b250aW51ZSwgY3RybC1jIHRvIGFib3J0LiIKcmVhZAoKZm9yIHAgaW4gJHBhdGNoZXM7IGRv
CglzdWJqZWN0PSQoc2VkIC1uICcxcy9eU3ViamVjdDogLy9wJyAkcCkKCWVjaG8gIlNlbmRp
bmcgJHN1YmplY3QiCglzZWQgMWQgJHAgfCBtYWlsIC1zICIkc3ViamVjdCIgJGVtYWlsIHx8
IGFib3J0CmRvbmUK
--------------020006090903090803060503--
