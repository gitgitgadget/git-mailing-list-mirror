From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge-friendly text-based data storage
Date: Mon, 26 Mar 2012 11:17:45 -0700
Message-ID: <7vfwcvp6pi.fsf@alter.siamese.dyndns.org>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEUL-0006Ls-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963Ab2CZSRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:17:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932830Ab2CZSRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:17:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E7AC75CB;
	Mon, 26 Mar 2012 14:17:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fTFGCq/5QKOivXAO5zptwKhhj8w=; b=G1Wp3E
	bO7x3jp4O2Mn/m2EhpJBFffuNBLDuMq45Qe0GB4d+V016bNW3CZyKQ0XefsOupJf
	/6hYcEKRp1K6b9gXT4/+MK72fSfYK9FYsclTzYzFMXsiiLfb+GEXPiAHfvta81sm
	2YW4EXMKgIsz3ZMo1McjB1JS+hGVyKK547suU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REvcRLbYmfnAc044TpPLLQ1Uv8th2FHs
	yiawlZ4WykOtveHYV09TQftog1C/GxB04NJky1jn/QDCdElN+e9jYRdclOoN4nNx
	rZ7QfpGSSzpHh6rTOXgAa6bMIPfBsNbJ5WFPn7z5UBTTgFpTIzazY3aOGhd4wgH1
	7fWcVGb01Fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958EC75CA;
	Mon, 26 Mar 2012 14:17:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30FFB75C9; Mon, 26 Mar 2012
 14:17:47 -0400 (EDT)
In-Reply-To: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com> (Richard
 Hartmann's message of "Mon, 26 Mar 2012 16:19:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD45C7C6-776F-11E1-B38B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193947>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> As long as there are no lines that start with the same file name, this
> file format would allow for efficient merging _if_ git has an internal
> concept of line identifiers.

You can write a custom low-level merge driver, and use the attribute
system to mark that your file is meant to be handled by that ll-merge
driver.  There is no need for Git to have "an internal concept of line
identifiers".

It may be of interest to run "git help attributes" and read up on
"Defining a custom merge driver" section.
