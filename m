From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: keep leading slash when canonicalizing paths
 (fallback case)
Date: Fri, 05 Oct 2012 22:36:46 -0700
Message-ID: <7vfw5srwk1.fsf@alter.siamese.dyndns.org>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino> <5014387C.50903@pobox.com>
 <20121005070430.GA23572@elie.Belkin> <20121005231207.GA22903@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 07:36:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKN4M-0002kB-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 07:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2JFFgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 01:36:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2JFFgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 01:36:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9211E448C;
	Sat,  6 Oct 2012 01:36:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jTHNVF9OUS2k5MZS9H+hHNeGk9E=; b=rgka2r
	+/3wf0M6Eudsb3txfJjtHveZC2ahu1Z36VjBxGIuYxRmduPxytqZAxIAnSBkRQQE
	3JhX+1Ns+m4v/cTHJqVU6g8+KtFbgUO/R1U0Bwj4PtMvAL0xFbWo9COsLs6Zd5f0
	ozDEpebAaavxvG5OVZF8BZ1AL5i833DJBOIDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAQklgWfhAqELnm9qUKkcASPFYKNzbam
	jVbt8kEv7uN1XTDuw/9k2K/tVdpWrTVOx7DHIjt8DMLOwmOuR1jPTUZ1kBF11lyr
	zradTbkG55/2n0lzapmySqVHH8XjBQWWv6SNw5ln8tqwk8jJWQtnu8S+ztlNNr6M
	s4PaW9a4m28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FEB7448B;
	Sat,  6 Oct 2012 01:36:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED9874489; Sat,  6 Oct 2012
 01:36:47 -0400 (EDT)
In-Reply-To: <20121005231207.GA22903@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 5 Oct 2012 23:12:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D266CCDA-0F77-11E2-B900-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207131>

Eric Wong <normalperson@yhbt.net> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Noticed by forcing the fallback on and running tests.  Without this
>> patch, t9101.4 fails:
>> 
>>  Bad URL passed to RA layer: Unable to open an ra_local session to \
>>  URL: Local URL 'file://homejrnsrcgit-scratch/t/trash%20directory.\
>>  t9101-git-svn-props/svnrepo' contains unsupported hostname at \
>>  /home/jrn/src/git-scratch/perl/blib/lib/Git/SVN.pm line 148
>> 
>> With it, the git-svn tests pass again.
>> 
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for noticing this.
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> and pushed to my master at git://bogomips.org/git-svn

Will pull before 1.8.0-rc1.  Thanks.
