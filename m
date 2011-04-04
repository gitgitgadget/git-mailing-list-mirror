From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 19/51] i18n: git-pull "rebase against" / "merge with" messages
Date: Mon, 4 Apr 2011 09:39:13 +0200
Message-ID: <BANLkTimHwSzm7MQ83gOt_OPFvZMn_2ca1g@mail.gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
	<1301849175-1697-20-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1104031314520.25129@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 09:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6eNd-0000Dw-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 09:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab1DDHjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 03:39:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55284 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab1DDHjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 03:39:14 -0400
Received: by fxm17 with SMTP id 17so3702064fxm.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3ErfLNFg/M4/XJva2iXgPTeerMQqQdwn4xp0rrOFrCw=;
        b=QylYUqsDII8xiCgObq7lKY/dFjNOjI7pgseJKI2gSupe36FFHnMFm5tJdbgzHGvvKb
         FdsxIjJWYi6yxMtChgfg8uLul1d5Ul9VxwXZFE/NFzQCUi2ChEqJEJRYB/icpPlu5TzN
         JIPE0nN0FO57bc+neXlsVpTeaSz5QsI86yEuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CjuXPbAfPxkTuHu7zZSOEQYSt+/vXFxLITuTPfGC7C13fWPRnKwz4mVA37cgoPHjAa
         PFujt6VPnFmmwP4dPhIEgQToI5amGaVZEDTKVJAhGJLzqllpQTHjWtLvkjxPQF2VtdkX
         tKjYwLRCHqsg8w+djul3dDgV2pZmW5+HGA0uM=
Received: by 10.223.127.210 with SMTP id h18mr644889fas.67.1301902753511; Mon,
 04 Apr 2011 00:39:13 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Mon, 4 Apr 2011 00:39:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104031314520.25129@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170794>

On Sun, Apr 3, 2011 at 19:33, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Sun, 3 Apr 2011, ?var Arnfj?r? Bjarmason wrote:
>
>> Gettextize the two messages that used "rebase against" and "merge
>> with". Split them into two depending on whether we are rebasing or not.
>
> I think this conflicts a lot with my 15a147e (rebase: use @{upstream}
> if no upstream specified, 2011-02-09), which factored out most or all
> of the code touched in your patch a reused it in git-rebase.sh. I
> remember thinking about i18n at some point while extracting that code,
> but then I forgot about it. I have inlcluded the relevant part of that
> patch below for your reference. As you can see, I added another
> variable $cmd that is either "pull" or "rebase". It is used in plain
> text because the command matches the verb in English, but I guess that
> may not be ideal in all translations. Maybe we extract some parts of
> the message, so we don't have to make four nearly identical copies of
> the message... I don't have any concrete suggestion right now, though.

Translation-wise we'd ideally make Yet Another Copy of almost the same
message. There's really no way around that sort of thing given the
tools we're using.

However we can probably get away with having a variable that
alternates between "pull" and "rebase", but I suspect those two words
will invoke different grammar rules in some languages, and thus will
impact the rest of the message.

So let's split this up when we resolve this conflict.
