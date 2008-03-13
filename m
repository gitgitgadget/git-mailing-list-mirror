From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] buitin-status: Add tests for submodule summary
Date: Thu, 13 Mar 2008 11:04:06 -0700
Message-ID: <7vprtyxzzd.fsf@gitster.siamese.dyndns.org>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
 <1205416085-23431-5-git-send-email-pkufranky@gmail.com>
 <47D93875.1050407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrnX-0005bm-Sv
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbYCMSET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbYCMSET
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:04:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46999 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbYCMSES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:04:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53D995E90;
	Thu, 13 Mar 2008 14:04:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 835025E8B; Thu, 13 Mar 2008 14:04:08 -0400 (EDT)
In-Reply-To: <47D93875.1050407@viscovery.net> (Johannes Sixt's message of
 "Thu, 13 Mar 2008 15:21:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77120>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ping Yin schrieb:
>> +cd sm &&
>> +head=$(git rev-parse --verify HEAD | cut -c1-7) &&
>> +cd ..
>
> I think you can make these three lines into:
>
> test_expect_success 'get short SHA1 of submodule HEAD' '
>
> 	head=$(cd sm && git rev-parse --verify HEAD | cut -c1-7)
> '

"git rev-parse --short=12 --verify HEAD" or whatever minimum length you
would want would free you from an ugly "pipe to cut".
