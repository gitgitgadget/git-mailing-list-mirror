From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: Small updates to test cases
Date: Thu, 26 Mar 2015 18:26:30 -0700
Message-ID: <xmqqwq23w7qx.fsf@gitster.dls.corp.google.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 02:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbJ2q-0003cx-0T
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbC0B0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:26:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752513AbbC0B0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:26:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 245C8430B4;
	Thu, 26 Mar 2015 21:26:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YDC5zVKfitXHORcW+n5ikEMczSo=; b=HvW3Qu
	vs3uZLaryRmud8XihyVyHN8ml0gFXpBvbpEQTjK5GzWn7RtsZ21Kua1oeAqQ84ZH
	VacHga9VLpz/nD/qLNczHzCrB5VNRXIKwaOtuWxib3KU7RQzuL2ny5POTua4NLld
	i/D+TzkObo6mjHu1MpEP/hLXskELs4ICY533U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Es8lNMz3ZXj3qLDbQQU6CarZByRwIHoU
	nlTl/c0dJQ0qScRb+QVPrrjDTLD1I3hyrcRuq9kk9YCOVhU6Ob2BM7NhoE0Zz2DT
	vxk/GP07CRCsboUTkZbVr+ArfGuPE0lXvtyiDs8hR9iLjZujYMKknvNPUiTVSof3
	9vBmAAmrR80=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BFCA430B3;
	Thu, 26 Mar 2015 21:26:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C872430B2;
	Thu, 26 Mar 2015 21:26:31 -0400 (EDT)
In-Reply-To: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Fri, 27 Mar 2015 01:04:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C874764-D420-11E4-B9AA-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266361>

Vitor Antunes <vitor.hda@gmail.com> writes:

> This patch set includes two small fixes to the rename test case. The fix to
> support dash should be trivial, but in the fix to the copy detection test case
> it isn't obvious to me what changed in diff-tree to result in a different file
> being detected as the origin of a copy.

Thanks.

As to 1/2 the lack of esac is clearly a bug---any self respecting
POSIX shell should have executed it without complaining.  But
changing from ':' to true should not be necessary---after all, the
colon is a more traditional way to spell true to Bourne shells, and
we use it in many places already.  Can you try reverting all the
"colon to true" bits, keeping only the "add missing esac" part, and
run your tests again?
