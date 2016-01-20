From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 10/11] test-dump-untracked-cache: don't modify the
 untracked cache
Date: Wed, 20 Jan 2016 11:12:56 +0100
Message-ID: <CAP8UFD2-Bg6K36WnJxqCQjCOj5-FhSW2H5ciafQv5na3AaTPnw@mail.gmail.com>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
	<1452841192-620-11-git-send-email-chriscool@tuxfamily.org>
	<xmqqa8o6ha3e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:13:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLplE-0001s3-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbcATKNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:13:04 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36103 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964841AbcATKM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:12:58 -0500
Received: by mail-lf0-f54.google.com with SMTP id h129so2674782lfh.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ocjvcDtKFPvOwEJ+fLAqCzmyzN/udp+ZSY5ym9fllvE=;
        b=W8qGqI0hEXx/jSxLs2LL1gjfaiQnU2/LkH1K9t/uZ0LBYWHRCAYY1mbnsReecyRxJA
         x+5kqEFr9nxU/ZeCZsL70+IoT8tL/EoOisN5yLnCYdtNs/NKCD+WEB/jP2bmnRtgZZrm
         3a+sbZrxGl4Q40rn6xOJ4fopXWWGGf0fQLKmzLU6CeeBe6viQ4QCw3Qc5CfaXrEXaJAy
         A24tOPl/DwX1ZPNDAJ7008BPPWfQ6C+VFLwo7JfqTos3xF4T3Q+OLwztw/s73oYb2Y9+
         a6jBCFxGocpQ0lSBFUy1kl8N1c16GnTmHTE7G2eVnpbNt8FyLP0fJBVZxX5XlbmZzoWF
         3GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ocjvcDtKFPvOwEJ+fLAqCzmyzN/udp+ZSY5ym9fllvE=;
        b=HbrvNZUZU0r5+9VSmgpMB8Y4X1YHe8bCrjFPOKHdVN+bp78+/cHC3viE6EF/GMp7jh
         Kj2kL7nv/+TO2/Nm8sg0y10w69v5kYN/9qzQqwe+7GuQQapbRG3T9KsrsHiIYKofz/xr
         6sJt8mCCjsFTvhslptK5IMSuQoJ+NvPpJo2OFKJAw7vnOubclAYMJFJi0OfjsrqcTpiy
         RMeoz0Oz5jRg97cdqb4gw7KPhCMawv7059ICtmye8tKOuIIJDcIET4OtLR4V2kbdJzO1
         E7WnIJwD9Mpt+sJAs9ATVAEJBNnoKKOISQox7Pd9d9qtYPoYkfV0jepfkjoeK4V+sZgL
         ReKQ==
X-Gm-Message-State: ALoCoQkyjW4Kb8siqU/M0GAD6nO0EOglEBDiQ8+Cyk4RrtAlZ5ArMc3f4E0Ps/CyaVad86Ahh/OA/w77MWVeR9QEsOh1fZnUcQ==
X-Received: by 10.25.205.76 with SMTP id d73mr12679378lfg.76.1453284776835;
 Wed, 20 Jan 2016 02:12:56 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Wed, 20 Jan 2016 02:12:56 -0800 (PST)
In-Reply-To: <xmqqa8o6ha3e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284446>

On Fri, Jan 15, 2016 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> diff --git a/cache.h b/cache.h
>> index 59a15fd..89c7e10 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1605,6 +1605,8 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
>>  extern int git_config_get_pathname(const char *key, const char **dest);
>>  extern int git_config_get_untracked_cache(void);
>>
>> +extern int ignore_untracked_cache_config;
>> +
>
> I know you said this is a hack to support the test, but I really do
> not like to have a test-only global variable exposed to everybody
> like this, as I do not think "ignore_untracked_cache_config" should
> be necessary outside the context of testing [*1*].
>
> If the config cache layer that is used by the implementation of
> git_config_get_untracked_cache() had a way to be told to pretend
> that the value of a particular configuration variable is a given
> value, then we could do
>
>         git_config_pretend_value("core.untrackedcache", "keep");
>
> at the beginning of the test program without harming anybody else.
>
> The above is just me "thinking aloud", without assessing if the
> damage to the entire codebase with that approach to extend the
> config layer would be larger than the damabe by this patch, and it
> is certainly not a suggestion to redo this patch along that line.
> But I am saying it aloud because it may turn out to be a good
> direction to go in the larger picture once this series is done--it
> may be a solution that is applicable to a class of similar problems
> in a more general way.
>
> Inside the scope of this series, can we at least add a comment next
> to this variable telling everybody to never use it in normal
> programs, or something?

Ok, the comments have been added or rewritten telling that in the v6 I
just sent, thanks.
