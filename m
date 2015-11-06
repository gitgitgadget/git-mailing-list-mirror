From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Fri, 6 Nov 2015 22:41:07 +0100
Message-ID: <563D1E73.8080805@kdbg.org>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
 <1446747439-30349-2-git-send-email-sbeller@google.com>
 <563BBBBC.7070807@kdbg.org>
 <CAGZ79kbNpwhOF2eveux+yXibrYx+_S6KjvqLV7yEfAe5Sdg4uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 22:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zuol2-0007IZ-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 22:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966026AbbKFVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 16:41:12 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:5998 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965979AbbKFVlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 16:41:11 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nswBq6sqJz5tlC;
	Fri,  6 Nov 2015 22:41:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8B98C5382;
	Fri,  6 Nov 2015 22:41:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbNpwhOF2eveux+yXibrYx+_S6KjvqLV7yEfAe5Sdg4uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281001>

Am 06.11.2015 um 20:00 schrieb Stefan Beller:
> On Thu, Nov 5, 2015 at 12:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Here is a prototype patch. Feel free to pick it up. It marks a process
>> whose EOF we have found by setting .err to -1. It's probably better to
>> extend the meaning of the in_use indicator for this purpose.
>
> Thanks for the proposal, I'll take that and make in_use a tristate for now
> (an enum consisting of FREE, WORKING, WAIT_CLEANUP)

I'd like to report that the prototype patch works on Windows. I tested 
it lightly using test-run-command with commands producing output from 
around 100 bytes to 10MB. So, I'm confident that this is the right approach.

Thank you for keeping the ball rolling!

-- Hannes
