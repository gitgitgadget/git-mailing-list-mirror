From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH v2] t/gitweb-lib: Don't pass constant to decode_utf8
Date: Wed, 20 Oct 2010 18:13:44 -0400
Message-ID: <3E0E134D-276A-4CA1-965D-274A6AA188C1@gernhardtsoftware.com>
References: <1287554231-84196-1-git-send-email-brian@gernhardtsoftware.com> <201010202105.59370.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 00:13:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8guv-0008He-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab0JTWNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:13:49 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39245 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0JTWNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 18:13:48 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 22AD21FFC05B; Wed, 20 Oct 2010 22:13:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 253A41FFC057;
	Wed, 20 Oct 2010 22:13:38 +0000 (UTC)
In-Reply-To: <201010202105.59370.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159441>


On Oct 20, 2010, at 3:05 PM, Jakub Narebski wrote:

> On Wed, 20 Oct 2010, Brian Gernhardt wrote:
> 
>> Encode.pm started updating the string to decode in-place when a second
>> argument is passed in version 2.40.  This causes 'decode_utf8("",
>> Encode::FB_CROAK)' to die with a message like:
> 
> Very minor complaint: line break here makes it less readable.
> 
> Perhaps this?
> 
>  Encode.pm started updating the string to decode in-place when a second argument
>  is passed in version 2.40.  This causes 'decode_utf8("", Encode::FB_CROAK)' to
>  die with a message like:

The wrapping was automatically done by vim.  I'll try tweaking width/contents to make it flow better.

>> Modification of a read-only value attempted at
>> /Library/Perl/Updates/5.10.0/darwin-thread-multi-2level/Encode.pm line
>> 216.
> 
> Very minor complaint: It might be better to not include path to installed
> Encode.pm, which is different on different filesystems.
> 
>  Modification of a read-only value attempted at .../Encode.pm line
>  216.

>> Changes since v1:
>> - Use an explicitly empty variable instead of $_
> 
> ...which was undefined, not empty, I think.

It still served to test the two argument case, but I thought an explicit variable that exactly matched the previous call would be better.

>> - based against maint
> 
> Was there any difference versus being based against 'master'?

Whitespace in context lines.  The skip_all and test_done lines were re-indented at some point.  Minor, but I thought I'd mention it.

~~ Brian
