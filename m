From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Mon, 10 Dec 2012 10:03:28 -0800
Message-ID: <7va9tlbx8v.fsf@alter.siamese.dyndns.org>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
 <7v38zecrqc.fsf@alter.siamese.dyndns.org>
 <5b69a9f1-0860-41da-914c-d55a17e54092@TX2EHSMHS026.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, <git@vger.kernel.org>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 19:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti7hk-0004r3-CY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 19:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156Ab2LJSDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 13:03:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab2LJSDb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 13:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72A3E98F7;
	Mon, 10 Dec 2012 13:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zRtfCl+udlRVx2Bf7QmleFLekl4=; b=nPfTNG
	VcFnPfXJIdgW2+ShOZ41xBqncxoat6vFEEAk2y96ksYXtwgMdIdX4MnYzfjjufR4
	3jlm9mXCPmv873cn8XG/n5qt8hi08ES/kXUZwh013QHstLnJrSW/mz+OdvPbEsGt
	j7J3gt6eS0Tju8whgA6Bq1SHEJpy1gcVQHDdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vbd8P14RQBg2GlCP1Bkykq7jtG3yjEE9
	SRNQPaJGwVPHfBCp3mQK6EiN33eOvSiazMFl5j/sCe6GuyoyNbsX+QS9LZztITZH
	Pbp6mMu4j7Baxnb1ymj0yGeFQpcPMOEBz8Tok2gMChHpVwBp7tzGbXJ4WqIXem9q
	HjMoXiXQnl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 604DD98F6;
	Mon, 10 Dec 2012 13:03:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFBBE98F5; Mon, 10 Dec 2012
 13:03:29 -0500 (EST)
In-Reply-To: <5b69a9f1-0860-41da-914c-d55a17e54092@TX2EHSMHS026.ehs.local>
 (Soren Brinkmann's message of "Mon, 10 Dec 2012 09:33:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E73D7FA0-42F3-11E2-856E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211265>

Soren Brinkmann <soren.brinkmann@xilinx.com> writes:

>> > Use git clean --force --force to delete all untracked git repositories
>> 
>> But I am not sure if this is ever sane.  Especially the one that
>> removes an embedded repository is suspicious.  "git clean" should
>> not ever touch it with or without --superforce or any other command.
> As I mentioned in my email where I reported this incorrect git clean output, I
> have a use case where I want git clean to remove embedded repositories.
> Whether it is a sane one is probably a different discussion.

Why is it a different discussion?  If something is not sane, the
tool shouldn't encourage users to do such an insane thing.
