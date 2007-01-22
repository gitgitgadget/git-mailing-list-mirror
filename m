From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Force Activestate Perl to tie git command pipe handle to a handle class
Date: Mon, 22 Jan 2007 15:42:26 +0100
Message-ID: <81b0412b0701220642u2aecc782m295a9b2a06a3611b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_154937_5321891.1169476946129"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 15:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90NX-0002We-EW
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 15:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXAVOm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 09:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXAVOm3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 09:42:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:22569 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbXAVOm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 09:42:28 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1334039nfa
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 06:42:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=uZ0z6yZCv5BOSYs+d0kyPTwpxRy06XApDP+HwMO5re6SstipXwRTxtuckGwISvcJ2b5j4myyXLMWRAKnTm7qjG8z5W3tYOuID36rFrQwLRCVvi3CyzjD8m54SEDCmdxDwsBtFQaFi/FPTKtDA32K+e0ubE3ENaurOxAxG/XuYvU=
Received: by 10.82.167.5 with SMTP id p5mr6846459bue.1169476946376;
        Mon, 22 Jan 2007 06:42:26 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 06:42:26 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37412>

------=_Part_154937_5321891.1169476946129
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise it tries to tie it to a scalar and complains about missing
method. Dunno why, may be ActiveState brokenness again.
---

Now git-remote.perl compiles and does something. If you are careful
and not forget to fill GITPERLLIB with cygwin path, of course.

 perl/Git.pm |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

------=_Part_154937_5321891.1169476946129
Content-Type: application/xxxxx; name="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.patch"
X-Attachment-Id: f_ex90elhl

RnJvbSAwN2ViODhlYjY3YjFhYzZhOTZhN2ExMzY0NGFiZjNmY2E0MjgxMTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE1OjI1OjQxICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRm9yY2Ug
QWN0aXZlc3RhdGUgUGVybCB0byB0aWUgZ2l0IGNvbW1hbmQgcGlwZSBoYW5kbGUgdG8gYSBoYW5k
bGUgY2xhc3MKCk90aGVyd2lzZSBpdCB0cmllcyB0byB0aWUgaXQgdG8gYSBzY2FsYXIgYW5kIGNv
bXBsYWlucyBhYm91dCBtaXNzaW5nCm1ldGhvZC4gRHVubm8gd2h5LCBtYXkgYmUgQWN0aXZlU3Rh
dGUgYnJva2VubmVzcyBhZ2Fpbi4KLS0tCiBwZXJsL0dpdC5wbSB8ICAgIDMgKystCiAxIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9w
ZXJsL0dpdC5wbSBiL3BlcmwvR2l0LnBtCmluZGV4IDU4NDE0ZTMuLjNiMzJhMjggMTAwNjQ0Ci0t
LSBhL3BlcmwvR2l0LnBtCisrKyBiL3BlcmwvR2l0LnBtCkBAIC03NDIsNyArNzQyLDggQEAgc3Vi
IF9jb21tYW5kX2NvbW1vbl9waXBlIHsKIAkJIwl3YXJuICdpZ25vcmluZyBTVERFUlIgb3B0aW9u
IC0gcnVubmluZyB3LyBBY3RpdmVTdGF0ZSc7CiAJCSRkaXJlY3Rpb24gZXEgJy18JyBvcgogCQkJ
ZGllICdpbnB1dCBwaXBlIGZvciBBY3RpdmVTdGF0ZSBub3QgaW1wbGVtZW50ZWQnOwotCQl0aWUg
KCRmaCwgJ0dpdDo6YWN0aXZlc3RhdGVfcGlwZScsICRjbWQsIEBhcmdzKTsKKwkJdGllICgqQUNQ
SVBFLCAnR2l0OjphY3RpdmVzdGF0ZV9waXBlJywgJGNtZCwgQGFyZ3MpOworCQkkZmggPSAqQUNQ
SVBFOwogCiAJfSBlbHNlIHsKIAkJbXkgJHBpZCA9IG9wZW4oJGZoLCAkZGlyZWN0aW9uKTsKLS0g
CjEuNS4wLnJjMi5nM2YxYQoK
------=_Part_154937_5321891.1169476946129--
