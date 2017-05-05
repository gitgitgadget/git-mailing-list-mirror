Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA82207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdEEXNt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:13:49 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34779 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdEEXNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:13:48 -0400
Received: by mail-lf0-f52.google.com with SMTP id 99so10761937lfu.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XryAzLAG5V1c2YbJSjuNUIWk4kGaOGA48SxOmfYvb3w=;
        b=eHNXFMbVcz9K7nMMBUlwXYIfDQ0hKWA811nc7syE7LEOcKFbF7jmK2Xw71fPKTnJvQ
         n8ZpZHis9TU6E/+Zk6txGWYh2mHcqteBDqcb775RD4xpqmb+iJFdE1N56HMX5yA6JGuS
         K2yhEPW786s95JRDPMv/jBS1MdCvu1rhQVvCLyReiMFOgxq4SH5gcFbbkjC9hzD+Agmn
         wLrJukGOMzAkM8s3pew2KhQ2EHnQ3ywPFUYvK3YOk9rmx+3072sVm3M9NFIGdcyh4eHL
         MkLsW0sSP2FzL0i/+qIlM2Ob7TIY/C2eDUYo9xaNR4WDzvYwi8vNF8fT64UO4uOIw+zs
         VP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XryAzLAG5V1c2YbJSjuNUIWk4kGaOGA48SxOmfYvb3w=;
        b=Nj8kNsxvLM9/xDTH+gf02T/iyUnbUDIpRYJkfh5s2lYrd2zqfCZZB7gzpuSoxyEQcq
         nk3SSs6zhTovIEgXh7uijCeRNsmNKmgECoNo2ZSAu7KBKB9DncK3F7DJWOb0EEv7GYyH
         yiSliEy0eaeHIXJtULkYCVavbGOm5yVF9KN8MbMWUQIbWoza+xWRPCZbvvt7DFfPheVn
         jCMJwJCiMUIcEP+65eI8tF4b+lFubJqyuOpoWILSjy6v0QaUJtcpPMo6/CT+XJ4fDtdE
         q5V5OWIv+OmEo+8Mpy2s3pNL8y6bzMDCIS616XErm2pvFkbpVIc5C0/NgScjRm0ZiOp8
         3F5w==
X-Gm-Message-State: AN3rC/7jwWTFU+K+lm5VtUbB4fbYNjePb/mbwu8gn+zcgfZ+WP8nelba
        nCiiYxVujffa4/2PYDPJ7MaBmbuQPQ==
X-Received: by 10.25.67.13 with SMTP id q13mr17662631lfa.36.1494026026800;
 Fri, 05 May 2017 16:13:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.229.213 with HTTP; Fri, 5 May 2017 16:13:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
 <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Fri, 5 May 2017 20:13:16 -0300
Message-ID: <CAEA2_RKzUdSPP4bBvGiFVfNnAY3wwp+0LYriC4q5XfCP-1-F4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive add
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 7:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> +static int git_add_interactive_config(const char *var,
>
> Not git_add_interactive__helper_config()? ;-)

I don't get if you mean this ironically (because of the verbosity) or
if you do think this would be a good name ;P

>> +     for (i =3D 0; i < q->nr; i++) {
>> +             struct diff_filepair *p;
>> +             p =3D q->queue[i];
>> +             diff_flush_stat(p, options, &stat);
>> +     }
>> +
>> +     for (i =3D 0; i < stat.nr; i++) {
>> +             int file_index =3D s->file_count;
>> +             for (j =3D 0; j < s->file_count; j++) {
>> +                     if (!strcmp(s->files[j].path, stat.files[i]->name)=
) {
>> +                             file_index =3D j;
>> +                             break;
>> +                     }
>> +             }
>
> So basically, this is looking up in a list whether we saw the file in
> question already, and the reason we have to do that is that we run the
> entire shebang twice, once with the worktree and once with the index.
>
> I wonder whether it would not make sense to switch away s->files from a
> list to a hashmap.
> [...]
> BTW in the first pass, we pretty much know that we only get unique names,
> so the entire lookup is unnecessary and will just increase the time
> complexity from O(n) to O(n^2). So let's avoid that.
>
> By moving to a hashmap, you can even get the second phase down to an
> expected O(n).

How would you go about implementing that hashmap (i.e. what should be
the hash)? Does Git have any interface for it, or is there any example
I can look after in the codebase?

> Apart from using PATH_MAX bytes for most likely only short names: [...]

If not PATH_MAX, what should I go for? Make it a strbuf? I tend to
believe keeping that on the stack would be simpler and more optimal.

> Now that I read this and remember that only WORKTREE and INDEX are handle=
d
> in the callback function: is there actually a use for the NONE enum value=
?
> I.e. is current_mode read out in any other context than the callback
> function? If there is no other read, then the NONE enum value is just
> confusing.

I just preferred to have a declared non-handled value than leave
something undefined behind. I felt it might avoid headaches in the
future with petty segfaults.

> Why not collapse all three functions into one? It is not like they are
> totally unrelated nor super-long.

To me it is a matter of personal preference to keep them separate. If
there is, however, any technical or project-style-related reason to
get them together, I'll certainly do it.

>> +static void print_modified(void)
>> +{
>> +     int i;
>> +     struct add_interactive_status s;
>> +     const char *modified_fmt =3D _("%12s %12s %s");
>
> We cannot really translate that...

Apparently, we can. =C3=86var covered that in his reply.

>> +     printf(ADD_INTERACTIVE_HEADER_INDENT);
>> +     color_fprintf(stdout, header_color, modified_fmt, _("staged"),
>> +                     _("unstaged"), _("path"));
>
> I think these _() need to become N_().

I cannot find any call to N_() outside of Perl code. What should that
even do differently?

>> +static void status_cmd(void)
>> +{
>> +     print_modified();
>> +}
>
> As long as this function really only calls another function with no
> parameters, let's just drop it. We can call print_modified() instead of
> status_cmd() just as easily.

I thought calling status_cmd() would make that more clear, but I agree
-- the options already make it clear enough,

I agree with all points I did not directly address. And thank you for
the review :)

-- Daniel.
