From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull --upload-pack reversion in git 2.5.0
Date: Fri, 31 Jul 2015 10:54:16 -0700
Message-ID: <xmqqk2tg5i2f.fsf@gitster.dls.corp.google.com>
References: <20150730154523.GA17002@kitenet.net>
	<vpqvbd1k1ke.fsf@anie.imag.fr> <20150730183144.GA6360@kitenet.net>
	<CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Fri Jul 31 19:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEVk-0004zS-3M
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbbGaRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 13:54:19 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35251 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbbGaRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 13:54:18 -0400
Received: by pdrg1 with SMTP id g1so46249155pdr.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=x0Fo+Zp/15MgT6C8XzQN8XYGAtZUyfY9dYr8O6yG9AM=;
        b=0tsuTrWRnhWhiQ4Xq9ruR0wnhDnIdQeu7aFIRXvQqW4JochUuWSKFO0Ub4dXf8nU3V
         t/kVrniofJTZZLWAeIKQlp2vvUTTzzd39RbGdCWX2+j+4ycKyfQIubSgsKZI3oxfMvY2
         aMDfD67lEIS5voVBoW/1IwWbGQa8dM9bmkDut21H6/894Gom9zyKJWFFMu8GFPboL5eU
         YADwtH3MbwK/J8LGn0oEH3epWq8OfTFijqO8cgapdsObNAqoCQM1T/5Ysomw8Tzk4NSu
         YLdQboF1FPYnWGbz+5NXB2XkftVusljS0IfTXTQtXZ+LyxCtiPlUAWR+o+rzfGIlb6BB
         wJKA==
X-Received: by 10.70.119.41 with SMTP id kr9mr9622377pdb.0.1438365257774;
        Fri, 31 Jul 2015 10:54:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id pc9sm8899131pdb.6.2015.07.31.10.54.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 10:54:16 -0700 (PDT)
In-Reply-To: <CAPc5daXPY7RQSM6oyFYJ2LjYjaT9dDG-+3=nbHONirGh50pdBA@mail.gmail.com>
	(Junio C. Hamano's message of "Thu, 30 Jul 2015 11:41:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275060>

Junio C Hamano <gitster@pobox.com> writes:

> On Thu, Jul 30, 2015 at 11:31 AM, Joey Hess <id@joeyh.name> wrote:
>> I think this comes down to a lack of quoting where git-pull runs
>> git-fetch. Before eb2a8d9ed3fca2ba2f617b704992d483605f3bb6,
>> "$@" was passed through to git-fetch, but now there is a $upload_pack
>> which is passed without being quoted.
>
> Yes, it is not just the matter of using "$upload_pack", though ;-)
>
> ${upload_pack+"$upload_pack"} or something.

Thanks for a bug report.

The next time, I'd appreciate if these regressions are caught before
it hits the tagged release, during the pre-release -rc period at the
latest, but preferrably earlier.  I'm greedy and expect far more
from those who are known to be competent heavy Git users than from
"I update every few releases" casual folks ;-)

Thanks, anyway.
