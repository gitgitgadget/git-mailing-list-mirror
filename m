From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] http: try http_proxy env var when http.proxy
 config option is not set
Date: Thu, 01 Mar 2012 10:33:37 -0800
Message-ID: <7v7gz4npby.fsf@alter.siamese.dyndns.org>
References: <4F4FBE0F.6020004@seap.minhap.es> <4F4FB5BF.8000904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, peff@peff.net
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Aoz-0002I8-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 19:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab2CASdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 13:33:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035Ab2CASdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 13:33:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 091CA7A01;
	Thu,  1 Mar 2012 13:33:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oCX3g9WhpxXhfMPrLhbQxFx81uU=; b=wXGb+P
	/w+8OfEyJkf+U76dt9RDV3Psz7EKmUJnG90QpyFAhYLf4drGcfIMrTKuKwn07023
	N7PlCFzLmm3aXiSPEjV64ys7gWNq1xHVru6T9i/YtCq20aQUiob2QFwKa5RjO/sK
	fI81/3KH7iD3fef1s3MBlRmw4Is87dbuG+jRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZFfToBmkyeyu9lwTILIYlXnDk19FcEI
	m4O2Vwk5NIlhVSmLRGniKv7xZjjaXX80ypAtzT93WSrwc0KrDohad2jPp1WQtXV7
	Maqpaww0Yq4QQInCWbRMTOgmgxzALKLXf3a+Q+U/fDv4ndKkkoFQk2CYsVZ3e67v
	JW55MVQ0VjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1ECB79FF;
	Thu,  1 Mar 2012 13:33:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E73479FD; Thu,  1 Mar 2012
 13:33:38 -0500 (EST)
In-Reply-To: <4F4FB5BF.8000904@vilain.net> (Sam Vilain's message of "Thu, 01
 Mar 2012 09:45:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FEFB9EC-63CD-11E1-BAA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191955>

Sam Vilain <sam@vilain.net> writes:

> On 3/1/12 10:21 AM, Nelson Benitez Leon wrote:
>> CuRL already reads it, but if $http_proxy has username but no password
>> curl will not ask you for the password.. so we read it ourselves to
>> detect that and ask for the password.
>
> That's not what this change does.  This change explicitly loads from
> the environment the 'http_proxy' variable and sets up curl to use it.
> As Junio said, this is (on its own) a regression.

Just to make sure there is no understanding down the road, I only
expressed a concern that this _might_ be a regression. That Mac OS X
behaviour is not something I observed first-hand.
