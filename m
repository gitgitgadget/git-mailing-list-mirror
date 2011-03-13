From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a problem with the gitconfig file for user.email
Date: Sun, 13 Mar 2011 16:01:38 -0700
Message-ID: <7v8vwihbfx.fsf@alter.siamese.dyndns.org>
References: <loom.20110313T182907-610@post.gmane.org>
 <vpqy64iy7r3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guy Maurel <guy-kde@maurel.de>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 14 00:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyuIM-0004xk-Np
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 00:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab1CMXBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 19:01:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab1CMXBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 19:01:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0170148A0;
	Sun, 13 Mar 2011 19:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6O0/xD5PtBxMk4YbrxEJlpodmsA=; b=if0LBc
	dePWfTqM8YXk6trphiOFm2evArK/C17pWvhcWIgb5/CoWtuMy43W9mu2ZiIe+Gyc
	iX3SiY+CSXI5FJV2SkQesaxNaMCWxH3z2+lOFMbdJLBpDzKRlU/IHhBWsj+xFAVE
	MrNYH7PNuu073h6B5fdhNifSDPkgxy1MAz7lM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ESh1pIh32sSCchXALD7FE5K5NvX3KiEG
	eNTpcO4RkdIOU+7sXy5+yStVloNnOT9YRs3XJt9K6bT0xIy+xgYq8t373v1euYvS
	tqxvbN909svnav5uK/eRKnetWG9bdWA2iOFL936jO+llxkagVNlFODklYfrGwMH+
	e0ctNxlCfMw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C54A2489E;
	Sun, 13 Mar 2011 19:03:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 61A30489C; Sun, 13 Mar 2011
 19:03:12 -0400 (EDT)
In-Reply-To: <vpqy64iy7r3.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 13 Mar 2011 23:29:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 154B8006-4DC6-11E0-9657-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168981>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Guy Maurel <guy-kde@maurel.de> writes:
>
>> why is it necessary to have a <TAB> before the email keyword in the [user]
>> section?
>
> It isn't. I've just checked with email right at the beginning of the
> line, without tab or space, and it works (with the latest git.git).
>
>> If not, one get the error message:
>>   fatal: bad config file line 2 in /home/guy-kde/.gitconfig
>
> Please, give a short and reproducible senario (eg. the full content of
> .gitconfig, and the command you've typed to get this).

Good suggestion.  I suspect this is some third party programs or hooks
that are trying to hand parse the config file.  In the distant past, some
of our perl based Porcelains may have done so but I think these days
everything we ship should be reading from "git config" output or calling
git_config() from C.
