From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Wed, 11 Nov 2015 23:18:39 +0100
Message-ID: <5643BEBF.6000804@kdbg.org>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
 <563DBDDA.2000106@kdbg.org>
 <CAGZ79kaZ0W5q8=iowbSTJY_mDNNYc6qdTszcWDDDCtYfZyeK_Q@mail.gmail.com>
 <5643A9A0.50105@kdbg.org>
 <CAGZ79kZTiGGL0t-CkeuWDfzX-pK_Lu8PZzE1sutq2jR_23B5xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwdj4-0008G0-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 23:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbKKWSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 17:18:42 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:65024 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbKKWSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 17:18:42 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nx0nq4Jlbz5tlB;
	Wed, 11 Nov 2015 23:18:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 47C32539C;
	Wed, 11 Nov 2015 23:18:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZTiGGL0t-CkeuWDfzX-pK_Lu8PZzE1sutq2jR_23B5xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281205>

Am 11.11.2015 um 21:53 schrieb Stefan Beller:
> On Wed, Nov 11, 2015 at 12:48 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> I wonder why task_finish() callback gets to choose a signal. The point here
>> is, IIUC, when one child dies, the others must be halted, too. SIGTERM seems
>> to be the only sensible choice.
>
> SIGKILL would also do?
>
> In case you know your children, you can also send a SIGUSR1 or SIGUSR2.
>...
> So I am not convinced SIGTERM is the only true choice here. And because I
> have no idea which of the signals may be useful in the future, I decided to
> go with all of them.

Fair enough.

-- Hannes
