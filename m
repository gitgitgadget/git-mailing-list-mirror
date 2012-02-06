From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 13:48:46 -0800
Message-ID: <7vpqdr63b5.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vwr7z653f.fsf@alter.siamese.dyndns.org> <20120206211321.GA2949@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuWQh-0008WN-EH
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab2BFVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 16:48:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872Ab2BFVst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 16:48:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE68D64E3;
	Mon,  6 Feb 2012 16:48:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v65jncxGga6WzCPo4gKOFz8ybZQ=; b=kUkYnT
	bEWVfs+2tVBZaKrqVv8ZRePiV1HoST4lL1uuVbyM0u9Iusv0P0nMWShRYY00Abx4
	jFQvsbRvNuwiQ4sgMOd5wH4gxaFXphoFsCNbHG8ZmQ4bnxs7cwrvy9CwA3O+22qm
	miezOVW6SrZqrrCaPgpzZkoxwOhpFn0MCB0MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yw0hgnDyv5MlCAnRSkVefz0j69hjowUr
	n6jts/mblWqaCBfMkoG+20NMaasTlrPNSTMidSm6lOafM42+Pn60o3aPD6K86Ke6
	101EPABFGVXnCkKNE/om9pkLvLQZ2ZEskTuUanFo5gnq2fYKtv8avMCkN4WnWs4z
	+BFD9jS3llo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B524664E2;
	Mon,  6 Feb 2012 16:48:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4895864E1; Mon,  6 Feb 2012
 16:48:48 -0500 (EST)
In-Reply-To: <20120206211321.GA2949@burratino> (Jonathan Nieder's message of
 "Mon, 6 Feb 2012 15:13:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A22D8C-510C-11E1-B503-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190110>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> IIRC, the original motivation of intent-to-add "add -N" was in response to
>> users who curse Git because they often forget to add new files before
>> committing, and they wanted to say "Here I have a new file, it is not
>> complete yet, but I do not want it left out of the commit. While my memory
>> is fresh, let me tell Git to keep an eye on it, so that it can remind me
>> if I forget to add the final contents."
>
> I agree with everything up to here.  But I believe these people were
> _already_ paying attention to "git status" output from the commandline
> and in the editor window when they run "git commit", to notice other
> changes they forgot to add, too.  I don't think this series would
> inconvenience them.

That means that you are willing to declare that nobody will ever need
"please remind me lest I forget".  Not just the original requestor of the
"add -N" feature, but absolutely nobody else.

Then the deprecation sequence presented in this series is fine.  The
wording to sell that "removal of misfeature" to the end user community
needs to be well thought out, though.
