From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout w/ removing untracked files
Date: Wed, 18 Aug 2010 12:51:23 -0700
Message-ID: <7v39ubaedg.fsf@alter.siamese.dyndns.org>
References: <20100818193154.GA13204@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Wed Aug 18 21:51:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olofi-0003nv-Un
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0HRTve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 15:51:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0HRTvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 15:51:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B699CE3A7;
	Wed, 18 Aug 2010 15:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3VGPrzyqs7NexmuyxSgoCIaLCQY=; b=duc1G0
	60fM+VVEqXnhYLqHIwmpX/JHtLN5roQpR5AlTCpaePE887BiQ8eAZs0ZDjPt7Ran
	JduUSf+4RkCXvDqVvFrm2hJcnRkp/J3PZGQ4U8PQVCViXG5VWCQB1a0y18xFCxq4
	1zA8daASFfagzIH3Nh6K6Wmd2sfplLdf24AIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAO1UqDx3KzIIPUbdjs5pRoEVldGxR8e
	ZRiM32/ylpnlIfpM/Ght/uCzqtfzVP1DvZsHhFuVsEfKb0c7KqilSaqIgDORao8z
	QhNccDcSFwY2LSfJcVjJ0HB3HogZFt+yEC+EKILOap1rjqe8Qc1V6SFlHjSpkKpE
	K2d9BVKuADU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08AE4CE3A5;
	Wed, 18 Aug 2010 15:51:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D25FCE3A4; Wed, 18 Aug
 2010 15:51:25 -0400 (EDT)
In-Reply-To: <20100818193154.GA13204@nibiru.local> (Enrico Weigelt's message
 of "Wed\, 18 Aug 2010 21\:31\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD75D088-AB01-11DF-982A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153882>

Enrico Weigelt <weigelt@metux.de> writes:

> For my Briegel buildsystem (git://pubgit.metux.de/projects/briegel.git/)
> I need to checkout a really tree (iow: no untracked files may be
> left in the workdir) from git. ATM I'm removing and recreating the
> whole directory first, but I hope to get rid of this step.

(1) If you have a correctly working "make reallyclean" to remove build
    artifacts, you wouldn't even need such an option.

(2) Have you tried to read up on "git clean -dfqx"?
