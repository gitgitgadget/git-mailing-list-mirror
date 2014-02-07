From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 07/14] trailer: add interpret-trailers command
Date: Fri, 7 Feb 2014 09:34:33 +0100
Message-ID: <CAP8UFD10aGq+cUcaiMHRKsLLKvF1eYUuM+G85MRHqhwBXZVv-g@mail.gmail.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.48784.chriscool@tuxfamily.org>
	<xmqqiosrwzoh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 09:34:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBgtS-0002wF-I9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 09:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbaBGIee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 03:34:34 -0500
Received: from mail-ve0-f182.google.com ([209.85.128.182]:56342 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaBGIee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 03:34:34 -0500
Received: by mail-ve0-f182.google.com with SMTP id jy13so2543465veb.27
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 00:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QSDnUX9mBZYLET+PbTO/+HoekEbyAIrcBbP370wAia4=;
        b=sRqQsfkj6nS36+tfxYHSkkkOolW64BodVjBL53Nk+myHnx7VMVMCy+aEB/nhsRNaPP
         GOCGnSS4ScKMC5aQpl9ufyJy3lai+SpiQCqcjFoy5prWt/aCySklQmjX0rwGD9bdpDW0
         RaP6dEu0GCx2ZEUOqlg9LTc8I9BY4CtG8hg62pJVLNrgtX/VLkK0MeOuV7sIweyCZMMj
         FJouuu3appWM0v0fJeotrCMI0tqHOQz1fSiuyAZiimkf2uNC+GTapDG7HWBziCS/wwGF
         ZeJcGl7rEeBb+YjrmZpnCAeHbOxqU9QnrHs0hJtJXVfDAGlg2AWNPzRpZcyvfUyLjVBt
         /7Dw==
X-Received: by 10.58.54.15 with SMTP id f15mr9255273vep.5.1391762073233; Fri,
 07 Feb 2014 00:34:33 -0800 (PST)
Received: by 10.58.173.231 with HTTP; Fri, 7 Feb 2014 00:34:33 -0800 (PST)
In-Reply-To: <xmqqiosrwzoh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241762>

On Fri, Feb 7, 2014 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> diff --git a/git.c b/git.c
>> index 3799514..1420b58 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
>>               { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
>>               { "init", cmd_init_db },
>>               { "init-db", cmd_init_db },
>> +             { "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
>>               { "log", cmd_log, RUN_SETUP },
>>               { "ls-files", cmd_ls_files, RUN_SETUP },
>>               { "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>
> Does this even need to have a git repository?  What is the RUN_SETUP
> for?

It needs to read git config files, but it could work without reading them too.
I will have another look at it.

Thanks,
Christian.
