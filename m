Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D773F1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbcJEREq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:04:46 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36592 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbcJEREp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:04:45 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so83506428qkf.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1MmUdiK8H84PbJ+qqTxVpPPXj9Gyb7lV4Y/TgDvaXk4=;
        b=WsWZ8o+F0ysIRqrN9CSJrOvYxL5eysTAQBXPlLgLG62PWcM5WJdBfjIqoUi/pP0liS
         K4qGxRCGqgUTGZWk2br4qOMchTOF7FzTahhJneA5kq+YYaCdLugibPOxBaYGXluVVFck
         wHLIXVvlF8mYDWbHkLpS8fdf3zLsqelaL7nutZMNdj/jKdgsuKUJ7EJKxjnrqGWBiRo+
         ru6/EhoKWno4gwWofdkdzpg+FtzqdZNF11fwp95iRjWSZnvcDBHVdM2RAXQZAMcQ8Mkn
         /coiuD26AdfHC5gT584tmDZlKJzYzAoSiicfb6ZBLxHHstGQDuKnt67pWKGxeBYOcExX
         D3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1MmUdiK8H84PbJ+qqTxVpPPXj9Gyb7lV4Y/TgDvaXk4=;
        b=cmjDILB/LYyzBWujAQDV03mKeIVWWWOkI5Jepvv4dhbSM0bkHZPshzBLdfJIZ8HenI
         rk2DtRRIp2cvDm6fR3rkpQvkJ8iCSmNtKmB1HLOY277J7+Ou8CWWuw9q5hAbM9p2kJg0
         2sj6QeeTXsGGjdTJooXdl1rFdcggUvutc21TUtnpLkqT783Ll1VhQajJh5tcFKHrMFpR
         ogYo6Xopd+7AuYjCkR7Myghc8WkJvejcgrjTxmosYYOqvn2Gn/uWQrt8fPGa5QiC7Dab
         5aWdFEZzJ6SF4kx8975jibTYnX37VTsbveN+FK/mlF1OxH7uFevD6CPvtvazPC93TI4Z
         xbUg==
X-Gm-Message-State: AA6/9RmbZ6ojvYxbZdM4AWtpGZCJiwX/60PIPb79ijsb45nlhH7trWQYOmwJo02X0qemkbfOkusMyK+t4zAFKBjV
X-Received: by 10.55.82.195 with SMTP id g186mr9471203qkb.220.1475687084083;
 Wed, 05 Oct 2016 10:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 5 Oct 2016 10:04:43 -0700 (PDT)
In-Reply-To: <xmqq8tu2ras4.fsf@gitster.mtv.corp.google.com>
References: <20161004221433.23747-1-sbeller@google.com> <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaFx++yipGmq=D2EPN4Gw9JhRXf_i4pFivTnkJmJXjFfg@mail.gmail.com> <xmqq8tu2ras4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Oct 2016 10:04:43 -0700
Message-ID: <CAGZ79kZ7zNkXBVUFq5aLSup9xsdCbZpy_x8z5=uAQqftmOq26A@mail.gmail.com>
Subject: Re: [RFC/PATCH] attr: Document a new possible thread safe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 10:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I thought about that, but as I concluded that the get_all_attrs doesn't need
>> conversion to a threading environment, we can keep it as is.
>
> I agree that it is OK for get_all_attrs() to use its own way to ask
> a question and receive an answer to it, that is different from how
> git_check_attr() asks its question.  The threading-support for it is
> an unrelated issue, though (not that I think it needs to be run from
> a multi-threaded caller).
>
>>> ...  I'd expect the most
>>> typical caller to be
>>>
>>>         static struct git_attr_check *check;
>>>         struct git_attr_result result[2]; /* we want two */
>>>
>>>         git_attr_check_initl(&check, "crlf", "ident", NULL);
>>>         git_check_attr(path, check, result);
>>>         /* result[0] has "crlf", result[1] has "ident" */
>>>
>>> or something like that.
>>
>> I see, that seems to be a clean API. So git_attr_check_initl
>> will lock the mutex and once it got the mutex it can either
>> * return early as someone else did the work
>> * needs to do the actual work
>> and then unlock. In any case the work was done.
>>
>> git_check_attr, which runs in all threads points to the same check,
>> but gets the different results.
>
> Yeah, something along that line.  It seems that we are now on the
> same page?
>

I think so, instead of resending the documentation, maybe the header
file shows that we're on the same page, I converted everything except
attr.c to follow this header attr.h:

---8<---
#ifndef ATTR_H
#define ATTR_H

/* An attribute is a pointer to this opaque structure */
struct git_attr;

/*
 * Given a string, return the gitattribute object that
 * corresponds to it.
 */
extern struct git_attr *git_attr(const char *);

/*
 * Return the name of the attribute represented by the argument.  The
 * return value is a pointer to a null-delimited string that is part
 * of the internal data structure; it should not be modified or freed.
 */
extern const char *git_attr_name(const struct git_attr *);

extern int attr_name_valid(const char *name, size_t namelen);
extern void invalid_attr_name_message(struct strbuf *, const char *, int);

/* Internal use */
extern const char git_attr__true[];
extern const char git_attr__false[];

/* For public to check git_attr_check results */
#define ATTR_TRUE(v) ((v) == git_attr__true)
#define ATTR_FALSE(v) ((v) == git_attr__false)
#define ATTR_UNSET(v) ((v) == NULL)

struct git_attr_check {
        int finalized;
        int check_nr;
        int check_alloc;
        struct git_attr **attr;
};

struct git_attr_result {
        int check_nr;
        int check_alloc;
        const char **value;
};

/*
 * Initialize the `git_attr_check` via one of the following three functions:
 *
 * git_attr_check_alloc allocates an empty check, add more attributes via
 *                      git_attr_check_append.
 * git_all_attrs        allocates a check and fills in all attributes that
 *                      are set for the given path.
 * git_attr_check_initl takes a pointer to where the check will be initialized,
 *                      followed by all attributes that are to be checked.
 *                      This makes it potentially thread safe as it could
 *                      internally have a mutex for that memory location.
 *                      Currently it is not thread safe!
 */
extern struct git_attr_check *git_attr_check_alloc(void);
extern void git_attr_check_append(struct git_attr_check *, const
struct git_attr *);
extern struct git_attr_check *git_all_attrs(const char *path);
extern void git_attr_check_initl(struct git_attr_check **, const char *, ...);

/* Query a path for its attributes */
extern struct git_attr_result *git_check_attr(const char *path,
                                             struct git_attr_check *);

/* internal? */
extern void git_attr_check_clear(struct git_attr_check *);

/* After use free the check */
extern void git_attr_check_free(struct git_attr_check *);

enum git_attr_direction {
        GIT_ATTR_CHECKIN,
        GIT_ATTR_CHECKOUT,
        GIT_ATTR_INDEX
};
void git_attr_set_direction(enum git_attr_direction, struct index_state *);

#endif /* ATTR_H */
