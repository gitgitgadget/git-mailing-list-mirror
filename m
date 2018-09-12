Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C971F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIMAUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:20:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43777 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeIMAUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:20:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id g53-v6so3004040qtg.10
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hdM4wbFN3wtGT+rc6/x7co5dW72S4SPb2TvPZOY5qPo=;
        b=kcQ7RPy9QpjhJvGXxWBZO10omgLebppvMSg2bbA3jfYN1Z00yCXZ9xyMNv5FFept1A
         2EXiY4xzTh38ZYZZTIbGQTZef9cFVczj5CyYPmLWC4lcpM5IfXJ4yy/1KbfWjiXg/Luw
         t0Eb6Um2lXzuKj9qB8m1R0eW1vyFvgqq5oZWf1XNFYDbbZ7ZH0aiG71/t5hAF6DEc7uq
         xwyYW7rvLQs6g5M9zHsYs1kdmHe3YyDm4yBankkFiCxT2cv+DHOZ1/MutXx1v/07fvDy
         8r6t+l07vwiS+aUTj2ZS1dhwvS55PSc0FkwWvksr8zU6qesSLaDdP85hfCXo0i99cMqQ
         vP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hdM4wbFN3wtGT+rc6/x7co5dW72S4SPb2TvPZOY5qPo=;
        b=HH0dMK14KCVNpp/GLxqF2aC23Y33CCMges/QbrH72+5sCaQ9MAuEnl5nMij/VwlSo1
         a6t1asxygQRJ/UkOsuc0mX0z0edOHgN/4bfk4SgFHlOOMHePwFXpExv/2H3n7ruq57Sq
         IMxr/VbEP4G73SJN+Y1NfWWGFPq4y3EUG1X9pHW64m3t//lcnxxwtx4B5u2vt3uPkEmr
         cSjKzQAQz8KRhpeLBJpvg1Lttbigwtnj3Pe6tqkUg5etl2bBedU8nncEtn+ch8CIwISE
         bua4AegJy2HTvu+pgAUe4G+1xs18hopFBcmaGae0MOr9HvJyosMBJG41NRq/Q1658hwp
         DrKw==
X-Gm-Message-State: APzg51AXGne3peGVX0MedluhgsETx1KQ5m+OFQeH5TBP8ieaG4q1G7Cm
        9ttNTcOtzSFmyWE5ccEi5IE=
X-Google-Smtp-Source: ANB0VdYX+WZsVM5EKtsW96lDXTm+N2tZwl1z4aPRZO1alum7VNVu4JQMrcKVKzUWLM11+XjgmEFRSw==
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr2770475qvc.161.1536779674605;
        Wed, 12 Sep 2018 12:14:34 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 63-v6sm967777qkm.0.2018.09.12.12.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 12:14:33 -0700 (PDT)
Subject: Re: [PATCH 0/1] contrib: Add script to show uncovered "new" lines
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.40.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7edb321e-c2df-d3b6-b4f3-9e8b1fc60698@gmail.com>
Date:   Wed, 12 Sep 2018 15:14:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.40.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2018 12:45 PM, Derrick Stolee via GitGitGadget wrote:
> For example, I ran this against the 'jch' branch (d3c0046)
> versus 'next' (dd90340)

As another example, I ran this against the 'pu' branch (4c416a53) versus 
'jch' (d3c0046) and got the following output, submitted here without 
commentary:

builtin/bisect--helper.c
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
43)             free((void *) terms->term_good);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
162)            if (get_oid_commit(commit, &oid))
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
163)                    return error(_("'%s' is not a valid commit"), 
commit);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
164)            strbuf_addstr(&branch, commit);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
172)                    error(_("Could not check out original HEAD '%s'. 
Try "
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
174)                    strbuf_release(&branch);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
175)                    argv_array_clear(&argv);
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
176)                    return -1;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
215)            error(_("Bad bisect_write argument: %s"), state);
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
216)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
220)            error(_("couldn't get the oid of the rev '%s'"), rev);
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
221)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
226)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
230)            error_errno(_("couldn't open the file '%s'"), 
git_path_bisect_log());
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
231)            goto fail;
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 242)fail:
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 243)    retval 
= -1;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
323)            yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
324)            if (starts_with(yesno, "N") || starts_with(yesno, "n"))
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
327)            goto finish;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
336)            error(_("You need to start by \"git bisect start\". You "
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
341)            goto fail;
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 345)fail:
35f7ca528ae     (Pranit Bauva   2017-10-27 15:06:37 +0000 
387)            return error(_("--bisect-term requires exactly one 
argument"));
35f7ca528ae     (Pranit Bauva   2017-10-27 15:06:37 +0000 
400)                    error(_("BUG: invalid argument %s for 'git 
bisect terms'.\n"
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
416)            return -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
419)            goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
423)            goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 427)fail:
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 428)    retval 
= -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
466)                    no_checkout = 1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
488)                     !one_of(arg, "--term-good", "--term-bad", NULL)) {
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
489)                    return error(_("unrecognised option: '%s'"), arg);
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
523)            if (get_oid("HEAD", &head_oid))
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
524)                    return error(_("Bad HEAD - I need a HEAD"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
539)                            error(_("checking out '%s' failed. Try 
'git "
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
559)                            return error(_("won't bisect on 
cg-seek'ed tree"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
562)                    return error(_("Bad HEAD - strange symbolic ref"));
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
570)            return -1;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
588)                    goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
598)                    goto fail;
5dfeec316b8     (Pranit Bauva   2017-10-27 15:06:37 +0000 
606)            goto fail;
3d3237b0e6b     (Pranit Bauva   2017-10-27 15:06:37 +0000 
686)                    return error(_("--bisect-reset requires either 
no argument or a commit"));
0b1f0fd910c     (Pranit Bauva   2017-10-27 15:06:37 +0000 
690)                    return error(_("--bisect-write requires either 4 
or 5 arguments"));
20edf353b72     (Pranit Bauva   2017-10-27 15:06:37 +0000 
697)                    return error(_("--check-and-set-terms requires 3 
arguments"));
a919f328ba3     (Pranit Bauva   2017-10-27 15:06:37 +0000 
703)                    return error(_("--bisect-next-check requires 2 
or 3 arguments"));
builtin/blame.c
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 922)    case 
DATE_HUMAN:
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
924)            blame_date_width = sizeof("Thu Oct 19 16:00");
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
925)            break;
builtin/gc.c
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
461)            ret = error_errno(_("cannot stat '%s'"), gc_log_path);
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
470)            ret = error_errno(_("cannot read '%s'"), gc_log_path);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
495)            die(FAILED_RUN, pack_refs_cmd.argv[0]);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
498)            die(FAILED_RUN, reflog.argv[0]);
3029970275b     (Jonathan Nieder        2018-07-16 23:57:40 -0700       
585)                            exit(128);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
637)                    die(FAILED_RUN, repack.argv[0]);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
647)                            die(FAILED_RUN, prune.argv[0]);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
654)                    die(FAILED_RUN, prune_worktrees.argv[0]);
fec2ed21871     (Jonathan Nieder        2018-07-16 23:54:16 -0700       
658)            die(FAILED_RUN, rerere.argv[0]);
builtin/rebase--interactive.c
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
24)             return error(_("no HEAD?"));
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
51)             return error_errno(_("could not create temporary %s"), 
path_state_dir());
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
57)             return error_errno(_("could not mark as interactive"));
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
77)             return -1;
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
81)             return -1;
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
87)             free(revisions);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
88)             free(shortrevisions);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
90)             return -1;
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
98)             free(revisions);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
99)             free(shortrevisions);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
101)            return error_errno(_("could not open %s"), 
rebase_path_todo());
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
106)            argv_array_push(&make_script_args, restrict_revision);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
114)            error(_("could not generate todo list"));
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 205) 
usage_with_options(builtin_rebase_interactive_usage, options);
93420467efe     (Alban Gruin    2018-08-28 14:10:42 +0200 
219)            warning(_("--[no-]rebase-cousins has no effect without "
adb4f8f6b72     (Alban Gruin    2018-08-28 14:10:43 +0200 
225)                    die(_("a base commit must be provided with 
--upstream or --onto"));
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 259)    case 
REARRANGE_SQUASH:
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 
260)            ret = rearrange_squash();
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 
261)            break;
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 262)    case 
ADD_EXEC:
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 
263)            ret = sequencer_add_exec_commands(cmd);
b3fe2e1f8cb     (Alban Gruin    2018-08-28 14:10:45 +0200 
264)            break;
adb4f8f6b72     (Alban Gruin    2018-08-28 14:10:43 +0200 265)    default:
adb4f8f6b72     (Alban Gruin    2018-08-28 14:10:43 +0200 
266)            BUG("invalid command '%d'", command);
builtin/rebase.c
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 61)     
strbuf_trim(&out);
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 62)     ret = 
!strcmp("true", out.buf);
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 63)     
strbuf_release(&out);
002ee2fe682     (Pratik Karki   2018-09-04 14:59:57 -0700 114)    case 
REBASE_AM:
002ee2fe682     (Pratik Karki   2018-09-04 14:59:57 -0700 
115)            die(_("%s requires an interactive rebase"), option);
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
148)            return error_errno(_("could not read '%s'"), path);
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
162)            return -1;
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
167)            return error(_("could not get 'onto': '%s'"), buf.buf);
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
178)                    return -1;
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 179)    } else 
if (read_one(state_dir_path("head", opts), &buf))
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
180)            return -1;
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
182)            return error(_("invalid orig-head: '%s'"), buf.buf);
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
186)            return -1;
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
188)            opts->flags &= ~REBASE_NO_QUIET;
73d51ed0a59     (Pratik Karki   2018-09-04 14:59:50 -0700 
196)            opts->signoff = 1;
73d51ed0a59     (Pratik Karki   2018-09-04 14:59:50 -0700 
197)            opts->flags |= REBASE_FORCE;
ead98c111b8     (Pratik Karki   2018-09-04 14:59:52 -0700 
204)                    return -1;
28a02c5a790     (Pratik Karki   2018-09-04 15:00:00 -0700 
219)                    return -1;
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
227)                    return -1;
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
235)                    return -1;
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
255)            return error(_("Could not read '%s'"), path);
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
271)                    res = error(_("Cannot store %s"), autostash.buf);
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
275)                    return res;
b2263c13613     (Johannes Schindelin    2018-08-29 07:31:17 -0700       
373) argv_array_pushf(&child.args,
b2263c13613     (Johannes Schindelin    2018-08-29 07:31:17 -0700       
375) oid_to_hex(&opts->restrict_revision->object.oid));
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 479)    case 
REBASE_INTERACTIVE:
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
480)            backend = "git-rebase--interactive";
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
481)            backend_func = "git_rebase__interactive";
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
482)            break;
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 491)    default:
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
492)            BUG("Unhandled rebase type %d", opts->type);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
509)            struct strbuf dir = STRBUF_INIT;
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
511)            apply_autostash(opts);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
512)            strbuf_addstr(&dir, opts->state_dir);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
513)            remove_dir_recursively(&dir, 0);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
514)            strbuf_release(&dir);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
515)            die("Nothing to do");
d4c569f8f4c     (Pratik Karki   2018-09-04 14:27:20 -0700 
542)            BUG("Not a fully qualified branch: '%s'", switch_to_branch);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
545)            return -1;
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
549)                    rollback_lock_file(&lock);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
550)                    return error(_("could not determine HEAD 
revision"));
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
567)            rollback_lock_file(&lock);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
568)            return error(_("could not read index"));
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
572)            error(_("failed to find tree of %s"), oid_to_hex(oid));
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
573)            rollback_lock_file(&lock);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
574)            free((void *)desc.buffer);
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
575)            return -1;
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
588)            ret = error(_("could not write index"));
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
592)            return ret;
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 608)    } else 
if (old_orig)
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
609)            delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
bff014dac7d     (Pratik Karki   2018-09-04 14:27:13 -0700 
637)                    opts->flags &= !REBASE_DIFFSTAT;
9a48a615b47     (Pratik Karki   2018-09-04 14:27:16 -0700 
671)                    return 1;
9a48a615b47     (Pratik Karki   2018-09-04 14:27:16 -0700 
687)            return 0;
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 
894)            const char *path = mkpath("%s/git-legacy-rebase",
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 
897)            if (sane_execvp(path, (char **)argv) < 0)
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 
898)                    die_errno(_("could not exec %s"), path);
55071ea248e     (Pratik Karki   2018-08-07 01:16:09 +0545 
900)                    BUG("sane_execvp() returned???");
0eabf4b95ca     (Pratik Karki   2018-08-08 20:51:22 +0545 
916)            die(_("It looks like 'git am' is in progress. Cannot 
rebase."));
f28d40d3a99     (Pratik Karki   2018-09-04 14:27:07 -0700 
953)            usage_with_options(builtin_rebase_usage,
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
973)                    die(_("Cannot read HEAD"));
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
977)                    die(_("could not read index"));
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
991)                    exit(1);
122420c2953     (Pratik Karki   2018-08-08 20:51:17 +0545 
1003)                   die(_("could not discard worktree changes"));
122420c2953     (Pratik Karki   2018-08-08 20:51:17 +0545 
1005)                   exit(1);
5e5d96197ca     (Pratik Karki   2018-08-08 20:51:18 +0545 
1016)                   exit(1);
5e5d96197ca     (Pratik Karki   2018-08-08 20:51:18 +0545 
1019)                   die(_("could not move back to %s"),
5a61494539b     (Pratik Karki   2018-08-08 20:51:19 +0545 
1029)                   die(_("could not remove '%s'"), options.state_dir);
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 1042)   default:
51e9ea6da76     (Pratik Karki   2018-08-08 20:51:20 +0545 
1043)           BUG("action: %d", action);
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1048)           const char *last_slash = strrchr(options.state_dir, '/');
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1049)           const char *state_dir_base =
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1050)                   last_slash ? last_slash + 1 : options.state_dir;
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1051)           const char *cmd_live_rebase =
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1053)           strbuf_reset(&buf);
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1054)           strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
c54dacb50ea     (Pratik Karki   2018-09-04 14:27:18 -0700 
1055)           die(_("It seems that there is already a %s directory, and\n"
53f9e5be94e     (Pratik Karki   2018-09-04 14:59:56 -0700 
1079)           strbuf_addstr(&options.git_am_opt, " --ignore-date");
53f9e5be94e     (Pratik Karki   2018-09-04 14:59:56 -0700 
1080)           options.flags |= REBASE_FORCE;
c7ee2134d42     (Pratik Karki   2018-09-04 15:00:01 -0700 
1092)           strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
0073df2bd31     (Pratik Karki   2018-09-04 15:00:07 -0700 
1124)           else if (strcmp("no-rebase-cousins", rebase_merges))
0073df2bd31     (Pratik Karki   2018-09-04 15:00:07 -0700 
1125)                   die(_("Unknown mode: %s"), rebase_merges);
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
1146)           case REBASE_AM:
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
1147)                   die(_("--strategy requires --merge or 
--interactive"));
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
1156)           default:
399a505296a     (Pratik Karki   2018-09-04 15:00:11 -0700 
1157)                   BUG("unhandled rebase type (%d)", options.type);
6dc73173f6c     (Pratik Karki   2018-08-08 21:21:33 +0545 
1165)           strbuf_addstr(&options.git_format_patch_opt, " --progress");
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 1173)   case 
REBASE_AM:
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
1174)           options.state_dir = apply_dir();
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
1175)           break;
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
1252)                   die(_("invalid upstream '%s'"), 
options.upstream_name);
bfa5147095f     (Pratik Karki   2018-09-04 15:00:12 -0700 
1258)                           die(_("Could not create new root commit"));
e65123a71d0     (Pratik Karki   2018-09-04 14:27:21 -0700 
1308)                   die(_("fatal: no such branch/commit '%s'"),
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
1316)                   die(_("No such ref: %s"), "HEAD");
ac7f467fef8     (Pratik Karki   2018-08-07 01:16:11 +0545 
1328)                   die(_("Could not resolve HEAD to a revision"));
e65123a71d0     (Pratik Karki   2018-09-04 14:27:21 -0700 
1330)           BUG("unexpected number of arguments left to parse");
e0333e5c63f     (Pratik Karki   2018-09-04 14:27:14 -0700 
1341)           die(_("could not read index"));
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
1368)                           die(_("Cannot autostash"));
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
1371)                           die(_("Unexpected stash response: '%s'"),
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
1377)                           die(_("Could not create directory for 
'%s'"),
7debdaa4ad1     (Pratik Karki   2018-09-04 15:00:02 -0700 
1383)                           die(_("could not reset --hard"));
e65123a71d0     (Pratik Karki   2018-09-04 14:27:21 -0700 
1427)                                   ret = !!error(_("could not parse 
'%s'"),
e65123a71d0     (Pratik Karki   2018-09-04 14:27:21 -0700 
1429)                                   goto cleanup;
e65123a71d0     (Pratik Karki   2018-09-04 14:27:21 -0700 
1438)                                   ret = !!error(_("could not 
switch to "
1ed9c14ff25     (Pratik Karki   2018-09-04 14:27:17 -0700 
1448)                            resolve_ref_unsafe("HEAD", 0, NULL, &flag))
1ed9c14ff25     (Pratik Karki   2018-09-04 14:27:17 -0700 
1449)                           puts(_("HEAD is up to date."));
9a48a615b47     (Pratik Karki   2018-09-04 14:27:16 -0700 
1458)                    resolve_ref_unsafe("HEAD", 0, NULL, &flag))
9a48a615b47     (Pratik Karki   2018-09-04 14:27:16 -0700 
1459)                   puts(_("HEAD is up to date, rebase forced."));
builtin/rev-list.c
0eee403f2f7     (Matthew DeVore 2018-09-04 11:05:47 -0700 
227)            die("unexpected missing %s object '%s'",
0eee403f2f7     (Matthew DeVore 2018-09-04 11:05:47 -0700 
228)                type_name(obj->type), oid_to_hex(&obj->oid));
builtin/stash.c
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
130)            free_stash_info(info);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
131)            error(_("'%s' is not a stash-like commit"), revision);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
132)            exit(128);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
165)                    free_stash_info(info);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
166)                    fprintf_ln(stderr, _("No stash entries found."));
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
167)                    return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 201)    
default: /* Invalid or ambiguous */
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
202)            free_stash_info(info);
31f109a3618     (Joel Teichroeb 2018-08-31 00:40:37 +0300 
229)            return error(_("git stash clear with parameters is 
unimplemented"));
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
244)            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
252)            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
265)            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
268)            return error(_("unable to write new index file"));
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
374)            remove_path(stash_index_path.buf);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
375)            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
402)            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
405)            return error(_("Cannot apply a stash in the middle of a 
merge"));
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
415)                            strbuf_release(&out);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
416)                            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
422)                            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
427)                            return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
434)            return error(_("Could not restore untracked files from 
stash"));
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
465)                    return -1;
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
470)                    strbuf_release(&out);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
475)                    strbuf_release(&out);
93871263d18     (Joel Teichroeb 2018-08-31 00:40:36 +0300 
476)                    return -1;
31f109a3618     (Joel Teichroeb 2018-08-31 00:40:37 +0300 
551)            return error(_("%s: Could not drop stash entry"),
b3513da4bd9     (Joel Teichroeb 2018-08-31 00:40:39 +0300 
623)            printf_ln(_("The stash entry is kept in case you need it 
again."));
8ceb24b2c38     (Paul-Sebastian Ungureanu       2018-08-31 00:40:41 
+0300       754)            free_stash_info(&info);
129f0b0a009     (Paul-Sebastian Ungureanu       2018-08-31 00:40:48 
+0300       755) usage_with_options(git_stash_show_usage, options);
0ac06fb81f2     (Paul-Sebastian Ungureanu       2018-08-31 00:40:43 
+0300       808)            fprintf_ln(stderr, _("\"git stash store\" 
requires one <commit> argument"));
0ac06fb81f2     (Paul-Sebastian Ungureanu       2018-08-31 00:40:43 
+0300       809)            return -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       884)            return 1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       925)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       926)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       931)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       932)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       937)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       938)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       966)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       967)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       978)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       979)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       984)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       985)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       992)            ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       993)            goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1018)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1019)           goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1031)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1032)           goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1037)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1038)           goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1049)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1050)           goto done;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1055)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1056)           goto done;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1089)                   fprintf_ln(stderr, _("You do not 
have the initial commit yet"));
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1110)           if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1111)                   fprintf_ln(stderr, _("Cannot save 
the current index state"));
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1112)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1113)           *stash_msg = NULL;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1114)           goto done;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1119)                   if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1120) fprintf_ln(stderr, _("Cannot save the untracked files"));
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1121)                   ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1122)                   *stash_msg = NULL;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1123)                   goto done;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1131)                   if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1132) fprintf_ln(stderr, _("Cannot save the current worktree 
state"));
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1133)                   goto done;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1139)                   if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1140) fprintf_ln(stderr, _("Cannot save the current worktree 
state"));
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1141)                   ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1142)                   *stash_msg = NULL;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1143)                   goto done;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1166)           if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1167)                   fprintf_ln(stderr, _("Cannot record 
working tree state"));
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1168)           ret = -1;
f6f191b3f25     (Paul-Sebastian Ungureanu       2018-08-31 00:40:44 
+0300       1169)           goto done;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1251)           return -1;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1260)           if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1261)                   fprintf_ln(stderr, _("Cannot 
initialize stash"));
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1262)           return -1;
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1272)           if (!quiet)
8002b9e6264     (Paul-Sebastian Ungureanu       2018-08-31 00:40:46 
+0300       1273)                   fprintf_ln(stderr, _("Cannot save 
the current status"));
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1274)           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1275)           goto done;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1292)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1311)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1312)                           goto done;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1321)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1322)                           goto done;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1330)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1339)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1350)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1359)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1360)                           goto done;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1368)                           ret = -1;
48c061fa443     (Paul-Sebastian Ungureanu       2018-08-31 00:40:45 
+0300       1394)                           ret = -1;
129f0b0a009     (Paul-Sebastian Ungureanu       2018-08-31 00:40:48 
+0300       1524) usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), 
argv[0]),
129f0b0a009     (Paul-Sebastian Ungureanu       2018-08-31 00:40:48 
+0300       1554)                           continue;
builtin/submodule--helper.c
9d34daefb74     (Antonio Ospite 2018-08-14 13:05:22 +0200 2174)   
die("submodule--helper config takes 1 or 2 arguments: name [value]");
commit-graph.c
5cef295f283     (Derrick Stolee 2018-08-20 18:24:32 +0000 
66)             return 0;
20fd6d57996     (Derrick Stolee 2018-08-20 18:24:30 +0000 
78)             return 0;
date.c
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
113)            die("Timestamp too large for this system: %"PRItime, time);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
216)            if (tm->tm_mon == human_tm->tm_mon) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
217)                    if (tm->tm_mday > human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
219)                    } else if (tm->tm_mday == human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
220)                            hide.date = hide.wday = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
221)                    } else if (tm->tm_mday + 5 > human_tm->tm_mday) {
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
223)                            hide.date = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
231)            gettimeofday(&now, NULL);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
232)            show_date_relative(time, tz, &now, buf);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
233)            return;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
246)            hide.seconds = 1;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
247)            hide.tz |= !hide.date;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
248)            hide.wday = hide.time = !hide.year;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
262)            strbuf_rtrim(buf);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
287)            gettimeofday(&now, NULL);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
290)            human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 886)static int 
auto_date_style(void)
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 888)    return 
(isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
909)            return DATE_HUMAN;
74e8221b523     (Linus Torvalds 2018-07-07 15:02:35 -0700 
911)            return auto_date_style();
diff-lib.c
fa49029577c     (Alex Vandiver  2018-01-02 19:04:56 -0800 
205)                    continue;
list-objects-filter.c
dbebce653b5     (Matthew DeVore 2018-09-04 11:05:49 -0700 
47)             BUG("unknown filter_situation: %d", filter_situation);
7329b7c6cdc     (Matthew DeVore 2018-09-04 11:05:50 -0700 100)    default:
7329b7c6cdc     (Matthew DeVore 2018-09-04 11:05:50 -0700 
101)            BUG("unknown filter_situation: %d", filter_situation);
dbebce653b5     (Matthew DeVore 2018-09-04 11:05:49 -0700 
152)            BUG("unknown filter_situation: %d", filter_situation);
dbebce653b5     (Matthew DeVore 2018-09-04 11:05:49 -0700 
257)            BUG("unknown filter_situation: %d", filter_situation);
dbebce653b5     (Matthew DeVore 2018-09-04 11:05:49 -0700 
438)            BUG("invalid list-objects filter choice: %d",
list-objects.c
f447a499dbb     (Matthew DeVore 2018-08-13 11:14:28 -0700 
197)                    ctx->show_object(obj, base->buf, ctx->show_data);
rebase-interactive.c
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
61)             return error_errno(_("could not read '%s'."), todo_file);
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
65)             strbuf_release(&buf);
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
66)             return -1;
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
74)             return error_errno(_("could not read '%s'."), todo_file);
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
78)             strbuf_release(&buf);
a9f5476fbca     (Alban Gruin    2018-08-10 18:51:35 +0200 
79)             return -1;
64a43cbd5da     (Alban Gruin    2018-08-10 18:51:31 +0200 
85)             return -1;
refs.c
4a6067cda51     (Stefan Beller  2018-08-20 18:24:16 +0000 
1405)           return 0;
sequencer.c
65850686cf0     (Alban Gruin    2018-08-28 14:10:40 +0200 
2276)           return;
65850686cf0     (Alban Gruin    2018-08-28 14:10:40 +0200 
2373)           write_file(rebase_path_quiet(), "%s\n", quiet);
2c58483a598     (Alban Gruin    2018-08-10 18:51:33 +0200 
3371)                   return error(_("could not checkout %s"), commit);
4df66c40b08     (Alban Gruin    2018-08-10 18:51:34 +0200 
3385)           return error(_("%s: not a valid OID"), orig_head);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4750)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4753)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4759)           return error_errno(_("could not read '%s'."), todo_file);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4762)           todo_list_release(&todo_list);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4763)           return error(_("unusable todo list: '%s'"), todo_file);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4782)           todo_list_release(&todo_list);
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4783)           return -1;
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4787)           return error(_("could not copy '%s' to '%s'."), todo_file,
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4791)           return error(_("could not transform the todo list"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4820)           return error(_("could not transform the todo list"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4823)           return error(_("could not skip unnecessary pick commands"));
b97e1873649     (Alban Gruin    2018-08-28 14:10:36 +0200 
4829)           return -1;
strbuf.c
f95736288a3     (Pratik Karki   2018-08-08 20:51:16 +0545 
127)                    --sb->len;
submodule-config.c
83a66534e63     (Antonio Ospite 2018-08-14 13:05:19 +0200 
714)            return CONFIG_INVALID_KEY;
150984f5339     (Antonio Ospite 2018-08-14 13:05:20 +0200 
729)            warning(_("Could not update .gitmodules entry %s"), key);
t/helper/test-dump-fsmonitor.c
6e1123ec573     (Alex Vandiver  2018-01-02 19:04:54 -0800 
25)                     valid++;
t/helper/test-repository.c
b7758963424     (Derrick Stolee 2018-08-20 18:24:24 +0000 
21)             die("Couldn't init repo");
b7758963424     (Derrick Stolee 2018-08-20 18:24:24 +0000 
47)             die("Couldn't init repo");
wrapper.c
7e621449185     (Pranit Bauva   2017-10-27 15:06:37 +0000 
701)            die_errno(_("could not stat %s"), filename);
wt-status.c
f3bd35fa0dd     (Stephen P. Smith       2018-09-05 17:53:29 -0700       
671)                    s->committable = 1;
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1949)                   if (s->state.rebase_in_progress ||
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 1950) 
s->state.rebase_interactive_in_progress)
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1951)                           branch_name = s->state.onto;
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1952)                   else if (s->state.detached_from)
1c623c066c2     (Junio C Hamano 2018-09-07 15:32:24 -0700 
1953)                           branch_name = s->state.detached_from;

