From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 14:47:00 -0700
Message-ID: <7vhb7g2pbf.fsf@alter.siamese.dyndns.org>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
 <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E039BA7.8060302@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten Billemont <lhunath@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas =?utf-8?Q?K=C3=B6hler?= <andi5.py@gmx.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 23:47:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZrjy-0003YT-6A
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 23:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367Ab1FWVrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 17:47:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038Ab1FWVrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 17:47:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D26BA6108;
	Thu, 23 Jun 2011 17:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6z6+XeAguTt2oL/aSxy9s/yuDZE=; b=ySrYoL
	+jAPIlVkqGKLSGHpqbYuOfwY9s1fhRehMDNqOmPxpxjU1Y7p+CTq24yqXdgqXwU8
	WECfOjzF8sx0bShyue+o9Dl8tnvAsG1bxQaopSDOVLGrvu3AjZ+T2D8lGlNgNJZJ
	sXtKmbkNRhVJVze0EhXtl/mN3I5ozTtQXDGcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TINur4G8+MDQ8RzGZ5OAjRzW17BcXDQq
	meb7yXDsHzm7h6YZywDCamzkt8VGwo1AZAMsQVotVYMG+C3Jmo/CqXOOHsecg/mP
	CcWP/B1d8nElr8ql1HYcfbBnF7zA7D0SrDNPweNe7sD1Sf5TQMZs34D774yUkRVS
	nuvm/v3FXoA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAB466107;
	Thu, 23 Jun 2011 17:49:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 342BB6106; Thu, 23 Jun 2011
 17:49:13 -0400 (EDT)
In-Reply-To: <4E039BA7.8060302@cisco.com> (Phil Hord's message of "Thu, 23
 Jun 2011 16:01:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A24D1282-9DE2-11E0-8936-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176295>

Phil Hord <hordp@cisco.com> writes:

> On 06/23/2011 10:35 AM, Junio C Hamano wrote:
>>> Now, when I run git submodule update, it starts checking out the third
>>> module and my workflow is broken.
>> See 33f072f (submodule sync: Update "submodule.<name>.url" for empty
>> directories, 2010-10-08), which introduced this behaviour.
>>
>> cmd_update considers anything that has submodule.<name>.url defined as
>> "the user is interested", so I suspect "git submodule sync" should not do
>> this.
>
> What about a compromise?  Change git-submodule-sync to skip submodules
> which are not already initialized.

You completely lost me. How's that different from reverting 33f072f? I do
not see a room for "compromise" here.
