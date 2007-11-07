From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Wed, 07 Nov 2007 12:42:41 -0800
Message-ID: <7v3avhbxdq.fsf@gitster.siamese.dyndns.org>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	<7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711070758w5832ab83ic16e8fb4edb80972@mail.gmail.com>
	<fcaeb9bf0711070805x49228d8dq7e8e6f26060c47ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iprk3-0005If-Oq
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759155AbXKGUmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759085AbXKGUmv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:42:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43757 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759014AbXKGUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:42:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 48EAA2EF;
	Wed,  7 Nov 2007 15:43:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id AAD5D933BE;
	Wed,  7 Nov 2007 15:43:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63854>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 11/7/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On 11/7/07, Junio C Hamano <gitster@pobox.com> wrote:
>> > [2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
>> >       would want to get Yays from people with non GNU sed.  Is
>> >       busybox sed good enough to grok our scripts these days?
>> >       Please ask help and collect Acks at least from folks on
>> >       Solaris, MacOS, FBSD, and OBSD.
>>
>> I haven't extensively used all the scripts. There seems to be no
>> sed-related failure from git testsuite results in my git-box branch.
>> So I would say for now it's good enough.
>
> Argh, should have made it clear, busybox sed is good enough.

Thanks.  And you can also happy grok Ralf's rewritten construct,
right?

That is, existing

        $ sed -e 's/foo/\n/' file

will be rewritten by the patch [2/5] to

        $ sed -e 's/foo/\
        /' file
