From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Tue, 11 Feb 2014 11:59:02 -0800
Message-ID: <xmqq61olpgjd.fsf@gitster.dls.corp.google.com>
References: <cover.1391794688.git.kirr@mns.spb.ru>
	<xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
	<20140211081716.GA4455@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:59:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJUB-0000BE-C0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbaBKT7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:59:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35870 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbaBKT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:59:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5736B638;
	Tue, 11 Feb 2014 14:59:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrSQCjc69yUC9S+3IPP6Gpr5A+o=; b=FqxfJ9
	ruq4lfgQJKGdNP3JE8PWN4oxGdTK14Rk3EljL2v6LdLOHlewXZeB2QYmg/bWosIx
	Zdlz7elMRBKNCSC2d5Ow+BqcjKbOIMPnvUFie3HpunvnOBLk7+Iq//KiPXiydF4C
	GNjiAgzbfTxxCR5iVBQ6UNpIY3WuDB/SSShbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IRP1b0eF31+y8pkYEcdEJFpuhVqslx/O
	FVP+2OHE/JcgMyjn0XZeCzgG00i7+w8T9kIdH+Iy5VfnUqljJ3iZATQstWKgpf6h
	YZvc976H1CptqXV71xQA0RGpQ6xarYCuLo2nNvvKOKhCdDT/oCBooKquYKbb6c6j
	Xe2aU1DxESE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DDB96B637;
	Tue, 11 Feb 2014 14:59:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74D346B632;
	Tue, 11 Feb 2014 14:59:05 -0500 (EST)
In-Reply-To: <20140211081716.GA4455@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Tue, 11 Feb 2014 12:17:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5FF6A9E-9356-11E3-B1A5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241959>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Sorry for the confusion. Could you please do the following:
>
> Patches should be applied over to ks/tree-diff-walk
> (74aa4a18). Before applying the patches, please cherry-pick
>
>     c90483d9    (tree-diff: no need to manually verify that there is no
>                  mode change for a path)
>
>     ef4f0928    (tree-diff: no need to pass match to
>                  skip_uninteresting())
>
> into that branch, and drop them from ks/combine-diff - we'll have one
> branch reworking the diff tree-walker, and the other taking advantage of
> it for combine-diff.

As long as that does not lose changes to tests and clean-ups, I'm
fine with that direction.  For example, I do not know if you want to
lose e3f62d12 (diffcore-order: export generic ordering interface,
2014-01-20), which is part of the combine-diff topic.
