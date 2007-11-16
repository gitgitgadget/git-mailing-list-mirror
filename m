From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 22:35:38 +0100
Organization: glandium.org
Message-ID: <20071116213538.GA30076@glandium.org>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org> <1195244917-25659-1-git-send-email-mh@glandium.org> <EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr> <20071116211148.GA28966@glandium.org> <EC3B30DC-E81C-4ECA-BE7F-F237E1338603@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:37:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It8sD-00059j-2v
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 22:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbXKPVg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbXKPVg4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 16:36:56 -0500
Received: from vawad.err.no ([85.19.200.177]:43683 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757572AbXKPVgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 16:36:55 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It8rl-0002fR-7y; Fri, 16 Nov 2007 22:36:47 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It8qg-0007qq-OM; Fri, 16 Nov 2007 22:35:38 +0100
Content-Disposition: inline
In-Reply-To: <EC3B30DC-E81C-4ECA-BE7F-F237E1338603@lrde.epita.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65249>

On Fri, Nov 16, 2007 at 10:31:15PM +0100, Benoit Sigoure wrote:
> On Nov 16, 2007, at 10:11 PM, Mike Hommey wrote:
>
>> On Fri, Nov 16, 2007 at 10:04:57PM +0100, Benoit Sigoure wrote:
>>> On Nov 16, 2007, at 9:28 PM, Mike Hommey wrote:
>>>>  test_expect_success \
>>>>  	'message in editor has initial comment' '
>>>>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>>>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>>>> +	( read empty ;
>>>> +	  [ "$empty" ] && exit 1 ;
>>>
>>> What is this meant to do?  Did you mean [ -n "$empty" ] ?
>>
>> Replacing with [ -n "$empty" ] would not work properly, except if you
>> replace the following ; with &&. Does that really make a readability
>> difference ?
>
> I don't get it.  As far as I understand, you're trying to check whether 
> $empty is indeed empty, right?  So how is `[ "$empty" ]' meant to work?
>   [ -n "$empty" ] && exit 1
>
> will exit 1 if empty isn't empty.

Sorry, I read '-z', not '-n'. [ "$empty" ] and [ -n "$empty" ] are the
same thing.

Mike
