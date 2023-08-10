Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5AC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjHJUjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjHJUjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819A1AA
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so1674824a12.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699989; x=1692304789;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXEjG8BgHTOItE+3HfRYfTYm23ynOeUqF+p8wAONBpE=;
        b=RW51lGXh81yrL19dI7IHWL0qKrPm+Q89tV1MqWtXZiMBmKXvKdFzbN4qwxnEy1CpOD
         lP0rL96Pry4n+ad8Y8wuz2TWyWKpGcKkK2V6kw2mdsZZwzgf38YB+bB32F3Kgb9MZLAv
         IR0NGLE6HcRc63t2U4o5UCfTHiQfQSa3wRZoT610sLV3/uRGxW0GNYxsiP0hzpbwhbIM
         /eZMUaDfgngGCeCPY/YGflZIYbGaUs4srmx5OsjAnLJ26UjH2vFUCZ9VWI+FnkLuKM82
         OQMeKK8O4xX0MJ12v6kJROyuAatE+Qralm89zWAeJO5DN2oVdrARC4XuKqcGpL5P0rq7
         4ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699989; x=1692304789;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXEjG8BgHTOItE+3HfRYfTYm23ynOeUqF+p8wAONBpE=;
        b=P6p7c2oEXZUZoc8ZNN3itEIazHES0RHZbSayQzv0s+O0gRwC7d2goHwFgJhKE8blwk
         pUgUbhkKJ6+1Opddj8g4Lf5SVHaxkocNsNt82W+9tiyFnQagyJQZ+pV82BfUU0B4HSrF
         dDv38yNVYN+UqKtd64gf4TCGEdkm3/OvZs67gk7a8nmZmdPW3PBYaJgHxroltln5pssC
         cMrNublG0lF+yXFKIwbwg/4lRsRrtRsqXqm3eyX7PO6KCvW1CYVy19n4naUzCv4R01RO
         Z7YPfVOBQcui4zYpVoPLPbTWBP2UAdiZq3TgbWrvmbl72BTZPrgm8yQEMP1wW6kvQ2bW
         QnNA==
X-Gm-Message-State: AOJu0Yx36J1bsJGxfpRdq93CJ1H+avTl064cJ7cxyxnCXoFUTD4MokrD
        yOUf/ILFzK2ZFgRIs5vBDW4JExBPqMo=
X-Google-Smtp-Source: AGHT+IF/tBzbKgE1tA7H2zY+o479CCCOpLdL8kireCyC2kVlZ0FYh6geZiCIkrD1/hCQ4O6+i4HSmA==
X-Received: by 2002:a05:6402:790:b0:523:3e5d:8aa2 with SMTP id d16-20020a056402079000b005233e5d8aa2mr86638edy.14.1691699989214;
        Thu, 10 Aug 2023 13:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7c68d000000b005231e1780aasm1196998edq.91.2023.08.10.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:48 -0700 (PDT)
Message-ID: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:39 +0000
Subject: [PATCH v2 0/8] maintenance: schedule maintenance on a random minute
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we initially created background maintenance -- with its hourly, daily,
and weekly schedules -- we considered the effects of all clients launching
fetches to the server every hour on the hour. The worry of DDoSing server
hosts was noted, but left as something we would consider for a future
update.

As background maintenance has gained more adoption over the past three
years, our worries about DDoSing the big Git hosts has been unfounded. Those
systems, especially those serving public repositories, are already resilient
to thundering herds of much smaller scale.

However, sometimes organizations spin up specific custom server
infrastructure either in addition to or on top of their Git host. Some of
these technologies are built for a different range of scale, and can hit
concurrency limits sooner. Organizations with such custom infrastructures
are more likely to recommend tools like scalar which furthers their adoption
of background maintenance.

This series attempts to help by spreading out background maintenance to a
random minute of the hour. This minute is selected during git maintenance
start, and the same minute applies to each of the three schedules.

This isn't a full solution to this problem, as the custom infrastructure
needs to be resilient to bursts of activity, but at least this will help
somewhat.

Each of the integrated schedulers needs a different way of integrating the
random minute. The most problematic is systemd, since our integration had a
clever use of templates to write one schedule that inserted the hourly,
daily, and weekly schedules as a string into the template. This needs some
refactoring before the custom minute could be inserted.

For the most part, each scheduler's integration is relatively simple. That
is, until we get to the systemd integration. That integration made use of a
clever templating technique that is no longer possible when making this
adjustment.

Patches 5-7 involve systemd, though patch 5 is just a move of code (without
edits) to make the diff in patch 6 somewhat simpler (it's still complicated
due to templating changes). Patch 7 fixes an issue where the systemd
schedules overlap.

Patch 8 fixes an issue where config changes persist even if the scheduler
fails to initialize. Thanks for noticing, Philip!


Updates in version 2
====================

 * get_random_minute() now uses a new helper, git_rand(), which is itself a
   wrapper around csprng_bytes() for easier use.
 * get_random_minute() also had an error in its use of getenv() which is now
   fixed.
 * Patch 6 has a lot of new changes, including:
   * Keeping the .service template.
   * Deleting the old .timer template when safe to do so.
 * Patch 7 fixes the schedule overlap in systemd.
 * Patch 8 fixes the issue where 'mainteancne.auto=false' would persist even
   if the scheduler failed to initialize.

Thanks, -Stolee

Derrick Stolee (8):
  maintenance: add get_random_minute()
  maintenance: use random minute in launchctl scheduler
  maintenance: use random minute in Windows scheduler
  maintenance: use random minute in cron scheduler
  maintenance: swap method locations
  maintenance: use random minute in systemd scheduler
  maintenance: fix systemd schedule overlaps
  maintenance: update schedule before config

 builtin/gc.c           | 291 +++++++++++++++++++++++++++++------------
 t/t7900-maintenance.sh |  28 +++-
 wrapper.c              |  10 ++
 wrapper.h              |   6 +
 4 files changed, 250 insertions(+), 85 deletions(-)


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1567%2Fderrickstolee%2Fmaintenance-random-minute-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1567/derrickstolee/maintenance-random-minute-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1567

Range-diff vs v1:

 1:  fefdaa94579 ! 1:  edc08023ed5 maintenance: add get_random_minute()
     @@ Commit message
          integrations with this method do not yet exist, but will follow in
          future changes.
      
     +    To avoid multiple sources of randomness in the Git codebase, create a
     +    new helper function, git_rand(), that returns a random uint32_t. This is
     +    similar to how rand() returns a random nonnegative value, except it is
     +    based on csprng_bytes() which is cryptographic and will return values
     +    larger than RAND_MAX.
     +
          One thing that is important for testability is that we notice when we
          are under a test scenario and return a predictable result. The schedules
          themselves are not checked for this value, but at least one launchctl
     @@ builtin/gc.c: static int get_schedule_cmd(const char **cmd, int *is_available)
      +MAYBE_UNUSED
      +static int get_random_minute(void)
      +{
     -+	static int random_initialized = 0;
     -+
      +	/* Use a static value when under tests. */
     -+	if (!getenv("GIT_TEST_MAINTENANCE_SCHEDULER"))
     ++	if (getenv("GIT_TEST_MAINT_SCHEDULER"))
      +		return 13;
      +
     -+	if (!random_initialized) {
     -+		srand((unsigned int)getpid());
     -+		random_initialized = 1;
     -+	}
     -+
     -+	return rand() % 60;
     ++	return git_rand() % 60;
      +}
      +
       static int is_launchctl_available(void)
       {
       	const char *cmd = "launchctl";
     +
     + ## wrapper.c ##
     +@@ wrapper.c: int csprng_bytes(void *buf, size_t len)
     + 	return 0;
     + #endif
     + }
     ++
     ++uint32_t git_rand(void)
     ++{
     ++	uint32_t result;
     ++
     ++	if (csprng_bytes(&result, sizeof(result)) < 0)
     ++		die(_("unable to get random bytes"));
     ++
     ++	return result;
     ++}
     +
     + ## wrapper.h ##
     +@@ wrapper.h: void sleep_millisec(int millisec);
     +  */
     + int csprng_bytes(void *buf, size_t len);
     + 
     ++/*
     ++ * Returns a random uint32_t, uniformly distributed across all possible
     ++ * values.
     ++ */
     ++uint32_t git_rand(void);
     ++
     + #endif /* WRAPPER_H */
 2:  babf62ec6d5 ! 2:  72ec86f2f88 maintenance: use random minute in launchctl scheduler
     @@ builtin/gc.c: static int get_schedule_cmd(const char **cmd, int *is_available)
      -MAYBE_UNUSED
       static int get_random_minute(void)
       {
     - 	static int random_initialized = 0;
     + 	/* Use a static value when under tests. */
      @@ builtin/gc.c: static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
       	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
       	struct stat st;
 3:  1048dff1d3a = 3:  f6d9c4f3b02 maintenance: use random minute in Windows scheduler
 4:  3ef3cf0861f = 4:  b291e6f7aec maintenance: use random minute in cron scheduler
 5:  37f96b6b619 ! 5:  88610437b4b maintenance: swap method locations
     @@ Commit message
          systemd_timer_enable_unit() method, so we can write a specific schedule
          for each unit.
      
     -    The diff is computed smaller by showing systemd_timer_enable_unit() move
     -    instead of systemd_timer_write_unit_templates().
     +    The diff is computed smaller by showing systemd_timer_enable_unit() and
     +    systemd_timer_delete_units()  move instead of
     +    systemd_timer_write_unit_templates() and
     +    systemd_timer_delete_unit_templates().
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ builtin/gc.c: static char *xdg_config_home_systemd(const char *filename)
      -	return 0;
      -}
      -
     --static int systemd_timer_delete_unit_templates(void)
     --{
     --	int ret = 0;
     --	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
     --	if (unlink(filename) && !is_missing_file_error(errno))
     --		ret = error_errno(_("failed to delete '%s'"), filename);
     --	FREE_AND_NULL(filename);
     --
     --	filename = xdg_config_home_systemd("git-maintenance@.service");
     --	if (unlink(filename) && !is_missing_file_error(errno))
     --		ret = error_errno(_("failed to delete '%s'"), filename);
     --
     --	free(filename);
     --	return ret;
     --}
     --
     + static int systemd_timer_delete_unit_templates(void)
     + {
     + 	int ret = 0;
     +@@ builtin/gc.c: static int systemd_timer_delete_unit_templates(void)
     + 	return ret;
     + }
     + 
      -static int systemd_timer_delete_units(void)
      -{
      -	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
     @@ builtin/gc.c: error:
      +	return 0;
      +}
      +
     -+static int systemd_timer_delete_unit_templates(void)
     -+{
     -+	int ret = 0;
     -+	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
     -+	if (unlink(filename) && !is_missing_file_error(errno))
     -+		ret = error_errno(_("failed to delete '%s'"), filename);
     -+	FREE_AND_NULL(filename);
     -+
     -+	filename = xdg_config_home_systemd("git-maintenance@.service");
     -+	if (unlink(filename) && !is_missing_file_error(errno))
     -+		ret = error_errno(_("failed to delete '%s'"), filename);
     -+
     -+	free(filename);
     -+	return ret;
     -+}
     -+
      +static int systemd_timer_delete_units(void)
      +{
      +	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
 6:  14e340b75fa ! 6:  e43778d3e40 maintenance: use random minute in systemd scheduler
     @@ Commit message
      
          In order to set these schedules to a given minute, we can no longer use
          the 'hourly', 'daily', or 'weekly' strings for '<schedule>' and instead
     -    need to abandon the template model.
     +    need to abandon the template model for the .timer files. We can still
     +    use templates for the .service files. For this reason, we split these
     +    writes into two methods.
      
          Modify the template with a custom schedule in the 'OnCalendar' setting.
          This schedule has some interesting differences from cron-like patterns,
     @@ Commit message
          week. Monday is used since that matches the day used for the 'weekly'
          schedule used previously.
      
     +    Now that the timer files are not templates, we might want to abandon the
     +    '@' symbol in the file names. However, this would cause users with
     +    existing schedules to get two competing schedules due to different
     +    names. The work to remove the old schedule name is one thing that we can
     +    avoid by keeping the '@' symbol in our unit names. Since we are locked
     +    into this name, it makes sense that we keep the template model for the
     +    .service files.
     +
          The rest of the change involves making sure we are writing these .timer
          and .service files before initializing the schedule with 'systemctl' and
          deleting the files when we are done. Some changes are also made to share
          the random minute along with a single computation of the execution path
          of the current Git executable.
      
     +    In addition, older Git versions may have written a
     +    'git-maintenance@.timer' template file. Be sure to remove this when
     +    successfully enabling maintenance (or disabling maintenance).
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## builtin/gc.c ##
     @@ builtin/gc.c: static char *xdg_config_home_systemd(const char *filename)
       	return xdg_config_home_for("systemd/user", filename);
       }
       
     +-static int systemd_timer_delete_unit_templates(void)
     ++#define SYSTEMD_UNIT_FORMAT "git-maintenance@%s.%s"
     ++
     ++static int systemd_timer_delete_timer_file(enum schedule_priority priority)
     + {
     + 	int ret = 0;
     +-	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
     ++	const char *frequency = get_frequency(priority);
     ++	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
     ++	char *filename = xdg_config_home_systemd(local_timer_name);
     ++
     + 	if (unlink(filename) && !is_missing_file_error(errno))
     + 		ret = error_errno(_("failed to delete '%s'"), filename);
     +-	FREE_AND_NULL(filename);
     + 
     +-	filename = xdg_config_home_systemd("git-maintenance@.service");
     ++	free(filename);
     ++	free(local_timer_name);
     ++	return ret;
     ++}
     ++
     ++static int systemd_timer_delete_service_template(void)
     ++{
     ++	int ret = 0;
     ++	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
     ++	char *filename = xdg_config_home_systemd(local_service_name);
     + 	if (unlink(filename) && !is_missing_file_error(errno))
     + 		ret = error_errno(_("failed to delete '%s'"), filename);
     + 
     + 	free(filename);
     ++	free(local_service_name);
     + 	return ret;
     + }
     + 
      -static int systemd_timer_write_unit_templates(const char *exec_path)
     -+static int systemd_timer_write_unit_template(enum schedule_priority schedule,
     -+					     const char *exec_path,
     -+					     int minute)
     ++/*
     ++ * Write the schedule information into a git-maintenance@<schedule>.timer
     ++ * file using a custom minute. This timer file cannot use the templating
     ++ * system, so we generate a specific file for each.
     ++ */
     ++static int systemd_timer_write_timer_file(enum schedule_priority schedule,
     ++					  int minute)
       {
     ++	int res = -1;
       	char *filename;
       	FILE *file;
       	const char *unit;
      +	char *schedule_pattern = NULL;
      +	const char *frequency = get_frequency(schedule);
     -+	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
     -+	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
     ++	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
      +
      +	filename = xdg_config_home_systemd(local_timer_name);
       
     @@ builtin/gc.c: static int systemd_timer_write_unit_templates(const char *exec_pat
       		fclose(file);
       		goto error;
      @@ builtin/gc.c: static int systemd_timer_write_unit_templates(const char *exec_path)
     + 		error_errno(_("failed to flush '%s'"), filename);
     + 		goto error;
       	}
     ++
     ++	res = 0;
     ++
     ++error:
     ++	free(schedule_pattern);
     ++	free(local_timer_name);
       	free(filename);
     ++	return res;
     ++}
       
      -	filename = xdg_config_home_systemd("git-maintenance@.service");
     ++/*
     ++ * No matter the schedule, we use the same service and can make use of the
     ++ * templating system. When installing git-maintenance@<schedule>.timer,
     ++ * systemd will notice that git-maintenance@.service exists as a template
     ++ * and will use this file and insert the <schedule> into the template at
     ++ * the position of "%i".
     ++ */
     ++static int systemd_timer_write_service_template(const char *exec_path)
     ++{
     ++	int res = -1;
     ++	char *filename;
     ++	FILE *file;
     ++	const char *unit;
     ++	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
     ++
      +	filename = xdg_config_home_systemd(local_service_name);
     ++	if (safe_create_leading_directories(filename)) {
     ++		error(_("failed to create directories for '%s'"), filename);
     ++		goto error;
     ++	}
       	file = fopen_or_warn(filename, "w");
       	if (!file)
       		goto error;
      @@ builtin/gc.c: static int systemd_timer_write_unit_templates(const char *exec_path)
     - 	       "\n"
     - 	       "[Service]\n"
     - 	       "Type=oneshot\n"
     --	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
     -+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s\n"
     - 	       "LockPersonality=yes\n"
     - 	       "MemoryDenyWriteExecute=yes\n"
     - 	       "NoNewPrivileges=yes\n"
     -@@ builtin/gc.c: static int systemd_timer_write_unit_templates(const char *exec_path)
     - 	       "RestrictSUIDSGID=yes\n"
     - 	       "SystemCallArchitectures=native\n"
     - 	       "SystemCallFilter=@system-service\n";
     --	if (fprintf(file, unit, exec_path, exec_path) < 0) {
     -+	if (fprintf(file, unit, exec_path, exec_path, frequency) < 0) {
     - 		error(_("failed to write to '%s'"), filename);
     - 		fclose(file);
     + 		error_errno(_("failed to flush '%s'"), filename);
       		goto error;
     -@@ builtin/gc.c: static int systemd_timer_write_unit_templates(const char *exec_path)
     - 	return 0;
     + 	}
     +-	free(filename);
     +-	return 0;
     ++
     ++	res = 0;
       
       error:
     -+	free(schedule_pattern);
     -+	free(local_timer_name);
     ++	free(local_service_name);
       	free(filename);
      -	systemd_timer_delete_unit_templates();
     - 	return -1;
     +-	return -1;
     ++	return res;
       }
       
       static int systemd_timer_enable_unit(int enable,
      -				     enum schedule_priority schedule)
      +				     enum schedule_priority schedule,
     -+				     const char *exec_path,
      +				     int minute)
       {
       	const char *cmd = "systemctl";
     @@ builtin/gc.c: static int systemd_timer_enable_unit(int enable,
       	 */
       	if (!enable)
       		child.no_stderr = 1;
     -+	else if (systemd_timer_write_unit_template(schedule, exec_path, minute))
     ++	else if (systemd_timer_write_timer_file(schedule, minute))
      +		return -1;
       
       	get_schedule_cmd(&cmd, NULL);
       	strvec_split(&child.args, cmd);
     + 	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
     + 		     "--now", NULL);
     +-	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
     ++	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
     + 
     + 	if (start_command(&child))
     + 		return error(_("failed to start systemctl"));
      @@ builtin/gc.c: static int systemd_timer_enable_unit(int enable,
       	return 0;
       }
       
     --static int systemd_timer_delete_unit_templates(void)
     -+static int systemd_timer_delete_unit_template(enum schedule_priority priority)
     - {
     -+	const char *frequency = get_frequency(priority);
     -+	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
     -+	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
     - 	int ret = 0;
     --	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
     -+	char *filename = xdg_config_home_systemd(local_timer_name);
     - 	if (unlink(filename) && !is_missing_file_error(errno))
     - 		ret = error_errno(_("failed to delete '%s'"), filename);
     - 	FREE_AND_NULL(filename);
     - 
     --	filename = xdg_config_home_systemd("git-maintenance@.service");
     -+	filename = xdg_config_home_systemd(local_service_name);
     - 	if (unlink(filename) && !is_missing_file_error(errno))
     - 		ret = error_errno(_("failed to delete '%s'"), filename);
     - 
     - 	free(filename);
     -+	free(local_timer_name);
     -+	free(local_service_name);
     - 	return ret;
     - }
     - 
     -+static int systemd_timer_delete_unit_templates(void)
     ++/*
     ++ * A previous version of Git wrote the timer units as template files.
     ++ * Clean these up, if they exist.
     ++ */
     ++static void systemd_timer_delete_stale_timer_templates(void)
     ++{
     ++	char *timer_template_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "timer");
     ++	char *filename = xdg_config_home_systemd(timer_template_name);
     ++
     ++	if (unlink(filename) && !is_missing_file_error(errno))
     ++		warning(_("failed to delete '%s'"), filename);
     ++
     ++	free(filename);
     ++	free(timer_template_name);
     ++}
     ++
     ++static int systemd_timer_delete_unit_files(void)
      +{
     ++	systemd_timer_delete_stale_timer_templates();
     ++
      +	/* Purposefully not short-circuited to make sure all are called. */
     -+	return systemd_timer_delete_unit_template(SCHEDULE_HOURLY) |
     -+	       systemd_timer_delete_unit_template(SCHEDULE_DAILY) |
     -+	       systemd_timer_delete_unit_template(SCHEDULE_WEEKLY);
     ++	return systemd_timer_delete_timer_file(SCHEDULE_HOURLY) |
     ++	       systemd_timer_delete_timer_file(SCHEDULE_DAILY) |
     ++	       systemd_timer_delete_timer_file(SCHEDULE_WEEKLY) |
     ++	       systemd_timer_delete_service_template();
      +}
      +
       static int systemd_timer_delete_units(void)
     @@ builtin/gc.c: static int systemd_timer_enable_unit(int enable,
      -	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
      -	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
      -	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
     +-	       systemd_timer_delete_unit_templates();
      +	int minute = get_random_minute();
     -+	const char *exec_path = git_exec_path();
     -+	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, exec_path, minute) ||
     -+	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, exec_path, minute) ||
     -+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, exec_path, minute) ||
     - 	       systemd_timer_delete_unit_templates();
     ++	/* Purposefully not short-circuited to make sure all are called. */
     ++	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, minute) |
     ++	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, minute) |
     ++	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, minute) |
     ++	       systemd_timer_delete_unit_files();
       }
       
       static int systemd_timer_setup_units(void)
     @@ builtin/gc.c: static int systemd_timer_enable_unit(int enable,
      -		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
      -		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
      -		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
     -+	int ret = systemd_timer_enable_unit(1, SCHEDULE_HOURLY, exec_path, minute) ||
     -+		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, exec_path, minute) ||
     -+		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, exec_path, minute);
     ++	int ret = systemd_timer_write_service_template(exec_path) ||
     ++		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY, minute) ||
     ++		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, minute) ||
     ++		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, minute);
     ++
       	if (ret)
       		systemd_timer_delete_units();
     ++	else
     ++		systemd_timer_delete_stale_timer_templates();
     ++
       	return ret;
     + }
     + 
      
       ## t/t7900-maintenance.sh ##
      @@ t/t7900-maintenance.sh: test_expect_success 'start and stop Linux/systemd maintenance' '
     @@ t/t7900-maintenance.sh: test_expect_success 'start and stop Linux/systemd mainte
       	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
       
      -	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
     ++	for schedule in hourly daily weekly
     ++	do
     ++		test_path_is_file "systemd/user/git-maintenance@$schedule.timer" || return 1
     ++	done &&
     ++	test_path_is_file "systemd/user/git-maintenance@.service" &&
     ++
      +	test_systemd_analyze_verify "systemd/user/git-maintenance@hourly.service" &&
      +	test_systemd_analyze_verify "systemd/user/git-maintenance@daily.service" &&
      +	test_systemd_analyze_verify "systemd/user/git-maintenance@weekly.service" &&
       
       	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
       	test_cmp expect args &&
     +@@ t/t7900-maintenance.sh: test_expect_success 'start and stop Linux/systemd maintenance' '
     + 	# stop does not unregister the repo
     + 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
     + 
     +-	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
     ++	for schedule in hourly daily weekly
     ++	do
     ++		test_path_is_missing "systemd/user/git-maintenance@$schedule.timer" || return 1
     ++	done &&
     + 	test_path_is_missing "systemd/user/git-maintenance@.service" &&
     + 
     + 	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 -:  ----------- > 7:  86c4255d63d maintenance: fix systemd schedule overlaps
 -:  ----------- > 8:  f0c0f6eff88 maintenance: update schedule before config

-- 
gitgitgadget
