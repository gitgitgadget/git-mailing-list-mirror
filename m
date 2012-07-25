From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 16:29:38 -0700
Message-ID: <7vk3xra07x.fsf@alter.siamese.dyndns.org>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org> <5010567B.1060907@pobox.com>
 <7vehnzbmyt.fsf@alter.siamese.dyndns.org> <50106136.5000404@pobox.com>
 <7vsjcfa3ha.fsf@alter.siamese.dyndns.org> <5010798E.6020401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:29:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuB1X-0006Vq-6m
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 01:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2GYX3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 19:29:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab2GYX3l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 19:29:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 951A29226;
	Wed, 25 Jul 2012 19:29:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cpaSy2q6C4hDIPy2k4yNaUWEVkc=; b=F5dbdI
	+Q74mtNbNVsAS+XYf/fH0CGTdkf4/0EoDRPzryY9ZsL9Lonky9+0+7TBdCLjw+bE
	Iwh3uLEK03/dHFO+JffPCjJP3ZFYQF7qcdIQdjuD/p5P+Nbc/yNB2HnC54QzvFYv
	/dmIg4ojctO2/2omSA08XR+55VxExAKueptkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnHSeb/En3XRJe8gOawxgW0KdpaACJeg
	jyJM1qyRUCSmb1yCLmiM3HLGuaFrCxms/dySlSD7IIlyAYaWbroFwqVQAIiWy933
	THd1GourSoplefycYgSwfSV5whNtIe1Cbe7a69fzOUofB5lCBvHWSXYT7m7GsfAi
	etO85n1WumE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A069225;
	Wed, 25 Jul 2012 19:29:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7E709223; Wed, 25 Jul 2012
 19:29:39 -0400 (EDT)
In-Reply-To: <5010798E.6020401@pobox.com> (Michael G. Schwern's message of
 "Wed, 25 Jul 2012 15:56:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AE236FA-D6B0-11E1-931B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202215>

Michael G Schwern <schwern@pobox.com> writes:

> On 2012.7.25 3:19 PM, Junio C Hamano wrote:
>> Michael G Schwern <schwern@pobox.com> writes:
>>> How about the git-svn SVN 1.7 fix in general?  All of these patch sets I'm
>>> sending build on one another, is that going to be a problem?  It's going to
>>> come in about six parts.
>> 
>> Judging from the rate of the discussion this is progressing, I was
>> imagining that this series would be ready by 1.7.13 at the earliest,
>> possibly back-merged to 1.7.12.X maintenance series, and 1.7.11.X
>> maintenance series is no longer relevant by then.
>> 
>> But I certainly do not mind seeing the series based on earlier
>> maintenance releases, e.g. maint-1.7.9.  There however are tons of
>> other git-svn.perl and perl/ updates since then, so basing the
>> series on the current maint branch to abandon 1.7.10.X and earlier
>> but still leaving the door open to downmerge to 1.7.11.X may be a
>> good trade-off.
>
> So... is that master or maint?  Just let me know which one.

I do not care too deeply either way, and in the end I think Eric
should have the final say.

Given that git://git.bogomips.org/git-svn.git/ has 'master' but
nothing to build on 'maint', I would imagine that basing on master
is just fine.

Thanks.
