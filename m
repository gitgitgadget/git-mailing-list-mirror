From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-send-email: ssh/login style password requests
Date: Fri, 1 Feb 2008 17:42:12 -0500
Message-ID: <5F77BB5B-8D2B-42FD-A805-7195757B14EE@mit.edu>
References: <1201841954-17949-1-git-send-email-mfwitten@mit.edu> <7vodb19edp.fsf@gitster.siamese.dyndns.org> <FE992810-2B2E-4C23-A7D3-AD4C39D925ED@MIT.EDU>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 23:43:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL4bF-0002gf-M0
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 23:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbYBAWmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 17:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYBAWmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 17:42:16 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35864 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756414AbYBAWmP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 17:42:15 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m11MgDBM029380
	for <git@vger.kernel.org>; Fri, 1 Feb 2008 17:42:13 -0500 (EST)
Received: from MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU (MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU [18.239.7.11])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m11MgCeg007373
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 1 Feb 2008 17:42:13 -0500 (EST)
In-Reply-To: <FE992810-2B2E-4C23-A7D3-AD4C39D925ED@MIT.EDU>
X-Mailer: Apple Mail (2.915)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72187>


On 1 Feb 2008, at 1:38 PM, Michael Witten wrote:

>> I like what the patch tries to do, but the system() there feels
>> a tad ugly.  In addition it makes me wonder (1) what happens if
>> you ^C out from this while loop
>
> Good question! Though I'm not sure you can handle this any other
> way than to intercept the signal.

It turns out that --compose will also leave some temporary files
behind if git-send-email is terminated out of course.

Should I establish a general handler for SIGTERM and SIGINT?

Michael Witten
