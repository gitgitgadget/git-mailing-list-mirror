From: Franz Schrober <franzschrober@yahoo.de>
Subject: Possible diff regression in v1.7.6-473-g27af01d
Date: Mon, 24 Oct 2011 10:23:47 +0100 (BST)
Message-ID: <1319448227.70497.YahooMailNeo@web29402.mail.ird.yahoo.com>
Reply-To: Franz Schrober <franzschrober@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="921974003-1989850134-1319448227=:70497"
Cc: "marat@slonopotamus.org" <marat@slonopotamus.org>,
	"rctay89@gmail.com" <rctay89@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"franzschrober@yahoo.de" <franzschrober@yahoo.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 24 11:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIGl8-0003S4-Lt
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 11:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab1JXJXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 05:23:49 -0400
Received: from nm3-vm0.bullet.mail.ird.yahoo.com ([77.238.189.213]:38381 "HELO
	nm3-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753833Ab1JXJXt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 05:23:49 -0400
Received: from [77.238.189.53] by nm3.bullet.mail.ird.yahoo.com with NNFMP; 24 Oct 2011 09:23:47 -0000
Received: from [212.82.108.121] by tm6.bullet.mail.ird.yahoo.com with NNFMP; 24 Oct 2011 09:23:47 -0000
Received: from [127.0.0.1] by omp1030.mail.ird.yahoo.com with NNFMP; 24 Oct 2011 09:23:47 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 644499.79768.bm@omp1030.mail.ird.yahoo.com
Received: (qmail 71306 invoked by uid 60001); 24 Oct 2011 09:23:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1319448227; bh=GT2rK+lBEECvLvRE0Fgj1e6d4CIfuhkMcCwO5GGUQac=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type; b=VBPABMw3DeRw6Bx1hAUVaj/qtDBVTBVKu8iJPHJLD5nnZPEA4VofsHREF4Nm2JfLcBCtHnR6/M9iJxlL4HuMKRlm4X33vt6/RGANUmmG7EOBbUlalFhgohf114A5U1AMFBJFqThPs5tOxf9PnR2b/1hXrfv2bNfRBroARsKndXQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=W5QUiHHtKoUvfDgIFd1CcE0TkA710VOyXq655wrjUkHot1vHynUuEVkUm1o+2M+xScF+yiTDUVkAnEGXf460MgoVSytYA4L3qLbIptO5hEpgvrAMyArA8HlRx5mnlwvOmHxCmjzOgHE6m0YL5pq5aHYTJsDvY+U3/g+Ei6hu6gA=;
X-YMail-OSG: kJOsrRcVM1nHZnUSWFIpInyl0aAbVKgSlZt2odZUdK_g7K4
 aWLpjDltylj9YeIXDfdCTnZ9lW2wDp.w6vJLMrZRr60OY0zT65u1ae5U8n6X
 7aBKc1zvjjTwgY0YLYL0pDD1mv4dNJUt2Rlw4ib4TzQVULxw1wnTpoqCmqvn
 w4bOCaUlJVw2Iuw3jIlRhlfPHqn.8myofn0tuFQ5Vukg4CQOfyQIGcY0AQwG
 ANQwV68mcmGLze2XDQqVY75srTPEM10V8pDtUvnBUlZ.aQs2uKyh9u.XnEbQ
 xb05CDGKDdt0s_gS8zVQsoFuAeeX6poH1RcvCUJCstiaKCGC52K_b3itm1xq
 A6ZfgwOMwbKqPDHDvfjB1
Received: from [134.109.192.185] by web29402.mail.ird.yahoo.com via HTTP; Mon, 24 Oct 2011 10:23:47 BST
X-Mailer: YahooMailWebService/0.8.114.317681
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184168>

--921974003-1989850134-1319448227=:70497
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI am using git to manage some patches on top of the actual upstrea=
m files, but noticed that the result of git-format-patch changed between 4b=
fe7cb6668c43c1136304bbb17eea1b3ddf0237=A0and=A027af01d552331eacf1ed2671b2b4=
b6ad4c268106=0A=0AI've attached two input files (I tried to provide a minim=
al example... I am not sure if a smaller example is possible but at least b=
oth files are smaller than 10 lines) and the results with version 1.7.6.3 a=
nd and 1.7.7. The diffs were created using:=A0git diff anonymized_orig anon=
ymized_new=0A=0AMy .gitconfig file is empty.=0A=0AThanks
--921974003-1989850134-1319448227=:70497
Content-Type: application/octet-stream; name=anonymized_orig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="anonymized_orig"

MAowCjAKMAo=

--921974003-1989850134-1319448227=:70497
Content-Type: application/octet-stream; name=anonymized_new
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="anonymized_new"

MQoyCjAKMwo0CjUKNgo3Cg==

--921974003-1989850134-1319448227=:70497
Content-Type: application/octet-stream; name="diff.1.7.6.3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff.1.7.6.3"

ZGlmZiAtLWdpdCBhL2Fub255bWl6ZWRfb3JpZyBiL2Fub255bWl6ZWRfbmV3
CmluZGV4IDQ0ZTBiZTguLmFkMGY4NTkgMTAwNjQ0Ci0tLSBhL2Fub255bWl6
ZWRfb3JpZworKysgYi9hbm9ueW1pemVkX25ldwpAQCAtMSw0ICsxLDggQEAK
LTAKLTAKLTAKLTAKKzEKKzIKKzAKKzMKKzQKKzUKKzYKKzcK

--921974003-1989850134-1319448227=:70497
Content-Type: application/octet-stream; name="diff.1.7.7"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff.1.7.7"

ZGlmZiAtLWdpdCBhL2Fub255bWl6ZWRfb3JpZyBiL2Fub255bWl6ZWRfbmV3
CmluZGV4IDQ0ZTBiZTguLmFkMGY4NTkgMTAwNjQ0Ci0tLSBhL2Fub255bWl6
ZWRfb3JpZworKysgYi9hbm9ueW1pemVkX25ldwpAQCAtMSw0ICsxLDggQEAK
KzEKKzIKIDAKLTAKLTAKLTAKKzMKKzQKKzUKKzYKKzcK

--921974003-1989850134-1319448227=:70497--
