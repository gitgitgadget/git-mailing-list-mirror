From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: .gitignore for large files?
Date: Mon, 25 Jul 2011 07:53:44 +0100
Organization: OPDS
Message-ID: <179943CA8CCC4BEE811E31B2BCC634D1@PhilipOakley>
References: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley> <CACsJy8C=ks1_TdQdNi4Wq8OCSAON9rhJ88zAp1kDZy3fBg2pmQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 08:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlF3G-0003IQ-5X
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 08:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab1GYGxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 02:53:48 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:41109 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab1GYGxq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 02:53:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQAAB0SLU5Z8rUp/2dsb2JhbAArCQEBBAEIAQEfFRUNAQEjBQYBAQQFAwEDEQMBAQEBAgIFLQICFAEBBAwSBwgWCAcXDAIBAgMBhEGFTY1fj1N4iHwCr16QMoErhAUwXwScWQGGdw
X-IronPort-AV: E=Sophos;i="4.67,259,1309734000"; 
   d="scan'208";a="507256562"
Received: from host-89-242-181-41.as13285.net (HELO PhilipOakley) ([89.242.181.41])
  by out1.ip06ir2.opaltelecom.net with SMTP; 25 Jul 2011 07:53:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177782>

Duy,

The .git attributes is a good call. I'm thinking that it would be a global 
flag (i.e. is a max file limit in place at all on this repo), and then a set 
of limits, initially one for 'text' and one for 'binary' (and possibly a 
third for anything with an ext diff), and probably use a similar attribute 
format as used for setting diff attributes and its filters to set a per file 
type limit [if required]

The relevant function names gives me a place to start....

Philip
----- Original Message ----- 
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
Cc: "Git List" <git@vger.kernel.org>
Sent: Sunday, July 24, 2011 3:59 AM
Subject: Re: .gitignore for large files?


> On Sun, Jul 24, 2011 at 3:00 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Has there been any discussion in the past on a method for ignoring large
>> files via the .gitignore process?
>>
>> It does appear to be a moderately common problem for folk to accidentally
>> commit a large file which bloats their repository and they want rid of 
>> it,
>> which causes history re-writes and such palaver.
>
> Once they are in, they cannot be ignored. Perhaps commit hooks at
> server side is a better place?
>
>> Perhaps a simple '>' and '<' option (the latter to cover null or minimal
>> files?) with a --warn postfix may be possible. Just an initial thought.
>
> Or you can make use of .gitattributes, more flexible syntax.
>
>> Where would the 'right place' be for me to look at the git code if it was
>> beneficial.
>
> In dir.c, add_exlude() does the parsing, excluded_from_list() handles the 
> logic.
> -- 
> Duy
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 10.0.1390 / Virus Database: 1518/3783 - Release Date: 07/23/11
> 
