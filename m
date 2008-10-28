From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Mon, 27 Oct 2008 20:24:22 -0700
Message-ID: <7vljw9h061.fsf@gitster.siamese.dyndns.org>
References: <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
 <20081027192923.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 04:25:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KufDJ-0004Qo-6K
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 04:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbYJ1DYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 23:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbYJ1DYg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 23:24:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYJ1DYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 23:24:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CDC275F24;
	Mon, 27 Oct 2008 23:24:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 68BE175F23; Mon, 27 Oct 2008 23:24:29 -0400 (EDT)
In-Reply-To: <20081027192923.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 27 Oct 2008 19:29:23 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1CAAF5C-A49F-11DD-89B7-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99272>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Thomas Rast <trast@student.ethz.ch>:
>
>> Replaces the existing simple history search with a more sophisticated
>> algorithm:
>> 
>> 1) Walk history with exponentially increasing stride lengths; i.e.,
>>    send the 1st commit, then the 2nd after that, then the 4th after
>>    that, and so on.
>> 
>> 2) Bisect the resulting intervals.
>
> Junio, may I ask what the status of this patch is? I see Nicolas responded and said "I gave this a quick try". Wasn't it a good enough review?

I took the "quick try" more about "first feel in performance" and not
"code review concentrating on correctness and trying to catch mistakes".

I like what the patch tries to solve, and the approach it takes to solve
it.  I haven't had a chance to have a block of time for me to concentrate
on this patch to assess where it could go wrong yet.
