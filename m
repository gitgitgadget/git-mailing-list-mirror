From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Tue, 16 Apr 2013 10:28:34 -0700
Message-ID: <7v38uqo059.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <20130416025840.GH3262@elie.Belkin>
 <CALkWK0kDgSicNejydLsH6iqj-yDYGz6CKd+kbn4EW1HxgAxsBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9gP-0008Bx-UG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045Ab3DPR2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:28:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936020Ab3DPR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:28:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E0617F6A;
	Tue, 16 Apr 2013 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCTzh7kunU98SutX5dSoTpEln1A=; b=bApi2n
	0TzdCHr7I8XbGMZkU1ETEKgUWSt+vUVPBHi58RdbIOB1bLvclPxW6IsDFo4Tg+aA
	fH3Pys7naoAG0DUhrM15vl1NwgnLp+wEorqZ73FqztsB6IxMYf6qpGTJxgzttELc
	efMxmS33YoxDNugVzJCg5SdpHgM5JZRWd92w0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfn6Q2RroV66CG4JUrZIVPhgotP96XkM
	pKKHAi425/y6pZGM6nifQuydtc12qpuvvZ1Hyg+rUznh2vAYObD0H5yFJ+DyYUu7
	KHCF24dSbXURDgeas43+8SGqVvCrnTacYD2+2UwbVpBPgg05DtdfmTDuujCG/0LN
	5VHd5o7NRw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD16E17F69;
	Tue, 16 Apr 2013 17:28:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C9C717F68; Tue, 16 Apr
 2013 17:28:36 +0000 (UTC)
In-Reply-To: <CALkWK0kDgSicNejydLsH6iqj-yDYGz6CKd+kbn4EW1HxgAxsBA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 16 Apr 2013 14:06:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11E8133E-A6BB-11E2-A114-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221431>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> My solution fixes all these problems, and we need
> .git/modules/<name>.git (no path-to-submodule nonsense) only as a last
> resort: #3 (ref: my email to Peff).

Have you noticed that there are distinction between submodule path
and submodule name already in the current system, and name is
derived from path if you do not give it when adding a submodule
merely as a convenience?

If some existing code uses .git/modules/<path>.git in "git submodule",
that is a bug that needs to be fixed.
