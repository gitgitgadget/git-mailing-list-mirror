From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Sun, 31 Aug 2014 12:08:49 +0100
Organization: OPDS
Message-ID: <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley> <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com> <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 13:08:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO309-0004si-Kz
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 13:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaHaLIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 07:08:49 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:63197 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751046AbaHaLIt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Aug 2014 07:08:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhwkAKABA1QCYJAzPGdsb2JhbABagw1kAUWCfIU7vBmKXgYCAgiBAxcFAQEBATg2g34FAQEEAQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHAxQGEwgCAQIDAYgdAwkMpSuGf4dUDYVlAReBLIt0gi01gks2gR0FhhSLHViIQ5B3ihk8L4JPAQEB
X-IPAS-Result: AhwkAKABA1QCYJAzPGdsb2JhbABagw1kAUWCfIU7vBmKXgYCAgiBAxcFAQEBATg2g34FAQEEAQgBARkVHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQIEgYHAxQGEwgCAQIDAYgdAwkMpSuGf4dUDYVlAReBLIt0gi01gks2gR0FhhSLHViIQ5B3ihk8L4JPAQEB
X-IronPort-AV: E=Sophos;i="5.04,436,1406588400"; 
   d="scan'208";a="119787933"
Received: from host-2-96-144-51.as13285.net (HELO PhilipOakley) ([2.96.144.51])
  by out1.ip07ir2.opaltelecom.net with SMTP; 31 Aug 2014 12:08:46 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256284>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Sun, Aug 31, 2014 at 11:49 AM, Duy Nguyen <pclouds@gmail.com> 
> wrote:
>> All checkouts share the same repository. Linked checkouts see the
>> repository a bit different from the main checkout. When you perform
>> the command
>>
>> ------------
>> git checkout --to <some-location> <some-branch>
>> ------------
>>
>> The checkout at <some-location> will have a unique id that is also 
>> the
>> branch name (e.g. "<some-branch>"). A number may be appended to the 
>> id
>
> .. and I got my facts wrong. The above line should be:
>
> last component of <some-location>. A number may be appended to the id
>

That's fine. Glad that we're on the same wavelength for the 
documentation.

>> to make it unique. All worktree-specific files of this new checkout
>> are in $GIT_DIR/repos/<unique-id> of the main checkout. So "HEAD"
>> inside the linked checkout will be resolved to
>> "$GIT_DIR/repos/<some-branch>/HEAD", while "HEAD" from the main
>
> s/<some-branch>/<unique-id>/
>
>> checkout remains "$GIT_DIR/HEAD".
>
>
>
> -- 
Philip 
