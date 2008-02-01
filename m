From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-send-email: ssh/login style password requests
Date: Fri, 1 Feb 2008 18:42:30 -0500
Message-ID: <E83D03C8-5D96-4110-A047-B7B5F7582F3B@MIT.EDU>
References: <1201841954-17949-1-git-send-email-mfwitten@mit.edu> <7vodb19edp.fsf@gitster.siamese.dyndns.org> <FE992810-2B2E-4C23-A7D3-AD4C39D925ED@MIT.EDU> <5F77BB5B-8D2B-42FD-A805-7195757B14EE@mit.edu> <7v4pcs8d4z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5XJ-0005UM-OA
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064AbYBAXmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760004AbYBAXmh
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:42:37 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:49452 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759953AbYBAXmg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 18:42:36 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m11NgW7q001689;
	Fri, 1 Feb 2008 18:42:32 -0500 (EST)
Received: from MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU (MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU [18.239.7.11])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m11NgVcV019595
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 Feb 2008 18:42:31 -0500 (EST)
In-Reply-To: <7v4pcs8d4z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72194>


On 1 Feb 2008, at 6:34 PM, Junio C Hamano wrote:

> Michael Witten <mfwitten@MIT.EDU> writes:
>
>> It turns out that --compose will also leave some temporary files
>> behind if git-send-email is terminated out of course.
>>
>> Should I establish a general handler for SIGTERM and SIGINT?
>
> I was mostly worried about ^C leaving the terminal in a funny
> state with your system(stty).
>
> I do not think you should lose the message the user carefully
> composed using an editor upon seeing ^C.  The user may start to
> compose, edit the message, and then at some later time decide to
> stop the mail-sending procedure by ^C-ing out.  The user would
> thank you if you somehow left an escape hatch to allow salvaging
> the message, instead of having it to be re-typed from scratch.

Indeed. How about a message stating that these files exist?

In any case, I'm looking for your endorsement of a signal handler
as the means to solve the main problem.
