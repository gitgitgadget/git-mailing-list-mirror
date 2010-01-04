From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] t0021: use $SHELL_PATH for the filter script
Date: Mon, 04 Jan 2010 16:50:39 +0100
Message-ID: <4B420E4F.1040706@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230110335.GF22959@coredump.intra.peff.net> <4B3E73AE.6050003@kdbg.org> <20100103072408.GA23031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 16:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRpDM-0005Mm-Tr
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 16:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0ADPvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 10:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094Ab0ADPvY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 10:51:24 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:58855 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752107Ab0ADPvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 10:51:24 -0500
Received: from [77.117.74.72] (77.117.74.72.wireless.dyn.drei.com [77.117.74.72])
	by bsmtp.bon.at (Postfix) with ESMTP id 82CC310021;
	Mon,  4 Jan 2010 16:51:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100103072408.GA23031@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136118>

Jeff King schrieb:
> On Fri, Jan 01, 2010 at 11:14:06PM +0100, Johannes Sixt wrote:
> 
>> On Windows, we need the shbang line to correctly invoke shell scripts via
>> a POSIX shell, except when the script is invoked via 'sh -c' because
>> sh (a bash) does "the right thing". Since nowadays the clean and smudge
>> filters are not always invoked via 'sh -c' anymore, we have to mark the
>> the one in t0021-conversion with #!$SHELL_PATH.
> 
> Hrm. This does mean we might be breaking users who have helper scripts
> in a similar state to those in the test suite...

Not helper scripts in general, but only clean and smudge filters, because 
these have been invoked with "sh -c" so far. Everything else, that was not 
run via "sh -c", but now is, is safe.

-- Hannes
