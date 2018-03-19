Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C051F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932909AbeCSNPS (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:15:18 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:53427 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeCSNPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:15:17 -0400
Received: by mail-it0-f47.google.com with SMTP id b136-v6so4053089iti.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fe+S1/Ul4WqZa7/w8XJVu9TMtTEbxpyVWZgdE3a6Sms=;
        b=RyX7/utcYaSCywifzjpZViQq+SQrVHGiO5VdDb/WmgzMgdpzhTMoUo6pvZ2fJOZZ8F
         OoDg0RDhR9WeXRHZtOQxx/Q2i6Mkx0SWb3u13CApx7W/WYYRyN50jLR+ldW3fBjWCBmS
         gB4Rzm1uaC0Se5TFoAmblFr96RYbClxNyEJXvIfQ6+wYPfOdX6iYgVTV6sA46QplOs9l
         aVqafcQofK6jwbk8Yh733O/K0Pz/k/mcpAhmtcjNe6NyUyb8QzTCMHQKVI7dtYAFYSL+
         oOY//vtpsOt3/0YBnhcR9tGLYcC/SCmeSNfEJZnZr43Io33G2MU8Rakwrcbmm+Fv37cp
         +9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fe+S1/Ul4WqZa7/w8XJVu9TMtTEbxpyVWZgdE3a6Sms=;
        b=O6iBZUeAMbgLPvtbRP2A+Gx6maD3l774ndVUancJrdXZ6UNTopwVQlBiHTEyhEYPUc
         FG2Q8ydig9ypvT2S4RBup2xLYBmoAS/DR+BMTNV9wN0ELkkf27oRqYLYmcrjP2hNY18U
         oIy1uQqkU/2YEaEAt0ClYOk4h1HrlU29/ImV6UCI8/WdKgYZNA2luNeX/Pd3ZhA52YQB
         8CoiLgS8RrhIcN8PYx6ZJYU7Zjhsf2jEF9PABHP7N2tA8uOYXkOVz4FMHygRgsCmQYEz
         yFAVSG9D+2RcTN2NDy1Kj/7mr5piSCkqSckEVTCYB3XpM1cJfynqDIH3YW5Yi+pHGBkz
         e59A==
X-Gm-Message-State: AElRT7EJpJUyZHXB7/pd4bxg/EhCm84xYWNKf1xzXN1SbHqKqVguSQ68
        17ZIB9hInYTvdKVHFdrPUEb8gsXQ+gQbMj3j4UY=
X-Google-Smtp-Source: AG47ELuZa4P+RnP+uJF1m4wFzIBpbgx2f5ZoK/yQButaqe/n4WJd8ZoK2eBgC8p69bKDjy9vTTwyTepFD5eH1CSWkFg=
X-Received: by 2002:a24:ac52:: with SMTP id m18-v6mr11411141iti.21.1521465316565;
 Mon, 19 Mar 2018 06:15:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Mon, 19 Mar 2018 06:15:15 -0700 (PDT)
In-Reply-To: <ebf67bcc-3e17-3fda-9f56-dd152e7bf3af@jeffhostetler.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-16-chriscool@tuxfamily.org> <ebf67bcc-3e17-3fda-9f56-dd152e7bf3af@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Mar 2018 14:15:15 +0100
Message-ID: <CAP8UFD0DNKVwz4D+s61+QMvtwcA3nomy0wnnfbAnSA4prnBbxg@mail.gmail.com>
Subject: Re: [PATCH 15/40] external-odb: add script mode support
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 8:55 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 1/3/2018 11:33 AM, Christian Couder wrote:
>>
>> diff --git a/odb-helper.c b/odb-helper.c
>> index 4b70b287af..c1a3443dc7 100644
>> --- a/odb-helper.c
>> +++ b/odb-helper.c
>> @@ -21,13 +21,124 @@ struct odb_helper_cmd {
>>         struct child_process child;
>>   };
>>   +/*
>> + * Callers are responsible to ensure that the result of vaddf(fmt, ap)
>> + * is properly shell-quoted.
>> + */
>> +static void prepare_helper_command(struct argv_array *argv, const char
>> *cmd,
>> +                                  const char *fmt, va_list ap)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +
>> +       strbuf_addstr(&buf, cmd);
>> +       strbuf_addch(&buf, ' ');
>> +       strbuf_vaddf(&buf, fmt, ap);
>
> I do find this a bit odd that you're putting the cmd, a space,
> and the printf results into a single arg in the argv, rather than
> directly loading up the argv.
>
> Is there an issue with the whitespace between the cmd and the
> printf result being in the same arg -- especially if there are
> quoting issues in the fmt string as you mention in the comment
> above?  (not sure, just asking)

This was discussed with Junio here:

https://public-inbox.org/git/xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com/

I agree that I should take another look at it though. I will do that
in the next version after the one I will send really soon now.

>> +static int parse_object_line(struct odb_helper_object *o, const char
>> *line)
>> +{
>
> Is there a reason to order the fields this way?  In the test
> at the bottom of this commit, you take cat-file output and
> re-order the columns with awk.   I'm just wondering if we kept
> cat-file ordering in the format here, we could simplify things.

Yeah, maybe the shell script could be simplified while the C code
would not be more complex. I don't remember if that was in the
original version from Peff or if there was a reason to do it this way.
I will take a look at that in the next version after the one I will
send really soon now.

>> +       char *end;
>> +       if (get_sha1_hex(line, o->sha1) < 0)
>> +               return -1;
>> +
>> +       line += 40;
>> +       if (*line++ != ' ')
>> +               return -1;
>> +
>> +       o->size = strtoul(line, &end, 10);
>> +       if (line == end || *end++ != ' ')
>> +               return -1;
>> +
>> +       o->type = type_from_string(end);
>> +       return 0;
>> +}
>> +
>> +static int add_have_entry(struct odb_helper *o, const char *line)
>> +{
>> +       ALLOC_GROW(o->have, o->have_nr+1, o->have_alloc);
>
> I didn't see where o->have is initially allocated.  The default is
> to start with 64 and then grow by 3/2 as needed.  If we are getting
> lots of objects here, we'll have lots of reallocs slowing things down.
> It would be better to seed it somewhere to a large value.

Yeah but using this is optional. It depends on the cap_have
capability. And I think that if there is a really huge number of
objects in the external odb, it might be better to just not use
cap_have.

Another possibility would be for the helper to send the number of
objects it has first, so that we could alloc the right number before
receiving the haves, but this could require the helper to be more
complex.

>> +       if (parse_object_line(&o->have[o->have_nr], line) < 0) {
>> +               warning("bad 'have' input from odb helper '%s': %s",
>> +                       o->name, line);
>> +               return 1;
>> +       }
>> +       o->have_nr++;
>> +       return 0;
>> +}
>> +
>> +static int odb_helper_object_cmp(const void *va, const void *vb)
>> +{
>> +       const struct odb_helper_object *a = va, *b = vb;
>> +       return hashcmp(a->sha1, b->sha1);
>> +}
>> +
>>   static void odb_helper_load_have(struct odb_helper *o)
>>   {
>> +       struct odb_helper_cmd cmd;
>> +       FILE *fh;
>> +       struct strbuf line = STRBUF_INIT;
>> +
>>         if (o->have_valid)
>>                 return;
>>         o->have_valid = 1;
>>   -     /* TODO */
>> +       if (odb_helper_start(o, &cmd, "have") < 0)
>> +               return;
>> +
>> +       fh = xfdopen(cmd.child.out, "r");
>> +       while (strbuf_getline(&line, fh) != EOF)
>> +               if (add_have_entry(o, line.buf))
>> +                       break;
>> +
>> +       strbuf_release(&line);
>> +       fclose(fh);
>> +       odb_helper_finish(o, &cmd);
>> +
>> +       qsort(o->have, o->have_nr, sizeof(*o->have),
>> odb_helper_object_cmp);
>>   }
>
> Help me understand this.  I originally thought that the "have"
> command would ask about one or more specific OIDs, but after a
> couple of readings it looks like the "have" command is getting the
> *complete* list of objects known to this external ODB and building
> a sorted array of them.  And then we do this for each external ODB
> configured.
>
> If this is the case, I'm concerned that this will have scale problems.
> "git cat-file..." shows that even my little git.git repo has 360K
> objects.  And "time git cat-file..." takes over 1.1 seconds.

Yeah, but originally external odbs were not supposed to contain a huge
number of objects. And now that cap_have is optional, it should
probably not be used if indeed the external odb contains a huge number
of objects.

> I'm wondering if there is a better/different way to do this.
> (Sorry if you've already covered this in earlier versions of this
> patch series and I missed it.)
>
> I'm wondering about "struct odb_helper" maintain a long-running
> connection to the sub-command which would let git ask for the object
> and either get it back (as you have below) or get an not-found error.
> The sub-command would then wait for another get-object request over
> stdin.
>
> I say this because whatever operation I'm doing (like a checkout or
> log or blame) is only going to need a small percentage of the total
> set of objects.  I think it would be more efficient to try/retry to
> fault them in as-needed via one or more external helpers than to build
> these tables in advance.

This is possible when using the "process mode" and not using cap_have.
I reused Ben Peart's work to make that possible by the way.

>>   static const unsigned char *have_sha1_access(size_t index, void *table)
>> @@ -53,6 +164,111 @@ int odb_helper_has_object(struct odb_helper *o, const
>> unsigned char *sha1)
>>         return !!odb_helper_lookup(o, sha1);
>>   }
>>   +int odb_helper_get_object(struct odb_helper *o, const unsigned char
>> *sha1,
>> +                           int fd)
>> +{
>> +       struct odb_helper_object *obj;
>> +       struct odb_helper_cmd cmd;
>> +       unsigned long total_got;
>> +       git_zstream stream;
>> +       int zret = Z_STREAM_END;
>> +       git_SHA_CTX hash;
>> +       unsigned char real_sha1[20];
>> +       struct strbuf header = STRBUF_INIT;
>> +       unsigned long hdr_size;
>> +
>> +       obj = odb_helper_lookup(o, sha1);
>> +       if (!obj)
>> +               return -1;
>> +
>> +       if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1))
>> < 0)
>> +               return -1;
>> +
>> +       memset(&stream, 0, sizeof(stream));
>> +       git_inflate_init(&stream);
>> +       git_SHA1_Init(&hash);
>> +       total_got = 0;
>> +
>> +       for (;;) {
>> +               unsigned char buf[4096];
>> +               int r;
>> +
>> +               r = xread(cmd.child.out, buf, sizeof(buf));
>> +               if (r < 0) {
>> +                       error("unable to read from odb helper '%s': %s",
>> +                             o->name, strerror(errno));
>> +                       close(cmd.child.out);
>> +                       odb_helper_finish(o, &cmd);
>> +                       git_inflate_end(&stream);
>> +                       return -1;
>> +               }
>> +               if (r == 0)
>> +                       break;
>> +
>> +               write_or_die(fd, buf, r);
>> +
>> +               stream.next_in = buf;
>> +               stream.avail_in = r;
>> +               do {
>> +                       unsigned char inflated[4096];
>> +                       unsigned long got;
>> +
>> +                       stream.next_out = inflated;
>> +                       stream.avail_out = sizeof(inflated);
>> +                       zret = git_inflate(&stream, Z_SYNC_FLUSH);
>> +                       got = sizeof(inflated) - stream.avail_out;
>> +
>> +                       git_SHA1_Update(&hash, inflated, got);
>> +                       /* skip header when counting size */
>> +                       if (!total_got) {
>> +                               const unsigned char *p = memchr(inflated,
>> '\0', got);
>> +                               if (p) {
>> +                                       unsigned long hdr_last = p -
>> inflated + 1;
>> +                                       strbuf_add(&header, inflated,
>> hdr_last);
>> +                                       got -= hdr_last;
>> +                               } else {
>> +                                       strbuf_add(&header, inflated,
>> got);
>> +                                       got = 0;
>> +                               }
>> +                       }
>> +                       total_got += got;
>> +               } while (stream.avail_in && zret == Z_OK);
>> +       }
>> +
>> +       close(cmd.child.out);
>> +       git_inflate_end(&stream);
>> +       git_SHA1_Final(real_sha1, &hash);
>> +       if (odb_helper_finish(o, &cmd))
>> +               return -1;
>> +       if (zret != Z_STREAM_END) {
>> +               warning("bad zlib data from odb helper '%s' for %s",
>> +                       o->name, sha1_to_hex(sha1));
>> +               return -1;
>> +       }
>> +       if (total_got != obj->size) {
>> +               warning("size mismatch from odb helper '%s' for %s (%lu !=
>> %lu)",
>> +                       o->name, sha1_to_hex(sha1), total_got, obj->size);
>> +               return -1;
>> +       }
>> +       if (hashcmp(real_sha1, sha1)) {
>> +               warning("sha1 mismatch from odb helper '%s' for %s (got
>> %s)",
>> +                       o->name, sha1_to_hex(sha1),
>> sha1_to_hex(real_sha1));
>> +               return -1;
>> +       }
>> +       if (parse_sha1_header(header.buf, &hdr_size) < 0) {
>> +               warning("could not parse header from odb helper '%s' for
>> %s",
>> +                       o->name, sha1_to_hex(sha1));
>> +               return -1;
>> +       }
>> +       if (total_got != hdr_size) {
>> +               warning("size mismatch from odb helper '%s' for %s (%lu !=
>> %lu)",
>> +                       o->name, sha1_to_hex(sha1), total_got, hdr_size);
>> +               return -1;
>> +       }
>
> Does "strbuf header" need to be released before all of the returns?

Yeah, thanks for noticing. This is fixed in the version I will send
really soon now.

>> +
>> +       return 0;
>> +}
>
> If I understand this function, it is receiving an object from the odb
> helper sub-command and creating a loose object for it in the local odb.
> The object is compressed on the wire and this function unzips it to
> verify the object is completely received and without errors.
>
> But this function does not keep the resulting object around in memory
> (which might not fit anyway).  I'm assuming that the higher-layer that
> needs the object will just be told to read the new loose object.

Yeah, that's how it works. I think I took most of the code and the way
this function works from the work Ben Peart had sent to the mailing
list.

Thanks,
Christian.
