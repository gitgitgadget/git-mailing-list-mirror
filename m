From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Why doesn't git rebase --interactive --preserve-merges continue past known conflicts?
Date: Fri, 31 Dec 2010 11:30:46 -0800 (PST)
Message-ID: <282560.39741.qm@web30004.mail.mud.yahoo.com>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-276465443-1293823846=:39741"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 31 20:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYkgh-0006Bw-4K
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 20:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab0LaTat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 14:30:49 -0500
Received: from web30004.mail.mud.yahoo.com ([209.191.69.21]:26298 "HELO
	web30004.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753216Ab0LaTat (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Dec 2010 14:30:49 -0500
Received: (qmail 47830 invoked by uid 60001); 31 Dec 2010 19:30:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1293823846; bh=pcI+cx8FpC5oNesNrcR3rFXf58uLeL7GoKZYPpi+0H8=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=kQ/EjKREq+Hey3cty+SU0zxrU4KZmBmmJVAioqjpxVPTTdMchbC/8RENZ37g8Dfx8NQeQzedAzS6Ouj+O1SMgNP4KVO4/JqjLgba60xBMdk6+etlLoTPNieQr0vw4MWZ4jG7TCswq2/wWcRQzqTZQD92EEA4sLDihrRxU6GVxKg=
X-YMail-OSG: .dHn6aUVM1kbarLx5U4FpkWuHJT.XxSatxn5EAg0NVnjM_.
 BG0kSusCRYPiAw.hMhbUItVGslOOoWEQrXAggrCt0KWpzq0pW8o_.KcSYIv0
 jACgv5skRsx6PYO0hSiEbVvnE0tRReff8SJxxszSB89ln5boLKXJ3xhJ5Chu
 iDLT5eDVZOUiHUUBJ_.Z1Sz.J9fQKSjciNEshy6U9qzASms9ep6BXpceenlf
 GZL9Wwxb7Zdp5s4uWd6k7BsweEhDm8nnSJh_5Kv5gm2yGR5_J3BOfBdaj9GD
 jgXhasEXi2roYgkrjFTqIxj5vQBGLLhwlfMFwpl2ABsk5hNn0xFv95vCfXDx
 do1k76DjStRiGBh68qstE4znt.VhM_bzdxAROpp39JdKtzukY_jTx3uz4dDD
 oiXY-
Received: from [17.202.32.26] by web30004.mail.mud.yahoo.com via HTTP; Fri, 31 Dec 2010 11:30:46 PST
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/553 YahooMailWebService/0.8.107.285259
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164395>

--0-276465443-1293823846=:39741
Content-Type: text/plain; charset=us-ascii

When I run "git rebase --interactive --preserve-merges" on a sequence of 
commits, edit an earlier commit, then run "git rebase --continue", the rebase 
operation always stops on a merge commit with a known conflict (in the rr-cache) 
instead of resolving it and continuing.

As long as I'm not rearranging commits, I expect git-rebase to resolve the known 
merge commit conflict and continue.  Why does it always stop?

I've attached a simple test case that demonstrates this behavior.

Dave

--0-276465443-1293823846=:39741
Content-Type: application/x-sh; name="t3404-rebase-interactive-preserve-merges.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="t3404-rebase-interactive-preserve-merges.sh"

IyEvYmluL3NoCiMKIyBDb3B5cmlnaHQgKGMpIDIwMDcgSm9oYW5uZXMgRS4g
U2NoaW5kZWxpbgojIENvcHlyaWdodCAoYykgMjAxMCBEYXZpZCBELiBLaWx6
ZXIKIwoKdGVzdF9kZXNjcmlwdGlvbj0nZ2l0IHJlYmFzZSAtLWludGVyYWN0
aXZlIC0tcHJlc2VydmUtbWF0Y2hlcyBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5
IHJlc29sdmUga25vd24gY29uZmxpY3RzIGluIG1lcmdlIGNvbW1pdHMnCi4g
Li90ZXN0LWxpYi5zaAoKLiAiJFRFU1RfRElSRUNUT1JZIi9saWItcmViYXNl
LnNoCgpzZXRfZmFrZV9lZGl0b3IKCnRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3Jl
YmFzZSBmYWlscycgJwoJZ2l0IGNvbmZpZyByZXJlcmUuZW5hYmxlZCAxICYm
Cgl0ZXN0X2NvbW1pdCBBIGZpbGUxICYmCgl0ZXN0X2NvbW1pdCBCIGZpbGUx
ICYmCglnaXQgY2hlY2tvdXQgLWIgdG9waWMgSEVBRF4gJiYKCXRlc3RfY29t
bWl0IEMgZmlsZTEgJiYKCWdpdCBjaGVja291dCBtYXN0ZXIgJiYKCXRlc3Rf
bXVzdF9mYWlsIGdpdCBtZXJnZSB0b3BpYyAmJgoJZWNobyBEID4gZmlsZTEg
JiYKCWdpdCBhZGQgZmlsZTEgJiYKCWdpdCBjb21taXQgLW0gIk1lcmdlZC4i
ICYmCglGQUtFX0xJTkVTPSJlZGl0IDEgMiIgZ2l0IHJlYmFzZSAtaSAtcCBI
RUFEfjIgJiYKCWVjaG8gQUEgPiBmaWxlMiAmJgoJZ2l0IGFkZCBmaWxlMiAm
JgoJZ2l0IGNvbW1pdCAtLWFtZW5kICYmCglnaXQgcmViYXNlIC0tY29udGlu
dWUKJwoKdGVzdF9kb25lCg==

--0-276465443-1293823846=:39741--
