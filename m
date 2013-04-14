From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/2] Test the Git version string
Date: Sun, 14 Apr 2013 22:26:30 +0100
Organization: OPDS
Message-ID: <79879228B71A45A48A961F5B1880B61F@PhilipOakley>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org> <7v8v4k6hp2.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 23:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URURE-0006el-DT
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab3DNV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 17:26:11 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25461 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754248Ab3DNV0J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 17:26:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhcOAJkda1FZ8Yth/2dsb2JhbAAuIoMGNohvuEgEAQMBgQYXdIIaBQEBBAEIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBh30KuW6NXwFNaoJnYQOITYV0mVWDDDuBLgEf
X-IronPort-AV: E=Sophos;i="4.87,471,1363132800"; 
   d="scan'208";a="69003429"
Received: from host-89-241-139-97.as13285.net (HELO PhilipOakley) ([89.241.139.97])
  by out1.ip07ir2.opaltelecom.net with SMTP; 14 Apr 2013 22:26:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221161>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, April 14, 2013 8:22 PM
> Philip Oakley <philipoakley@iee.org> writes:
>
>> This patch series seeks to add tests for the version string format
>> and document it.
>>
>> The key questions to be answered are:
>> * should the test be inside t0000, or somewhere else?
>> * should the version string be limited to one line, <80 characters?
>
> One line, perhaps, but I do not think any byte-limit is reasonable.

OK

>
> It is unreasonable to limit the form to X.Y.Z; after we hit Git 2.0,
> it is likely that we would go to two-decimals.

Ah. And then maintenance releases could be the .Z maybe. I suppose it 
will depend on circumstances.

>
> If the "parsing" is done for white/blacklist purposes, is there a
> need to straight-jacket the verison string format like this series?

The purpose is to document what we felt we could guarantee, and that 
which was open to variation, so that those, like the Git-Gui, can code 
in a sensible check for the version. Two digits (X.Y) should pass the 
existing Git Gui check.

I'll drop the length limit, and keep to an X.Y check

Is the end of t0000-basic.sh a sensible place for the check?

> --
Philip 
