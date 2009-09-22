From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Tue, 22 Sep 2009 12:46:00 -0700
Message-ID: <7v1vlyrcef.fsf@alter.siamese.dyndns.org>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
 <20090914105750.GB9216@sigill.intra.peff.net>
 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
 <20090914120311.GA17172@sigill.intra.peff.net>
 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
 <4AAE4087.5030607@viscovery.net>
 <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>
 <4AAE42F2.30304@viscovery.net>
 <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
 <4AAE4724.1090705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqBKN-0000W8-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZIVTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZIVTqO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 15:46:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZIVTqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 15:46:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FB835B2F0;
	Tue, 22 Sep 2009 15:46:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LybQ6jXgzsQSgXyE0/yxQ6CXwf8=; b=QNvvAq
	YEc+4SBUQl/Cqm74hyjPswmfwtzZPOKvjq7wTEgimhhMt2mIMpn1lhRpApInskh2
	bz+v3hNk/oj2fKjNFTtkjVBoouO/dNkxczn8Ws7PHec6BuI5SAynkcC2rARnlyYy
	tfYnNuecBEXmtiQ9pP0TdmlCGmaAZvCLT7A/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bPbfFANTrVCFizDFG8/I+mGgq5sJ1G2V
	XtaGneDKS0OwjNdXS+MnQQ2bup3gHdpTwSKFj176y1DVHUTxCeMJuXPgf7WAU2Q1
	TuUsjqkvQjx2ne19j6uVZ3NHm+qgOT19cUTE3xXRpqZBwy8iY33erxuoODI+RN7g
	K30ujeX82T8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DEAD95B2ED;
	Tue, 22 Sep 2009 15:46:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D504B5B2E7; Tue, 22 Sep 2009
 15:46:01 -0400 (EDT)
In-Reply-To: <4AAE4724.1090705@viscovery.net> (Johannes Sixt's message of
 "Mon\, 14 Sep 2009 15\:37\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 941C2E34-A7B0-11DE-B3DE-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128955>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Erik Faye-Lund schrieb:
>> On Mon, Sep 14, 2009 at 3:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> "The" warning? Not "the two" warnings? Then I suggest to stop here; MSVC
>>> is only half-competent with regards to noreturn.
>> 
>> There was only one warning in this regard on MSVC - the one about
>> unreachable code. And yes, MSVC is only half-competent, but it seems
>> it's competence is in the half that matters in our case.
>> 
>> Do you suggest to stop the patch-series, or to stop the testing?
>
> My suggestion was about stopping the patch series.
>
> But thinking a bit more about it, I can imagine that there are calls to
> die() that, if it is not marked noreturn, could trigger other warnings
> with MSVC. That would be annoying, and it's better to mark it noreturn.
>
> So I withdraw my suggestion to stop :-)

Anything happened to this series?
