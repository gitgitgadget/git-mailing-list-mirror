From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Sat, 11 Feb 2012 07:33:57 +0100
Message-ID: <4F360BD5.80006@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org> <4EE6E61F.8080405@alum.mit.edu> <7vk461vuy9.fsf@alter.siamese.dyndns.org> <4EE7A387.3070400@alum.mit.edu> <4EE7CDF2.3040408@alum.mit.edu> <7vzkewt5qu.fsf@alter.siamese.dyndns.org> <4F158E99.2020906@alum.mit.edu> <4F352F03.2030104@alum.mit.edu> <20120210204457.GD5504@sigill.intra.peff.net> <7v62fepew8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6XN-0007dX-2k
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab2BKGeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:34:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50540 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab2BKGeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:34:15 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED675.dip.t-dialin.net [84.190.214.117])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6XwvJ019720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 11 Feb 2012 07:33:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7v62fepew8.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190493>

On 02/10/2012 10:17 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>> If everything_local() is trying to check that the references are in the
>>> local repository plus alternates, then it is incorrect that
>>> everything_local() doesn't consider alternate references in its
>>> determination.  My guess is that this is the case, and that something
>>> like the following might be the fix:
>>
>> Junio could answer more authoritatively than I, but I am pretty sure it
>> is the latter. The point is to skip the expensive find_common
>> negotiation if we know that there are no objects to fetch. Thus the
>> "local" here is "do we have them on this side of the git-protocol
>> connection", not "do we have them in our non-alternates repository".
> 
> Correct.  The function is about "do we need to get any object from the
> other side?" optimization.

Thanks for your feedback.  I have just submitted a patch series [1] that
attempts to fix this problem.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/190488

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
