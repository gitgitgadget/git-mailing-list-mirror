From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Testsuite regression with perl 5.8.0 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 14:30:57 +0100
Message-ID: <54CA3611.1000804@statsbiblioteket.dk>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 14:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGpBY-0001ol-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 14:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbA2Na7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 08:30:59 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:3558 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752577AbbA2Na7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2015 08:30:59 -0500
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Thu, 29 Jan 2015 14:30:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263147>

On 28/01/15 00:35, Junio C Hamano wrote:
> A release candidate Git v2.3.0-rc2 is now available for testing
> at the usual places.
>

Commit 2cf770 added testing of the --[no-]xmailer option to git 
send-email in t9001-send-email.sh
Unfortunately it used the modern Getopt::long style of --no-<option> to 
negate the option which is not supported with Getopt::Long 2.32 as 
shipped with perl 5.8.0 on RHEL3 causing the tests to fail.

Changing the --no-xmailer option to the old --noxmailer style allows the 
tests to pass.

-tgc
