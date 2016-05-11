From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pre-Process Files for Commits and Pulls
Date: Wed, 11 May 2016 14:38:00 -0700
Message-ID: <xmqq37pojmx3.fsf@gitster.mtv.corp.google.com>
References: <CALo8eZyX+vPMxVzeQgrhn0G+x44myvPot-EqC=DACEo3OwDwQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Brandon Teska <brandon.teska@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 23:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bpa-0001H0-QW
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcEKViF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:38:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766AbcEKViE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:38:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 012361968A;
	Wed, 11 May 2016 17:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8UVAtiAdgM4TfF2VPqY/PQHRy0A=; b=fOnBpb
	4sCkE1pRAq33rUq6X0G/gZPyz3IcgZW07MCsToQA0v8v3CptTUgdWVOXjm10FfWH
	nTABGjQ1kFB/fFLPkUgn+mqxUFPjATc5GBahJcqFjpVk8kk5Whq3KnBKK1gqxq+4
	DbtTPEjvot2mun+FrOLqep8F/jIYHalLZrey8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFBcdME6+smixuUZEbaCt232HMOvX0MJ
	YCBIRyuHkM9BZqoegsUrFKtXXDaJHl99pBlGw1zKgu28Hzy2CcWNOG4+9t6kennU
	iMuCRdHjI2qeNvDNWlYu/VKIczmrhWE4vFTncV7x+YjUa0B7ttmuLAzO5dZ65WFf
	MybrcnbkN3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED0CF1967F;
	Wed, 11 May 2016 17:38:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68ACC1967D;
	Wed, 11 May 2016 17:38:02 -0400 (EDT)
In-Reply-To: <CALo8eZyX+vPMxVzeQgrhn0G+x44myvPot-EqC=DACEo3OwDwQA@mail.gmail.com>
	(Brandon Teska's message of "Wed, 11 May 2016 14:45:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A36DF110-17C0-11E6-A88B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294370>

Brandon Teska <brandon.teska@gmail.com> writes:

> 1. Person A works on (binary) file locally
> 2. Person A commits and pushes to the repo
> 3. Before the push, a script deconstructs the binary file into several
> text files
> 4. Those text files are pushed

A smudge/clean filter pair is how this is done, but you need to drop
"several text files" from the requirement.
