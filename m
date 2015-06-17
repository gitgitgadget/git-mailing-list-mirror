From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 09:19:06 -0700
Message-ID: <xmqqd20u48at.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5G3X-0007yj-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbbFQQTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:19:10 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34915 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbbFQQTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:19:09 -0400
Received: by iesa3 with SMTP id a3so37286524ies.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5Chq9OTy2R+9OGnxTQEXvvLgKwTKgSAUYmJNy6ZDXVU=;
        b=mNChQRo94fcmk+KbnwZyI0ugAFJnbtHEjnEF6i8WX89v9bMKT6J5C8MQjh5eDGOdQk
         eJzq7V8Fz7shvL8hpfHsdSl4RixR0xgyi++722HZZmXvl1u55ktZUKKcfwBqM/LweOMT
         NVBSycTTLqr/g8GAZ1r4CJJAkxOxxNoL+3cda+ZoauYK3/UZqIN71JPL+OngxgegyVU0
         Dxrz6h47mcs3ZF1+bQI5vuIFuM2I4snvw1Hljtf5jhLWxWIm+v+Lgpiz3Q+b2ApZimeL
         Q5QM/ySx3C4q9deF7H0iyW9nF7maFM6zAzKyDDYKjf4DBK0OV0JhT/HNmLdI7FbAgTeC
         9rOw==
X-Received: by 10.43.17.135 with SMTP id qc7mr1029164icb.14.1434557948841;
        Wed, 17 Jun 2015 09:19:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id b73sm2873623iob.25.2015.06.17.09.19.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 09:19:08 -0700 (PDT)
In-Reply-To: <xmqqoake4akt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 17 Jun 2015 08:29:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271863>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Yes, but "Switch branchs or discard local changes" still does not
>> describe "git checkout HEAD^^^ -- file.txt" (restore to an old state,
>> but does not switch branch) or "git checkout -- file.txt" (get from the
>> index).
>
> You are right, especially when file.txt does not have any change
> relative to HEAD, there is no "discarding" going on.  You are
> actively introducing a change to an unchanged file by checking
> contents out of a different revision.
>
>> To me, "discard local changes" imply that there will be no uncommited
>> changes on the files implied in the command after the operation.
>
> Yup.

What was discussed in this thread sounded suspiciously familiar ;-).

Unfortunately "overwrite changes in the working tree" and "discard
local changes" are equally bad.  As it does not say overwrite with
what, we invite the original confusion that triggered these threads
if the reader thought an equally useful but different "overwrites
with result of merging your local changes to the pristine" (similar
to what "checkout -m" does) would happen.

At least, "restore working tree files" without saying "restoring
them to what state?" is much less likely to cause such a confusion.

So perhaps

    git-checkout - Switch branches or restore working tree files

in the headline, and then explain "restore to what state" in the
description?
