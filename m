From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] format-patch: introduce format.outputDirectory configuration
Date: Wed, 13 Jan 2016 13:27:19 -0500
Message-ID: <CAPig+cSxVdZN_wr3XuqDGuKn14J3B7s=S8OoH19v+AjMvcX6+Q@mail.gmail.com>
References: <CAPig+cTCRq9VCT7t8E9yjk4QcHYB2_qeBwGB_31keB4nTjkLkA@mail.gmail.com>
	<1452691211-15347-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:27:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQ8i-0001Od-Rn
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbcAMS1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:27:21 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34697 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbcAMS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:27:20 -0500
Received: by mail-vk0-f67.google.com with SMTP id a123so8354140vkh.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OA+wnOh0FpKYRinxSWDNvMJAUPiMW9eWJEj0lwSubEg=;
        b=x8qhEfJmHyKMC1w+k3nod5jr9qcEnmhmLLJ6NfnKtx3HtzQwr2uISEaSdhaUdlhZBw
         GUO89KsT3D67FGBfr16Z2t1kXmwTbyf52HUMOYjnsKfvCQQHPESJ42iXig9/Zi66xKpE
         YBrX6W8J2St1XMvWye9tkHgeSi9xolA4XQnu1NADBlB4KXU+w4wMXoCs8lTQmH9++h2s
         96GAW5EJ0D3XPZxnd37Gs/auMXROcrFEO59PhWfSVqBa+mjVgTN0Yyr/MqodPVHPI/vy
         RHS/JVZ94g8dVpC+bnlB3FG/FlvfMtzBTBGmk/FkDDqEOYt5JV/lfGZ96i2zSteRIf2H
         3RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OA+wnOh0FpKYRinxSWDNvMJAUPiMW9eWJEj0lwSubEg=;
        b=fWC6L31cAvi8aCJULKP+/nOeVyXFvxL2fIoNH1Ju2I63eXBCNUBxl8LYrLRma+fVit
         IR7cN0DgoBSrANrKjPRQhxCHaEil3xlBdwwrQjZ8F47NIthkVO1WJ6bbbgS5UqyXCcGR
         oFMbKBGW+0GF5HdvY38hYdNUbetwKZjDLu1xFg7IgvbbOpmVvt7MvsLBuu6lmeQym0Et
         QleHO2fT4wZo7P/EHcLb08is/vQqsxsCOhBovbMCdy6uYaLqsFfOP+SoJEJOPpeSdMXl
         6Erk5eNMJPYpc4ZLoCWMMMDSmEeSQgsIbnM50tmhtvkBYiJi2d6coMnyz/13TdO3tvEG
         jC2Q==
X-Gm-Message-State: ALoCoQljfC3MuvM1IuDR28xpd8+CHv/8NTyyCtnlgJ4itnoPW3O2IuzM1wVBA9tzsDe2lq7LUuMFB5G9LkU0yO3LxXzcPvn7Cg==
X-Received: by 10.31.182.143 with SMTP id g137mr64239373vkf.45.1452709639118;
 Wed, 13 Jan 2016 10:27:19 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 13 Jan 2016 10:27:19 -0800 (PST)
In-Reply-To: <1452691211-15347-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: dbuI0Eos6ZIK4ljIpEzBouUGfGk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283963>

On Wed, Jan 13, 2016 at 8:20 AM, Stephen P. Smith <ischis2@cox.net> wrote:
> From: Alexander Kuleshov <kuleshovmail@gmail.com>
>
> We can pass -o/--output-directory to the format-patch command to store
> patches in some place other than the working directory. This patch
> introduces format.outputDirectory configuration option for same
> purpose.
>
> The case of usage of this configuration option can be convenience
> to not pass every time -o/--output-directory if an user has pattern
> to store all patches in the /patches directory for example.
>
> The format.outputDirectory has lower priority than command line
> option, so if user will set format.outputDirectory and pass the
> command line option, a result will be stored in a directory that
> passed to command line option.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> Notes:
>     Fixed s/convinience/convenience/
>
>     Moved 'static const char *config_output_directory;' to be with othe
>     similarly typed variables.

Thanks. This version is also:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

(A note for future submissions of other patches: Once a person has
given a Reviewed-by:, you're welcome to include the Reviewed-by: in a
re-roll provided that the re-roll doesn't change anything which would
obviously invalidate the Reviewed-by:. In this particular case, for
instance, v6 merely fixed a couple very minor nits mentioned in my v5
review, so it would have been perfectly acceptable to include my
Reviewed-by: in v6.)

>  Documentation/config.txt           |  4 ++++
>  Documentation/git-format-patch.txt |  6 +++++-
>  builtin/log.c                      |  6 ++++++
>  t/t4014-format-patch.sh            | 15 +++++++++++++++
>  4 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f617886..e92a0ee 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1243,6 +1243,10 @@ format.coverLetter::
>         format-patch is invoked, but in addition can be set to "auto", to
>         generate a cover-letter only when there's more than one patch.
>
> +format.outputDirectory::
> +       Set a custom directory to store the resulting files instead of the
> +       current working directory.
> +
>  filter.<driver>.clean::
>         The command which is used to convert the content of a worktree
>         file to a blob upon checkin.  See linkgit:gitattributes[5] for
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index e3cdaeb..64c2803 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -57,7 +57,11 @@ The names of the output files are printed to standard
>  output, unless the `--stdout` option is specified.
>
>  If `-o` is specified, output files are created in <dir>.  Otherwise
> -they are created in the current working directory.
> +they are created in the current working directory. The default path
> +can be set with the 'format.outputDirectory' configuration option.
> +The `-o` option takes precedence over `format.outputDirectory`.
> +To store patches in the current working directory even when
> +`format.outputDirectory` points elsewhere, use `-o .`.
>
>  By default, the subject of a single patch is "[PATCH] " followed by
>  the concatenation of lines from the commit message up to the first blank
> diff --git a/builtin/log.c b/builtin/log.c
> index e00cea7..0d738d6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -699,6 +699,7 @@ static int do_signoff;
>  static const char *signature = git_version_string;
>  static const char *signature_file;
>  static int config_cover_letter;
> +static const char *config_output_directory;
>
>  enum {
>         COVER_UNSET,
> @@ -777,6 +778,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
>                 config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>                 return 0;
>         }
> +       if (!strcmp(var, "format.outputdirectory"))
> +               return git_config_string(&config_output_directory, var, value);
>
>         return git_log_config(var, value, cb);
>  }
> @@ -1391,6 +1394,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         if (rev.show_notes)
>                 init_display_notes(&rev.notes_opt);
>
> +       if (!output_directory && !use_stdout)
> +               output_directory = config_output_directory;
> +
>         if (!use_stdout)
>                 output_directory = set_outdir(prefix, output_directory);
>         else
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 646c475..3b99434 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1445,4 +1445,19 @@ test_expect_success 'From line has expected format' '
>         test_cmp from filtered
>  '
>
> +test_expect_success 'format-patch format.outputDirectory option' '
> +       test_config format.outputDirectory patches &&
> +       rm -fr patches &&
> +       git format-patch master..side &&
> +       test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
> +'
> +
> +test_expect_success 'format-patch -o overrides format.outputDirectory' '
> +       test_config format.outputDirectory patches &&
> +       rm -fr patches patchset &&
> +       git format-patch master..side -o patchset &&
> +       test_path_is_missing patches &&
> +       test_path_is_dir patchset
> +'
> +
>  test_done
> --
> 2.7.0-rc2
