From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Sun, 17 Aug 2014 12:08:30 +0200
Message-ID: <7147D39A-66CE-4824-B051-C625789BFFA5@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de> <1407303134-16635-3-git-send-email-prohaska@zib.de> <20140816102703.GD7857@serenity.lan> <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de> <874mxc9xp3.fsf@igel.home>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 12:09:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIxOZ-0003q9-MA
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 12:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbaHQKI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 06:08:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:41704 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaHQKI6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2014 06:08:58 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7HA8cTh010310;
	Sun, 17 Aug 2014 12:08:38 +0200 (CEST)
Received: from [192.168.1.200] (95-91-208-130-dynip.superkabel.de [95.91.208.130])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7HA8a7H010102
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 17 Aug 2014 12:08:37 +0200 (CEST)
In-Reply-To: <874mxc9xp3.fsf@igel.home>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53F07F26.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F07F26.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F07F26.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255362>


On Aug 16, 2014, at 7:00 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
>> The test should confirm that the the file that is added is not mmapped to
>> memory.
> 
> RSS doesn't tell you that.  You can mmap a big file without RSS getting
> bigger.

All data are accessed after mapping, so RSS should be fine.  The test always did what I expected.

	Steffen
