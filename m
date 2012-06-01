From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH v2 6/6] vcs-svn: drop no-op reset methods
Date: Fri, 1 Jun 2012 14:26:58 +1000
Message-ID: <CAFfmPPOSLXU1Fcg=xc4OMF2+w6VTYAEL=Jgw+f6dfgxXmuO1rg@mail.gmail.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
	<1338475290-22644-7-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 06:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaJSE-0005hM-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 06:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab2FAE1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 00:27:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55860 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2FAE07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 00:26:59 -0400
Received: by yhmm54 with SMTP id m54so1324750yhm.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=HQrPRd07aBA00RkWhyFGWfIK2wsihn6WO6B9oOJqdCM=;
        b=hCI/Y9wtn7EC7yt+fHNYqD07rTr6E5Qu4kLWz8BhsMegZMC60h1yi2bgMZ4dW2rofm
         +AzSFfItFbV3BxMv1SglaPuc0ujQX+iaNLNZN1CcE6DhABIRKbAEwdpHcdNH/uNQrCPq
         i45UgItGgKKTQgPWymq4IbgSZ/kt4P9acb8qdl8EljgjKhtlE/0YbKOCVpdOgHx0y61g
         CaKPmBNljyyv9HbWF4arlTy47sQkzkfz4YsS42xwbc4vIUNB5vqhMhn9rNlxO+SG/fn+
         YAimSPYEy9ZpkoW1ydh3Gsx64Chu2MJf67rwH1xMqB6bFXLRF9yKTmBb4zqx0OSLIExl
         62+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=HQrPRd07aBA00RkWhyFGWfIK2wsihn6WO6B9oOJqdCM=;
        b=F53kvmBwgBCFttA8skH9TcegE+a76+H8PQNQCmB6VA6/abwxc2d5I5lPEti6U7qRTE
         O+UqbIBhviX1jlunbqgszeDiLartd5RbKzEgVUyExQupz005FyUwcTlots2zZIkcltzF
         meLLwYCxFjMQxM7rsAFutRhjxsqR2bDzNedhz8d1tRYQ2TyNNJe4S5lqbKFPxJ0o1LDD
         1Lh8+GDMliOGZiEQyq9M4QCyR/1Plos/hAMoxPEt3si8CrQgw6IelNVXW0uVrrAi4zWv
         kMO5DwHoxls3TT7g/JjSNau6id5F0MM14zTJO1j/16DueRlhoOFHHlzRd4uAK+3W6Drs
         U7DA==
Received: by 10.236.161.73 with SMTP id v49mr1145229yhk.89.1338524818802;
        Thu, 31 May 2012 21:26:58 -0700 (PDT)
Received: by 10.236.161.73 with SMTP id v49mr1145215yhk.89.1338524818683; Thu,
 31 May 2012 21:26:58 -0700 (PDT)
Received: by 10.101.155.23 with HTTP; Thu, 31 May 2012 21:26:58 -0700 (PDT)
In-Reply-To: <1338475290-22644-7-git-send-email-davidbarr@google.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmugkz5WH4/ZyRXxOydXXPgUl9FB26+mwWiiVoW9sVbgrrqwwqNxJcYZqWcExvt9lYELEx+14ScKmz/mYbZBMKT63c/bxB7rj5lkaaruHcwOEqn1WmSVNsopWAHnlPVkbndjKF57pPZCthl20llcRc6JAPWHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198955>

On Fri, Jun 1, 2012 at 12:41 AM, David Barr <davidbarr@google.com> wrot=
e:
> Since v1.7.5~42^2~6 (vcs-svn: remove buffer_read_string)
> buffer_reset() does nothing thus fast_export_reset() also.
>
> Signed-off-by: David Barr <davidbarr@google.com>
> ---
> =A0vcs-svn/fast_export.c | =A0 =A05 -----
> =A0vcs-svn/fast_export.h | =A0 =A01 -
> =A0vcs-svn/line_buffer.c | =A0 =A04 ----
> =A0vcs-svn/line_buffer.h | =A0 =A01 -
> =A0vcs-svn/svndump.c =A0 =A0 | =A0 =A02 --
> =A05 files changed, 13 deletions(-)
>
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 6ded98b..1f04697 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -42,11 +42,6 @@ void fast_export_deinit(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die_errno("error closing fast-import f=
eedback stream");
> =A0}
>
> -void fast_export_reset(void)
> -{
> - =A0 =A0 =A0 buffer_reset(&report_buffer);
> -}
> -
> =A0void fast_export_delete(const char *path)
> =A0{
> =A0 =A0 =A0 =A0putchar('D');
> diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
> index aa629f5..8823aca 100644
> --- a/vcs-svn/fast_export.h
> +++ b/vcs-svn/fast_export.h
> @@ -6,7 +6,6 @@ struct line_buffer;
>
> =A0void fast_export_init(int fd);
> =A0void fast_export_deinit(void);
> -void fast_export_reset(void);
>
> =A0void fast_export_delete(const char *path);
> =A0void fast_export_modify(const char *path, uint32_t mode, const cha=
r *dataref);
> diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
> index 01fcb84..57cc1ce 100644
> --- a/vcs-svn/line_buffer.c
> +++ b/vcs-svn/line_buffer.c
> @@ -124,7 +124,3 @@ off_t buffer_skip_bytes(struct line_buffer *buf, =
off_t nbytes)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return done;
> =A0}
> -
> -void buffer_reset(struct line_buffer *buf)
> -{
> -}
> diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
> index 8901f21..ee23b4f 100644
> --- a/vcs-svn/line_buffer.h
> +++ b/vcs-svn/line_buffer.h
> @@ -14,7 +14,6 @@ struct line_buffer {
> =A0int buffer_init(struct line_buffer *buf, const char *filename);
> =A0int buffer_fdinit(struct line_buffer *buf, int fd);
> =A0int buffer_deinit(struct line_buffer *buf);
> -void buffer_reset(struct line_buffer *buf);
>
> =A0int buffer_tmpfile_init(struct line_buffer *buf);
> =A0FILE *buffer_tmpfile_rewind(struct line_buffer *buf); =A0/* prepar=
e to write. */
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 6d1e3cd..f1705f3 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -499,8 +499,6 @@ void svndump_deinit(void)
>
> =A0void svndump_reset(void)
> =A0{
> - =A0 =A0 =A0 fast_export_reset();
> - =A0 =A0 =A0 buffer_reset(&input);
> =A0 =A0 =A0 =A0strbuf_release(&dump_ctx.uuid);
> =A0 =A0 =A0 =A0strbuf_release(&dump_ctx.url);
> =A0 =A0 =A0 =A0strbuf_release(&rev_ctx.log);
> --
> 1.7.10.2
>

It' a little embarrassing that I didn't catch this before submitting.
Please squash in this fix-up when queueing.

--
diff --git a/test-line-buffer.c b/test-line-buffer.c
index 7ec9b13..ef1d7ba 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -87,6 +87,5 @@ int main(int argc, char *argv[])
 		die("input error");
 	if (ferror(stdout))
 		die("output error");
-	buffer_reset(&stdin_buf);
 	return 0;
 }
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 332a5f7..83633a2 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -31,9 +31,7 @@ static int apply_delta(int argc, char *argv[])
 		die_errno("cannot close preimage");
 	if (buffer_deinit(&delta))
 		die_errno("cannot close delta");
-	buffer_reset(&preimage);
 	strbuf_release(&preimage_view.buf);
-	buffer_reset(&delta);
 	return 0;
 }

--
David Barr
