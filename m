From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: bug report on update-index --assume-unchanged
Date: Sat, 6 Dec 2014 13:28:25 -0000
Organization: OPDS
Message-ID: <E7C0C71D452B476D8E0E60AD75423156@PhilipOakley>
References: <1417732931.20814.16.camel@segulix><1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org><CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com><1417798622.23238.6.camel@segulix> <xmqq1toeq79b.fsf@gitster.dls.corp.google.com> <12536C063959480083CC2D4CBA0BA38E@PhilipOakley> <1417826757.30899.16.camel@segulix>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9rgio_Basto?= <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxFPI-0000XE-VL
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 14:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaLFN2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2014 08:28:11 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:47909 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761AbaLFN2K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 08:28:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuYOAPkDg1ROl3SjPGdsb2JhbABZgwaBKoYzbME2AYQRBAKBExcBAQEBAQEFAQEBATggG4N9BgEBBAgBASgBBR4BASELAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYguxTGPf4x9g1KDKIEVBYQiiyRchxiDRw6FZIVegmuHUT8wgQMkgRwBAQE
X-IPAS-Result: AuYOAPkDg1ROl3SjPGdsb2JhbABZgwaBKoYzbME2AYQRBAKBExcBAQEBAQEFAQEBATggG4N9BgEBBAgBASgBBR4BASELAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYguxTGPf4x9g1KDKIEVBYQiiyRchxiDRw6FZIVegmuHUT8wgQMkgRwBAQE
X-IronPort-AV: E=Sophos;i="5.07,529,1413241200"; 
   d="scan'208";a="18799805"
Received: from host-78-151-116-163.as13285.net (HELO PhilipOakley) ([78.151.116.163])
  by out1.ip02ir2.opaltelecom.net with SMTP; 06 Dec 2014 13:28:07 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260952>

=46rom: "S=E9rgio Basto" <sergio@serjux.com>
[..]
>> Part of the implied question is why "git commit ." would notice when
>> when "git commit -a" didn't appear to. So it's unclear as to what th=
e
>> user should have expected.
>>
> I agree with this sentence, this is a bug because:
>
> git commit -a ( and -a means all ) is incoherent with "git commit ."
> This is stupid because when I want commit part of the tree, commit
> includes one file that is not included when I say to commit all .
> So maybe you should fix, git commit -a to be coherent .

Ultimately this (-a vs '.' with --assume-unchanged) is not a 'bug',=20
because it does as planned. However the documenation is 'wrong' or at=20
least misguides many readers.

Thank you for bring it to the list's attention.
[..]
>
> Sorry I don't have time to read all messages in thread ,
> but I'm going to test git with the patch suggest in this thread , at
> least, I solve "my" problem for some time ...
>
My patch, and Junio's 'squash' are to correct the documentation, and=20
especially remove the line about it having an "ignore" capability, whic=
h=20
is a promise not kept (your -a vs '.' !).

I'll be updating the documenation patch today for review, though that=20
doesn't solve the wider problem of:
    - 'how to temporarily ignore changes to a tracked file'.
--
Philip=20
