From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Mon, 15 Mar 2010 01:37:18 -0700
Message-ID: <7v7hpeyo8x.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock> <20100315074748.GA28827@progeny.tock>
 <20100315074909.GA8824@progeny.tock>
 <7vzl2a0zud.fsf@alter.siamese.dyndns.org>
 <20100315083521.GB10068@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5no-0007rf-LN
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759895Ab0COIh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:37:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759885Ab0COIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:37:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 280E6A1FF7;
	Mon, 15 Mar 2010 04:37:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a++e8ThnIIsadKVBuGaIV2vMvh8=; b=VLFQLA
	zj9o9sSYNdrLSkR3o3g1IXm1TiuHsvnV0iQQ6BdQikfb8SOJhhS4yyiz9uhzgdkj
	9tb/ULvgz5IMqWdi0jdurizg65ofXsoA8hSbf4sfTeULy1WhtcbOY4HAyv3oE6Dm
	+8RMp5HucV75Sc6m84tya0Y/Nl+EMmzfKZSL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cx42SO9olu5SB9r7z4B0WPhJDHv+6YiD
	oFcmnG2yzA93VD2KrrF/t9rDu1gb2sLWwJ37bBCYDuCyyP4NtpYSVodknZ8ofbRK
	SMcQZN4YLiQCY6dSHV43uFCTqWH3pauAXZY6fmkwA6SdeDr/gFqm5kkFSue+seAH
	q70q9CWI7ZA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6F4A1FF2;
	Mon, 15 Mar 2010 04:37:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4517FA1FEB; Mon, 15 Mar
 2010 04:37:19 -0400 (EDT)
In-Reply-To: <20100315083521.GB10068@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 15 Mar 2010 03\:35\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA787F1C-300D-11DF-A8B9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142193>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I think this patch itself makes sense, but if you were to add one name to
>> xmparam structure, wouldn't it make sense to store all three names in
>> there?
>
> Good idea.  Will do.

That would also mean that existing name1 and name2 arguments many
functions (starting from xdl_merge()) have will go.
