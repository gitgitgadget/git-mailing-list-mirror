From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/12] commit: avoid race when creating orphan commits
Date: Thu, 12 Feb 2015 11:36:47 -0800
Message-ID: <xmqqk2zmsz00.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:37:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzZK-0006ix-7I
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbBLTgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:36:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752179AbbBLTgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:36:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CC1C373A5;
	Thu, 12 Feb 2015 14:36:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Z0qnR2YxBpO0bajQfOTwCsJkak=; b=JDcyjX
	ywPDi5J2pa1nDkNUfWF4FzUMnzOt8ek/sNIC68GdAuCjUEa9eLXBgJzzix8opO/U
	3DZfwcj3fcvEOX2uYDe9w7/JxvCgoStiMKU1CrmHzOiZHj2u8FJlt2wOJDYXwV0m
	DldCcExTgBQBMDvz+Q3HBuNKQDw7WNrqMeNMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xif5ZCdnQAUVQR7LmOvzv1BB+HgdPwZ7
	RqQSVCnTeteBGh1v6h/NL4ZEcoqubhl85os1oUy5ntsReo69zxMx1G4snlS+7siL
	oIn9FqV3yK4NgeYssWlt4x3YwZvGhH9TDd1Wqkm67XE8y8Csdx9phQ4yWK21fDkn
	dN69H8aXUQ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03140373A4;
	Thu, 12 Feb 2015 14:36:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C326373A3;
	Thu, 12 Feb 2015 14:36:48 -0500 (EST)
In-Reply-To: <1423739543-1025-8-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 12 Feb 2015 12:12:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C54F0B6-B2EE-11E4-9A2E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263754>

Good.
