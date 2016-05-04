From: "Philip Oakley" <philipoakley@iee.org>
Subject: unary minus operator applied to unsigned type, result still unsigned?
Date: Wed, 4 May 2016 23:59:23 +0100
Organization: OPDS
Message-ID: <74B59A4DF45C45AF9CDCF6662DDAEF1E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 00:59:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5lR-0002ue-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbcEDW7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:59:25 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35408 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbcEDW7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:59:25 -0400
Received: from PhilipOakley ([92.16.243.54])
	by smtp.talktalk.net with SMTP
	id y5lKaasZpUaZty5lKasVPJ; Wed, 04 May 2016 23:59:22 +0100
X-Originating-IP: [92.16.243.54]
X-Spam: 0
X-OAuthority: v=2.2 cv=M4MPEG4s c=1 sm=1 tr=0 a=qUd12D775FIHivlWuAanHQ==:117
 a=qUd12D775FIHivlWuAanHQ==:17 a=8nJEP1OIZ-IA:10 a=2po6-AAJoN7wWPKHhXQA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAl5uM6eN4W93w4AnLVPp4hHZpsYYbsuBvZW+iDTlY+d753jeSkjnoAebpSw+uTn+5Ho+Vl+a3ctA3rHL7aCNwp7HrTtOl/JMqpNbrjaFPdAigE77vDT
 KH4UXCtklN1AyjcmWTJ4PTcP7kBR4tGNn/yrIczhWl0DytXyEDvqMlGj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293619>

I'm working on building Git on Visual Studio as part of the Git for Windows
capability.

The MSVC compiler is reporting:

1>..\sha1-lookup.c(100) : warning C4146: unary minus operator applied to
unsigned type, result still unsigned

1>..\sha1-lookup.c(316) : warning C4146: unary minus operator applied to
unsigned type, result still unsigned

the two lines of code are the same, and the message suggests a bad return 
value:

#100: return -lo-1;

#316: return -lo-1;


Should these be protected by an appropriate brackets/calculation (-1-lo) ? 
Or does
gcc use an alternate assumption about unary minus conversion for functions
returning int?

--

Philip
