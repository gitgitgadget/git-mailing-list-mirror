From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] add a test for semantic errors in config files
Date: Thu, 24 Jul 2014 09:41:15 -0700
Message-ID: <xmqqmwbyaevo.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-4-git-send-email-tanayabh@gmail.com>
	<vpq38drvohr.fsf@anie.imag.fr>
	<xmqq38drd8ue.fsf@gitster.dls.corp.google.com>
	<53D11077.10907@gmail.com> <vpqha26kg2d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:41:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAM5B-0008MO-5O
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 18:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757637AbaGXQlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 12:41:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53604 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbaGXQlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 12:41:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE92C2A3FD;
	Thu, 24 Jul 2014 12:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+LvpNELsDRX7eItXalZ4GY1iWQ=; b=I0dJaj
	JZTPxWcd19ZU/wRjma0YGVD9s0AHqaXr+R6kofKjwWMzkiMdMwcQ+XkLTLIJ1FLD
	ZDh2XyRkjSvloYADBqnaUc06Ai4ePMsyhgx1rQgZfy2c4oSYqIbF0la0CXeCUL+P
	4qVYhZuNNJXj+xxjyQlx9KJOo+/b1em9byQ3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GXE6jXOekilzecAEZ5EGd1RF5jEBuJQs
	uretSvUemQScSli0SE+Oq9jHVb0/IwOTYebp+WqqCmmsz0S25DFEz4FsJNkZMahH
	AO1FrsQ2VrrDZQ/MQa06oRgZWD6bEvRZCrEGtg8EMTRM57okFHsRaUkX2hH6+whO
	CNog0piU2Us=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E37772A3FC;
	Thu, 24 Jul 2014 12:41:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 853DA2A3F1;
	Thu, 24 Jul 2014 12:41:17 -0400 (EDT)
In-Reply-To: <vpqha26kg2d.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	24 Jul 2014 16:05:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 557F6D14-1351-11E4-8993-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254168>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>>>>> +	test_when_finished "mv .git/config.old .git/config" &&
>>>>> +	echo "[alias]\n br" >.git/config &&
>>> 
>>> Is the use of \n portable?
>>> 
>>
>> Yes, you are right, will replace with printf in the next patch.
>
> ... or a cat >.git/config <<\EOF, since this is the construct used
> elsewhere in the script.

That sounds much better ;-)  Thanks.
