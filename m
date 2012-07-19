From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] autoconf: remove some redundant shell indirections
Date: Thu, 19 Jul 2012 10:24:21 -0700
Message-ID: <7vfw8nvf3u.fsf@alter.siamese.dyndns.org>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
 <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com> <7v394owq3l.fsf@alter.siamese.dyndns.org> <5007B7B1.8000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SruSj-0003v7-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab2GSRYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab2GSRYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:24:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7455378B4;
	Thu, 19 Jul 2012 13:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6U/3nMwnBKog9z7iuhBPjhQoNYY=; b=r5vRbj
	b+CE8GOmqVDh8yv25khGXwmv3XYNRDzOdMpAPWIjnuntnjN0r1JKBKWrTa7RltKA
	dXhggxkXDD5bwy5MoCAwU3Vaq8xC9pUz7O5LGmHlaMUUpLcgPBzkLHM4Tr+EXcXY
	X987b1molWo07TmJDNqWtyrfi2FbJbeV3dV0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0CZJJaY3OZrUMU4UVzsEq9Vz0WAJyH1
	WRYsDQ+Gvba21SuV1kfHC8Sat8sWcGWlx214+zMSgl9QvD7c2utQn+ytiNzDHfNb
	8PEz0MqAM8AAbY0HMhBSHXOrJK6aKkgIheAxNWh2pBWr0BPZrNWG53O3jyi1XWDm
	w5pU1LCQMho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6205578B3;
	Thu, 19 Jul 2012 13:24:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CFA78B1; Thu, 19 Jul 2012
 13:24:22 -0400 (EDT)
In-Reply-To: <5007B7B1.8000909@gmail.com> (Stefano Lattarini's message of
 "Thu, 19 Jul 2012 09:30:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94CC2936-D1C6-11E1-A1D5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201744>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 07/19/2012 02:29 AM, Junio C Hamano wrote:
>> 
>> The inconsistency between the existing one that does not quote the
>> string that is not substituted, i.e.
>> 
>> 	GIT_UC_PROGRAM[]_PATH=$withval
>> 
>> and the new one that quotes _PATH, i.e.
>> 
>> 	GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])
>> 
>> looks somewhat strange, though.
>>
> Will fix that in the re-roll.

I see you already used the []_PATH in your reroll, and I do not
think it matters either way in pracice, but I suspect that it is
technically more correct to have _PATH part inside the bra-ket
quotes (of course, changing the style to maximally quote like that
is a totally different topic, and should be done as a separate
patch, so I think your reroll is the right thing to do within the
scope of this series).

Thanks.
