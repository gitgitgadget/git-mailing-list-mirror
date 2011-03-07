From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] documentation fix: git log -p does not imply -c.
Date: Mon, 07 Mar 2011 10:37:21 -0800
Message-ID: <7vtyfe22vy.fsf@alter.siamese.dyndns.org>
References: <4D724A0F.7050904@gmail.com>
 <1299355004-3532-2-git-send-email-haircut@gmail.com>
 <7vbp1n4vhv.fsf@alter.siamese.dyndns.org>
 <20110307154712.GA11934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Monsen <haircut@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 19:37:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwfJL-00084I-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 19:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab1CGShf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 13:37:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1CGShe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 13:37:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21E1C362A;
	Mon,  7 Mar 2011 13:38:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tK24JeloHuPVBVOEqEBaG/CGVKc=; b=Ivrgtc
	cv9A8m3yKGOosF0SgM134oJqYBsPyx69h1IftuiYV+L0CC9o0kCA4beCSzdEcJK6
	i0UMZnSBj10CyqskLzayUp7BwR0ByswxPnaqP95Js3phCmDyC5soAcj3DXtabV2i
	slN+GKk30RsOR3N/5+hS48a7YLAjLhARA++ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=um2GZALeMkm3SDHHaEMwln5tEXqEmhZM
	wxJSLM4VFpZkj247b2R8g0QmkvKtgttM+oTGF1yO2JBCB0nHke0Ty04RApc4kcTb
	uq/qWV84qMTs1TwtJ6DUKXfRGpwTLVbqP5ZKtqM1gupb0rfMCWadZwiPMt+HGhcX
	FkJOpeK09+s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4FFA361B;
	Mon,  7 Mar 2011 13:38:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A77D3617; Mon,  7 Mar 2011
 13:38:48 -0500 (EST)
In-Reply-To: <20110307154712.GA11934@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Mar 2011 10:47:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27CBD66C-48EA-11E0-B4E3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168601>

Jeff King <peff@peff.net> writes:

> On Sun, Mar 06, 2011 at 04:36:28PM -0800, Junio C Hamano wrote:
>
>> The --cc format _is_ the default, not -c format.
>
> Hmm. "git show" seems to show --cc, but "git log -p" does not show
> anything.

The intention has always been to default to --cc since 0fe7c1d (built-in
diff: assorted updates., 2006-04-29) for "diff" if I am not misremembering
things, but you are right---"log" is a tad different.

The code does not want to use --cc by default for "log", and I don't think
that should change.  See 1aec791 (git log: don't do merge diffs by
default, 2006-04-19).
