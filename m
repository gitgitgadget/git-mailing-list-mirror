From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git commit fails under some circumstances
Date: Wed, 06 Apr 2011 10:24:17 -0700
Message-ID: <7v1v1fjnsu.fsf@alter.siamese.dyndns.org>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
 <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
 <20110405173603.GD9965@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laszlo Papp <djszapi@archlinux.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7WT3-0005pi-3a
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1DFRY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 13:24:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab1DFRY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:24:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFE904F6D;
	Wed,  6 Apr 2011 13:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YET+wTVxddtgYDfqH5rl15KT6hc=; b=pIxczL
	nb5MANhSsURrL41a4MoOJuP+dNYFJXh9Gw2EEwF0TEfyBxIivPVW4yC4wN4Qs9TV
	9Lm7Hf+GoCJW5bxfPcjhn/yNUPuMnUyjbHNm63Wg56oot7aNjHKf1FDhJcaPDsUj
	oOzWubpyV9KirydTUpQqM/ijc4bNlmjOg7mF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQWfuAu66X24KwtadMkZZ2h/iOmcIsRr
	+IKeRIZ9VqVBVnXUUkQaj5jwp0vGFUVbGPVAQ/gVZImxPoFCv8awe9aNH0nn3yfT
	Pv0vn9lTdF8FMIEqYPXlNOE/LEY73p7KN6fLGMFODKXwBXpoKPT0plY6yNTTxCiW
	LbiDhk6F5AY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B71C24F6C;
	Wed,  6 Apr 2011 13:26:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C73E4F67; Wed,  6 Apr 2011
 13:26:13 -0400 (EDT)
In-Reply-To: <20110405173603.GD9965@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Apr 2011 13:36:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB1D70F8-6072-11E0-AD50-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170994>

Jeff King <peff@peff.net> writes:

> I am much more concerned with whether and how this information would be
> represented in the "git status --porcelain" format.

I earlier suggested using 'I'; a safer alternative would be to change
nothing and let the callers figure it out.  I slightly favor the former;
while there is a definite risk of breaking scripts' expectations, they can
be tentatively marked "this script does not work until you 'git add' paths
you used 'add -N'" and I don't think it would be such a big deal.
