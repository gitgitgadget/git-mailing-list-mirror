From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] test: add test_write_lines helper
Date: Thu, 24 Apr 2014 11:31:27 -0700
Message-ID: <xmqqwqeevatc.fsf@gitster.dls.corp.google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
	<1398331809-11309-2-git-send-email-mst@redhat.com>
	<20140424170826.GH15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOQq-0007dj-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724AbaDXSbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:31:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbaDXSbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:31:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 593A38035E;
	Thu, 24 Apr 2014 14:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OBjk8d98if3ZRtZB+o8bpA7y7J8=; b=gCvTx+
	AOQUxkM15dXYTj9/B3FjfQNqcyF1UaGYcashKfHXMKHFKGuxxwmxhUIFIzrX8bic
	IKzJSo41r404gVCxwR3j4Qs7qgyNxyK63B2t63i7GZ/PvHN+YD7dozc9cYBsXFsA
	iVkGAfTZH1wBVNOvxabMXfncmEpRm1/iFOzyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kYJjC4ZYtASCcPj2PtOh9qtB47mGMdkI
	uSYkzYRB11aUaeXOi4WZLQhAOY15IFJXJdbMVo/5zwQYyPqRVYVmWvMg3YI+oCVo
	WJ7IovBF9hNKps90cP4oeCQLcRTIcAp8WJ/T3KBFrpE+NAkQlf10Fi8uPT/bwq32
	xryILkqj338=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A4838035C;
	Thu, 24 Apr 2014 14:31:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 498C980357;
	Thu, 24 Apr 2014 14:31:29 -0400 (EDT)
In-Reply-To: <20140424170826.GH15516@google.com> (Jonathan Nieder's message of
	"Thu, 24 Apr 2014 10:08:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A6D6FA5C-CBDE-11E3-84A1-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246988>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Michael S. Tsirkin wrote:
>
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -712,6 +712,11 @@ test_ln_s_add () {
>>  	fi
>>  }
>>  
>> +# This function writes out its parameters, one per line
>> +test_write_lines () {
>> +	printf "%s\n" "$@";
>> +}
>> +
>
> Thanks for fixing this.
>
> Nits:
>
>  * no need for the trailing semicolon

Good eyes.  I was wondering if I wrote that (which I found very
unlikely).

>  * it's probably worth documenting this in t/README as well so people
>    writing new test scripts know what it's about.

Sounds like a good idea.

Thanks.
