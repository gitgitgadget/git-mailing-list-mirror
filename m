From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 02 Aug 2012 11:58:08 -0700
Message-ID: <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net> <20120802160753.GA17158@copier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx0bb-000073-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2HBS6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 14:58:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab2HBS6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 14:58:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444FD914B;
	Thu,  2 Aug 2012 14:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZJmW1ONg9CZUb1gmrXTNYT+eSuQ=; b=jedrhB
	dAvGUZzwOw4aWsEXycAnSGdXXjRp9UFvJSNfPri+SARI8iM0nWISwGy1peRiEc/K
	VkAV+nnKqUVumuxfgbYjRCCwnE1CBUuSRtNrx3+yCfmtC0amz2vhVukYfTnIxT7O
	RTyM3Pa21usFGMF+mJZiG3Nw6T0vEDtpo1k94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrsO6oSdnNPmgwNrc3L0oipsdy6JalIN
	+sRMSXB0KRk54W/4/b6HOePOno8Po4h6FpJOg/5Mzmhe5xGOs5YpXbZ4DHKM3DAJ
	76jwxYEaUUDyMJh09wjfMhPfoS7t0EVnUpXJhw8cu+2nKQEb8X745ucmkANgxl0N
	/b5XE7cHIrg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3034A914A;
	Thu,  2 Aug 2012 14:58:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3A3F9149; Thu,  2 Aug 2012
 14:58:09 -0400 (EDT)
In-Reply-To: <20120802160753.GA17158@copier> (Jonathan Nieder's message of
 "Thu, 2 Aug 2012 09:07:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0076D0B0-DCD4-11E1-A7FE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202786>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Eric Wong wrote:
>> "Michael G. Schwern" <schwern@pobox.com> wrote:
>
>>> This patch series fixes git-svn for SVN 1.7 tested against SVN 1.7.5 and
>>> 1.6.18.  Patch 7/8 is where SVN 1.7 starts passing.
>>
>> Thanks Michael.  I've made minor editorial changes (mostly rewording
>> commit titles to fit the larger project).
>
> Thanks from me as well.  I'm still worried about whether the increased
> use of canonicalize_url will introduce regressions for the existing
> SVN 1.6 support, and I should have time to look it over this weekend.

Likewise.  I'd prefer to see it cook during the feature freeze and
not merge to 'master' until post 1.7.12 cycle opens.
