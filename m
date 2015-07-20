From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 20:36:36 +0100
Organization: OPDS
Message-ID: <1E307B9A21744983970834F69116F358@PhilipOakley>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org><1437416790-5792-5-git-send-email-philipoakley@iee.org> <CAPig+cQ_G=Ar0uxbxDaO6oEZwkRi7FM4qEQexDohDGxN10OJUA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 21:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHGrT-00031Y-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbbGTTgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 15:36:23 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:35588 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014AbbGTTgW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 15:36:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DmCQBETa1VPHMBFlxcgxNUaYMihBu2CB0KhXcEAQMBAYExTQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBARkVFggBASELAgMFAgEDFQMCAgUhAgIUAQQYAgYHAwMRBggLCAIBAgMBCgIEiAUMCbJfhTOBJI9wgSKKKoQjEQFRgm8vgRQFjDiIGgGBCoNkiTuWfoEJgxo9MQGBDIE+AQEB
X-IPAS-Result: A2DmCQBETa1VPHMBFlxcgxNUaYMihBu2CB0KhXcEAQMBAYExTQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBARkVFggBASELAgMFAgEDFQMCAgUhAgIUAQQYAgYHAwMRBggLCAIBAgMBCgIEiAUMCbJfhTOBJI9wgSKKKoQjEQFRgm8vgRQFjDiIGgGBCoNkiTuWfoEJgxo9MQGBDIE+AQEB
X-IronPort-AV: E=Sophos;i="5.15,509,1432594800"; 
   d="scan'208";a="794447791"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 20 Jul 2015 20:36:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274350>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Mon, Jul 20, 2015 at 2:26 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Explain how the cc-cmd (and to-cmd) is invoked, along with two
>> simple examples (and a how-not-to example) to help in getting 
>> started.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> diff --git a/Documentation/git-send-email.txt 
>> b/Documentation/git-send-email.txt
>> index ddc8a11..9f991cf 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -436,6 +436,42 @@ following commands:
>>  Note: the following perl modules are required
>>        Net::SMTP::SSL, MIME::Base64 and Authen::SASL
>>
>> +Creating a cc-cmd (and to-cmd) action
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +git-send-email invokes the cc-cmd like this:
>> +
>> +       $cc-cmd $patchfilename
>> +
>> +Thus the patch itself can be processed to locate appropriate email 
>> address
>> +information if required.
>> +
>> +A simple solution for a basic address list is to create a 'cc-cmd' 
>> file
>> +(executable) which provides a list of addressees:
>
> Rather than calling this a "simple solution", you might instead say
> that this is an example of a bare-bones script which just returns a
> fixed list of email addresses without attempting to extract any
> addresses from the patch file itself.
>
>> +       #!/bin/sh
>> +       echo <<\EOF
>> +       person1@example.com
>> +       person2@example.com
>> +       EOF
>
> I don't know if it deserves mention that the script must be executable
> (chmod +x) or should we assume that readers are smart enough to
> understand this implicitly? (It probably should be mentioned.)

It's there, but it's after the wrap-around. Maybe
s/(executable)/(must be executable: `chmod +x`)/
to be fully pedantic.

>
> Other than those minor points, the above looks fine, however...
>
>> +Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text 
>> file
>> +of email addresses), does not work as expected as the invocation 
>> becomes:
>> +
>> +       $cat cc-cmd $patchfilename
>> +
>> +and since 'cat' copies the concatenation of its input files to its 
>> output,
>> +this adds the patch file to the address list resulting in an error
>> +"unable to extract a valid address from:".
>> +
>> +The quick-and-dirty work-around is to use '#' to effectively comment 
>> out
>> +the patch file name:
>> +
>> +    --cc-cmd='cat cc-cmd #'
>> +
>> +which works, but is very, very ugly.
>
> This entire above text about "cat $addressfile" seems awfully
> inappropriate for a manual page, especially the bit about the terrible
> "cat $file #" hack.

Given that this invocation is why this all kicked off ...
'cat list.txt', being the most simple of commands and a first cargo-cult 
try for many, I definitely think it's worthwhile including somehow.

Perhaps one needs to be more direct with the right invocation.

"A simple `--cc-cmd='cat list.txt #'` is a quick-and-dirty way of using 
an address list, while ignoring the patch content."


>
>>  SEE ALSO
>>  --------
>>  linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
>> --
>> 2.4.2.windows.1.5.gd32afb6
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
