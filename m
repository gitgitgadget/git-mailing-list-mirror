From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 00/40] libify apply and use lib in am, part 2
Date: Mon, 13 Jun 2016 18:16:00 +0200
Message-ID: <CAP8UFD3GgG6geKrXHMKFk-F5inA569DBDjVekNKaDgr5XYaMDw@mail.gmail.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 18:16:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUX3-0008Fi-2X
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425014AbcFMQQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:16:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36196 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424127AbcFMQQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:16:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so16033044wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KvleDZdTiP3jbFF9Qwt19Izb09apwKkY74pjtooXoY8=;
        b=tNZT0YO/sTyHSBrxfH92Hsby/w6SJw6g2EqZutOQ4AUjx3nJkEN8MGEQUxkrFNYkup
         DUHtX7IW0vC4264NtBgdxxAx2ffjT5rVja27Uvh82RPZD6I6Q30JBtKFkPrMvQN25LQT
         RaJsVKQ9QbCqdHiTlSJFdOn1vaPMb3ddgbmvUim/DQqh6Z2Ac5Wz+hA7vmELgXv/V3CG
         p9DkXwtd5S6Bit/HRgv+yQkVGXpziq1o9LSKsMOvahXdnLMlkCef+3gFNQsveCzSP/82
         Mv/IynDILRrZsrNjwXlD5f7qfKBgdHZau3+zqCw0HgN0kdgZO/p2HrCFnTef7617hXOO
         6JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KvleDZdTiP3jbFF9Qwt19Izb09apwKkY74pjtooXoY8=;
        b=imbX825Y4I4uUzNcNvPvi3s2epJBzAn1FNmA60+dUwT4kw2rErahePkNxm7PL9qQ2B
         Vu0D68u8B2/A9ULj23Lhnf9PhsxpKZukRO2cHlg8F8tYRMagOpRrCgAecY7d+Uml7MSr
         5WTtVTQ9U0Z5jQKVsTpGP61M4N7drj6fDCWqIuu23gRSVwrwyD1Vz9cfUkb/cuSytCn9
         GKz8H4lkVHTuo9KjDzMVoB9qil4C9v9UMGR78w+7Cby4u/VuwNV3KBTnK+VCPvR98Ux3
         yvhAKMbPbnIsxhiBoKVU+9ixU0ZV4FnZoLMyAIhmSb1/C00OKoNJ2JBS0hoZL17bgVdG
         Pd1g==
X-Gm-Message-State: ALyK8tI2nLd2ww9yM1aNUKdbp5UVUdB3Pt+sGXenTiJz+8xUp3oDxPhzosp11BmQJUzgleo89DritaR/yw99oA==
X-Received: by 10.28.167.136 with SMTP id q130mr413970wme.62.1465834561321;
 Mon, 13 Jun 2016 09:16:01 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Mon, 13 Jun 2016 09:16:00 -0700 (PDT)
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297233>

On Mon, Jun 13, 2016 at 6:09 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and the previous one, as a
> reply to this email.

Here is the diff:

diff --git a/apply.c b/apply.c
index cd4cd01..777798a 100644
--- a/apply.c
+++ b/apply.c
@@ -4386,7 +4386,7 @@ static int create_one_file(struct apply_state *state,
                        ++nr;
                }
        }
-       return error_errno(_("unable to write file '%s' mode %o: %s"),
+       return error_errno(_("unable to write file '%s' mode %o"),
                           path, mode);
 }

diff --git a/builtin/am.c b/builtin/am.c
index 43f7316..8647298 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1584,7 +1584,6 @@ static int run_apply(const struct am_state
*state, const char *index_file)
         * If we are allowed to fall back on 3-way merge, don't give false
         * errors during the initial attempt.
         */
-
        if (state->threeway && !index_file)
                apply_state.be_silent = 1;

@@ -1600,6 +1599,7 @@ static int run_apply(const struct am_state
*state, const char *index_file)

        argv_array_clear(&apply_paths);
        argv_array_clear(&apply_opts);
+       clear_apply_state(&apply_state);

        if (res)
                return res;
diff --git a/builtin/apply.c b/builtin/apply.c
index 93744f8..ddd61de 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -74,8 +74,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
                OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
                        N_("allow overlapping hunks")),
                OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
-               OPT_BOOL(0, "silent", &state.be_silent,
-                       N_("do not print any output")),
                OPT_BIT(0, "inaccurate-eof", &options,
                        N_("tolerate incorrectly detected missing
new-line at the end of file"),
                        APPLY_OPT_INACCURATE_EOF),
diff --git a/run-command.c b/run-command.c
index c09d6b0..af0c8a1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
 }

 #ifndef GIT_WINDOWS_NATIVE
-static void dup_devnull(int to)
+static inline void dup_devnull(int to)
 {
        int fd = open("/dev/null", O_RDWR);
        if (fd < 0)
