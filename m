From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Tue, 04 Sep 2012 10:26:32 -0700
Message-ID: <7vmx15bsxj.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:26:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8wtg-0002n7-IF
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 19:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586Ab2IDR0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 13:26:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757403Ab2IDR0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 13:26:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8BB81CC;
	Tue,  4 Sep 2012 13:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R3oAIfPRXY/VfQGpocNs//Wgsm8=; b=noVHbV
	S7pDveqijqrsHMXYm6fPAFoPZ2T01JmqcwqeoFsI5jHI+lDXOS5nWCBCvcs/PT/J
	HlppilZGjczchR209Bz9YbKhceREw43zDQpI+MQAHxcV+YKqt0c+Gg2JPlJCvw4L
	5yuc+22nDhERL737dHEvdrBWZtItArL9TpLlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdjjfXR6no1LThBgvWEyNJaM2ouMg5mx
	u2gYFq0FLbxSLfjDZH4IT4AdYb4LQ4FiKIaB99kfxTd/gQVeLvUJIZWqWdMzczsm
	Ha7HhvyyTW9PkBUgQett4Mxv6QAQvovZ3qCh8A0VR9fpeIFIPdA4US28UMOBDRpG
	ICxl3lmgqhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291DB81CB;
	Tue,  4 Sep 2012 13:26:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9F8081C0; Tue,  4 Sep 2012
 13:26:33 -0400 (EDT)
In-Reply-To: <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Sep 2012 20:06:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC3D55AE-F6B5-11E1-A600-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204757>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> +static void output_exclude(const char *path, struct exclude *exclude)
>> +{
>> +       char *type = exclude->to_exclude ? "excluded" : "included";
>> +       char *bang = exclude->to_exclude ? "" : "!";
>> +       char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
>> +       printf(_("%s: %s %s%s%s "), path, type, bang, exclude->pattern, dir);
>
> These English words "excluded" and "included" make the translator me
> want to translate them. But they could be the markers for scripts, so
> they may not be translated. How about using non alphanumeric letters
> instead?

I agree they should not be translated, but it is a disease to think
unintelligible mnemonic is a better input format for scripts than
the spelled out words.  "excluded/included" pair is just fine.
