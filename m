From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 03/14] lockfile: remove some redundant functions
Date: Wed, 10 Jun 2015 20:27:56 +0200
Message-ID: <557881AC.3020800@kdbg.org>
References: <cover.1433751986.git.mhagger@alum.mit.edu>	<0d17c04842bef618ecd474c56f2dbcf6a613a379.1433751986.git.mhagger@alum.mit.edu> <xmqqtwuflawx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kjO-0001kJ-JI
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933599AbbFJS2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 14:28:02 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:5688 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932676AbbFJS2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:28:00 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m6Gyj2lbzz5tlK;
	Wed, 10 Jun 2015 20:27:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 32E045296;
	Wed, 10 Jun 2015 20:27:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqtwuflawx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271339>

Am 10.06.2015 um 19:40 schrieb Junio C Hamano:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Remove the following functions and rewrite their callers to use the
>> equivalent tempfile functions directly:
>>
>> * fdopen_lock_file() -> fdopen_tempfile()
>> * reopen_lock_file() -> reopen_tempfile()
>> * close_lock_file() -> close_tempfile()
>
> Hmph,
>
> My knee-jerk reaction was "I thought lockfile abstraction was
> fine---why do we expose the implementation detail of the lockfile,
> which is now happen to be implemented on top of the tempfile API, to
> the callers?"

Just for the record, I had exactly the same reaction, and I find this 
transition against the spirit of a self-contained lockfile API.

-- Hannes
