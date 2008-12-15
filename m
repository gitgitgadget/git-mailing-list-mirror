From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: make feature_blame return a list
Date: Mon, 15 Dec 2008 23:52:38 +0100
Message-ID: <gi6n3m$kvc$1@ger.gmane.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org> <7v7i61w06k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 23:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCMKK-0004fd-BS
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 23:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbYLOWwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 17:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbYLOWwy
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 17:52:54 -0500
Received: from main.gmane.org ([80.91.229.2]:36130 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbYLOWwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 17:52:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCMIx-0004xN-CL
	for git@vger.kernel.org; Mon, 15 Dec 2008 22:52:47 +0000
Received: from 78.13.57.58 ([78.13.57.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 22:52:47 +0000
Received: from giuseppe.bilotta by 78.13.57.58 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 22:52:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78.13.57.58
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103214>

On Monday 15 December 2008 23:20, Junio C Hamano wrote:

> Matt Kraai <kraai@ftbfs.org> writes:
> 
>> The feature defaults are expected to be a list, but feature_blame was
>> returning a scalar.  This change makes it consistent with the other
>> boolean feature subroutines.
>>
>> Signed-off-by: Matt Kraai <kraai@ftbfs.org>
>> ---
>>  gitweb/gitweb.perl |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 6eb370d..145e712 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -367,12 +367,12 @@ sub feature_blame {
>>      my ($val) = git_get_project_config('blame', '--bool');
>>  
>>      if ($val eq 'true') {
>> -            return 1;
>> +            return (1);
>>      } elsif ($val eq 'false') {
>> -            return 0;
>> +            return (0);
>>      }
>>  
>> -    return $_[0];
>> +    return ($_[0]);
>>  }
> 
> My Perl may be getting rusty, but does the above make any difference?
> How?

It's formally more correct and makes the blame feature fit with the
general feature framework, although the feature works correctly even
without the (). I was actually going to send a similar patch myself, 
having missed it during the cleanup and get/check splitup patchset.

Matt's patch gets my Ack, for what it's worth.


-- 
Giuseppe "Oblomov" Bilotta
