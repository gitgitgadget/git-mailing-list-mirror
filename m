Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EAD20188
	for <e@80x24.org>; Fri, 12 May 2017 07:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757086AbdELHXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 03:23:30 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37941 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756302AbdELHX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 03:23:29 -0400
Received: by mail-it0-f49.google.com with SMTP id e65so32712050ita.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oaUx3jAFt3S8lqoGkBBX93NOq/g1dOKqdk3wti0oHAE=;
        b=WY4Oqp8FTsF1P2qs2yX6JKVWrfSmYqjT2ewxn45r0FSvDe5YK0fZ8Uyk/BHuxO/k/z
         mDjz7NPn/niVRDWYq6ULOyN/O7351oDH9qqkAmUWiYHM29C4JnvUNTEzdxzRilkKPmA3
         J8XDQwiPNdJGH5zSgqyi5ekO2gfv0zDmqijrlXhxF6Plo4zmN6BusvMMMuPfcNFjkjB7
         b3y0wkGVEA8zEseDRjuavotn3BK+H2M5tGOwch2hfv2zuV7WsOpWwyk9F8IFjZ85DL2I
         l39Aosf3vSk2mIVXXRRiqQKFGInUq1mGUgXrKI/u/8xBlPP+ppMi+43XZcTrgtoe8e1W
         7+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oaUx3jAFt3S8lqoGkBBX93NOq/g1dOKqdk3wti0oHAE=;
        b=sAZr+nDKt+vN84LN5Z41QovvhoazLfgwND3Yz9dsLYrzujg501o1E5NA4uX83A3y0J
         F/aTD8uDxj7XrSlXn7noMx6hW9olZ4YKKvBTUl4rRTTpqef0bGYSQc43Pmrf22Ep196h
         uqUOCW9NFPfmhXUz6MyElyfJoCiWjtZ7NGGaoG8xit4qbcnXmuTnNp6fIHKdoU+SzEUZ
         UG0AiPTZk8HYC913Kdt/eCNLNIpx2Q4beVfUDkLsVJ03qG6xc4pI+Z9JTj4ydNWSSKMt
         zc6J6SA6khF6stX4+/rqMaRPg7qqRLT6VsTKV+6bE8TAFZ+C5ly8IJehwtL5u4Y/F23A
         Dcjg==
X-Gm-Message-State: AODbwcCwrtdYMNHzTmgUWCfq18HEs7so2LKZJFpp1NxLY+ORy6nPauvX
        VjbdLyZavPfDaaGdoAO9EseGdzHt6AAdkSU=
X-Received: by 10.36.166.4 with SMTP id q4mr2228993ite.66.1494573808555; Fri,
 12 May 2017 00:23:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 00:23:07 -0700 (PDT)
In-Reply-To: <20170511193753.19594-1-jonathantanmy@google.com>
References: <20170511193753.19594-1-jonathantanmy@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 12 May 2017 09:23:07 +0200
Message-ID: <CACBZZX74dsTJtAQdrMmEDPKOVdEaiL4dGrmz9OZ3jQhhmr5xEA@mail.gmail.com>
Subject: Re: [RFC] send-email: support validate hook
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 9:37 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, send-email has support for rudimentary e-mail validation.
> Allow the user to add support for more validation by providing a
> sendemail-validate hook.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> This is motivated by situations in which we discuss a work in progress
> using Gerrit (which requires Change-Id trailers in patches), and then,
> forgetting to remove the Change-Id trailers, send them to the Git
> mailing list (which does not want such trailers). I can envision such
> functionality being useful in other situations, hence this patch
> submission.
>
> I'm not very familiar with Perl, and "There Is More Than One Way To Do
> It", so advice on Perl style is appreciated.


I hacked this up last night, it also addresses Junio's comment about GIT_DIR:

+++ b/git-send-email.perl
@@ -25,7 +25,7 @@ use Getopt::Long;
 use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
-use File::Spec::Functions qw(catfile);
+use File::Spec::Functions qw(catdir catfile);
 use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
@@ -629,22 +629,19 @@ if (@rev_list_opts) {
 @files = handle_backup_files(@files);

 if ($validate) {
-       my @hook = ($repo->repo_path().'/hooks/sendemail-validate', '');
-       my $use_hook = -x $hook[0];
-       if ($use_hook) {
-               # The hook needs a correct GIT_DIR.
-               $ENV{"GIT_DIR"} = $repo->repo_path();
-       }
+       my $validate_hook = catfile(catdir($repo->repo_path(),
'hooks'), 'sendemail-validate');
        foreach my $f (@files) {
                unless (-p $f) {
                        my $error;
-                       if ($use_hook) {
-                               $hook[1] = abs_path($f);
+                       if (-x $validate_hook) {
+                               my $target = abs_path($f);
                                my $cwd_save = cwd();
-                               chdir($repo->wc_path() or $repo->repo_path());
+                               chdir($repo->wc_path() or
$repo->repo_path()) or die "chdir: $!";
+                               # The hook needs a correct GIT_DIR.
+                               local $ENV{"GIT_DIR"} = $repo->repo_path();
                                $error = "rejected by sendemail-validate hook"
-                                       unless system(@hook) == 0;
-                               chdir($cwd_save);
+                                       if system($validate_hook, $target);
+                               chdir($cwd_save) or die "chdir: $!";
                        }
                        $error = validate_patch($f) unless $error;
                        $error and die sprintf(__("fatal: %s:
%s\nwarning: no patches were sent\n"),

Changes there:

 * use catdir instead of string concat, I don't know if we run
format-patch on any platform where this matters in theory (e.g. VMS I
think), but the file uses that API already, so continue using it.
 * Just make this more brief by moving the -x test into the loop,
we're sending E-Mail here, no need to optimize stat calls (you did ask
for style advice :)
* Check the return value of chdir & die appropriately
* localize GIT_DIR
* "die if system" is more idiomatic than "die unless system == 0"

Or actually just move this into a function:

@@ -629,23 +629,11 @@ if (@rev_list_opts) {
 @files = handle_backup_files(@files);

 if ($validate) {
-       my @hook = ($repo->repo_path().'/hooks/sendemail-validate', '');
-       my $use_hook = -x $hook[0];
-       if ($use_hook) {
-               # The hook needs a correct GIT_DIR.
-               $ENV{"GIT_DIR"} = $repo->repo_path();
-       }
+       my $validate_hook = catfile(catdir($repo->repo_path(),
'hooks'), 'sendemail-validate');
        foreach my $f (@files) {
                unless (-p $f) {
                        my $error;
-                       if ($use_hook) {
-                               $hook[1] = abs_path($f);
-                               my $cwd_save = cwd();
-                               chdir($repo->wc_path() or $repo->repo_path());
-                               $error = "rejected by sendemail-validate hook"
-                                       unless system(@hook) == 0;
-                               chdir($cwd_save);
-                       }
+                       $error = validate_via_hook($validate_hook, $f)
if -x $validate_hook;
                        $error = validate_patch($f) unless $error;
                        $error and die sprintf(__("fatal: %s:
%s\nwarning: no patches were sent\n"),
                                                  $f, $error);
@@ -1763,6 +1751,22 @@ sub validate_patch {
        return;
 }

+sub validate_via_hook {
+       my ($validate_hook, $patch) = @_;
+       my $error;
+
+       my $target = abs_path($patch);
+       my $cwd_save = cwd();
+       chdir($repo->wc_path() or $repo->repo_path()) or die "chdir: $!";
+       # The hook needs a correct GIT_DIR.
+       local $ENV{"GIT_DIR"} = $repo->repo_path();
+       $error = "rejected by sendemail-validate hook"
+               if system($validate_hook, $target);
+       chdir($cwd_save) or die "chdir: $!";
+
+       return $error;
+}
+
 sub handle_backup {
        my ($last, $lastlen, $file, $known_suffix) = @_;
        my ($suffix, $skip);

I wonder if we were designing this interface today whether whether the
existing behavior of  --validate wouldn't just be shipped as a
*.sample hook instead. There's also the caveat now that your hook
might be OK with really long lines, but the existing validate function
denies it, and there's no way to override that. I think a better way
to do this is:

        foreach my $f (@files) {
                unless (-p $f) {
-                       my $error;
-                       if ($use_hook) {
-                               $hook[1] = abs_path($f);
-                               my $cwd_save = cwd();
-                               chdir($repo->wc_path() or $repo->repo_path());
-                               $error = "rejected by sendemail-validate hook"
-                                       unless system(@hook) == 0;
-                               chdir($cwd_save);
-                       }
-                       $error = validate_patch($f) unless $error;
+                       my $error = -x $validate_hook
+                               ? validate_via_hook($validate_hook, $f)
+                               : validate_patch($f);

I.e. if you specify a validate hook it replaces the existing hardcoded behavior.

Also, just to check, is this new thing still consistent with the cwd
docs in githooks (see e.g. 501d3cd7b8).?

> ---
>  Documentation/git-send-email.txt |  1 +
>  Documentation/githooks.txt       |  8 ++++++++
>  git-send-email.perl              | 18 +++++++++++++++++-
>  t/t9001-send-email.sh            | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 9d66166f6..bb23b02ca 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -377,6 +377,7 @@ have been specified, in which case default to 'compose'.
>         Currently, validation means the following:
>  +
>  --
> +               *       Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
>                 *       Warn of patches that contain lines longer than 998 characters; this
>                         is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
>  --
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a56..b2514f4d4 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -447,6 +447,14 @@ rebase::
>  The commits are guaranteed to be listed in the order that they were
>  processed by rebase.
>
> +sendemail-validate
> +~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by 'git send-email'.  It takes a single parameter,
> +the name of the file that holds the e-mail to be sent.  Exiting with a
> +non-zero status causes 'git send-email' to abort before sending any
> +e-mails.
> +
>
>  GIT
>  ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eea0a517f..7de91ca7c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -27,6 +27,7 @@ use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
>  use Error qw(:try);
> +use Cwd qw(abs_path cwd);
>  use Git;
>  use Git::I18N;
>
> @@ -628,9 +629,24 @@ if (@rev_list_opts) {
>  @files = handle_backup_files(@files);
>
>  if ($validate) {
> +       my @hook = ($repo->repo_path().'/hooks/sendemail-validate', '');
> +       my $use_hook = -x $hook[0];
> +       if ($use_hook) {
> +               # The hook needs a correct GIT_DIR.
> +               $ENV{"GIT_DIR"} = $repo->repo_path();
> +       }
>         foreach my $f (@files) {
>                 unless (-p $f) {
> -                       my $error = validate_patch($f);
> +                       my $error;
> +                       if ($use_hook) {
> +                               $hook[1] = abs_path($f);
> +                               my $cwd_save = cwd();
> +                               chdir($repo->wc_path() or $repo->repo_path());
> +                               $error = "rejected by sendemail-validate hook"
> +                                       unless system(@hook) == 0;
> +                               chdir($cwd_save);
> +                       }
> +                       $error = validate_patch($f) unless $error;
>                         $error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
>                                                   $f, $error);
>                 }
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 60a80f60b..f3f238d40 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1913,4 +1913,44 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
>         test_cmp expected-list actual-list
>  '
>
> +test_expect_success $PREREQ 'invoke hook' '
> +       mkdir -p .git/hooks &&
> +
> +       write_script .git/hooks/sendemail-validate <<-\EOF &&
> +               # test that we have the correct environment variable, pwd, and
> +               # argument
> +               case "$GIT_DIR" in
> +                       *.git)
> +                               true
> +                               ;;
> +                       *)
> +                               false
> +                               ;;
> +               esac &&
> +               test -e 0001-add-master.patch &&
> +               grep "add master" "$1"
> +       EOF
> +
> +       mkdir subdir &&
> +       (
> +               # Test that it works even if we are not at the root of the
> +               # working tree
> +               cd subdir &&
> +               git send-email \
> +                       --from="Example <nobody@example.com>" \
> +                       --to=nobody@example.com \
> +                       --smtp-server="$(pwd)/../fake.sendmail" \
> +                       ../0001-add-master.patch &&
> +
> +               # Verify error message when a patch is rejected by the hook
> +               sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
> +               git send-email \
> +                       --from="Example <nobody@example.com>" \
> +                       --to=nobody@example.com \
> +                       --smtp-server="$(pwd)/../fake.sendmail" \
> +                       ../another.patch 2>err
> +               test_i18ngrep "rejected by sendemail-validate hook" err
> +       )
> +'
> +
>  test_done
> --
> 2.13.0.rc2.291.g57267f2277-goog
>
