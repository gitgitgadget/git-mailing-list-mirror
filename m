From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: .gitignore for large files?
Date: Mon, 25 Jul 2011 22:36:42 +0100
Organization: OPDS
Message-ID: <0F3C5B6B6420446A9D64B9394AA2BC4D@PhilipOakley>
References: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley> <CACsJy8C=ks1_TdQdNi4Wq8OCSAON9rhJ88zAp1kDZy3fBg2pmQ@mail.gmail.com> <179943CA8CCC4BEE811E31B2BCC634D1@PhilipOakley> <CACsJy8B8kYU7bkD8SiK354z4u=sY3hHbe4JVwNT_1pxod1cqUw@mail.gmail.com> <7vd3gyrxtl.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSpU-0004oM-E0
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab1GYVgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:36:44 -0400
Received: from out1.ip09ir2.opaltelecom.net ([62.24.128.245]:59495 "EHLO
	out1.ip09ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752930Ab1GYVgn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 17:36:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYFADLhLU5Z8rUp/2dsb2JhbAArBQQBAQUIAQE0IgEBIwsCBAUDAQMXCjEUAQEEDBIHCBYIBwEWDAIBAgMBig6dN3iIdgjAdoVgXwSHJpUzhng
X-IronPort-AV: E=Sophos;i="4.67,264,1309734000"; 
   d="scan'208";a="485398212"
Received: from host-89-242-181-41.as13285.net (HELO PhilipOakley) ([89.242.181.41])
  by out1.ip09ir2.opaltelecom.net with SMTP; 25 Jul 2011 22:36:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177821>

Subject: How to ignore large files?
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> While .gitattributes looks like a better place, it does not have
>> "exclude" attribute equivalence to .gitignore. If I remember
>> correctly, the way .gitignore and .gitattributes are implemented makes
>> it very hard to turn .gitignore into part of .gitattributes
>> implementation (gitattr checks .gitattributes of current dir first,
>> then upward to parents, while .gitgnore follows the opposite
>> direction).
>
> While I do not think it is necessarily a good idea to invent yet another
> way to exclude and add it to the attributes mechanism (unless we will be
> dropping the support for gitignore, which is not the case), I do not know
> why you think the direction of the scan matters.
>
> A more important difference is that the attribute mechanism covers the
> actual paths, not intermediate directories, unlike gitignore does.

The choice of any actual implementation would depend on both feasability and 
usefulness. Duy was pointing out (to me?) the different approaches used for 
respecting the gitattributes and (multiple) gitignore files. My first 
thought had been to use the .gitignore file but I then realised the 
potential problems of adding more metacharacters ( > and < ).

I've also just seen that 1.7.6 introduced the core.bigFileThreshold for 
memory management reasons, while this suggestion is to help folk avoid the 
mistake of unintentional committing of very large files without being 
warned.

Does the concept (of warning/ignoring when files are 'large') have any 
merit?

Philip 
