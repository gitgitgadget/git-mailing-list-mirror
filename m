From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Tue, 13 Oct 2015 14:07:57 -0700
Message-ID: <xmqqeggya34i.fsf@gitster.mtv.corp.google.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	<xmqqzizn9qaf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYZ+RyjvkgY8+aeRpnVtaCyqFxQqQ3wggjtef7y6MNLcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:08:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm6nk-0006wT-QR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 23:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbbJMVH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 17:07:59 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33117 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbbJMVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 17:07:59 -0400
Received: by pabrc13 with SMTP id rc13so31904890pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tRkTRBxiwBCXctQQ9izWAGqDQMGNY3IoS3Yoe7d1Y8E=;
        b=j2KYxuAQcNc688ZsDV9n0NIBGnWtej2qnGmBY/EQK0Q+EikBxAzZQwDYE7fRq90Krb
         LBmeR+Q63E7rGvned2lM37mSJOwwmVnqawclUWU5UnmZqBtE55KG7t6yvqdJdCpfr9rr
         5uqbpX3y8olOqOX1hyROkAXIhAvVly3qvm8NHXlo0fWEy/Nna9RVfKxLkIevCPaxrbcu
         OB6j3sBWskGV5VitPekRxs2HDe2FIM0dK8u4T+LBwp1pEtGZSnYjySuBhxnQfEuE18XI
         era6TuOIef3BfCM53Ar4OujOxrcv7RFuui/3YtPivImJZhwSNDE64LqgwZ5lfw+mu7zo
         78Sw==
X-Received: by 10.66.145.193 with SMTP id sw1mr42949331pab.74.1444770478631;
        Tue, 13 Oct 2015 14:07:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id fk8sm5577597pab.33.2015.10.13.14.07.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 14:07:58 -0700 (PDT)
In-Reply-To: <CAGZ79kYZ+RyjvkgY8+aeRpnVtaCyqFxQqQ3wggjtef7y6MNLcA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 13 Oct 2015 09:03:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279520>

Stefan Beller <sbeller@google.com> writes:

> Assuming we go with your second school of thought (N are the real
> running processes, M including the finished but still pending output tasks),

That's neither of my two, I would think.

Anyway, I think it is now clear that it not very easy to say "I know
what to fill in M and N" there ;-).
