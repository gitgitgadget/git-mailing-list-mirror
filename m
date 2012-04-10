From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 12:32:18 -0700
Message-ID: <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 21:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHgnl-0002xa-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 21:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab2DJTcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 15:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab2DJTcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 15:32:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2964B7F4B;
	Tue, 10 Apr 2012 15:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bsxmD3KHKTU4AnV2I6c89rLrxCQ=; b=jS25kM
	UwOXOFKA0kCJ5KYfPEghq6K/8WyDy2t6rgMdl7WqGOa8lxvoXekY9dBTDcBYOF3x
	PwXxoMZTXBzURM9yksEvl+1A3olfYW799w16dGORfW5/NhAS/wW5ed+LO7YkPXFq
	fPaflr+c3Q+dQlIiB8eEJ9cF2j9ecSPVgSuyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpJ8mFBLzqe6C7iAW/aBu4OoI65CtGil
	qC1BB1r8dYcRaZJatb9uCTMz3BZAkDwIFGkcqknTmSAQ/i9kISLYfDdtZEcFAHoC
	f/dfVqnEasXjmcpg8YmLm6AuFWEprKovmSIDI01sOtT1UA9nV4jAu5IKda1O3muD
	ZTtXKaVleiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 206397F4A;
	Tue, 10 Apr 2012 15:32:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 940687F47; Tue, 10 Apr 2012
 15:32:19 -0400 (EDT)
In-Reply-To: <20120410181317.GA17776@hmsreliant.think-freely.org> (Neil
 Horman's message of "Tue, 10 Apr 2012 14:13:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E33B1F22-8343-11E1-ADB6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195124>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Tue, Apr 10, 2012 at 09:45:46AM -0700, Junio C Hamano wrote:
> ...
>>  (2) The message is given by the "git commit" command.  "If the commit was
>>      created empty" looks confusing.  Even though I can understand that
> Its coded within the git commit command code, but is only ever displayed if
> whence is GIT_CHERRY_PICK, so as far as I can see, from a users perspective,
> this will only be seen if they type git cherry-pick on the command line.

Here is what I tried, and I think you are wrong.

	$ git cherry-pick $some_commit
        ... conflicts ...
        $ edit so that the working tree matches HEAD
        $ git commit -a
        ... message from status ...
        THE ADVICE IN QUEWSTION COMES HERE!!!
