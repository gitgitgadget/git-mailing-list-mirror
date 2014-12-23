From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 08:32:13 -0800
Message-ID: <xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:32:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3SNh-0005pQ-J6
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 17:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbaLWQcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 11:32:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756113AbaLWQcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 11:32:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A34628775;
	Tue, 23 Dec 2014 11:32:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7UAR83bQCHJ5uhVLfPThbOQDPAU=; b=Sc1sbP
	6VVNHZTuyJwDo84ArYXNJMLbAhRMA4ItWZxyRFIMMI0GFghojB6TFptQ6W4GJIFM
	2flgP57k+eEoTrLRnD54LIxnRXg151y/qcXQo4tDNm9OetcF8JCLMkYHVa4qz0zk
	rHNrfApZkfxDyRKTsHaU5Ky5a3/XVtXpvclYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PNR6G27+r4JRzw+S3i5GPCgt885E45qa
	RQ+Xh4wtEPhjQHj3GDIlx4hwPDHHctJ2Gy6nXKwfw7yS3+2nLOMaU8qcj/FVBo/n
	mtflz2tQna+m0BLkH/8IcPChmUsfp4/DoMx8Vnv0UKvTii2Ol6Hn0C2VkQX5YhOZ
	6HIixhTH1rs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8102C28774;
	Tue, 23 Dec 2014 11:32:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0650928773;
	Tue, 23 Dec 2014 11:32:14 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 10:50:50 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40E9EFA4-8AC1-11E4-B687-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261738>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> > Of course you can say that! ;-) The problem these ugly messages try to
>> >> > solve is to give the user a hint which setting to change if they want to
>> >> > override the default behavior, though...
>> >> 
>> >> Ahh, OK, then dashed form would not work as a configuration variable
>> >> names, so missingTaggerEntry would be the only usable option.
>> >
>> > Except that cunning me has made it so that both missing-tagger-entry *and*
>> > missingTaggerEntry work...
>> 
>> Then the missing-tagger-entry side needs to be dropped.  The naming
>> does not conform to the way how we name our officially supported
>> configuration variables.
>
> But it does conform with the way we do our command-line parameters,

Hmmm....  What is the expected user interaction?  The way I read the
series was ($MISSING_TAGGER stands for the "token" we choose to show):

    (1) The user runs fsck without customization, and may see a
	warning (or error):

        $ git fsck
        error in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: $MISSING_TAGGER

    (2) The user demotes it to warning and runs fsck again:

	$ git config fsck.$MISSING_TAGGER warn
        $ git fsck
        warning: tag d6602ec5194c87b0fc87103ca4d67251c76f233a: $MISSING_TAGGER

I suspect that it would be much better if the configuration
variables were organized the other way around, e.g.

	$ git config fsck.warn missingTagger,someOtherKindOfError

Then a one-shot override would make sense and easier to give as
command line option, e.g.

	$ git fsck --warn=missingTagger,someOtherKindOfError

But the proposed organization to use one variable per questionable
event type (as opposed to one variable per severity level) would
lead to a one-shot override of this form, e.g.

	$ git fsck --missing-tagger=warn --some-other-kind-of-error=warn

which I think is insane to require us to support unbound number of
dashed options.

Or are you saying that we allow "git config core.file-mode true"
from the command line to set core.fileMode configuration?

Puzzled...
