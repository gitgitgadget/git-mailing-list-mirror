From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] notes_merge_commit(): do not pass temporary buffer to
 other function
Date: Wed, 28 Sep 2011 04:50:20 +0200
Message-ID: <4E828B6C.1010707@alum.mit.edu>
References: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu> <7vd3elyl8t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 04:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8kEA-0001Fw-R3
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 04:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab1I1Cu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 22:50:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38721 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab1I1CuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 22:50:25 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEB79A.dip.t-dialin.net [84.190.183.154])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8S2oLCq022708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 28 Sep 2011 04:50:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vd3elyl8t.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182285>

On 09/27/2011 06:59 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I discovered this problem when an innocent modification to unrelated
>> code triggered test failures.
>>
>>  notes-merge.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git notes-merge.c notes-merge.c
>> index e1aaf43..baaf31f 100644
>> --- notes-merge.c
>> +++ notes-merge.c
> 
> It is Ok to play with -p0 yourself but please don't do that in the public.

Sorry; I had set diff.noprefix=true, not realizing that it would affect
things like "git format-patch".  It also confused emacs' magit mode, and
probably some other tools.  It's now set permanently back to false.

The reason I was experimenting with this option is that it is a quick
double-click to select a filename like "foo/bar" in the diff output,
whereas selecting the filename out of "a/foo/bar" requires a slower
click and drag.  Once I considered whether git could be taught to
explicitly ignore the "[ab]/" prefix when parsing filenames, but that is
too evil even for me :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
