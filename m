From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 21:12:49 -0000
Organization: OPDS
Message-ID: <D9562ECC995343B3A51D449DC2B46CBC@PhilipOakley>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com><CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com> <xmqqtwxmt43h.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Alexander Kuleshov" <kuleshovmail@gmail.com>,
	<git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 22:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXFpL-0004hB-PL
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 22:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbCOVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 17:11:57 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:32351 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339AbbCOVL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 17:11:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C1GAA79QVVPGRKFlxbgwaBLIY5bbZzi28EAoEYTQEBAQEBAQYBAQEBOCAbhAoFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGIFgyxZJQKixeEcYMegRYFilWFZWGdGYQRPjGCQwEBAQ
X-IPAS-Result: A2C1GAA79QVVPGRKFlxbgwaBLIY5bbZzi28EAoEYTQEBAQEBAQYBAQEBOCAbhAoFAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHAxQGARIIAgECAwGIFgyxZJQKixeEcYMegRYFilWFZWGdGYQRPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.11,405,1422921600"; 
   d="scan'208";a="492081665"
Received: from host-92-22-74-100.as13285.net (HELO PhilipOakley) ([92.22.74.100])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 15 Mar 2015 21:11:46 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265523>

From: "Junio C Hamano" <gitster@pobox.com>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The commit message is missing the important justification for why 
>> this
>> new option is desirable, and why only git-add needs it.
>
> I think that is a very good point.  I actually do not see why this
> option is ever needed, in a modern world that has the negative
> pathspec magic.

Isn't the problem one of "how are users to discover such magic". The 
fact we call it 'magic' (a sleight of hand...) may be why Alexander felt 
the need for the extra option.

Maybe He/We would be better off adjusting the documentation such that 
these 'magic' capabilities are brought out of their hiding places into 
regular view - e.g. a paragraph within the 'git add' documentation 
(and/or other commands) showing how such excludes are easily done with a 
few simple keystrokes....

'git help revisions' doesn't appear to cover it. I'm not sure we even 
mention "negative pathspec" in the documentation (apart from rel notes 
1.9.0 & 2.3.0).

Maybe Alexander could change itch to: make the "magic negative pathspec" 
capability more visible?

>
> Is there a reason why this is undesiable
>
>    $ git add -- \*.c ':!secret.c'
>
> and has to be spelled as
>
>    $ git add --exclude=secret.c -- \*.c
>
> I do not see why...
> --
Philip 
