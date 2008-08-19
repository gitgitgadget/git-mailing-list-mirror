From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t9301-fast-export.sh: don't unset config variable while
 we're skipping test 4
Date: Mon, 18 Aug 2008 19:39:16 -0500
Message-ID: <XjMPN99F86xBqhO6FWdPpHD5Gr3r-dH2xHwjFFmE3P4jw1t54M8gRA@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <kbCw6MBjduXNz0eWrsdfGIVr60qjr7cf1eJqhd4l-UzDfHEk1LrlkA@cipher.nrlssc.navy.mil> <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFGv-0002CC-Gc
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbYHSAjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756305AbYHSAjX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:39:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52256 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296AbYHSAjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:39:22 -0400
Received: by mail.nrlssc.navy.mil id m7J0dGKl003605; Mon, 18 Aug 2008 19:39:16 -0500
In-Reply-To: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2008 00:39:16.0484 (UTC) FILETIME=[0275EC40:01C90194]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92796>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> ---
>>
>>
>> This is necessary if t9301.4 is included in the GIT_SKIP_TESTS
>> environment variable.
> 
> If it is not skipped what happens?  Does your change break this test?

Yes, it was only meant as an example to be used along with the build
script I supplied.

> How about attempting to unset always (because the test does not want to
> have the configuration) but ignore the result from the command (because
> the config may not have had anything to unset to begin with depending on
> what happened in the previous tests)?

Yes, unsetting always and ignoring the result would allow this test to
pass. It could also be moved into its own test so that it could be skipped
using GIT_SKIP_TESTS, but still signal failure when it is not skipped.

-brandon
