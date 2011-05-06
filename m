From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] staging: brcm80211: SDIO/MMC cleanups
Date: Fri, 06 May 2011 09:07:48 -0700
Message-ID: <7v39kr3j8r.fsf@alter.siamese.dyndns.org>
References: <20110504165947.40EED208186@grundler.mtv.corp.google.com>
 <4DC3B086.90802@broadcom.com> <7viptn3neo.fsf@alter.siamese.dyndns.org>
 <4DC41B06.5040500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Arend van Spriel <arend@broadcom.com>,
	"Grant\@google.com" <Grant@google.com>,
	"\"Grundler \<grundler\"\@chromium.org \<Grundler" 
	<grundler@chromium.org>, Greg Kroah-Hartman <greg@kroah.com>,
	"devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Dowan Kim <dowan@broadcom.com>,
	Henry Ptasinski <henryp@broadcom.com>,
	Venkat Rao <vrao@broadcom.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 06 18:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QINZo-00038R-Bg
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab1EFQIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:08:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1EFQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 12:08:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C24255905;
	Fri,  6 May 2011 12:10:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dw7Geb8IWoCFLwQn7h7Ns+/IObQ=; b=K01G30
	TZWzb7WR+NU6LxLXqUA3WVr1xSkm/TQnzN7qkiFL/jBFq4yuzlwNBg0xMlVi0vJw
	fuLXZzKoTyg1VsxvxNP8odI7anfa5u6oijQ0nbRhLOjCpJhb5G8S4LZFgwpbg9Tp
	VLUb6vG7IjkaOOm4bwR/rNui2n7U25S3hjot0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjsTTC/ovnt9d1UY+BCpA5JM4l6P10a7
	wf/M/ODeeoAkFXFs2gmzoOlZPqDNHq6pWs1SQMdKIfrJnZnO1rqKhKiyIfnM1IdM
	jvEW6/ajEZLLuVNFN3S8JhBwHI2cT90ubL0jdn9nMgfgNhzXBYEjXMCFAaYmH8hC
	R+8VGdF2VEc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 217C958FE;
	Fri,  6 May 2011 12:10:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1BDF58F2; Fri,  6 May 2011
 12:09:53 -0400 (EDT)
In-Reply-To: <4DC41B06.5040500@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 06 May 2011 18:00:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 510022D2-77FB-11E0-8FA8-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172985>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 06.05.2011 16:37:
>> "Arend van Spriel" <arend@broadcom.com> writes:
>> 
>>> The git documentation on the git am command is not very elaborate. I
>>> investigated the issue and checked following:
>>> 1. line 135 in dhd_sdio.c in the patch does match line 135 in my
>>> checked out branch.
>> 
>> Does it exactly match, or does it merely visually match if you ignore tabs
>> and spaces munged by somebody between the state of the file submitter
>> committed and grunder.eml file you stored?
>
> Junio, he reported the hashes to match! Puzzling. Or a MUA doing things
> to the .eml.

The latter is exactly what I meant.  The mailchain leading to the
receiver's mailbox would not adjust the hash recorded in the patch when it
munges whitespaces.
