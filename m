From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 06 Jan 2014 10:42:17 -0800
Message-ID: <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:42:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0F85-0007o6-F2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbaAFSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:42:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbaAFSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:42:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 383385FBB9;
	Mon,  6 Jan 2014 13:42:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fbg8cleBPz1osB5Vc1IZZ9viU9g=; b=JGbLvH
	7fDLHOpswm5SJDoAp06owNNbGmAH8DhLFP5Oyyp2o/4frkRauNYPzn21FJkjMiDM
	PdndSQ4eeEjCFzfUY67R6o/sfc4t/bEK8yGTeyE8LCWDEdETqaAmnv9bKDpbwzZN
	mSNwN9g4DulzXQo0L4c56WWSik92i5TTZzGX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npbr13eqm5eOV3Alf1L4OV/yMKV8JO5V
	yLyutfOG1lV1Rgef4vHkmKWSL+UXwzgOXwXlSWlMSD4oGPADto2iPlRO/x5bnJ0O
	Z2V/xGismIEgcWhBKkajQbP8ao9jQeYhrnIPXy+uv5dbuINhkVTW6UySVTRo7D0o
	ynFP81mK8ak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 234CD5FBB7;
	Mon,  6 Jan 2014 13:42:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6963B5FBB4;
	Mon,  6 Jan 2014 13:42:19 -0500 (EST)
In-Reply-To: <1389028732-27760-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 6 Jan 2014 22:48:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 45B54C5A-7702-11E3-AC2B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240045>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A very common workflow for preparing patches involves working off a
> topic branch and generating patches against 'master' to send off to the
> maintainer. However, a plain
>
>   $ git format-patch -o outgoing
>
> is a no-op on a topic branch,...

Two points.

 - why is a single branch name sufficient?

 - is it a better option to simply default to @{u}, if one exists,
   instead of failing?
