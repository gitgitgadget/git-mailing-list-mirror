From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ability to remember last known good build
Date: Fri, 11 Mar 2016 10:08:14 -0800
Message-ID: <xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
References: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Pedroso\, Osiris" <osiris.pedroso@intergraph.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRU6-000358-J4
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcCKSIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:08:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750734AbcCKSIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:08:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FABA4BFA4;
	Fri, 11 Mar 2016 13:08:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cgy49ylBlQ0+d4Ly1fT827RfuG8=; b=tvWG1f
	QkTiu5FWrkMq8m1RK0ddyi2vrZIoGVwWcpTcRHcOiC0X+sq6dhMeWvfYllrTFKeF
	KLlOBxNds/H2U0MR3T9V8tZefo9yogu30PrgfmcMTrLeUH9LrYa1Zd7tqVAFN8nG
	HPyzgV2uxJ4J458bxLLyXLQ62/hUwXqq0/qL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUETDD3gbg0tJo35bRODtKgUs8UUZNsM
	rOoszsysSjO2REK4A96rPo+kg9UupQirt+n9dB9I2RCF1WaEbeBgiX4jv1Uz1ux6
	eKXDRG+MBDdzIu0P0EsbYrfQ/3RU6C+j1r0iVxp2VDUx0NfXnXf1joMfl7TmzN05
	hR44Ue3S9vc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 663D04BF9D;
	Fri, 11 Mar 2016 13:08:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D71ED4BF9C;
	Fri, 11 Mar 2016 13:08:15 -0500 (EST)
In-Reply-To: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com>
	(Osiris Pedroso's message of "Fri, 11 Mar 2016 17:51:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A1084E4-E7B4-11E5-8AA2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288693>

"Pedroso, Osiris" <osiris.pedroso@intergraph.com> writes:

> I participate in an open source project that any pull merge is accepted, no matter what.
>
> This makes for lots of broken builds, even though we do have Travis-CI enabled on the project, because people will merge a request before even the build is complete.
>
> Therefore, I would like to remember the id of the commit of the last successful build. This would be updated by the Travis-CI script itself upon a successful build.
>
> I imagine best option would be to merge master to a certain branch named "Last_known_Linux_build" or "Last_known_Windows_build" or even "Last_known_build_all_tests_passing".
>
> I am new to git, but some other experienced co-volunteers tell me that it may not be possible due to authentication issues.
>
> Any better way of accomplishing this?

"test && git branch -f last-good"?
