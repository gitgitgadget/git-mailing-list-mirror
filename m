From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] Add url.<base>.pushInsteadOf: URL rewriting for
 push only
Date: Tue, 08 Sep 2009 00:02:42 -0700
Message-ID: <7vws49gbql.fsf@alter.siamese.dyndns.org>
References: <cover.1252313313.git.josh@joshtriplett.org>
 <5e58748923d9b4a182499a6ba8fa4636bce4810e.1252313313.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkujC-0002iC-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZIHHCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbZIHHCq
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:02:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbZIHHCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:02:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 921C72A0EB;
	Tue,  8 Sep 2009 03:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Qdp+FcpmjVfJyOCnHI1nI8ZX1EU=; b=i91mv9X3bsPjvC6ik4/PNqQ
	P45DeuP8kLXCOeN2SV4Zh3exERWSK0k0L75XczMRqVOSpow8PQT5qmpFg5S9Eauj
	cfLUvnANoQWRso6hhIA9/bbVQS+nvjVx5iSdipIjt1P46dJOcFrEmrratymk6N+J
	AMGIQPYvc7MbXI+dugU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=abBYNmJAoBSXU2hF5mKtBHfh7R3Pg1LoQ/en2q1y540voHTak
	8zKmo2rRYO0JNW0PBosA9JmZnTNzwlljAirbdMXZTVWUwJOrcWeVoYUSceKIgC94
	kRfvgLqMIA+EIs7LcoTvqY/dP3yqVXb9gM/2S7e+cF688sSxFVnjLBwJS4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 769E42A0E9;
	Tue,  8 Sep 2009 03:02:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9DEF2A0E7; Tue,  8 Sep
 2009 03:02:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CC635BE-9C45-11DE-9D31-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127979>

Josh Triplett <josh@joshtriplett.org> writes:

> This configuration option allows systematically rewriting fetch-only
> URLs to push-capable URLs when used with push.  For instance:
>
> [url "ssh://example.org/"]
>     pushInsteadOf = "git://example.org/"
>
> This will allow clones of "git://example.org/path/to/repo" to
> subsequently push to "ssh://example.org/path/to/repo", without manually
> configuring pushurl for that remote.
>
> Includes documentation for the new option, bash completion updates, and
> test cases (both that pushInsteadOf applies to push and that it does
> *not* apply to fetch).

Thanks.

I will queue these patches, but I presume you would also want to add a
test that pushInsteadOf is ignored for remotes with an explicit pushURL?
