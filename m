From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to trim the fat on my log graphs
Date: Tue, 22 Apr 2014 14:37:42 -0700
Message-ID: <xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WciOC-0003X9-UP
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 23:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401AbaDVVh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 17:37:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812AbaDVVhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 17:37:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 521337F7AE;
	Tue, 22 Apr 2014 17:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LBrYHlTm7C0fLOUZ5QYYHkOuZ34=; b=wSTk5j
	XilIjfJ41SAX9fRG+yO0ms0XeUrzrXam3z5mFzLTyiLWjewQOujtHn7rCMUCbfmC
	FY9NaZ6fTgYfRWjjfVegiiCdwWrk7RSW/LTpuw2sTMjbgqemD3hnMriMNC7DrfND
	hmGjSryAYS4oYE7lDwPeqpx5yizsAPLaufJGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHrIJPIWyrfvOJpDL34aiJi2FN3DLptX
	bLpwYvyOsmvlIacdt0IZB/P5wrsb3X8+NnCUKskamxA7IoyVk3tkyDeIQNF1YYZe
	/2Bidq/5SCaCQQ7JilP/E9X7JHWsw0vRP8fYULTH2aFLGM7l/EhJMiOuHrrxtSJ7
	XTmCf9ZoHY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA2F7F7AD;
	Tue, 22 Apr 2014 17:37:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 990F57F7A9;
	Tue, 22 Apr 2014 17:37:43 -0400 (EDT)
In-Reply-To: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
	(Robert Dailey's message of "Tue, 22 Apr 2014 15:50:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 56693BEE-CA66-11E3-AB15-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246790>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> git log log --graph --abbrev-commit --decorate --date=relative
> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
> white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes
> ...
> The goal is to weed out the really distant and irrelevant commits. I
> really just want to see the commits that are closely related to my
> current branch. Thanks in advance.

For a starter, how about dropping "--branches --remotes" from that
command line?  A merge from elsewhere will show as "Merge branch foo"
which should be sufficient without the decoration.
