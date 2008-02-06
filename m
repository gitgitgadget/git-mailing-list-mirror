From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: command prompt script for current branch
Date: Wed, 6 Feb 2008 14:52:56 -0500
Message-ID: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13922_26751174.1202327576428"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 20:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqKx-0004f5-0l
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbYBFTxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbYBFTw7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:52:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:25446 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbYBFTw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:52:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2013087rvb.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=0YblPDzYRc7fY4UN3S4pNftB//8JiXVgUIOI92mWDwA=;
        b=ZoC+xfS/qswxCVrdq2EMFkZXyfkNvL/wF3sF+Sh77qXz7ahW2jzX7TLo7/euR3LaHraZL7VAE7mvuAwpyuITRAqME0ziGvl2RCw3tXOipyB3+MojoqGc252b4i0wJxeJJTG2K/tg4WJc8g1r3WcOgukBjCLV4d548+muuISSVUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=aoRJ7NY5GJUYxBQVh2fEeQdDiVHT/m58XeQM6o4KahM8Xhy6qnpdfVGM4nLP0T2KO9+qfacESaLlREWT/DHQLYNJUH52iThkVRFMNcAF/zmbzuYDIZhN7xfrT0AxEcqF1BP30VOKzG+vrbCv+OSh6ysXIdVsnZi2sD2TOLvf73w=
Received: by 10.140.171.4 with SMTP id t4mr6925788rve.187.1202327576445;
        Wed, 06 Feb 2008 11:52:56 -0800 (PST)
Received: by 10.140.173.7 with HTTP; Wed, 6 Feb 2008 11:52:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72836>

------=_Part_13922_26751174.1202327576428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Attached is a script I quickly wrote up yesterday.  Sometimes I've
found I started working only to realize I was on the wrong branch.
(Now that I'm accustomed to working with git, I make many small
branches, so it happens.)

So I made this small script to simply write the name of the currently
checked out branch, as well as information on how many commits it
differs from the remote tracking branch, if any.
It also appends an exclamation mark if I have uncommitted changes.  I
stuck it in my PS1 environment variable, so that it would be part of
my command prompt.

I tried to choose git commands that would be relatively quick, since
this will be run for every single command prompt.  If I've chosen
suboptimal ways of doing this, please let me know.  There's a few too
many 'grep' and 'sed' commands for my liking, so maybe there is a way
to get the same information more directly instead of parsing git
command output.  Anyways, if it's of general interest, I'd be happy to
make a patch for /contrib.

For my tiny git repos, this seems to have pretty much no negative
impact on my work flow.  When I cd'd to my git.git clone there was
about a 1/2-second delay the first time, but subsequent command
prompts incurred no visible delay.  I've no idea how fast it would be
for something as big as the kernel, for example.

Steve

------=_Part_13922_26751174.1202327576428
Content-Type: application/x-sh; name=curgitbranch.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fccapdf30
Content-Disposition: attachment; filename=curgitbranch.sh

IyEvYmluL2Jhc2gKCiMgVGhpcyBzY3JpcHQgc3BpdHMgb3V0IHRoZSBjdXJyZW50IGJyYW5jaCBh
bmQgaXRzIHJlbGF0aW9uc2hpcCB0byBpdHMKIyByZW1vdGUgdHJhY2tpbmcgYnJhbmNoLCBpZiBh
bnkuICBJdCBhbHNvIHJlcG9ydHMgKHVzaW5nIGFuCiMgZXhjbGFtYXRpb24gbWFyaykgd2hldGhl
ciBvciBub3QgdGhlIGN1cnJlbnQgYnJhbmNoIGlzIGRpcnR5CiMgKHVuY29tbWl0dGVkKS4gIEkg
dXNlIGl0IGluIG15IFBTMSBlbnZpcm9ubWVudCB2YXJpYWJsZSwgc28gdGhhdCBhbnkKIyB0aW1l
IEkgY2QgaW50byBhIGdpdC10cmFja2VkIHByb2plY3QsIEkgaW1tZWRpYXRlbHkga25vdyB3aGlj
aAojIGJyYW5jaCBpcyBjaGVja2VkIG91dCBhbmQgd2hldGhlciBpdCBpcyB1cCB0byBkYXRlIHdp
dGggdGhlIHJlbW90ZQojIHRyYWNraW5nIGJyYW5jaC4KIwojIEZvciBleGFtcGxlLCBteSAuYmFz
aHJjIGZpbGUgaGFzIHRoZSBmb2xsb3dpbmcgbGluZToKIyBQUzE9JyR7ZGViaWFuX2Nocm9vdDor
KCRkZWJpYW5fY2hyb290KX1cblxbXDAzM1swMTszMm1cXVx1QFxoXFtcMDMzWzAwbVxdOidcCiMg
J1xbXDAzM1swMTszNG1cXVx3XFtcMDMzWzAwOzMzbVxdJChjdXJnaXRicmFuY2guc2gpXFtcMDMz
WzAwbVxdXG5cJCAnCiMKIyBJZiBpdCB0YWtlcyB0b28gbXVjaCByb29tIGluIHlvdXIgdGVybWlu
YWwsIGZlZWwgZnJlZSB0byBpZ25vcmUKIyBpbmZvcm1hdGlvbiBhYm91dCByZW1vdGUgdHJhY2tp
bmcgYnJhbmNoZXMsIGFzIGRlc2NyaWJlZCBiZWxvdy4gIFlvdQojIGNhbiBvdGhlcndpc2UgY3Vz
dG9taXplIHRoaXMgc2NyaXB0IHRvIHJlbW92ZSAiZ2l0IHJldi1saXN0IiBjYWxscwojIGZvciBl
eGFtcGxlLCBpZiB5b3UgYXJlIGNvbmNlcm5lZCBhYm91dCBzcGVlZC4KCiMgZXhpdCBpZiBub3Qg
YSBnaXQgcmVwbwppZiAhIChnaXQgYnJhbmNoID4vZGV2L251bGwgMj4mMSk7IHRoZW4KICAgIGV4
aXQKZmkKCkJSQU5DSD0kKGdpdCBicmFuY2ggfCBncmVwIFwqIHwgc2VkIHMsXCpcICwsICkKUkVN
T1RFPSQoZ2l0IGNvbmZpZyAtLWxpc3QgfCBncmVwIGJyYW5jaC4kQlJBTkNILnJlbW90ZSAyPi9k
ZXYvbnVsbCB8IGN1dCAtZjIgLWQ9KQpNRVJHRT0kKGdpdCBjb25maWcgLS1saXN0IHwgZ3JlcCBi
cmFuY2guJEJSQU5DSC5tZXJnZSAyPi9kZXYvbnVsbCB8IHNlZCBzLF4uKj1yZWZzL2hlYWRzLyws
KQoKIyBleGl0IGlmIG5vIGJyYW5jaCBmb3VuZAppZiBbICIke0JSQU5DSH0ieCA9PSB4IF07IHRo
ZW4KICAgIGV4aXQKZmkKCmVjaG8gLW4gJyAnWyRCUkFOQ0gKCiMgZGlydHkgc3RhdGUKaWYgWyAi
JChnaXQtZGlmZi1pbmRleCAtLW5hbWUtb25seSBIRUFEKSJ4ICE9IHggXTsgdGhlbgogICAgZWNo
byAtbiBcIQpmaQoKIyBleGl0IGlmIG5vIHJlbW90ZSB0cmFja2luZyBicmFuY2ggZm91bmQKaWYg
WyAke1JFTU9URX14ID09IHggLWEgJHtNRVJHRX14ID09IHggXTsgdGhlbgogICAgZWNobyBdCiAg
ICBleGl0CmZpCgojIFVuY29tbWVudCB0aGlzIGxpbmUgdG8gaWdub3JlIHJlbW90ZSB0cmFja2lu
ZyBicmFuY2hlcwojIGVjaG8gXTsgZXhpdAoKIyBjYWxjIG51bWJlciBvZiByZXZzIGJldHdlZW4g
cmVtb3RlIGFuZCBsb2NhbApGV0RSRVZTPSQoZ2l0IHJldi1saXN0ICRSRU1PVEUvJE1FUkdFLi4k
QlJBTkNIIDI+L2Rldi9udWxsIDI+JjEgfCB3YyAtbCkKCiMgYW5kIHRoZSBvdGhlciB3YXksIGlu
IGNhc2UgaXQgaXMgbm90IHVwIHRvIGRhdGUKQkFDS1JFVlM9JChnaXQgcmV2LWxpc3QgJEJSQU5D
SC4uJFJFTU9URS8kTUVSR0UgMj4vZGV2L251bGwgMj4mMSB8IHdjIC1sKQoKZWNobyAtbiAnICct
XD4gJFJFTU9URS8kTUVSR0UKCmlmIFsgJEZXRFJFVlMgLWd0IDAgXTsgdGhlbgogICAgZWNobyAt
biArJEZXRFJFVlMKZmkKCmlmIFsgJEJBQ0tSRVZTIC1ndCAwIF07IHRoZW4KICAgIGVjaG8gLW4g
LSRCQUNLUkVWUwpmaQoKZWNobyBdCg==
------=_Part_13922_26751174.1202327576428--
