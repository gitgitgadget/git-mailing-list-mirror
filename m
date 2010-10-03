From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 5/6] Introduce the git fast-import-helper
Date: Sun, 03 Oct 2010 17:45:08 +0200
Message-ID: <4CA8A504.50009@dbservice.com>
References: <4CA86A12.6080905@dbservice.com> <1286108511-55876-5-git-send-email-tom@dbservice.com> <20101003153144.GA18001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 17:46:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Qle-0002CH-C9
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 17:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab0JCPpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 11:45:15 -0400
Received: from office.neopsis.com ([78.46.209.98]:35932 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab0JCPpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 11:45:14 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 3 Oct 2010 17:45:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20101003153144.GA18001@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157883>

On 10/3/10 5:31 PM, Jonathan Nieder wrote:
> Tomas Carnecky wrote:
> 
>>  fast-import-helper.c | 2201 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Aaa!  Could someone send a diff of this against the usual fast-import.c?
> 
> I'm sure you won't be surprised to hear I am not optimistic about the
> long-term maintainability of two separate fast-import implementations.
> If we get usability improvements by patching the existing fast-import,
> that would be much better.

I agree. But when I started hacking on fast-import it seemed easier to
completely rip out parts that I didn't need and then add the few bits
that I needed. I only need two new things from fast-import:
  1) support non-numeric marks (and even this is maybe not strictly
required)
  2) dump the mark->sha1 mapping immediately after creating the object
(I heard there is a patch somewhere that does just that)
All other changes are not needed. Though I think there are a few things
which could be ported back to fast-import.c. I'll try to see which
changes make sense to be backported and will post patches.

tom
