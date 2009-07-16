From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to ignore space when using 'git send-email' command
Date: Thu, 16 Jul 2009 13:57:03 -0700
Message-ID: <7v4otc8hy8.fsf@alter.siamese.dyndns.org>
References: <3b9893450907131353o77102b8cx6c8944f6cc45214a@mail.gmail.com>
 <20090716100926.GC6742@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: n179911 <n179911@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRY1e-0006Oq-70
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 22:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345AbZGPU5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933315AbZGPU5K
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 16:57:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbZGPU5K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 16:57:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF62589F1;
	Thu, 16 Jul 2009 16:57:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7EDD489EC; Thu, 16 Jul 2009
 16:57:05 -0400 (EDT)
In-Reply-To: <20090716100926.GC6742@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 16 Jul 2009 06\:09\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A979992-724B-11DE-B3AF-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123423>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 13, 2009 at 01:53:11PM -0700, n179911 wrote:
>
>> When i use 'git send-email' command how can I specify it to
>> 'ignore-all-space'?
>
> Have you tried:
>
>   git send-email --ignore-all-space origin
>
> ?
>
>> I see there is an 'ignore-all-space' option in 'git diff' and 'git
>> format-patch', but there is not such option for git send-email.
>
> There are two ways of running send-email:
>
>   1. format-patch your patches into a file or directory, and then
>      send-email on it. In this case, you need to --ignore-all-space when
>      doing the format-patch, which is what is generating the patches.
>
>   2. give send-email revision arguments, which are fed to format-patch
>      (which is what I showed above).  In this case, you can give
>      format-patch arguments directly to send-email.
>
> Does that help?

That may help but it is generally a bad idea to send a patch generated
with ignore-all-spaces and other options, as it means that the receiving
end will get changes that not even you the sender had any chance to test.
