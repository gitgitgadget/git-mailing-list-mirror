From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 11:47:16 -0700
Message-ID: <7v8v3hjt57.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<7vwqr1jw67.fsf@alter.siamese.dyndns.org>
	<CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKFv-0002FB-O3
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758057Ab3ENSrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:47:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757923Ab3ENSrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:47:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 625DC1ECB7;
	Tue, 14 May 2013 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Mz5cUTM/YnZZFe6OUYcQL7kpqU=; b=ShNlRM
	LuiuChBVP6Aa9t279fLzVMwzXjw754IdIjm9KFmqFwc2ugQYLCy8mx4+guFG8v7n
	lN7/1+M2lLYJ69KSJs/i5uTJcR4rvbfZEpXa1BfaCePRRozp6E5vULnnctUSYb/i
	CUdWXaERWGX+giCRhGNnKPgacSz8S+P0lirRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nD/OlS18+fMXRzn2tv+I2ueVUr5FjTqS
	7LCaG3gSa7fWXslqZH1ipPgu5w0TzTJnerkg0U8ccvPvWy7PahZtfE22lVrFUN4s
	DAQwCpnv8DZp+ek+y6eGxNkgkxJZuCytrzgq1wdMRebyVo0MjIELDboqRFSTWhwg
	8VtqGiagsfA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DB41ECB5;
	Tue, 14 May 2013 18:47:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6B751ECB2;
	Tue, 14 May 2013 18:47:17 +0000 (UTC)
In-Reply-To: <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 14 May 2013 23:50:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B39E51F4-BCC6-11E2-A1A5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224314>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Any time you say "This means that", "More precisely", etc. please
>> check if you can rewrite it to lose everything before them (i.e. a
>> vague sentence that needs to be clarified may not have to be there
>> at all).
>
> Right.  I thought both are necessary in this case: the first sentence
> gives easy information to a first-timer.  For someone who has played
> with it a bit, and wants to know more: the second line.
>
>>> ++
>>> +It is often useful when you're looking for an exact string (like a
>>> +function prototype), and want to know the history of that string since
>>> +it first came into being.
>>
>> I think you should remind that the most useful case (and indeed the
>> intended one) is for "an exact string" to be a multi-line "block of
>> text".  People often get a (wrong) impression from the word "string"
>> that it is meant to be used with a single-liner.
>
> Yes, I've been meaning to discuss that.  I've been having some trouble
> with multi-line strings: zsh doesn't insert a TAB in the next line.
> The workaround I have is to write a shell script and execute that.
> How do you do it?

I do not use zsh but with bash+readline the old tradition lnext can
be used (see "stty -a" output and it typically is set to ^V), i.e.
\C-v followed by \C-i should give you a literal HT.
