From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Wed, 13 Nov 2013 23:12:32 -0000
Organization: OPDS
Message-ID: <5ABC4D34F41F48E39205914BC8D3DC35@PhilipOakley>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com><xmqqhabilpzx.fsf@gitster.dls.corp.google.com><CAD3a31UVkNaPTCWCAbv0NwCOTE5_2A+P7-e28VRnk9Aopa6hcQ@mail.gmail.com> <xmqqbo1ofd1s.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "Ken Tanzer" <ken.tanzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 00:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgjbs-0001bx-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 00:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab3KMXM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 18:12:28 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:36855 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085Ab3KMXM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 18:12:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmgGACcGhFJZ8Yn6/2dsb2JhbABZgweJPrZ5gSIXdGmBIRYBBAEBBAEIAQEuHgEBIQsCAwUCAQMVAQsMGRQBBAgSBgcXBgoJCAIBAgMBhTgHghINAwkKtiYNiWuMbYE5gTkRgxaBEQOJCoYShwmOPoU4gyg8gTU
X-IPAS-Result: AmgGACcGhFJZ8Yn6/2dsb2JhbABZgweJPrZ5gSIXdGmBIRYBBAEBBAEIAQEuHgEBIQsCAwUCAQMVAQsMGRQBBAgSBgcXBgoJCAIBAgMBhTgHghINAwkKtiYNiWuMbYE5gTkRgxaBEQOJCoYShwmOPoU4gyg8gTU
X-IronPort-AV: E=Sophos;i="4.93,695,1378854000"; 
   d="scan'208";a="446850753"
Received: from host-89-241-137-250.as13285.net (HELO PhilipOakley) ([89.241.137.250])
  by out1.ip02ir2.opaltelecom.net with SMTP; 13 Nov 2013 23:12:26 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237806>

From: "Junio C Hamano" <gitster@pobox.com>
To: "Ken Tanzer" <ken.tanzer@gmail.com>
Sent: Wednesday, November 13, 2013 5:04 PM
> Ken Tanzer <ken.tanzer@gmail.com> writes:
>
>>> I am not very much surprised if such a file misbehaves, because the
>>> "format-patch | am" pipeline is designed to be used on patches that
>>> can be transferred in plain-text e-mail safely.  Long lines should
>>> probably be OK, but mixed CRLF, CR and LF may be problematic.
>>
>> I'm not sure I understand this comment.  format-patch seems to work
>> fine on binary files.
>
> Yes.
>
> The problematic is when you tell it to process text files, taking
> into account various common text breakages may be introduced to the
> payload, and line-end conversion is among the operations that the
> user may be telling it to munge the perfectly-fine input, in an
> attempt to compensate.
>

>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> I do have this global config
>>>  core.safecrlf=warn
>>> regarding line endings.

Ken,

Do you have one of these line ending conversion settings active in your 
config file?

It sounds like the 'git am' script may be silencing the warnings too 
aggressively if that is the case.

Philip 
