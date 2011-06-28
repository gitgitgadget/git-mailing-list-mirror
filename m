From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: quote double-dash in "<commit> --
 <filename>" for AsciiDoc
Date: Tue, 28 Jun 2011 14:22:45 -0700
Message-ID: <7vaad1tzve.fsf@alter.siamese.dyndns.org>
References: <20110628171748.GA11485@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 23:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbfkF-0005tF-Ct
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 23:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab1F1VWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 17:22:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1F1VWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 17:22:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D5C24E54;
	Tue, 28 Jun 2011 17:25:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hw6Pn2jzzBzHFdSdhbxIVU3WFn4=; b=LeOj9E
	RtiymWPqGUhyTU8+ajLK4yQ+QFyDxlKiV3RNwVbPmfs4dMbR+iklUGavdiJ19pjj
	G/UbxfGu/Ixb6jDhRY9NZGnc9pomVHoKQwvDiBIKFwcb6KZKUVzE60HBuJZBJI1v
	0P6NNpAUwAFm6ZAoGNHOIxC2CY5rZ3jdwO2eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykAo4YxoiHet+JgHoTP0OueLkK8/dlWh
	F6kEjLHQz0nitxD2HabYQLdgFCf7dvzXY5co3/t6AvVmzzUrIyPUNyrEwM057z/K
	0XXtEt44zQTebq9h+lUEu3soBCGXIutg9VJmrN5KmRgjrPANsIDHe2Jrxpttrz+K
	qO+SAp/Hkuc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F1CDA4E53;
	Tue, 28 Jun 2011 17:25:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D9C34E52; Tue, 28 Jun 2011
 17:25:00 -0400 (EDT)
In-Reply-To: <20110628171748.GA11485@elie> (Jonathan Nieder's message of
 "Tue, 28 Jun 2011 12:17:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 144BAD42-A1CD-11E0-90E8-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176419>

Jonathan Nieder <jrnieder@gmail.com> writes:

> As explained in v1.7.3-rc0~13^2 (Work around em-dash handling in newer
> AsciiDoc, 2010-08-23), outside of verbatim environments, newish
> versions of AsciiDoc will convert double hyphens to en dashes.  Use
> the litdd syntax introduced by that patch to avoid such misformatting
> in sentences where "--" represents the two-character "end of options"
> argument that separates revision names from filename patterns.

Thanks.

This looks very bad:

    $ cd $git/share/man
    $ grep -l '(em ' */*.?

even though we do want em-dash for some hits in the above output.  And
even worse, there seem to be exceptions to this rule, like ...

> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index ac10cfbb..a516d577 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -23,7 +23,7 @@ throw away all uncommitted changes in your working directory, you
>  should see linkgit:git-reset[1], particularly the '--hard' option.  If

... the one before "hard" above.
