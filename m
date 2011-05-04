From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] t5541-http-push: add test for chunked
Date: Tue, 03 May 2011 21:07:38 -0700
Message-ID: <7v8vunglbp.fsf@alter.siamese.dyndns.org>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304437649-7052-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 06:08:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHTNi-0004Qa-TX
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788Ab1EDEHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:07:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1EDEHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:07:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80AB55B0F;
	Wed,  4 May 2011 00:09:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JsImccXtA5kFvYBdH3akPKnifgM=; b=cqgsDj
	kwCdUOXcl3Cx2j34wxfQmwrRTVQFAiOMK6EGjYHxe9M9yy2j3ghorNsjQvdfdRqf
	DB+1UJfWNQrW2TJO/xlPU0hxhFpc0fat1q9Tilr+EmU95zsE6MxSDBWu8kAWQkXx
	s4ZjPYxWNaP9HlrS1ckjTDgWiici+nhewy6FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMgsWR2LY/lHJYm363nq1oi3fRaduB4y
	LUPupCMcsgR7jshTGDTna5NtCJy9zz40MGzqHTirCSh4nA9hlk1w1sgcklwEsvut
	BXSM37+7G6lHPlOvoRPL1wmcqcpJxcgVDUM2o8O5iyHiQq8g0WpYrNElfKwK99O+
	vj9nXmk0X0s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 396F25B0E;
	Wed,  4 May 2011 00:09:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4A1B5B0D; Wed,  4 May 2011
 00:09:43 -0400 (EDT)
In-Reply-To: <1304437649-7052-2-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Tue, 3 May 2011 23:47:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A801F54-7604-11E0-8A21-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172710>

Tay Ray Chuan <rctay89@gmail.com> writes:

> +	GIT_REPO=$TEST_DIRECTORY/../.git &&
> +	test -d $GIT_REPO &&

Shouldn't a test be runnable without failing in a tarball extract?
