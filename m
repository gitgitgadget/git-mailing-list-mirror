Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDD0207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdEFAC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:02:56 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36166 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEFACz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:02:55 -0400
Received: by mail-pf0-f178.google.com with SMTP id q66so9085821pfi.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5BKoFsl0Z1fVwIr7nEm1SjRXe8BYaJ4npLnIAnpbIqU=;
        b=rzOtqA0jUbn0PqASdEyur5cALhF5eiXlfmyAg4ljnceV0lpm3uMzQBd0Hz2ZZXpCt1
         iouEiWPtGnX45DrA8JKVtvDiP1OY8Vd8lKk01YrWKsvqYuxOcQObp1H41GO7g0Zisz46
         jT5GfRbaJaHAnH8fq3ScUdkiXj2ud4VX4xU+p5rJM7qv1iHtJBK2kx8d9OBteI+si8/v
         Q4Ue1OUOcUsLFhkQHe5kJfnBEgG9g/TXZ0H9pf8CQIM+7jFcvjt0R2dsaU0dbpVP6mrO
         IrJlRqLmK21P3wEz3iP+DNQbMYmv7wxiiBy+zD9As2/8EKRntqr9ME++VIAv2+CZgri0
         6IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5BKoFsl0Z1fVwIr7nEm1SjRXe8BYaJ4npLnIAnpbIqU=;
        b=MN24bOjjQA1iPEJ4+16noVnSqbln1b42lb7sJ+dtaNYKT9PC+lshCxnBHyJcYWJxtb
         BLwEyqXbzP5GknLhOEvaMtLYO0TBu0oxJtOGvR1lo600Xy8w72HH7cDHcLDlmyCpig1n
         HeKnSxZibrXhmhGrajzqT3CnJPjaCC0QJmmA/ldCKQ2nfAFBP2aTD9WLLIw0h4z+ZRB4
         3ZL+yoxf6Qr1hhwygJPkzZ+bBeTFI6XKU8rb2tLSDu0JZhqfs1SnltNOxUwzFVQFDu3b
         CG/upTfHZ+Xg6W/TUhRi+LhUKm16Y4teAzNSzxS1lTBSNAw02SZENr/i41aIiolIkha3
         HfQQ==
X-Gm-Message-State: AN3rC/4jILH8GkVRvtZwVOLHbavMl2LFXW1obmzQDQT+q/0DoS+Au68U
        GhnCw4joefsCwpa4o/4avt9j+1ummdnf6kGINg==
X-Received: by 10.99.60.81 with SMTP id i17mr6413127pgn.183.1494028974770;
 Fri, 05 May 2017 17:02:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Fri, 5 May 2017 17:02:54 -0700 (PDT)
In-Reply-To: <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com> <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 May 2017 17:02:54 -0700
Message-ID: <CAGZ79ka4vG1yd1JtK9bDBjWPUG0UCPMvw2XQUsfX_e_xFCpVLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] receive-pack: verify push options in cert
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 4:46 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In commit f6a4e61 ("push: accept push options", 2016-07-14), send-pack
> was taught to include push options both within the signed cert (if the
> push is a signed push) and outside the signed cert; however,
> receive-pack ignores push options within the cert, only handling push
> options outside the cert.
>
> Teach receive-pack, in the case that push options are provided for a
> signed push, to verify that the push options both within the cert and
> outside the cert are consistent, and to provide the results of that
> verification to the receive hooks as an environment variable (just like
> it currently does for the nonce verification).
>
> This sets in stone the requirement that send-pack redundantly send its
> push options in 2 places, but I think that this is better than the
> alternatives. Sending push options only within the cert is
> backwards-incompatible with existing Git servers (which read push
> options only from outside the cert), and sending push options only
> outside the cert means that the push options are not signed for.

As the combination of push certs and push options are broken
(at least when using JGit as well, which are used in Gerrit
installations), I would not feel too bad about actually going
the backwards-incompatible way.

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/git-receive-pack.txt | 10 ++++++++
>  builtin/receive-pack.c             | 49 ++++++++++++++++++++++++++++++++++----
>  t/t5534-push-signed.sh             | 15 ++++++++++++
>  3 files changed, 70 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index 86a4b32f0..f50ca0f29 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -106,6 +106,16 @@ the following environment variables:
>         Also read about `receive.certNonceSlop` variable in
>         linkgit:git-config[1].
>
> +`GIT_PUSH_CERT_OPTION_STATUS`::
> +`BAD`;;
> +       For backwards compatibility reasons, when accepting a signed
> +       push, receive-pack requires that push options be written both
> +       inside and outside the certificate. ("git push" does this
> +       automatically.) `BAD` is returned if they are inconsistent.
> +`OK`;;
> +       The push options inside and outside the certificate are
> +       consistent.
> +
>  This hook is called before any refname is updated and before any
>  fast-forward checks are performed.
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index f96834f42..fe26c2f72 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -81,6 +81,9 @@ static long nonce_stamp_slop;
>  static unsigned long nonce_stamp_slop_limit;
>  static struct ref_transaction *transaction;
>
> +static const char *PUSH_OPTION_BAD = "BAD";
> +static const char *PUSH_OPTION_OK = "OK";
> +
>  static enum {
>         KEEPALIVE_NEVER = 0,
>         KEEPALIVE_AFTER_NUL,
> @@ -473,7 +476,8 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
>   * after dropping "_commit" from its name and possibly moving it out
>   * of commit.c
>   */
> -static char *find_header(const char *msg, size_t len, const char *key)
> +static char *find_header(const char *msg, size_t len, const char *key,
> +                        const char **next_line)
>  {
>         int key_len = strlen(key);
>         const char *line = msg;
> @@ -486,6 +490,8 @@ static char *find_header(const char *msg, size_t len, const char *key)
>                 if (line + key_len < eol &&
>                     !memcmp(line, key, key_len) && line[key_len] == ' ') {
>                         int offset = key_len + 1;
> +                       if (next_line)
> +                               *next_line = *eol ? eol + 1 : eol;
>                         return xmemdupz(line + offset, (eol - line) - offset);
>                 }
>                 line = *eol ? eol + 1 : NULL;
> @@ -495,7 +501,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
>
>  static const char *check_nonce(const char *buf, size_t len)
>  {
> -       char *nonce = find_header(buf, len, "nonce");
> +       char *nonce = find_header(buf, len, "nonce", NULL);
>         unsigned long stamp, ostamp;
>         char *bohmac, *expect = NULL;
>         const char *retval = NONCE_BAD;
> @@ -575,9 +581,40 @@ static const char *check_nonce(const char *buf, size_t len)
>         return retval;
>  }
>
> -static void prepare_push_cert_sha1(struct child_process *proc)
> +static const char *check_push_option(const char *buf, size_t len,
> +                                    const struct string_list *push_options)
> +{
> +       int options_seen = 0;
> +       char *option;
> +       const char *next_line;
> +       const char *retval = PUSH_OPTION_OK;
> +
> +       while ((option = find_header(buf, len, "push-option", &next_line))) {
> +               len -= (next_line - buf);
> +               buf = next_line;
> +               options_seen++;
> +               if (options_seen > push_options->nr
> +                   || strcmp(option,
> +                             push_options->items[options_seen - 1].string)) {
> +                       retval = PUSH_OPTION_BAD;
> +                       goto leave;
> +               }
> +               free(option);
> +       }
> +
> +       if (options_seen != push_options->nr)
> +               retval = PUSH_OPTION_BAD;
> +
> +leave:
> +       free(option);
> +       return retval;
> +}
> +
> +static void prepare_push_cert_sha1(struct child_process *proc,
> +                                  const struct string_list *push_options)
>  {
>         static int already_done;
> +       static const char *push_option_status;
>
>         if (!push_cert.len)
>                 return;
> @@ -609,6 +646,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>                 strbuf_release(&gpg_output);
>                 strbuf_release(&gpg_status);
>                 nonce_status = check_nonce(push_cert.buf, bogs);
> +               push_option_status = check_push_option(push_cert.buf, bogs,
> +                                                      push_options);
>         }
>         if (!is_null_sha1(push_cert_sha1)) {
>                 argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
> @@ -631,6 +670,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>                                                  "GIT_PUSH_CERT_NONCE_SLOP=%ld",
>                                                  nonce_stamp_slop);
>                 }
> +               argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_OPTION_STATUS=%s",
> +                                push_option_status);
>         }
>  }
>
> @@ -683,7 +724,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
>                 proc.err = muxer.in;
>         }
>
> -       prepare_push_cert_sha1(&proc);
> +       prepare_push_cert_sha1(&proc, feed_state->push_options);
>
>         code = start_command(&proc);
>         if (code) {
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index ecb8d446a..2607b8797 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -124,6 +124,21 @@ test_expect_success GPG 'signed push sends push certificate' '
>         test_cmp expect dst/push-cert-status
>  '
>
> +test_expect_success GPG 'signed push reports push option status in receive hook' '
> +       prepare_dst &&
> +       mkdir -p dst/.git/hooks &&
> +       git -C dst config receive.certnonceseed sekrit &&
> +       git -C dst config receive.advertisepushoptions 1 &&
> +       write_script dst/.git/hooks/post-receive <<-\EOF &&
> +               # record the push option status
> +               echo "$GIT_PUSH_CERT_OPTION_STATUS" > ../push-option-status
> +       EOF
> +
> +       git push --push-option="foo" --push-option="bar" --signed dst noop ff &&
> +
> +       test "$(cat dst/push-option-status)" = "OK"
> +'
> +

I think in this context we'd really want to test the negative way as
well, reporting BAD?
I am unsure how easy it is to forge push options in the test, though.
The code looks good, but I only reviewed it for a minute.

Thanks,
Stefan
