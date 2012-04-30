From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Sun, 29 Apr 2012 18:21:05 -0700
Message-ID: <7vk40yhv5q.fsf@alter.siamese.dyndns.org>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <20120427082118.GA7257@dcvr.yhbt.net>
 <20120427082559.GC4023@login.drsnuggles.stderr.nl>
 <20120429082341.GA32664@dcvr.yhbt.net>
 <7vvckihyqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 03:21:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOfJD-0002z7-IE
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 03:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab2D3BVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 21:21:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab2D3BVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 21:21:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0460183FD;
	Sun, 29 Apr 2012 21:21:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hV1iH/+AqGvh9/Qj+JewBnRLKnw=; b=auzf5Z
	iRnsnrFw/GQZ95hnFeuZUP4qkuq4xpo6e+u/3HgYwJ9HaFq/HDBSozpXyk2bNR+M
	BlUQb2McwQLorw83naOQ0zzV6bsTVnT9LHIDXy+vRHMGkAOz6ZPyc9JCY/OnRAUA
	N/LjRQ5hBp0Lpv2cJoBjNdmnLSkUp4U7a+rm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XqEoiI7L8geMYDOY43bDwklbs5kucHXK
	ueb9ENr+XkT/lcjY0M8Tjt1YDU4hHbLZqUlexDV7p6tBbda/dszI/mkBVVVbBPcl
	dNvl/n5fTp7VVt0OJtcvO2gHxKOME647Y2yjZR0acQE+LTnJ/MFo15o7m4IU1hWx
	JsR0g2tNCqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFBB583FC;
	Sun, 29 Apr 2012 21:21:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78C0E83FB; Sun, 29 Apr 2012
 21:21:06 -0400 (EDT)
In-Reply-To: <7vvckihyqm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 29 Apr 2012 17:03:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C27A1DF0-9262-11E1-A03D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196532>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <normalperson@yhbt.net> writes:
>
>> Matthijs Kooijman <matthijs@stdin.nl> wrote:
>>> > > On Linux, this makes authentication using passwords from gnome-keyring
>>> > > and kwallet work (only the former was tested). On Mac OS X, this allows
>>> > > using the OS X Keychain.
>>> Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>
>>
>> Thanks Matthijs, pushed to master of git://bogomips.org/git-svn for
>> Junio.
>>
>> (actually pushed the other night, but I got distracted before
>>  sending this email :x)
>
> Thanks. Pulled.

As I am already too deep into today's integration round, I will not be
rewinding this pull anymore, but on one of my Ubuntu 10.04 boxes, I am
seeing this:

    Initialized empty Git repository in
    /srv/git/t/trash directory.t9118-git-svn-funky-branch-names/project/.git/
    ValueError svn_auth_get_platform_specific_client_providers is not implemented yet

So the tip of 'master' may be broken for some "git svn" users.
