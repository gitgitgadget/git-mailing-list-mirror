From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 12:12:19 -0500
Message-ID: <4B840C73.8020204@gmail.com>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi> <4B83DCB1.5050905@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyJC-00042M-O8
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab0BWRMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:12:24 -0500
Received: from mail001.aei.ca ([206.123.6.130]:51979 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0BWRMW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:12:22 -0500
Received: (qmail 13004 invoked by uid 89); 23 Feb 2010 17:12:20 -0000
Received: by simscan 1.2.0 ppid: 12995, pid: 12998, t: 0.0417s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 23 Feb 2010 17:12:20 -0000
Received: (qmail 8413 invoked by uid 89); 23 Feb 2010 17:12:20 -0000
Received: by simscan 1.2.0 ppid: 8408, pid: 8409, t: 0.5687s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.95.3/m: spam: 3.3.0
X-Spam-Checker-Version: SpamAssassin 3.3.0 (2010-01-18)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FREEMAIL_FROM autolearn=ham version=3.3.0
Received: from dsl-147-130.aei.ca (HELO gorthwop.homeip.net) (66.36.147.130)
  by mail.aei.ca with SMTP; 23 Feb 2010 17:12:19 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <4B83DCB1.5050905@gnu.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140815>

Paolo Bonzini wrote:
> On 02/23/2010 01:33 PM, Ilari Liusvaara wrote:
>> According to relevant RFCs, in addition to alphanumerics, the following
>> characters are valid in URL scheme parts: '+', '-' and '.', but
>> currently only alphanumerics are allowed in remote helper names.
>>
>> Allow those three characters in remote helper names (both 'foo://' and
>> 'foo::' syntax).
> 
> I think '+' could be special-cased in that, for example, "svn+ssh://"
> should still invoke an hypothetic git-remote-svn helper.  There is no
> use yet for this feature, but I'm sure that foreign VCS helpers would
> use it.
> 

Special-casing the + could be useful to simplify support for
"svn::ssh://"-style addresses as both could receive the same URL
("ssh://..").

It would also mean less clutter in the script directory. Instead of
having two scripts, one to catch "helper://.." remote URLs and another
to catch "helper+ssh://.." URLs, the same script would differentiate
between used protocols.

-- 
Gabriel Filion
