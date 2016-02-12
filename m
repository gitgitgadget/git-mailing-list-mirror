From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Fri, 12 Feb 2016 10:19:38 -0800
Message-ID: <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
References: <20160212164853.GA6888@witiko>
	<xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?VsOtdCBOb3ZvdG7DvQ==?= <witiko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIJm-0003Ak-LH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcBLSTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:19:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752271AbcBLSTl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 13:19:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C47CB41B60;
	Fri, 12 Feb 2016 13:19:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mjO2VkBrKMRQ
	sguZ7N0jE7JAJT0=; b=cRidvLsmKDoikXiIMCesEnfXrffr0K4WMEoun1ggbkO8
	ZUjyrgJPqmkT3D+zwSKhSJstMW5O3krC13zfLZufomdaV6bFoXY1sx3n8WSyBqoa
	752nG2uMotpxTs9V/dbI4xAaPqnZiOq4ylxTTDIYuZBddrve5bku8W045SuHH20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AJXLO1
	6Pq+hoXC2auxLmiSrIRhKbdzmECXZQQSeevT6veukOSFAAQIYiLWdJ4rA9vXkmWB
	OXluLGO7b5Dm3r7YuaQdwCEfMUZepQGnk2A06h9wQTYK+v4jQ7Jrx8zAWw23UEAp
	spIL4fve11dgohE3DSmDD9ER/5AD2L00pOoM0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE25441B5F;
	Fri, 12 Feb 2016 13:19:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B7C941B5E;
	Fri, 12 Feb 2016 13:19:40 -0500 (EST)
In-Reply-To: <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Feb 2016 10:09:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E550AB8-D1B5-11E5-9310-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286062>

Junio C Hamano <gitster@pobox.com> writes:

> V=C3=ADt Novotn=C3=BD <witiko@gmail.com> writes:
>
>> Is this a bug, or is the ability to symlink `.git` just a happy coin=
cidence?
>
> It has never been supported.

Oops, hit "send" too early.

We have support for a "gitdir:" facility that would work even on a
filesystem that cannot do symlinks (see gitrepository-layout(5)),
and both the higher-level submodule Porcelain and the more recent
"worktree" experimental code do use it.
