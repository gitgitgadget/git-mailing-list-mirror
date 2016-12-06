Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322B020259
	for <e@80x24.org>; Tue,  6 Dec 2016 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbcLFIgs (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 03:36:48 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36570 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbcLFIgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 03:36:47 -0500
Received: by mail-qk0-f172.google.com with SMTP id n21so372736564qka.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 00:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bch7+8sOWcAXHVcZw0efq6qvNK04Do2+HHjrHGiYsDA=;
        b=SgkmbERX4Fobi/rSwT3aRb8RtseKSWQoh1O9MQmfl1Q2JQ0dB05lU3SRf72ajgYAnd
         2mDthjh90OCaq+970leVHZWZqmerfTo1snY9tbnbCQNY6gqEo7qr0SOi4ZtoSYFxYOH1
         WYy+hFxKlgjcloHg+yVQ3eqD0yP21DPEFXXr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bch7+8sOWcAXHVcZw0efq6qvNK04Do2+HHjrHGiYsDA=;
        b=LCaI9trV1ZoRzOCk359e1OrP0Dvpjd7qk/Zr7ul9kPDjTmYtVtoZL2fj3uPtDGLuC+
         tP/nMCB51w9qPbDbUYCSl+EK0U7AIt+RvIare12KjOil8dGhdpeQlsIuhanwj4c1QdAz
         hTzRWuQHKXp6Uk8SKwrP9zFRYOKdCy31kyQfZRIKxrYV9szK178cK5hivfIx2z6mZfQn
         iTrBV0U7OY8PqOxs/11ZtFbFaXfnr/fra48hywi3ZPD4/BGMOvr9x2X6HmOwkBAXzPqS
         v8xJG48v2758uVgiomDcYHGuWuN36LNEa/mzMPb2B8cEDxnViKJzNg2nmx/hkq/lq//X
         6qDQ==
X-Gm-Message-State: AKaTC002IZNHLm+4Z80SllHluSgC4wDt7ceZQnevvLa3gvsQ+OBlTNhMZ6cYfIo3IzzIA2Ad7YgTSgUXycrpdw==
X-Received: by 10.55.144.70 with SMTP id s67mr59329919qkd.290.1481013406430;
 Tue, 06 Dec 2016 00:36:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Tue, 6 Dec 2016 00:36:46 -0800 (PST)
In-Reply-To: <01020158d1de0e71-ac079bb9-bc7d-4fb7-9ff7-60fd6955116b-000000@eu-west-1.amazonses.com>
References: <01020158d1de0e71-ac079bb9-bc7d-4fb7-9ff7-60fd6955116b-000000@eu-west-1.amazonses.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 6 Dec 2016 08:36:46 +0000
Message-ID: <CAE5ih79S+SFt-fsQ_2c4eXMankoXvoSE3zhxw39Y4XeQqQ9nMg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: add p4 shelf support
To:     Nuno Subtil <subtil@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 December 2016 at 02:02, Nuno Subtil <subtil@gmail.com> wrote:
> Extends the submit command to support shelving a commit instead of
> submitting it to p4 (similar to --prepare-p4-only).

Is this just the same as these two changes?

http://www.spinics.net/lists/git/msg290755.html
http://www.spinics.net/lists/git/msg291103.html

Thanks,
Luke

>
> Signed-off-by: Nuno Subtil <subtil@gmail.com>
> ---
>  git-p4.py | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..3c4be22 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1286,6 +1286,8 @@ def __init__(self):
>                  optparse.make_option("--export-labels", dest="exportLabels", action="store_true"),
>                  optparse.make_option("--dry-run", "-n", dest="dry_run", action="store_true"),
>                  optparse.make_option("--prepare-p4-only", dest="prepare_p4_only", action="store_true"),
> +                optparse.make_option("--shelve-only", dest="shelve_only", action="store_true", help="Create P4 shelf for first change that would be submitted (using a new CL)"),
> +                optparse.make_option("--shelve-cl", dest="shelve_cl", help="Replace shelf under existing CL number (previously shelved files will be deleted)"),
>                  optparse.make_option("--conflict", dest="conflict_behavior",
>                                       choices=self.conflict_behavior_choices),
>                  optparse.make_option("--branch", dest="branch"),
> @@ -1297,6 +1299,8 @@ def __init__(self):
>          self.preserveUser = gitConfigBool("git-p4.preserveUser")
>          self.dry_run = False
>          self.prepare_p4_only = False
> +        self.shelve_only = False
> +        self.shelve_cl = None
>          self.conflict_behavior = None
>          self.isWindows = (platform.system() == "Windows")
>          self.exportLabels = False
> @@ -1496,6 +1500,12 @@ def prepareSubmitTemplate(self):
>                  else:
>                      inFilesSection = False
>              else:
> +                if self.shelve_only and self.shelve_cl:
> +                    if line.startswith("Change:"):
> +                        line = "Change: %s\n" % self.shelve_cl
> +                    if line.startswith("Status:"):
> +                        line = "Status: pending\n"
> +
>                  if line.startswith("Files:"):
>                      inFilesSection = True
>
> @@ -1785,7 +1795,11 @@ def applyCommit(self, id):
>                  if self.isWindows:
>                      message = message.replace("\r\n", "\n")
>                  submitTemplate = message[:message.index(separatorLine)]
> -                p4_write_pipe(['submit', '-i'], submitTemplate)
> +
> +                if self.shelve_only:
> +                    p4_write_pipe(['shelve', '-i', '-r'], submitTemplate)
> +                else:
> +                    p4_write_pipe(['submit', '-i'], submitTemplate)
>
>                  if self.preserveUser:
>                      if p4User:
> @@ -1799,12 +1813,17 @@ def applyCommit(self, id):
>                  # new file.  This leaves it writable, which confuses p4.
>                  for f in pureRenameCopy:
>                      p4_sync(f, "-f")
> -                submitted = True
> +
> +                if not self.shelve_only:
> +                    submitted = True
>
>          finally:
>              # skip this patch
>              if not submitted:
> -                print "Submission cancelled, undoing p4 changes."
> +                if not self.shelve_only:
> +                    print "Submission cancelled, undoing p4 changes."
> +                else:
> +                    print "Change shelved, undoing p4 changes."
>                  for f in editedFiles:
>                      p4_revert(f)
>                  for f in filesToAdd:
> @@ -2034,9 +2053,13 @@ def run(self, args):
>              if ok:
>                  applied.append(commit)
>              else:
> -                if self.prepare_p4_only and i < last:
> -                    print "Processing only the first commit due to option" \
> -                          " --prepare-p4-only"
> +                if (self.prepare_p4_only or self.shelve_only) and i < last:
> +                    if self.prepare_p4_only:
> +                        print "Processing only the first commit due to option" \
> +                              " --prepare-p4-only"
> +                    else:
> +                        print "Processing only the first commit due to option" \
> +                              " --shelve-only"
>                      break
>                  if i < last:
>                      quit = False
> @@ -3638,6 +3661,7 @@ def printUsage(commands):
>      "debug" : P4Debug,
>      "submit" : P4Submit,
>      "commit" : P4Submit,
> +    "shelve" : P4Submit,
>      "sync" : P4Sync,
>      "rebase" : P4Rebase,
>      "clone" : P4Clone,
>
> --
> https://github.com/git/git/pull/309
