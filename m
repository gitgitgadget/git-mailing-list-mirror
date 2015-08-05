From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: Don't pass --full-history to git-log(1)
Date: Wed, 05 Aug 2015 14:45:20 -0700
Message-ID: <xmqqvbct1kb3.fsf@gitster.dls.corp.google.com>
References: <1438784487-9176-1-git-send-email-avarab@gmail.com>
	<xmqqr3nh4qx5.fsf@gitster.dls.corp.google.com>
	<CACBZZX5GvCqx3LkWBDb4kDFpyaEwK-Fnhtof6nhKsctmx22m1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:45:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN6V6-0003RR-E0
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbbHEVpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 17:45:24 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33817 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbHEVpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:45:22 -0400
Received: by pawu10 with SMTP id u10so45362256paw.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=tXq8zg73zAhrjCad3DS2rm7Q/JEJ414l3+Ld/lW/s8A=;
        b=BGpNeg8ldbHyrJbA6h1m83b2Ty88JoCnyEJiUgxsmJp7r82sC6P8JpWTf2Yc2ct7mD
         oTWIfYVaZJR2jJhUlTuxSA69xFsTQlEU9P0CQS8vLMkDNMNyiAB+rhBlbadhtRSTthpP
         n5/zr9/bqngRQTTCo0gxb5GCjgo7KD8BH9uS2MNzMfo6EKN07q5RM7eFSPO6YGL1gYNQ
         rAX/k61vWOvO7xTA0gPgdIyyWZQXBcEwZ0opuDuPdbJRh+vjwA9t2ZoxCmx+L/ve/Zvx
         hFvHUu3VnO+kJKYLrTAbbwY0cQpI64dtf5Ytd0JbNXom01FPloyFOkPK8sf3lgmRaRnq
         D4yQ==
X-Received: by 10.66.132.16 with SMTP id oq16mr24014017pab.13.1438811122169;
        Wed, 05 Aug 2015 14:45:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id d13sm3971082pbu.51.2015.08.05.14.45.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:45:21 -0700 (PDT)
In-Reply-To: <CACBZZX5GvCqx3LkWBDb4kDFpyaEwK-Fnhtof6nhKsctmx22m1g@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 5 Aug
 2015 23:28:38
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275404>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm reminded of the make(1) story about not supporting spaces instead
> of tabs because the guy already had a few dozen users.
>
> We could have changed this in 2008, when Git already had much fewer
> users,

Heh, in 2008 we already had more than a few dozen.

I think

 (1) It is perfectly OK to add an UI option to let the web visitor
     choose between simplified and full history at runtime,
     optionally with a new gitweb.conf option to let the project
     owner choose which one is the default;

 (2) It is also OK to add gitweb.conf option to let the project/site
     choose between the two, optionally allowing the web visitor to
     override it with something like (1).

Anything else would not give the same out-of-the-box experience and
would probably not fly well.
