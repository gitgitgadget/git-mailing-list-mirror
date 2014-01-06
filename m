From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 15:29:57 -0500
Message-ID: <CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 21:30:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0GoH-0007Wc-G4
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 21:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbaAFU37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 15:29:59 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33992 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbaAFU37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 15:29:59 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so15973361wgg.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 12:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9KkSTz611sng8By9u3nCXuZuKsPxhH2SvV0sNEpCEcw=;
        b=NrG3l4QkycX1nuM/yxpon/vOPGAoSIv3qCKjYGzfkTJ0ud84vooeV0X+fkX58ni+LX
         x3b0yNGsMQSHNOYUI5iDMcY0qJ1yoUiE6lkcm7yKcPLQ5btcE7tIQKweUl5KmMIWiNlo
         kywvN/D9zSyow6ikMuwgEtbSk99DYbS9l6arLFe9lGcOsuVkaMm2NfophXDd5Tx0nnS9
         I2C97cnyUM7O9Y9+OV+8H2AJdEL+48ZgRfq8BGY0k/Vm4Mh50rqDIDbjIRZEQ3byMaXT
         Ce+/hmCZCyIe4SlcxPJCl9P9HI5P4QJwF75DyB7OV+v8syKlYI4LqeDONJfUWS5cNhmv
         YClg==
X-Received: by 10.180.36.40 with SMTP id n8mr13752274wij.54.1389040197932;
 Mon, 06 Jan 2014 12:29:57 -0800 (PST)
Received: by 10.180.74.232 with HTTP; Mon, 6 Jan 2014 12:29:57 -0800 (PST)
In-Reply-To: <20140106201854.GA28162@sigill.intra.peff.net>
X-Google-Sender-Auth: 0t-hq7ARjdipZd39hTHZxyxEdXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240058>

On Mon, Jan 6, 2014 at 3:18 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 06, 2014 at 12:06:51PM -0800, Junio C Hamano wrote:
>
>> Unless you set @{u} to this new configuration, in which case the
>> choice becomes dynamic depending on the current branch, but
>>
>>  - if that is the only sane choice based on the current branch, why
>>    not use that as the default without having to set the
>>    configuration?
>>
>>  - Or if that is still insufficient, don't we need branch.*.forkedFrom
>>    that is different from branch.*.merge, so that different branches
>>    you want to show "format-patch" output can have different
>>    reference points?
>
> Yeah, I had similar thoughts. I personally use "branch.*.merge" as
> "forkedFrom", and it seems like we are going that way anyway with things
> like "git rebase" and "git merge" defaulting to upstream. But then there
> is "git push -u" and "push.default = upstream", which treats the
> upstream config as something else entirely.

Just for more reference, I rarely use "branch.*.merge" as
"forkedFrom".  I typically want to use master as my target, but like
Ram, I publish my changes elsewhere for safe keeping.  I think in a
typical, feature branch-based workflow @{u} would be nearly useless.

-John
