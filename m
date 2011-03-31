From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: update help text
Date: Thu, 31 Mar 2011 11:45:35 -0700
Message-ID: <7v4o6jku28.fsf@alter.siamese.dyndns.org>
References: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
 <20110329210457.GA14031@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:46:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Msb-0002Wr-9v
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759064Ab1CaSp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:45:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759060Ab1CaSpz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:45:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2690E35BE;
	Thu, 31 Mar 2011 14:47:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8TqzJjhab9fwlIE3krTnlRWHY5Y=; b=iSDWW/
	lziFtsn61xMQBEhhdVE43QiHApTpF0IlN4RKl3lMK1pMucfnw16r9HiF/hykEBlr
	USousqpRswYESuLqA9/UtST2GjjPvxfM7XuIxMlS8UYDJ20GTDnjIgfhMG/SL72s
	+5P2UuZk8QEygHybYTTZf7yTknyYgBhhyBr1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IdfUpyegUnN7kGY7lF5//USRIv39AXCe
	f4q7znZnnsjo2rzgElIbHZJSan3HpXd0fugM/GQy0K3uc8+LxYOudj6pFNC2wmn9
	+aFUwdwSZd/mEA8UBEFjRJ8CbpAKDRbyEAw8r/FAb2nXjcjdsZAn7DdICFHPuItI
	jK2sBx9yMf4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8F9935AE;
	Thu, 31 Mar 2011 14:47:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6717335A7; Thu, 31 Mar 2011
 14:47:26 -0400 (EDT)
In-Reply-To: <20110329210457.GA14031@elie> (Jonathan Nieder's message of
 "Tue, 29 Mar 2011 16:04:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58281D80-5BC7-11E0-80CF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170516>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The description does not make it obvious to me how these two (--merge
> and --keep) differ.  I think the intent of the options are:
>
>  --keep:
> 	start working on a different commit, carrying over local changes
> 	(like "git checkout")
>  --merge:
> 	return to <commit>, cancelling a merge-like operation that
> 	creates some unmerged and some clean index entries
>
> Maybe something along these lines could be ok starting point?
>
> 	OPT_SET_INT(0, "keep", &reset_type,
> 		"move to <commit>, carrying over local changes in working tree",
> 		KEEP),
> 	OPT_SET_INT(0, "merge", &reset_type,
> 		"return to <commit>, cancelling failed merge or cherry-pick",
> 		MERGE),

I cannot think of anything better, but I can still show my concern that
"move to" and "return to" might not convey exactly what we are trying to
express.

But I agree that your phrasing definitely is a good starting point.
