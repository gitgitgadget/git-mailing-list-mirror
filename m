From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store helper
Date: Thu, 05 Mar 2015 14:10:35 -0800
Message-ID: <xmqqsidj14f8.fsf@gitster.dls.corp.google.com>
References: <20150305215146.394caa71@gentp.lnet>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luis Ressel <aranea@aixah.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:10:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTdyd-00077y-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 23:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbbCEWKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 17:10:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752299AbbCEWKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 17:10:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C5CA3E6FB;
	Thu,  5 Mar 2015 17:10:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/ZniAWeRDe41nD+q6qz6sEmy1c=; b=B+INod
	pq8DO97N8wFOAE2lpBpLum2AJZz00EftrDrCkF4cha/f2MtDQCajVc57iBMXv9T2
	hc/CeejdpGsBhSaTOeMgs8R+dbybeCwdd5lyFlV6oT9greSTgTkSEnhCsyRsQE3N
	464NEdDGJ7fhCw2PDX0DRI6B2zXGoBWfAYdkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpv9ABM+ss210DfRkZZQYSeq91tSHERF
	EtE6IhXt8Y3T9T6S+lWLKGNcwnysHnC4pfytZska5P0ATYYX7PYMN4FQylyftaCN
	TOfVvLTIFjriD2yA2Eo+ew9mnLErtCn02uhGL6hqH/ASbZrWX1i899SUnwluVoid
	ttqDcZleyqM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 134C53E6FA;
	Thu,  5 Mar 2015 17:10:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 931CA3E6F9;
	Thu,  5 Mar 2015 17:10:36 -0500 (EST)
In-Reply-To: <20150305215146.394caa71@gentp.lnet> (Luis Ressel's message of
	"Thu, 5 Mar 2015 21:51:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73571CF4-C384-11E4-93F3-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264873>

Luis Ressel <aranea@aixah.de> writes:

> Oh, and should I add a testcase for the new functionality introduced by
> this patch? And if yes, what exactly should I test?

Absolutely.

Thinking things through to design what needs to be tested is part of
the exercise ;-)  You need to demonstrate that the new feature kicks
in when it should, and also you need to make sure the new feature
does not get used when it shouldn't.
