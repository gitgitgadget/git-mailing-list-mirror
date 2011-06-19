From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Bring notes.c template handling in line with
 commit.c.
Date: Sun, 19 Jun 2011 15:50:04 -0700
Message-ID: <7vpqm9e8rn.fsf@alter.siamese.dyndns.org>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-2-git-send-email-ydirson@free.fr>
 <201106192323.09511.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQon-0005oZ-Uk
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab1FSWuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:50:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab1FSWuH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:50:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7BA6686E;
	Sun, 19 Jun 2011 18:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbMq8o/B9ZAA8EyWILt6SavuU64=; b=JDTWHt
	joSkU/XreW26C1KGXA5jc1+GHyqT1rJTEG6PGP337YUxoRkSG/ya+sg3t5h6WXkC
	5jUX0X4Z5iVu1DQgYUiL0vS/CrYnDaz174VnDFbsyDzWYCbys9aA33oqEsyzRfna
	9pGfZr/qAKwZSzQ0tJPKHGiqpfVRguMl52ihY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUlTu4mJye03ez9/46T+3xVa0v0wtSdB
	DRAUTpMUBLRh+KUDCcfUnBTlMSg0wsR4jBTp9Cf/WQPP2NvNw0nZNBtdDQ3DensE
	AS2xvDYQ+M81kBYq7GdK9S+dG8niuxqVgEeXAzolFsZ5Gj/tSzVybNVOJl1ghoab
	YGDBcA/fs1U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8551E686D;
	Sun, 19 Jun 2011 18:52:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3AEA686C; Sun, 19 Jun 2011
 18:52:16 -0400 (EDT)
In-Reply-To: <201106192323.09511.johan@herland.net> (Johan Herland's message
 of "Sun, 19 Jun 2011 23:23:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7E165B2-9AC6-11E0-9EF4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176037>

Johan Herland <johan@herland.net> writes:

> On Saturday 18 June 2011, Yann Dirson wrote:
>> Signed-off-by: Yann Dirson <ydirson@free.fr>
>
> Please mention in the commit message that the commit merely replaces 
> write_or_die()/int fd with the corresponding stdio functionality, and that 
> there is no (intended) change in behavior. It was not apparent from your 
> commit message that you had not made any other changes.
>
> Otherwise the patch looks OK.

I had an impression that you would lose a lot of error checking, unless
you are careful, if you go from write_or_die() to stdio.
