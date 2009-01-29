From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Thu, 29 Jan 2009 14:10:41 -0500
Message-ID: <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LScJC-0005HO-7O
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZA2TKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZA2TKr
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:10:47 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50244 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZA2TKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:10:46 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B19C91FFC15B; Thu, 29 Jan 2009 19:10:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=4.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1AEAA1FFC159;
	Thu, 29 Jan 2009 19:10:38 +0000 (UTC)
In-Reply-To: <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107719>


On Jan 29, 2009, at 12:19 PM, Junio C Hamano wrote:

> If we really wanted to care about case-folding file systems,  
> shouldn't we
> make test_commit shell function a bit more than the downcasing?  How  
> about
> this patch instead?

That's a good point.  Always good to prevent future issues.

> test_commit () {
> -	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
> +	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}
> 	echo "${3-$1}" > "$file" &&
> 	git add "$file" &&
> 	test_tick &&

Added this and ran through the tests.  Works for me. :-D

Tested-by: Brian Gernhardt <benji@silverinsanity.com> (HFS+ on Mac OS  
10.5.6)
