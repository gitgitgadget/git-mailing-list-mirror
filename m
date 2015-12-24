From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 04/11] update-index: add untracked cache notifications
Date: Thu, 24 Dec 2015 22:11:50 +0100
Message-ID: <CAP8UFD12kjUFvuaSMj3Q5sgDzCELejO7mEBuZ8g-=Cfa7sv5=A@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
	<1450904639-25592-5-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8BQi8LQSHsZ7UMduCdE2_AeNwxn3kppc1xTfaNsMN=OXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 22:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCDAy-00052r-4a
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 22:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbbLXVLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 16:11:52 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34783 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbLXVLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 16:11:51 -0500
Received: by mail-lf0-f47.google.com with SMTP id y184so166939423lfc.1
        for <git@vger.kernel.org>; Thu, 24 Dec 2015 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0at1cXacdPLOgQIx84XbjN7PrlGoHqDXpm82v6D1W+A=;
        b=KCfqWR0DLQlGI8aiVDSiaqgYUkUXc7Q1bf12tGWp6RAN208+7HIoFDlMQkUoBNhjp0
         zSvv8U0/AS1AftQxao9GhOGrtd4I9V70qnr/WHVio7wIV/xrQD9d7AiuB4lGWMU3nUsg
         dghdEc8OBkJWd6140MYhluEnt2em7VbzIF3+0NEJtMKcWYQQHpIKGzyzN/gA8nZWFwYv
         Qy3cABeXogzX088eqP69ase933VW8KngFbJx5Zf97MXCJ0RIebFQ2nTLAnwPM4cHmm9K
         +vnKCpoeLVXvQTJ0moS5ZakzQqGRayWcaOTyHUs3j8jsHBfIf1zifwNlf/O8XS6PbZWT
         t9zA==
X-Received: by 10.25.169.212 with SMTP id s203mr10480682lfe.134.1450991510385;
 Thu, 24 Dec 2015 13:11:50 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 24 Dec 2015 13:11:50 -0800 (PST)
In-Reply-To: <CACsJy8BQi8LQSHsZ7UMduCdE2_AeNwxn3kppc1xTfaNsMN=OXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282984>

On Thu, Dec 24, 2015 at 11:01 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 24, 2015 at 4:03 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> @@ -1135,10 +1135,16 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>                 }
>>                 add_untracked_ident(the_index.untracked);
>>                 the_index.cache_changed |= UNTRACKED_CHANGED;
>> -       } else if (untracked_cache == UC_DISABLE && the_index.untracked) {
>> -               free_untracked_cache(the_index.untracked);
>> -               the_index.untracked = NULL;
>> -               the_index.cache_changed |= UNTRACKED_CHANGED;
>> +               if (verbose)
>> +                       printf(_("Untracked cache enabled for '%s'\n"), get_git_work_tree());
>
> Nit. If you use report(), then you can skip "if (verbose)" because
> it's done inside report().

Ok, will do.

Thanks,
Christian.
