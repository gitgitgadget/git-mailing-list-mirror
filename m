From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 02 Aug 2012 14:22:03 -0700
Message-ID: <7vmx2dc7lw.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net> <20120802160753.GA17158@copier>
 <20120802205123.GA14391@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx2qU-0005sJ-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 23:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab2HBVWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 17:22:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab2HBVWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 17:22:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C914A9AD9;
	Thu,  2 Aug 2012 17:22:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8De7m99DDbun7COBR5kpmaClwTI=; b=MnhIEX
	0CE4S/qaL3pO01XOJhLpnETjKQ/widsZ9HomIs9pf1nVO/JxWBadhGDQVqlptnIv
	swb6/xNF5tY6aIq/CFB4c1rRPqT0wjy1+Zkj8YReEJWOeVxcwK/RLqqeqen/3abc
	eXe0JIPb+2FiVrSA3XA57ASl4SsuxUrvW5Q9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Avy7SaCsCHJZsO7A8VQiFnRypvdWu+4Z
	rE8M0S5DELNUOcDO6JkDs4PNjllH1blJNUkRVibkzkRkiwQntIxg1Bf1Tk4x0juK
	jAJG5Q056asxFwoKWTrJx0rmmjLyBe99eoSM1O/vREoRnv2RhyQNDKByugy6fVYQ
	Bf5H12CqLwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B761E9AD8;
	Thu,  2 Aug 2012 17:22:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23C579AD6; Thu,  2 Aug 2012
 17:22:05 -0400 (EDT)
In-Reply-To: <20120802205123.GA14391@dcvr.yhbt.net> (Eric Wong's message of
 "Thu, 2 Aug 2012 20:51:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B9BF85C-DCE8-11E1-A015-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202795>

Eric Wong <normalperson@yhbt.net> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Thanks from me as well.  I'm still worried about whether the increased
>> use of canonicalize_url will introduce regressions for the existing
>> SVN 1.6 support, and I should have time to look it over this weekend.
>> 
>> The comment in canonicalize_url "There wasn't a 1.6 way to do it" is
>> not true.  The relevant thread on the git list had a little
>> conversation about keeping svn 1.4 support, but I'm not sure why
>> that's relevant, given that svn_canonicalize_path has worked largely
>> the same way starting with SVN 1.1 (and on the other hand had
>> significant changes in SVN 1.7).
>> 
>> Hopefully you've looked this over carefully already and I'm worrying
>> needlessly.
>
> Thanks for reminding me, I went back to an old chroot 1.4.2 indeed
> does fail canonicalization.
>
> Will bisect and squash a fix in.

Oops; should I eject this out of next and wait for a reroll, then?
