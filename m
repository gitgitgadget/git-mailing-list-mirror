From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introducing a test_create_repo_bare (was Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes)
Date: Thu, 18 Dec 2014 09:06:28 -0800
Message-ID: <xmqqlhm47uqz.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
	<xmqq61d996oc.fsf@gitster.dls.corp.google.com>
	<20141218002825.GQ29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 18:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1eX5-0007yI-KM
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 18:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbaLRRGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 12:06:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbaLRRGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 12:06:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96C0C264F1;
	Thu, 18 Dec 2014 12:06:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=46qxkskFRUWjORKLgXYB2LwQ/74=; b=loJp2x
	gDquMzXTG1RObRSFdkH/ubv9hjQm3EU116wLRyAS/xAKP+/hiSl0sSdbMtn1UGGh
	bGT6tv5q40nouBHum9OVSdo76Cx8gxzguXFWALy/yTcAZ73Yu+VrBHu08QO1qHRo
	V/fR5+Ly0/g/sz4Z8L3H9zjVFCA8lylhMqweY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qnmZrZ1aegZuLNY6PvEQDDm1j2Cl1k3o
	Reh7pnyDE5+49s9DXddVevUCDi6Dnuq3id1lNuq+e7qjBfAPzaXmJwM0rNDYBBg/
	5as6jluWn7QiMQHvRMV9o4pDnsSZyz6DO7EgJeQAhsX4lEX7ErZ6Ml+sbBu6WA1Y
	b4wggtiBHK8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E01C264EE;
	Thu, 18 Dec 2014 12:06:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08016264EB;
	Thu, 18 Dec 2014 12:06:31 -0500 (EST)
In-Reply-To: <20141218002825.GQ29365@google.com> (Jonathan Nieder's message of
	"Wed, 17 Dec 2014 16:28:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36EC153C-86D8-11E4-80DA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261529>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> The issue is if some existing tests will be helped, if we had such a
>> helper.
>
> Since both bin-wrappers/git and test-lib.sh set GIT_TEMPLATE_DIR and
> templates/blt doesn't contain any enabled hooks, I don't see how such
> a helper would be useful.

Probably bin-wrappers/git has gained it after test_setup_repo
protected itself manually, and I obviously forgot about it. I agree
with your conclusion below, if test_create_repo has become a no-op
these days.  Thanks.

> If making things more consistent were worth the churn, then if
> anything it would make sense to make test_create_repo private to the
> setup code in test-lib.sh and to use plain 'git init <directory>' in
> tests.
