From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Submodules: have a depth field in the .gitmodules file
Date: Wed, 25 May 2016 15:38:57 -0700
Message-ID: <xmqqeg8pzrsu.fsf@gitster.mtv.corp.google.com>
References: <20160525220006.27138-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:39:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hSO-0000Ky-82
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcEYWjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:39:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480AbcEYWjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:39:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEC1E1E115;
	Wed, 25 May 2016 18:38:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sX81uh+/WgJyGU7Xd/ZYJz4n3UI=; b=HhqG3z
	j7ik36IyBv6XnI5A9tfyvyR1N/G2kJIcAwLRtMWpUwIM/hAD88LPhNDmVzrrAj/q
	8Ndn0mw/GYKlNb4E0ftBJowQyfcT3SKQQ8Z8x5TV/4etFJwRWo7LGixYn+/IraHM
	53Tb3ngjbTT+o3SCFFKifLz1dtb9Ik/FlhkZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pCL6nI/DYIhPIckypnJa2PFGtVvzydk0
	imSpy1IlKVieOnTmrIswXEYI9/bdyA/p4TYr+Z5AbGm/tAFaVgCWfZfyBNJCYrY5
	jHCtOYDd1GTz1EGiLczg8Mule4pYAlZWvXMRdPs8mu1ISrDL4ksSy0sH6sok44PV
	9eDR5K0EVmI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DCBBC1E113;
	Wed, 25 May 2016 18:38:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DF711E112;
	Wed, 25 May 2016 18:38:59 -0400 (EDT)
In-Reply-To: <20160525220006.27138-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 25 May 2016 15:00:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78E365BA-22C9-11E6-BFAE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295600>

Stefan Beller <sbeller@google.com> writes:

> Sometimes the history of a submodule is not considered important by
> the projects upstream. To make it easier for downstream users, allow
> a field 'submodule.<name>.depth' in .gitmodules, which can be used
> to indicate the recommended depth.

Hmph.  I can understand and certainly agree with the first sentence,
but I am not sure if "depth", if it is anything other than "1" or
"infinity", is a reasonable value.

I'd understand if a project wants to say something like "at this
moment, history before v2.0 tag does not matter", though.
