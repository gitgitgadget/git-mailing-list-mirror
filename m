From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Add a new config. option for skipping merges in git-log
Date: Mon, 16 Mar 2015 13:50:40 -0700
Message-ID: <xmqqy4mwpsyn.fsf@gitster.dls.corp.google.com>
References: <5506E751.8010506@posteo.de>
	<xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>
	<5507301B.2060401@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXbyN-0001Kp-0y
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 21:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbbCPUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 16:50:45 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52602 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964973AbbCPUuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 16:50:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89C1541B7B;
	Mon, 16 Mar 2015 16:50:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j+GinIbfyOoh3nteI8cu0xRPmaQ=; b=RZU3uG
	ou0PgOQzSA1ma7mhsV46pfOUPByxImgWuq2q0kh/dxG8QeOLndQN8Tn2/T/NySqf
	9TMZ1UaRxWVLMwYzo9dk4SiTNOpk/G5IQrwg1vAthU1ffdm5axdOWX+NFAUlgmZu
	iKVq+tVy+Dars3ZbhhE4hi2z9qFaBhS/4DpCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2Uoq0fgtf0MOFCGFir7MBbgiC2BX/PZ
	DM+Qo59Ol51wT+EwZcZ9iN3h+0ygK9bFv0CRwcyuqzhmexERiszcpUc3JwrIHr/m
	OZ+h3nwCy35HMIvJkLzMxmhbzlqkHXRVXipIZAtMcXTibjtn81jVSzNfJMqTCanE
	ryjtp3SQ+hk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C82841B7A;
	Mon, 16 Mar 2015 16:50:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A850B41B79;
	Mon, 16 Mar 2015 16:50:41 -0400 (EDT)
In-Reply-To: <5507301B.2060401@posteo.de> (Koosha Khajehmoogahi's message of
	"Mon, 16 Mar 2015 20:33:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BE4BB6E-CC1E-11E4-A2BB-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265594>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> Thanks for your suggestions. The "extra bit" in rev_info is used when
> we need to compare user's command-line input to his configuration. Since
> command-line input is processed in revision.c but config. options are read
> in builtin/log.c, we need a way to pass the value to builtin/log.c. How
> would you do that without this extra bit?

The command line overrides the config, no?  If you set up what the
command line defaults to from the config, let the command line
parser do whatever it wants to do, and do nothing else after the
command line parser returns, wouldn't that be sufficient?

Puzzled...
