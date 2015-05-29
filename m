From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Fri, 29 May 2015 11:04:29 -0700
Message-ID: <xmqqoal3claq.fsf@gitster.dls.corp.google.com>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqq382giokd.fsf@gitster.dls.corp.google.com>
	<87oal32wuj.fsf@ensimag.grenoble-inp.fr>
	<xmqqa8wne50t.fsf@gitster.dls.corp.google.com>
	<vpqh9qvp8sw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 20:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOe4-00011T-CT
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 20:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbbE2SEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 14:04:32 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34686 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444AbbE2SEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 14:04:31 -0400
Received: by igbhj9 with SMTP id hj9so20912338igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vhnQj1jpru2pzNEuYNvj9R18Vtsb05Luq/j9Svyk6y8=;
        b=brrB3YX1b6oq1WKG+yK62ff2HFoSPoYZOVQ6t6E4fxp7B3mCL4bIYoCidrqMLIzcZt
         5wQcnnDOmXBUfwfUgZ5C89sQCiYS7IsIn5GmoQIpPSlR/lKLMK+NvHBHtqDxyXVdf4mg
         6Yg8irZECz5P11MKLeJoHujki85Ax8T7/GIOEYLSZR1LvJ2ZP9yXsUsTEdh8lhhHSWWy
         9aKNEugFmK5oBGcrJshow/tIWyCBQSMpPlYtIO9K+jitnUjQ8QVj0OViSV8+a5Blj+Mu
         qV/mCWqPpsSSBIPhTeWMY3qDc8Be9wC1DBrFanmwJ+NHIX1qqjDacgexozX1TeSVS94V
         jj9w==
X-Received: by 10.50.43.227 with SMTP id z3mr5703163igl.22.1432922670887;
        Fri, 29 May 2015 11:04:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id f126sm4681282ioe.21.2015.05.29.11.04.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 11:04:30 -0700 (PDT)
In-Reply-To: <vpqh9qvp8sw.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 19:55:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270262>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>>
>>> Yes, that works if Foo is in an alias file, so that's clearly a bad
>>> example, I added quotes:
>>>
>>> 	git send-email --to='"Foo, Bar" <foobar@example.com>'
>>
>> I'd further suggest replacing ", Bar" with something a bit more
>> realistic that people use in real life, e.g. ", Esq." or ", PhD"
>> (e.g. "Jane Doe, Esq.")
>
> Why not, but it's also not uncommon to see "Last, First", like
> "Moy, Matthieu" <Matthieu.Moy@imag.fr>.

", Bar" is not clear what its relationship is to "Foo", but with ",
Matthieu" it is clear what is going on, so that is fine, too.
