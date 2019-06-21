Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCF61F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUWb3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33422 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfFUWb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id i4so7920210otk.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QL0lveZTYgI6Ayo+iu4zJofXLHoHNFlFiRiHoJy0bL0=;
        b=M85AAz14miQFnT7ILTPx93FQGMTxlqu0tKBhd1w0K+zzHvTobtWj6lX5dGxJGcHMSX
         TfAI9fNKDzJwwVIGuyuOM27BAnS6ecgOIO6v90V1Uf2bETXE2r9OS7nkH3SXdC4vJoRt
         CN4087mbRGjAskHz5qFYurrYVdwAHKJ4Nj4YhEluLwfXd9DTr/g1GqJqYSQU121hVHiJ
         ECnkuC2j+ssktFpoXG7lYdImRo8L0VaNTZcfveSrAgLgitnBR36JLm3zRQnj7ZhJWN33
         CpNqzTU+CW3TdeE+MpsJgIMiohyTpaB70WsSLMInup8LQYQCwVJJ8WFAhoRBPfma/d9h
         9rLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QL0lveZTYgI6Ayo+iu4zJofXLHoHNFlFiRiHoJy0bL0=;
        b=RPML1kj5HeDp6qMxFqqQO7y9qQKgwap6HmcfuMsro7ZmkRSEbgOcbIeJBkv9Kh3UID
         /LugnuxVkFy30npu3QMkdvRk/QcYWz4kFFBU1qQ7npeX/l86gEzeuAKAe9MANI7OcaXc
         hikgNISyQhr/6zYKwviyE4i6zDv88IPr/flEWTF2VXJpa95hJ/RPPGJz7FOGgCtJYa4t
         0+toajgZt8IZrqlZvmg7abupjwX1VhYtU4pnuUY99hklapFrcQoio9l57MaCxtqgQw7s
         bRoPdS9alKS58uBeDvEoiT4wqdCDCRuvmn5V22JUeGVp9u1GJPtnv9flOxXv5fI9KzTI
         D/lw==
X-Gm-Message-State: APjAAAX6oaxpfPBA9HpoKo1VC4BHdE9zkUUhBVTF/1wZ3z254l12uXUI
        a8AsP78zdu8kRcKv01+9BypTBahB7oY=
X-Google-Smtp-Source: APXvYqyxAE36dl46P1wEp5em5v1J7gSGLlzG6Yvl7HTnfV2sA00lw4pXDZYoX4Gg5EjFGFV6qGspHA==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr70693663otc.27.1561156286298;
        Fri, 21 Jun 2019 15:31:26 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id t11sm1440454otq.13.2019.06.21.15.31.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/14] completion: add default options
Date:   Fri, 21 Jun 2019 17:31:06 -0500
Message-Id: <20190621223107.8022-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Versions of Git older than v2.17 don't know about
--git-completion-helper, so provide some defaults for them.

Also, some commands fail if there's no Git repository available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 97 +++++++++++++++++++++++++-
 t/t9902-completion.sh                  |  4 +-
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index d3ee6c7dc2..922ba5f925 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -377,6 +377,100 @@ else
 	unset $(compgen -v __gitcomp_builtin_)
 fi
=20
+__gitcomp_builtin_add_default=3D" --dry-run --verbose --interactive --patc=
h --edit --force --update --renormalize --intent-to-add --all --ignore-remo=
val --refresh --ignore-errors --ignore-missing --chmod=3D --no-dry-run -- -=
-no-verbose --no-interactive --no-patch --no-edit --no-force --no-update --=
no-renormalize --no-intent-to-add --no-all --no-ignore-removal --no-refresh=
 --no-ignore-errors --no-ignore-missing --no-chmod"
+__gitcomp_builtin_am_default=3D" --interactive --3way --quiet --signoff --=
utf8 --keep --keep-non-patch --message-id --keep-cr --no-keep-cr --scissors=
 --whitespace=3D --ignore-space-change --ignore-whitespace --directory=3D -=
-exclude=3D --include=3D --patch-format=3D --reject --resolvemsg=3D --conti=
nue --resolved --skip --abort --quit --show-current-patch --committer-date-=
is-author-date --ignore-date --rerere-autoupdate --gpg-sign -- --no-interac=
tive --no-3way --no-quiet --no-signoff --no-utf8 --no-keep --no-keep-non-pa=
tch --no-message-id --no-scissors --no-whitespace --no-ignore-space-change =
--no-ignore-whitespace --no-directory --no-exclude --no-include --no-patch-=
format --no-reject --no-resolvemsg --no-committer-date-is-author-date --no-=
ignore-date --no-rerere-autoupdate --no-gpg-sign"
+__gitcomp_builtin_apply_default=3D" --exclude=3D --include=3D --no-add --s=
tat --numstat --summary --check --index --intent-to-add --cached --apply --=
3way --build-fake-ancestor=3D --whitespace=3D --ignore-space-change --ignor=
e-whitespace --reverse --unidiff-zero --reject --allow-overlap --verbose --=
inaccurate-eof --recount --directory=3D --add -- --no-stat --no-numstat --n=
o-summary --no-check --no-index --no-intent-to-add --no-cached --no-apply -=
-no-3way --no-build-fake-ancestor --no-whitespace --no-ignore-space-change =
--no-ignore-whitespace --no-reverse --no-unidiff-zero --no-reject --no-allo=
w-overlap --no-verbose --no-inaccurate-eof --no-recount --no-directory"
+__gitcomp_builtin_archive_default=3D" --output=3D --remote=3D --exec=3D --=
no-output -- --no-remote --no-exec"
+__gitcomp_builtin_bisect__helper_default=3D" --next-all --write-terms --bi=
sect-clean-state --check-expected-revs --bisect-reset --bisect-write --chec=
k-and-set-terms --bisect-next-check --bisect-terms --bisect-start --no-chec=
kout --no-log --checkout --log"
+__gitcomp_builtin_blame_default=3D" --incremental --root --show-stats --pr=
ogress --score-debug --show-name --show-number --porcelain --line-porcelain=
 --show-email --color-lines --color-by-age --indent-heuristic --minimal --c=
ontents=3D --abbrev --no-incremental -- --no-root --no-show-stats --no-prog=
ress --no-score-debug --no-show-name --no-show-number --no-porcelain --no-l=
ine-porcelain --no-show-email --no-color-lines --no-color-by-age --no-minim=
al --no-contents --no-abbrev"
+__gitcomp_builtin_branch_default=3D" --verbose --quiet --track --set-upstr=
eam-to=3D --unset-upstream --color --remotes --contains --no-contains --abb=
rev --all --delete --move --copy --list --show-current --create-reflog --ed=
it-description --merged --no-merged --column --sort=3D --points-at=3D --ign=
ore-case --format=3D -- --no-verbose --no-quiet --no-track --no-set-upstrea=
m-to --no-unset-upstream --no-color --no-remotes --no-abbrev --no-all --no-=
delete --no-move --no-copy --no-list --no-show-current --no-create-reflog -=
-no-edit-description --no-column --no-points-at --no-ignore-case --no-forma=
t"
+__gitcomp_builtin_cat_file_default=3D" --textconv --filters --path=3D --al=
low-unknown-type --buffer --batch --batch-check --follow-symlinks --batch-a=
ll-objects --unordered --no-path -- --no-allow-unknown-type --no-buffer --n=
o-follow-symlinks --no-batch-all-objects --no-unordered"
+__gitcomp_builtin_check_attr_default=3D" --all --cached --stdin --no-all -=
- --no-cached --no-stdin"
+__gitcomp_builtin_check_ignore_default=3D" --quiet --verbose --stdin --non=
-matching --no-index --index -- --no-quiet --no-verbose --no-stdin --no-non=
-matching"
+__gitcomp_builtin_check_mailmap_default=3D" --stdin --no-stdin"
+__gitcomp_builtin_checkout_default=3D" --quiet --detach --track --orphan=
=3D --ours --theirs --merge --conflict=3D --patch --ignore-skip-worktree-bi=
ts --no-guess --ignore-other-worktrees --recurse-submodules --progress --ov=
erlay --guess -- --no-quiet --no-detach --no-track --no-orphan --no-merge -=
-no-conflict --no-patch --no-ignore-skip-worktree-bits --no-ignore-other-wo=
rktrees --no-recurse-submodules --no-progress --no-overlay"
+__gitcomp_builtin_checkout_index_default=3D" --all --force --quiet --no-cr=
eate --index --stdin --temp --prefix=3D --stage=3D --create -- --no-all --n=
o-force --no-quiet --no-index --no-stdin --no-temp --no-prefix"
+__gitcomp_builtin_cherry_default=3D" --abbrev --verbose --no-abbrev -- --n=
o-verbose"
+__gitcomp_builtin_cherry_pick_default=3D" --quit --continue --abort --clea=
nup=3D --no-commit --edit --signoff --mainline=3D --rerere-autoupdate --str=
ategy=3D --strategy-option=3D --gpg-sign --ff --allow-empty --allow-empty-m=
essage --keep-redundant-commits --commit -- --no-cleanup --no-edit --no-sig=
noff --no-mainline --no-rerere-autoupdate --no-strategy --no-strategy-optio=
n --no-gpg-sign --no-ff --no-allow-empty --no-allow-empty-message --no-keep=
-redundant-commits"
+__gitcomp_builtin_clean_default=3D" --quiet --dry-run --interactive --excl=
ude=3D --no-quiet -- --no-dry-run --no-interactive"
+__gitcomp_builtin_clone_default=3D" --verbose --quiet --progress --no-chec=
kout --bare --mirror --local --no-hardlinks --shared --recursive --recurse-=
submodules --jobs=3D --template=3D --reference=3D --reference-if-able=3D --=
dissociate --origin=3D --branch=3D --upload-pack=3D --depth=3D --shallow-si=
nce=3D --shallow-exclude=3D --single-branch --no-tags --shallow-submodules =
--separate-git-dir=3D --config=3D --server-option=3D --ipv4 --ipv6 --filter=
=3D --checkout --hardlinks --tags -- --no-verbose --no-quiet --no-progress =
--no-bare --no-mirror --no-local --no-shared --no-recursive --no-recurse-su=
bmodules --no-jobs --no-template --no-reference --no-reference-if-able --no=
-dissociate --no-origin --no-branch --no-upload-pack --no-depth --no-shallo=
w-since --no-shallow-exclude --no-single-branch --no-shallow-submodules --n=
o-separate-git-dir --no-config --no-server-option --no-ipv4 --no-ipv6 --no-=
filter"
+__gitcomp_builtin_column_default=3D" --command=3D --mode --raw-mode=3D --w=
idth=3D --indent=3D --nl=3D --padding=3D --no-command -- --no-mode --no-raw=
-mode --no-width --no-indent --no-nl --no-padding"
+__gitcomp_builtin_commit_default=3D" --quiet --verbose --file=3D --author=
=3D --date=3D --message=3D --reedit-message=3D --reuse-message=3D --fixup=
=3D --squash=3D --reset-author --signoff --template=3D --edit --cleanup=3D =
--status --gpg-sign --all --include --interactive --patch --only --no-verif=
y --dry-run --short --branch --ahead-behind --porcelain --long --null --ame=
nd --no-post-rewrite --untracked-files --verify --post-rewrite -- --no-quie=
t --no-verbose --no-file --no-author --no-date --no-message --no-reedit-mes=
sage --no-reuse-message --no-fixup --no-squash --no-reset-author --no-signo=
ff --no-template --no-edit --no-cleanup --no-status --no-gpg-sign --no-all =
--no-include --no-interactive --no-patch --no-only --no-dry-run --no-short =
--no-branch --no-ahead-behind --no-porcelain --no-long --no-null --no-amend=
 --no-untracked-files"
+__gitcomp_builtin_commit_graph_default=3D" --object-dir=3D --no-object-dir"
+__gitcomp_builtin_config_default=3D" --global --system --local --worktree =
--file=3D --blob=3D --get --get-all --get-regexp --get-urlmatch --replace-a=
ll --add --unset --unset-all --rename-section --remove-section --list --edi=
t --get-color --get-colorbool --type=3D --bool --int --bool-or-int --path -=
-expiry-date --null --name-only --includes --show-origin --default=3D --no-=
global -- --no-system --no-local --no-worktree --no-file --no-blob --no-get=
 --no-get-all --no-get-regexp --no-get-urlmatch --no-replace-all --no-add -=
-no-unset --no-unset-all --no-rename-section --no-remove-section --no-list =
--no-edit --no-get-color --no-get-colorbool --no-type --no-null --no-name-o=
nly --no-includes --no-show-origin --no-default"
+__gitcomp_builtin_count_objects_default=3D" --verbose --human-readable --n=
o-verbose -- --no-human-readable"
+__gitcomp_builtin_describe_default=3D" --contains --debug --all --tags --l=
ong --first-parent --abbrev --exact-match --candidates=3D --match=3D --excl=
ude=3D --always --dirty --broken --no-contains -- --no-debug --no-all --no-=
tags --no-long --no-first-parent --no-abbrev --no-exact-match --no-candidat=
es --no-match --no-exclude --no-always --no-dirty --no-broken"
+__gitcomp_builtin_difftool_default=3D" --gui --dir-diff --no-prompt --syml=
inks --tool=3D --tool-help --trust-exit-code --extcmd=3D --no-index -- --no=
-gui --no-dir-diff --no-symlinks --no-tool --no-tool-help --no-trust-exit-c=
ode --no-extcmd"
+__gitcomp_builtin_fast_export_default=3D" --progress=3D --signed-tags=3D -=
-tag-of-filtered-object=3D --export-marks=3D --import-marks=3D --fake-missi=
ng-tagger --full-tree --use-done-feature --no-data --refspec=3D --anonymize=
 --reference-excluded-parents --show-original-ids --data -- --no-progress -=
-no-signed-tags --no-tag-of-filtered-object --no-export-marks --no-import-m=
arks --no-fake-missing-tagger --no-full-tree --no-use-done-feature --no-ref=
spec --no-anonymize --no-reference-excluded-parents --no-show-original-ids"
+__gitcomp_builtin_fetch_default=3D" --verbose --quiet --all --append --upl=
oad-pack=3D --force --multiple --tags --jobs=3D --prune --prune-tags --recu=
rse-submodules --dry-run --keep --update-head-ok --progress --depth=3D --sh=
allow-since=3D --shallow-exclude=3D --deepen=3D --unshallow --update-shallo=
w --refmap=3D --server-option=3D --ipv4 --ipv6 --negotiation-tip=3D --filte=
r=3D --no-verbose -- --no-quiet --no-all --no-append --no-upload-pack --no-=
force --no-multiple --no-tags --no-jobs --no-prune --no-prune-tags --no-rec=
urse-submodules --no-dry-run --no-keep --no-update-head-ok --no-progress --=
no-depth --no-shallow-since --no-shallow-exclude --no-deepen --no-update-sh=
allow --no-server-option --no-ipv4 --no-ipv6 --no-negotiation-tip --no-filt=
er"
+__gitcomp_builtin_fmt_merge_msg_default=3D" --log --message=3D --file=3D -=
-no-log -- --no-message --no-file"
+__gitcomp_builtin_for_each_ref_default=3D" --shell --perl --python --tcl -=
-count=3D --format=3D --color --sort=3D --points-at=3D --merged --no-merged=
 --contains --no-contains --ignore-case -- --no-shell --no-perl --no-python=
 --no-tcl --no-count --no-format --no-color --no-points-at --no-ignore-case"
+__gitcomp_builtin_format_patch_default=3D" --numbered --no-numbered --sign=
off --stdout --cover-letter --numbered-files --suffix=3D --start-number=3D =
--reroll-count=3D --rfc --subject-prefix=3D --output-directory=3D --keep-su=
bject --no-binary --zero-commit --ignore-if-in-upstream --no-stat --add-hea=
der=3D --to=3D --cc=3D --from --in-reply-to=3D --attach --inline --thread -=
-signature=3D --base=3D --signature-file=3D --quiet --progress --interdiff=
=3D --range-diff=3D --creation-factor=3D --binary -- --no-numbered --no-sig=
noff --no-stdout --no-cover-letter --no-numbered-files --no-suffix --no-sta=
rt-number --no-reroll-count --no-zero-commit --no-ignore-if-in-upstream --n=
o-add-header --no-to --no-cc --no-from --no-in-reply-to --no-attach --no-th=
read --no-signature --no-base --no-signature-file --no-quiet --no-progress =
--no-interdiff --no-range-diff --no-creation-factor"
+__gitcomp_builtin_fsck_default=3D" --verbose --unreachable --dangling --ta=
gs --root --cache --reflogs --full --connectivity-only --strict --lost-foun=
d --progress --name-objects --no-verbose -- --no-unreachable --no-dangling =
--no-tags --no-root --no-cache --no-reflogs --no-full --no-connectivity-onl=
y --no-strict --no-lost-found --no-progress --no-name-objects"
+__gitcomp_builtin_fsck_objects_default=3D" --verbose --unreachable --dangl=
ing --tags --root --cache --reflogs --full --connectivity-only --strict --l=
ost-found --progress --name-objects --no-verbose -- --no-unreachable --no-d=
angling --no-tags --no-root --no-cache --no-reflogs --no-full --no-connecti=
vity-only --no-strict --no-lost-found --no-progress --no-name-objects"
+__gitcomp_builtin_gc_default=3D" --quiet --prune --aggressive --keep-large=
st-pack --no-quiet -- --no-prune --no-aggressive --no-keep-largest-pack"
+__gitcomp_builtin_grep_default=3D" --cached --no-index --untracked --exclu=
de-standard --recurse-submodules --invert-match --ignore-case --word-regexp=
 --text --textconv --recursive --max-depth=3D --extended-regexp --basic-reg=
exp --fixed-strings --perl-regexp --line-number --column --full-name --file=
s-with-matches --name-only --files-without-match --only-matching --count --=
color --break --heading --context=3D --before-context=3D --after-context=3D=
 --threads=3D --show-function --function-context --and --or --not --quiet -=
-all-match --index -- --no-cached --no-untracked --no-exclude-standard --no=
-recurse-submodules --no-invert-match --no-ignore-case --no-word-regexp --n=
o-text --no-textconv --no-recursive --no-extended-regexp --no-basic-regexp =
--no-fixed-strings --no-perl-regexp --no-line-number --no-column --no-full-=
name --no-files-with-matches --no-name-only --no-files-without-match --no-o=
nly-matching --no-count --no-color --no-break --no-heading --no-context --n=
o-before-context --no-after-context --no-threads --no-show-function --no-fu=
nction-context --no-or --no-quiet --no-all-match"
+__gitcomp_builtin_hash_object_default=3D" --stdin --stdin-paths --no-filte=
rs --literally --path=3D --filters -- --no-stdin --no-stdin-paths --no-lite=
rally --no-path"
+__gitcomp_builtin_help_default=3D" --all --guides --config --man --web --i=
nfo --verbose --no-all -- --no-guides --no-config --no-man --no-web --no-in=
fo --no-verbose"
+__gitcomp_builtin_init_default=3D" --template=3D --bare --shared --quiet -=
-separate-git-dir=3D --no-template -- --no-bare --no-quiet --no-separate-gi=
t-dir"
+__gitcomp_builtin_init_db_default=3D" --template=3D --bare --shared --quie=
t --separate-git-dir=3D --no-template -- --no-bare --no-quiet --no-separate=
-git-dir"
+__gitcomp_builtin_interpret_trailers_default=3D" --in-place --trim-empty -=
-where=3D --if-exists=3D --if-missing=3D --only-trailers --only-input --unf=
old --parse --no-divider --trailer=3D --divider -- --no-in-place --no-trim-=
empty --no-where --no-if-exists --no-if-missing --no-only-trailers --no-onl=
y-input --no-unfold --no-trailer"
+__gitcomp_builtin_log_default=3D" --quiet --source --use-mailmap --decorat=
e-refs=3D --decorate-refs-exclude=3D --decorate --no-quiet -- --no-source -=
-no-use-mailmap --no-decorate-refs --no-decorate-refs-exclude --no-decorate"
+__gitcomp_builtin_ls_files_default=3D" --cached --deleted --modified --oth=
ers --ignored --stage --killed --directory --eol --empty-directory --unmerg=
ed --resolve-undo --exclude=3D --exclude-from=3D --exclude-per-directory=3D=
 --exclude-standard --full-name --recurse-submodules --error-unmatch --with=
-tree=3D --abbrev --debug --no-cached -- --no-deleted --no-modified --no-ot=
hers --no-ignored --no-stage --no-killed --no-directory --no-eol --no-empty=
-directory --no-unmerged --no-resolve-undo --no-exclude-per-directory --no-=
recurse-submodules --no-error-unmatch --no-with-tree --no-abbrev --no-debug"
+__gitcomp_builtin_ls_remote_default=3D" --quiet --upload-pack=3D --tags --=
heads --refs --get-url --sort=3D --symref --server-option=3D --no-quiet -- =
--no-upload-pack --no-tags --no-heads --no-refs --no-get-url --no-symref --=
no-server-option"
+__gitcomp_builtin_ls_tree_default=3D" --long --name-only --name-status --f=
ull-name --full-tree --abbrev --no-long -- --no-name-only --no-name-status =
--no-full-name --no-full-tree --no-abbrev"
+__gitcomp_builtin_merge_default=3D" --stat --summary --log --squash --comm=
it --edit --cleanup=3D --ff --ff-only --rerere-autoupdate --verify-signatur=
es --strategy=3D --strategy-option=3D --message=3D --file --verbose --quiet=
 --abort --continue --allow-unrelated-histories --progress --gpg-sign --ove=
rwrite-ignore --signoff --verify --no-stat -- --no-summary --no-log --no-sq=
uash --no-commit --no-edit --no-cleanup --no-ff --no-rerere-autoupdate --no=
-verify-signatures --no-strategy --no-strategy-option --no-message --no-ver=
bose --no-quiet --no-abort --no-continue --no-allow-unrelated-histories --n=
o-progress --no-gpg-sign --no-overwrite-ignore --no-signoff --no-verify"
+__gitcomp_builtin_merge_base_default=3D" --all --octopus --independent --i=
s-ancestor --fork-point --no-all"
+__gitcomp_builtin_merge_file_default=3D" --stdout --diff3 --ours --theirs =
--union --marker-size=3D --quiet --no-stdout -- --no-diff3 --no-ours --no-t=
heirs --no-union --no-marker-size --no-quiet"
+__gitcomp_builtin_mktree_default=3D" --missing --batch --no-missing -- --n=
o-batch"
+__gitcomp_builtin_multi_pack_index_default=3D" --object-dir=3D --no-object=
-dir"
+__gitcomp_builtin_mv_default=3D" --verbose --dry-run --no-verbose -- --no-=
dry-run"
+__gitcomp_builtin_name_rev_default=3D" --name-only --tags --refs=3D --excl=
ude=3D --all --stdin --undefined --always --no-name-only -- --no-tags --no-=
refs --no-exclude --no-all --no-stdin --no-undefined --no-always"
+__gitcomp_builtin_notes_default=3D" --ref=3D --no-ref"
+__gitcomp_builtin_pack_objects_default=3D" --quiet --progress --all-progre=
ss --all-progress-implied --index-version=3D --max-pack-size=3D --local --i=
ncremental --window=3D --window-memory=3D --depth=3D --reuse-delta --reuse-=
object --delta-base-offset --threads=3D --non-empty --revs --unpacked --all=
 --reflog --indexed-objects --stdout --include-tag --keep-unreachable --pac=
k-loose-unreachable --unpack-unreachable --sparse --thin --shallow --honor-=
pack-keep --keep-pack=3D --compression=3D --keep-true-parents --use-bitmap-=
index --write-bitmap-index --filter=3D --missing=3D --exclude-promisor-obje=
cts --delta-islands --no-quiet -- --no-progress --no-all-progress --no-all-=
progress-implied --no-local --no-incremental --no-window --no-depth --no-re=
use-delta --no-reuse-object --no-delta-base-offset --no-threads --no-non-em=
pty --no-revs --no-stdout --no-include-tag --no-keep-unreachable --no-pack-=
loose-unreachable --no-unpack-unreachable --no-sparse --no-thin --no-shallo=
w --no-honor-pack-keep --no-keep-pack --no-compression --no-keep-true-paren=
ts --no-use-bitmap-index --no-write-bitmap-index --no-filter --no-exclude-p=
romisor-objects --no-delta-islands"
+__gitcomp_builtin_pack_refs_default=3D" --all --prune --no-all -- --no-pru=
ne"
+__gitcomp_builtin_pickaxe_default=3D" --incremental --root --show-stats --=
progress --score-debug --show-name --show-number --porcelain --line-porcela=
in --show-email --color-lines --color-by-age --indent-heuristic --minimal -=
-contents=3D --abbrev --no-incremental -- --no-root --no-show-stats --no-pr=
ogress --no-score-debug --no-show-name --no-show-number --no-porcelain --no=
-line-porcelain --no-show-email --no-color-lines --no-color-by-age --no-min=
imal --no-contents --no-abbrev"
+__gitcomp_builtin_prune_default=3D" --dry-run --verbose --progress --expir=
e=3D --exclude-promisor-objects --no-dry-run -- --no-verbose --no-progress =
--no-expire --no-exclude-promisor-objects"
+__gitcomp_builtin_prune_packed_default=3D" --dry-run --quiet --no-dry-run =
-- --no-quiet"
+__gitcomp_builtin_pull_default=3D" --verbose --quiet --progress --recurse-=
submodules --rebase --stat --log --signoff --squash --commit --edit --clean=
up=3D --ff --ff-only --verify-signatures --autostash --strategy=3D --strate=
gy-option=3D --gpg-sign --allow-unrelated-histories --all --append --upload=
-pack=3D --force --tags --prune --jobs --dry-run --keep --depth=3D --unshal=
low --update-shallow --refmap=3D --ipv4 --ipv6 --no-verbose -- --no-quiet -=
-no-progress --no-recurse-submodules --no-rebase --no-stat --no-log --no-si=
gnoff --no-squash --no-commit --no-edit --no-cleanup --no-ff --no-verify-si=
gnatures --no-autostash --no-strategy --no-strategy-option --no-gpg-sign --=
no-allow-unrelated-histories --no-all --no-append --no-upload-pack --no-for=
ce --no-tags --no-prune --no-jobs --no-dry-run --no-keep --no-depth --no-up=
date-shallow --no-ipv4 --no-ipv6"
+__gitcomp_builtin_push_default=3D" --verbose --quiet --repo=3D --all --mir=
ror --delete --tags --dry-run --porcelain --force --force-with-lease --recu=
rse-submodules --receive-pack=3D --exec=3D --set-upstream --progress --prun=
e --no-verify --follow-tags --signed --atomic --push-option=3D --ipv4 --ipv=
6 --verify -- --no-verbose --no-quiet --no-repo --no-all --no-mirror --no-d=
elete --no-tags --no-dry-run --no-porcelain --no-force --no-force-with-leas=
e --no-recurse-submodules --no-receive-pack --no-exec --no-set-upstream --n=
o-progress --no-prune --no-follow-tags --no-signed --no-atomic --no-push-op=
tion --no-ipv4 --no-ipv6"
+__gitcomp_builtin_range_diff_default=3D" --creation-factor=3D --no-dual-co=
lor --patch --no-patch --unified --function-context --raw --patch-with-raw =
--patch-with-stat --numstat --shortstat --dirstat --cumulative --dirstat-by=
-file --check --summary --name-only --name-status --stat --stat-width=3D --=
stat-name-width=3D --stat-graph-width=3D --stat-count=3D --compact-summary =
--binary --full-index --color --ws-error-highlight=3D --abbrev --src-prefix=
=3D --dst-prefix=3D --line-prefix=3D --no-prefix --inter-hunk-context=3D --=
output-indicator-new=3D --output-indicator-old=3D --output-indicator-contex=
t=3D --break-rewrites --find-renames --irreversible-delete --find-copies --=
find-copies-harder --no-renames --rename-empty --follow --minimal --ignore-=
all-space --ignore-space-change --ignore-space-at-eol --ignore-cr-at-eol --=
ignore-blank-lines --indent-heuristic --patience --histogram --diff-algorit=
hm=3D --anchored=3D --word-diff --word-diff-regex=3D --color-words --color-=
moved --color-moved-ws=3D --relative --text --exit-code --quiet --ext-diff =
--textconv --ignore-submodules --submodule --ita-invisible-in-index --ita-v=
isible-in-index --pickaxe-all --pickaxe-regex --find-object=3D --diff-filte=
r=3D --output=3D --dual-color -- --no-creation-factor --no-function-context=
 --no-compact-summary --no-full-index --no-color --no-abbrev --no-find-copi=
es-harder --no-rename-empty --no-follow --no-minimal --no-indent-heuristic =
--no-color-moved --no-color-moved-ws --no-text --no-exit-code --no-quiet --=
no-ext-diff --no-textconv"
+__gitcomp_builtin_read_tree_default=3D" --index-output=3D --empty --verbos=
e --trivial --aggressive --reset --prefix=3D --exclude-per-directory=3D --d=
ry-run --no-sparse-checkout --debug-unpack --recurse-submodules --quiet --s=
parse-checkout -- --no-empty --no-verbose --no-trivial --no-aggressive --no=
-reset --no-dry-run --no-debug-unpack --no-recurse-submodules --no-quiet"
+__gitcomp_builtin_rebase_default=3D" --onto=3D --no-verify --quiet --verbo=
se --no-stat --signoff --ignore-whitespace --committer-date-is-author-date =
--ignore-date --whitespace=3D --force-rebase --no-ff --continue --skip --ab=
ort --quit --edit-todo --show-current-patch --merge --interactive --preserv=
e-merges --rerere-autoupdate --keep-empty --autosquash --gpg-sign --autosta=
sh --exec=3D --allow-empty-message --rebase-merges --fork-point --strategy=
=3D --strategy-option=3D --root --reschedule-failed-exec --verify --stat --=
ff -- --no-onto --no-quiet --no-verbose --no-signoff --no-ignore-whitespace=
 --no-committer-date-is-author-date --no-ignore-date --no-whitespace --no-f=
orce-rebase --no-preserve-merges --no-rerere-autoupdate --no-keep-empty --n=
o-autosquash --no-gpg-sign --no-autostash --no-exec --no-allow-empty-messag=
e --no-rebase-merges --no-fork-point --no-strategy --no-strategy-option --n=
o-root --no-reschedule-failed-exec"
+__gitcomp_builtin_rebase__interactive_default=3D" --ff --keep-empty --allo=
w-empty-message --rebase-merges --rebase-cousins --autosquash --signoff --v=
erbose --continue --skip --edit-todo --show-current-patch --shorten-ids --e=
xpand-ids --check-todo-list --rearrange-squash --add-exec-commands --onto=
=3D --restrict-revision=3D --squash-onto=3D --upstream=3D --head-name=3D --=
gpg-sign --strategy=3D --strategy-opts=3D --switch-to=3D --onto-name=3D --c=
md=3D --rerere-autoupdate --reschedule-failed-exec --no-ff -- --no-keep-emp=
ty --no-allow-empty-message --no-rebase-merges --no-rebase-cousins --no-aut=
osquash --no-signoff --no-verbose --no-head-name --no-gpg-sign --no-strateg=
y --no-strategy-opts --no-switch-to --no-onto-name --no-cmd --no-rerere-aut=
oupdate --no-reschedule-failed-exec"
+__gitcomp_builtin_receive_pack_default=3D" --quiet --no-quiet"
+__gitcomp_builtin_reflog_default=3D" --quiet --source --use-mailmap --deco=
rate-refs=3D --decorate-refs-exclude=3D --decorate --no-quiet -- --no-sourc=
e --no-use-mailmap --no-decorate-refs --no-decorate-refs-exclude --no-decor=
ate"
+__gitcomp_builtin_remote_default=3D" --verbose --no-verbose"
+__gitcomp_builtin_repack_default=3D" --quiet --local --write-bitmap-index =
--delta-islands --unpack-unreachable=3D --keep-unreachable --window=3D --wi=
ndow-memory=3D --depth=3D --threads=3D --max-pack-size=3D --pack-kept-objec=
ts --keep-pack=3D --no-quiet -- --no-local --no-write-bitmap-index --no-del=
ta-islands --no-unpack-unreachable --no-keep-unreachable --no-window --no-w=
indow-memory --no-depth --no-threads --no-max-pack-size --no-pack-kept-obje=
cts --no-keep-pack"
+__gitcomp_builtin_replace_default=3D" --list --delete --edit --graft --con=
vert-graft-file --raw --format=3D --no-raw -- --no-format"
+__gitcomp_builtin_rerere_default=3D" --rerere-autoupdate --no-rerere-autou=
pdate"
+__gitcomp_builtin_reset_default=3D" --quiet --mixed --soft --hard --merge =
--keep --recurse-submodules --patch --intent-to-add --no-quiet -- --no-mixe=
d --no-soft --no-hard --no-merge --no-keep --no-recurse-submodules --no-pat=
ch --no-intent-to-add"
+__gitcomp_builtin_revert_default=3D" --quit --continue --abort --cleanup=
=3D --no-commit --edit --signoff --mainline=3D --rerere-autoupdate --strate=
gy=3D --strategy-option=3D --gpg-sign --commit -- --no-cleanup --no-edit --=
no-signoff --no-mainline --no-rerere-autoupdate --no-strategy --no-strategy=
-option --no-gpg-sign"
+__gitcomp_builtin_rm_default=3D" --dry-run --quiet --cached --ignore-unmat=
ch --no-dry-run -- --no-quiet --no-cached --no-ignore-unmatch"
+__gitcomp_builtin_send_pack_default=3D" --verbose --quiet --receive-pack=
=3D --exec=3D --remote=3D --all --dry-run --mirror --force --signed --push-=
option=3D --progress --thin --atomic --stateless-rpc --stdin --helper-statu=
s --force-with-lease --no-verbose -- --no-quiet --no-receive-pack --no-exec=
 --no-remote --no-all --no-dry-run --no-mirror --no-force --no-signed --no-=
push-option --no-progress --no-thin --no-atomic --no-stateless-rpc --no-std=
in --no-helper-status --no-force-with-lease"
+__gitcomp_builtin_shortlog_default=3D" --committer --numbered --summary --=
email --no-committer -- --no-numbered --no-summary --no-email"
+__gitcomp_builtin_show_default=3D" --quiet --source --use-mailmap --decora=
te-refs=3D --decorate-refs-exclude=3D --decorate --no-quiet -- --no-source =
--no-use-mailmap --no-decorate-refs --no-decorate-refs-exclude --no-decorat=
e"
+__gitcomp_builtin_show_branch_default=3D" --all --remotes --color --more -=
-list --no-name --current --sha1-name --merge-base --independent --topo-ord=
er --topics --sparse --date-order --reflog --name -- --no-all --no-remotes =
--no-color --no-more --no-list --no-current --no-sha1-name --no-merge-base =
--no-independent --no-topo-order --no-topics --no-sparse --no-date-order"
+__gitcomp_builtin_show_index_default=3D""
+__gitcomp_builtin_show_ref_default=3D" --tags --heads --verify --head --de=
reference --hash --abbrev --quiet --exclude-existing --no-tags -- --no-head=
s --no-verify --no-head --no-dereference --no-hash --no-abbrev --no-quiet"
+__gitcomp_builtin_stage_default=3D" --dry-run --verbose --interactive --pa=
tch --edit --force --update --renormalize --intent-to-add --all --ignore-re=
moval --refresh --ignore-errors --ignore-missing --chmod=3D --no-dry-run --=
 --no-verbose --no-interactive --no-patch --no-edit --no-force --no-update =
--no-renormalize --no-intent-to-add --no-all --no-ignore-removal --no-refre=
sh --no-ignore-errors --no-ignore-missing --no-chmod"
+__gitcomp_builtin_stash_default=3D""
+__gitcomp_builtin_status_default=3D" --verbose --short --branch --show-sta=
sh --ahead-behind --porcelain --long --null --untracked-files --ignored --i=
gnore-submodules --column --no-renames --find-renames --renames -- --no-ver=
bose --no-short --no-branch --no-show-stash --no-ahead-behind --no-porcelai=
n --no-long --no-null --no-untracked-files --no-ignored --no-ignore-submodu=
les --no-column"
+__gitcomp_builtin_stripspace_default=3D" --strip-comments --comment-lines"
+__gitcomp_builtin_symbolic_ref_default=3D" --quiet --delete --short --no-q=
uiet -- --no-delete --no-short"
+__gitcomp_builtin_tag_default=3D" --list --delete --verify --annotate --me=
ssage=3D --file=3D --edit --sign --cleanup=3D --local-user=3D --force --cre=
ate-reflog --column --contains --no-contains --merged --no-merged --sort=3D=
 --points-at --format=3D --color --ignore-case -- --no-annotate --no-file -=
-no-edit --no-sign --no-cleanup --no-local-user --no-force --no-create-refl=
og --no-column --no-points-at --no-format --no-color --no-ignore-case"
+__gitcomp_builtin_update_index_default=3D" --ignore-submodules --add --rep=
lace --remove --unmerged --refresh --really-refresh --cacheinfo --chmod=3D =
--assume-unchanged --no-assume-unchanged --skip-worktree --no-skip-worktree=
 --info-only --force-remove --stdin --index-info --unresolve --again --igno=
re-missing --verbose --clear-resolve-undo --index-version=3D --split-index =
--untracked-cache --test-untracked-cache --force-untracked-cache --force-wr=
ite-index --fsmonitor --fsmonitor-valid --no-fsmonitor-valid -- --no-ignore=
-submodules --no-add --no-replace --no-remove --no-unmerged --no-info-only =
--no-force-remove --no-ignore-missing --no-verbose --no-index-version --no-=
split-index --no-untracked-cache --no-test-untracked-cache --no-force-untra=
cked-cache --no-force-write-index --no-fsmonitor"
+__gitcomp_builtin_update_ref_default=3D" --no-deref --stdin --create-reflo=
g --deref -- --no-stdin --no-create-reflog"
+__gitcomp_builtin_update_server_info_default=3D" --force --no-force"
+__gitcomp_builtin_upload_pack_default=3D" --stateless-rpc --advertise-refs=
 --strict --timeout=3D --no-stateless-rpc -- --no-advertise-refs --no-stric=
t --no-timeout"
+__gitcomp_builtin_verify_commit_default=3D" --verbose --raw --no-verbose -=
- --no-raw"
+__gitcomp_builtin_verify_pack_default=3D" --verbose --stat-only --no-verbo=
se -- --no-stat-only"
+__gitcomp_builtin_verify_tag_default=3D" --verbose --raw --format=3D --no-=
verbose -- --no-raw --no-format"
+__gitcomp_builtin_version_default=3D" --build-options --no-build-options"
+__gitcomp_builtin_whatchanged_default=3D" --quiet --source --use-mailmap -=
-decorate-refs=3D --decorate-refs-exclude=3D --decorate --no-quiet -- --no-=
source --no-use-mailmap --no-decorate-refs --no-decorate-refs-exclude --no-=
decorate"
+__gitcomp_builtin_write_tree_default=3D" --missing-ok --prefix=3D --no-mis=
sing-ok -- --no-prefix"
+__gitcomp_builtin_send_email_default=3D" --numbered --no-numbered --signof=
f --stdout --cover-letter --numbered-files --suffix=3D --start-number=3D --=
reroll-count=3D --rfc --subject-prefix=3D --output-directory=3D --keep-subj=
ect --no-binary --zero-commit --ignore-if-in-upstream --no-stat --add-heade=
r=3D --to=3D --cc=3D --from --in-reply-to=3D --attach --inline --thread --s=
ignature=3D --base=3D --signature-file=3D --quiet --progress --interdiff=3D=
 --range-diff=3D --creation-factor=3D --binary -- --no-numbered --no-signof=
f --no-stdout --no-cover-letter --no-numbered-files --no-suffix --no-start-=
number --no-reroll-count --no-zero-commit --no-ignore-if-in-upstream --no-a=
dd-header --no-to --no-cc --no-from --no-in-reply-to --no-attach --no-threa=
d --no-signature --no-base --no-signature-file --no-quiet --no-progress --n=
o-interdiff --no-range-diff --no-creation-factor"
+
 # This function is equivalent to
 #
 #    __gitcomp "$(git xxx --git-completion-helper) ..."
@@ -400,7 +494,8 @@ __gitcomp_builtin ()
 	if [ -z "$options" ]; then
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
-		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) "
+		options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) " ||
+			eval "options=3D\" $incl \$${var}_default \""
 		for i in $excl; do
 			options=3D"${options/ $i / }"
 		done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3dbfef6960..14598bfbec 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1428,7 +1428,7 @@ test_expect_success 'double dash "git" itself' '
 	EOF
 '
=20
-test_expect_failure 'double dash "git checkout"' '
+test_expect_success 'double dash "git checkout"' '
 	offgit &&
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
@@ -1561,7 +1561,7 @@ test_expect_success 'complete tree filename with meta=
characters' '
 	EOF
 '
=20
-test_expect_failure PERL 'send-email' '
+test_expect_success PERL 'send-email' '
 	test_completion "git send-email ma" "master " &&
 	offgit &&
 	test_completion "git send-email --cov" "--cover-letter "
--=20
2.22.0

