From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 08:32:07 -0800
Message-ID: <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 17:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WELgc-0003Jc-Rf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbaBNQcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 11:32:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbaBNQcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 11:32:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BABBF6C81A;
	Fri, 14 Feb 2014 11:32:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tD6WOaEsR2TNYe43zzqeD+UrbwE=; b=uwrYqR
	vzFCl7lj8h4RPWLqNALDrKS1IFII5IaiAOU/2tJtDidyQQHIQOR9V5yCzliNBIHB
	KYaeiN3W2vaE2iEBtZqd0Hd4E6vRD95ti65+iHr0GKEjqqZ10z75l/8xMjxnucpc
	qaEb+BwhqdP77rvGXeFHuFKMXzMeo0BWu7c1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUqxrW3bQCWGdPQtv2yY5oAwfJz9RSeX
	I21QcR4GhEH08T6AeF64v6mvzshHoJe66hAApiGJac68EP8HjE7Rfw0GyWrq4TFD
	TVLxB/h2F6LlUKUZmF2dwyZMCcw/9ccYz3shJ3lmXuAGuU3uWpsZWO+ddLQ705VM
	87iV6YXPjaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CCD16C819;
	Fri, 14 Feb 2014 11:32:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 118156C814;
	Fri, 14 Feb 2014 11:32:10 -0500 (EST)
In-Reply-To: <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 14 Feb 2014 19:59:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8DACCE00-9595-11E3-88BE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242110>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Josef Wolf <jw@raven.inka.de> writes:
>>
>>> Notice the refs/heads _within_ refs/heads!
>>>
>>> Now I wonder how I managed to get into this situation and what's the best way
>>> to recover?
>>
>> Probably you did something like "git branch refs/heads/master".  You can
>> remove it again with "git branch -d refs/heads/master".
>
> As a porcelain, "git branch" should prevent (or at least warn) users
> from creating such refs, I think.

"warn", possibly, but I do not see a reason to *prevent*.

 A. You are not allowed to call your branch with a string that begins with
    'refs/heads/'.
 B. Why?
 A. Because it will confuse you.
 B. I know what I am doing.
 A. ???
