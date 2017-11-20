Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8E0202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbdKTU2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:28:13 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:39853 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdKTU2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:28:12 -0500
Received: by mail-qk0-f172.google.com with SMTP id w125so9105499qkb.6
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zD4WoaZpCYCdG8tsWBYjQ5bu2R3/r5NaztB0XNYWQjg=;
        b=D1PPO7mJtKIu++sIYRncLAo+DPK8zU0mdsPBOqjfMj43XypAD1kC9bqNO4C40ufopW
         w7Tz/TaibGF6MHU97gYMGu4cfW0MpRiU0G7hR8Lxjij8PvmIicUX5+qUrJhUHgYYP56/
         TerNpHmEJg0WGKpO0eaF1BHDBvF3rTwk5sCaXZmBfdMSn2B5/GFsKZSTzb9oO699P77G
         IjWyduydPf1UUc7Y0FdLiMV2Dyrw6jVeczEgwslUHzupP9SWjd9o7ACUP8RRC3DqMJW+
         osN/qgr37J0U/ngECMAgqVGTnck4wnNMyM1YUscXpZ82M7D40jHAtlw7x5rWl+ui74+Y
         nzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zD4WoaZpCYCdG8tsWBYjQ5bu2R3/r5NaztB0XNYWQjg=;
        b=af184DyS1TiaIHWMPtEkr6cye9EPAI8uFtDE5HeWgLewaAkaa++geBkfZ0s0zPoJRH
         804scSWHF3dEg44tVF19fH9Tj15Ebo71Haue4LOddskSzzgn0AB4Hgw4jJQck7NZcuaJ
         aGD4BbUZdYgcfkaaGyxmZil602/qbLMLASHPeeS8gaBVhvUhqvv+3Azb2PRh8tIod7X0
         itHQMFbvJBqlqWMsH5T/WAq0jbysP6wsDX/iOLIio6eyRanbfDk2dTljrV1dY6Tvhri8
         mnTfPrGLkoJgv2uUr566CMg1qHVYO3azOVsz4g5KbgjNLWrKsi8J9CByhR65yCDs7zNB
         Zw6Q==
X-Gm-Message-State: AJaThX5O0uqO+3t8tBUf8pOWxwdFeX6jR/J4NMn8dYWVK1DzZTDYgoXx
        zfL5qmkfJr+3+6tYTL8qnfauO3y3ENCTlrNZj5/IsQ==
X-Google-Smtp-Source: AGs4zMYKrV25G2YcfNLZm2/XBm7O4qgkbPEZJYuQeEBNoapITzqjgvivKkYcQQk4OQYOYK+fNs5fE3PMlw2Y+NED2l4=
X-Received: by 10.55.76.85 with SMTP id z82mr23496229qka.346.1511209692044;
 Mon, 20 Nov 2017 12:28:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 20 Nov 2017 12:28:11 -0800 (PST)
In-Reply-To: <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com> <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com> <20171120170443.awpvcuubsi5o6zmp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Nov 2017 12:28:11 -0800
Message-ID: <CAGZ79ka+5o07cz4A8=Gu_VqO1hYqqO=8Ju1uAaDY23s7xjCWvw@mail.gmail.com>
Subject: Re: [PATCH V4] config: add --expiry-date
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, hsed@unimetic.com,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 9:04 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 18, 2017 at 12:37:03PM +0900, Junio C Hamano wrote:
>
>> > +int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
>> > +{
>> > +   if (!value)
>> > +           return config_error_nonbool(var);
>> > +   if (parse_expiry_date(value, timestamp))
>> > +           return error(_("'%s' for '%s' is not a valid timestamp"),
>> > +                        value, var);
>> > +   return 0;
>> > +}
>> > +
>>
>> I think this is more correct even within the context of this
>> function than dying, which suggests the need for a slightly related
>> (which is not within the scope of this change) clean-up within this
>> file as a #leftoverbits task.  I think dying in these value parsers
>> goes against the point of having die_on_error bit in the
>> config-source structure; Heiko and Peff CC'ed for b2dc0945 ("do not
>> die when error in config parsing of buf occurs", 2013-07-12).
>
> Yes, I agree that ideally the value parsers should avoid dying.
> Unfortunately I think it will involve some heavy refactoring, since
> git_config_bool(), for instance, does not even have a spot in its
> interface to return an error.
>
> Of course we can leave those other helpers in place and add a "gently"
> form for each. It is really only submodule-config.c that wants to be
> careful in its callback, so we could just port that. Skimming it over,
> it looks like there are a few git_config_bool() and straight-up die()
> calls that could be more forgiving.
>
> +cc Stefan, who added the die(). It may be that we don't care that much
> these days about recovering from broken .gitmodules files.

By that you mean commits like 37f52e9344 (submodule-config:
keep shallow recommendation around, 2016-05-26) for example?
That adds a git_config_bool to the submodule config machinery.

I agree that we'd want to be more careful, but for now I'd put it to the
#leftoverbits.

Thanks,
Stefan
