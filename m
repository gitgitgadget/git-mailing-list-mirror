Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D7A1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHCRXq (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:23:46 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41116 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeHCRXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:23:46 -0400
Received: by mail-qk0-f174.google.com with SMTP id n85-v6so4127326qke.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wzbcwRs6+bQVj9VA9W6wSqCo1ZKYPIzocU3hFI/XViI=;
        b=XV6wNgG2wKOPNaHbczphnpmuCHq693GCqOcuirqRL6x6iQyNmwzJ4aWlvGymWj27dC
         HelDGWslR1MkSczgWavClmIsGwQPQFFZh01Llqbsuf4WfnU4XFQHud37CcGDTONu3vbB
         jnyKGSPW+f/bOfBy0euURvKtfi58pIXqEm7K4BMmT35ZN6m35J5VX6mKekZt/cT2stgQ
         i4o1BMYk2jScfLHNA3js8DTXphaLbfcHaMb/Dt5Ly/p/qtFWQmmJhjIoO39cvbxuHNQH
         2JOqLo2j7B9HBlox2BgW968mypEBb8kLc5MKGs1tTooXWypDryc2n1VHr2lLi2InZWiL
         GGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wzbcwRs6+bQVj9VA9W6wSqCo1ZKYPIzocU3hFI/XViI=;
        b=mWfa/vYIdOP43GMt377J8aX0F9M+IQmohw0n+6puSsyNHOkqw0Km6f9j+RWrPmMTUN
         5d5EX/28PAiMIrCscVDwiAES5EgHAPj+8TmP5zqLf7GLG5EURXJn/HysjI39PCvtnlE6
         sX5tKVzHM7teBcTCyWghZ3FrOsK2pvnbNrywXq7+hOnKFEbJTZdno2CpoRkcAV1TWN1F
         GSR86/abChu1r5u6bTY3O3q/no9zN8IPip5r9srdVIBybb6tBv8IoQBXvCi0+wXQhfpU
         2pSMuDFbpiJwTALwvtuheOxnZNYBMSE9EC9mt1jfB2N+eDjXe2YHz2Vc5ymWkUmfeQBQ
         bLPw==
X-Gm-Message-State: AOUpUlHEhsiuaO2eUq67+7YmX3cbO/u3/uh8r7z1qXR4hFTSaIlEn0qd
        K9iapSDOT1w+mPxgM5JK61Y=
X-Google-Smtp-Source: AAOMgpeqpEDanPIBTBNLTcGUwzG1WlC9yIghTYgxddlZArGMdn6pbFisveQjhTpOU+qn5fmSndiC2Q==
X-Received: by 2002:a37:1515:: with SMTP id f21-v6mr4108847qkh.157.1533310016162;
        Fri, 03 Aug 2018 08:26:56 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d80-v6sm6129961qka.33.2018.08.03.08.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 08:26:54 -0700 (PDT)
Subject: Re: [PATCH v1 01/25] structured-logging: design document
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-2-git@jeffhostetler.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <13302a8c-a114-c3a7-65df-55f47f902126@gmail.com>
Date:   Fri, 3 Aug 2018 11:26:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713165621.52017-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/2018 12:55 PM, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   Documentation/technical/structured-logging.txt | 816 +++++++++++++++++++++++++
>   1 file changed, 816 insertions(+)
>   create mode 100644 Documentation/technical/structured-logging.txt
> 
> diff --git a/Documentation/technical/structured-logging.txt b/Documentation/technical/structured-logging.txt
> new file mode 100644
> index 0000000..794c614
> --- /dev/null
> +++ b/Documentation/technical/structured-logging.txt
> @@ -0,0 +1,816 @@
> +Structured Logging
> +==================
> +
> +Structured Logging (SLOG) is an optional feature to allow Git to
> +generate structured log data for executed commands.  This includes
> +command line arguments, command run times, error codes and messages,
> +child process information, time spent in various critical functions,
> +and repository data-shape information.  Data is written to a target
> +log file in JSON[1,2,3] format.
> +
> +SLOG is disabled by default.  Several steps are required to enable it:
> +
> +1. Add the compile-time flag "STRUCTURED_LOGGING=1" when building git
> +   to include the SLOG routines in the git executable.
> +

Is the intent to remove this compile-time flag before this is merged? 
With it off by default in builds, the audience for this is limited to 
those who build their own/custom versions of git. I can see other 
organizations wanting to use this that don't have a custom fork of git 
they build and install on their users machines.

Like the GIT_TRACE mechanism today, I think this should be compiled in 
but turned off via the default settings by default.

> +2. Set "slog.*" config settings[5] to enable SLOG in your repo.
> +
> +
> +Motivation
> +==========
> +
> +Git users may be faced with scenarios that are surprisingly slow or
> +produce unexpected results.  And Git developers may have difficulty
> +reproducing these experiences.  Structured logging allows users to
> +provide developers with additional usage, performance and error data
> +that can help diagnose and debug issues.
> +
> +Many Git hosting providers and users with many developers have bespoke
> +efforts to help troubleshoot problems; for example, command wrappers,
> +custom pre- and post-command hooks, and custom instrumentation of Git
> +code.  These are inefficient and/or difficult to maintain.  The goal
> +of SLOG is to provide this data as efficiently as possible.
> +
> +And having structured rather than free format log data, will help
> +developers with their analysis.
> +
> +
> +Background (Git Merge 2018 Barcelona)
> +=====================================
> +
> +Performance and/or error logging was discussed during the contributor's
> +summit in Barcelona.  Here are the relevant notes from the meeting
> +minutes[6].
> +
> +> Performance misc (Ævar)
> +> -----------------------
> +> [...]
> +>  - central error reporting for git
> +>    - `git status` logging
> +>    - git config that collects data, pushes to known endpoint with `git push`
> +>    - pre_command and post_command hooks, for logs
> +>    - `gvfs diagnose` that looks at packfiles, etc
> +>    - detect BSODs, etc
> +>    - Dropbox writes out json with index properties and command-line
> +>        information for status/fetch/push, fork/execs external tool to upload
> +>    - windows trace facility; would be nice to have cross-platform
> +>    - would hosting providers care?
> +>    - zipfile of logs to give when debugging
> +>    - sanitizing data is harder
> +>    - more in a company setting
> +>    - fileshare to upload zipfile
> +>    - most of the errors are proxy when they shouldn't, wrong proxy, proxy
> +>        specific to particular URL; so upload endpoint wouldn't work
> +>    - GIT_TRACE is supposed to be that (for proxy)
> +>    - but we need more trace variables
> +>    - series to make tracing cheaper
> +>    - except that curl selects the proxy
> +>    - trace should have an API, so it can call an executable
> +>    - dump to .git/traces/... and everything else happens externally
> +>    - tools like visual studio can't set GIT_TRACE, so
> +>    - sourcetree has seen user environments where commands just take forever
> +>    - third-party tools like perf/strace - could we be better leveraging those?
> +>    - distribute turn-key solution to handout to collect more data?
> +

While it makes sense to have clear goals in the design document, the 
motivation and background sections feel somehow out of place.  I'd 
recommend you clearly articulate the design goals and drop the 
background data that led you to the goals.

> +
> +A Quick Example
> +===============
> +
> +Note: JSON pretty-printing is enabled in all of the examples shown in
> +this document.  When pretty-printing is turned off, each event is
> +written on a single line.  Pretty-printing is intended for debugging.
> +It should be turned off in production to make post-processing easier.
> + > +    $ git config slog.pretty <bool>
> +

nit - I'd move this "Note:" section to the end of your "A Quick 
Example." While it's good to understand about pretty printing, its not 
the first or most important thing.

> +Here is a quick example showing SLOG data for "git status".  This
> +example has all optional features turned off.  It contains 2 events.
> +The first is generated when the command started and the second when it
> +ended.
> +
> +{
> +  "event": "cmd_start",
> +  "clock_us": 1530273550667800,
> +  "pid": 107270,
> +  "sid": "1530273550667800-107270",
> +  "command": "status",
> +  "argv": [
> +    "./git",
> +    "status"
> +  ]
> +}
> +{
> +  "event": "cmd_exit",
> +  "clock_us": 1530273550680460,
> +  "pid": 107270,
> +  "sid": "1530273550667800-107270",
> +  "command": "status",
> +  "argv": [
> +    "./git",
> +    "status"
> +  ],
> +  "result": {
> +    "exit_code": 0,
> +    "elapsed_core_us": 12573,
> +    "elapsed_total_us": 12660
> +  },
> +  "version": {
> +    "git": "2.18.0.rc0.83.gde7fb7c",
> +    "slog": 0
> +  },
> +  "config": {
> +    "slog": {
> +      "detail": 0,
> +      "timers": 0,
> +      "aux": 0
> +    }
> +  }
> +}
> +
> +Both events fields describing the event name, the event time (in

Maybe "Both events have fields describing the event name..."

> +microseconds since the epoch), the OS process-id, a unique session-id
> +(described later), the normalized command name, and a vector of the
> +original command line arguments.
> +
> +The "cmd_exit" event additionally contains information about how the
> +process exited, the elapsed time, the version of git and the SLOG
> +format, and important SLOG configuration settings.
> +

At first glance, the SLOG configuration settings seem out of place but 
I'll read on to see why they are needed with every cmd_exit event...

> +The fields in the "cmd_start" event are replicated in the "cmd_exit"
> +event.  This allows log file post-processors to operate in 2 modes:
> +
> +1. Just look at the "cmd_exit" events.  This us useful if you just
> +   want to analyze the command summary data.
> +
> +2. Look at the "cmd_start" and "cmd_exit" events as bracketing a time
> +   span and examine the detailed activity between.  For example, SLOG
> +   can optionally generate "detail" events when spawning child
> +   processes and those processes may themselves generate "cmd_start"
> +   and "cmd_exit" events.  The (top-level) "cmd_start" event serves as
> +   the starting bracket of all of that activity.
> +

I'm assuming the sid is what will enable correlating the child process 
events with the outer command?

> +
> +Target Log File
> +===============
> +
> +SLOG writes events to a log file.  File logging works much like
> +GIT_TRACE where events are appended to a file on disk.
> +
> +Logging is enabled if the config variable "slog.path" is set to an
> +absolute pathname.
> +
> +As with GIT_TRACE, this file is local and private to the user's
> +system.  Log file management and rotation is beyond the scope of the
> +SLOG effort.
> +
> +Similarly, if a user wants to provide this data to a developer, they
> +must explicitly make these log files available; SLOG does not
> +broadcast any of this information.  It is up to the users of this
> +system to decide if any sensitive information should be sanitized, and
> +how to export the logs.
> +

It's good to clarify this.

> +
> +Comparison with GIT_TRACE
> +=========================
> +
> +SLOG is very similar to the existing GIT_TRACE[4] API because both
> +write event messages at various points during a command.  However,
> +there are some fundamental differences that warrant it being
> +considered a separate feature rather than just another
> +GIT_TRACE_<key>:
> +

But it does make me wonder if we need to keep both systems.  If there 
are two, as a developer I need to know which I should use.  What is the 
criteria I should use to decide between adding GIT_TRACE and SLOG 
tracing?  It seems like it would be best if we could converge on a 
single tracing model.

> +1. GIT_TRACE events are unrelated, line-by-line logging.  SLOG has
> +   line-by-line events that show command progress and can serve as
> +   structured debug messages.  SLOG also supports accumulating summary
> +   data (such as timers) that are automatically added to the final
> +   `cmd_exit` event.
> +
> +2. GIT_TRACE events are unstructured free format printf-style messages
> +   which makes post-processing difficult.  SLOG events are written in
> +   JSON and can be easily parsed using Perl, Python, and other tools.
> +
> +3. SLOG uses a well-defined API to build SLOG events containing
> +   well-defined fields to make post-command analysis easier.
> +
> +4. It should be easier to filter/redact sensitive information from
> +   SLOG data than from free form data.
> +
> +5. GIT_TRACE events are controlled by one or more global environment
> +   variables which makes it awkward to selectively log some repos and
> +   not others.  SLOG events are controlled by a few configuration
> +   settings[5].  Users (or system administrators) can configure
> +   logging using repo-local or global config settings.
> +
> +6. GIT_TRACE events do not identify the git process.  This makes it
> +   difficult to associate all of events from a particular command.
> +   Each SLOG event contains a session id to allow all events for a
> +   command to be identified.
> +
> +7. Some git commands spawn child git commands.  GIT_TRACE has no
> +   mechanism to associate events from a child process with the parent
> +   process.  SLOG session ids allow child/parent relationships to be
> +   tracked (even if there is an intermediate /bin/sh process between
> +   them).
> +
> +8. GIT_TRACE supports logging to a file or stderr.  SLOG only logs to
> +   a file.
> +
> +9. Smashing SLOG into GIT_TRACE doesn't feel like a good fit.  The 2
> +   APIs share nothing other than the concept that they write logging
> +   data.
> +

Is SLOG a superset of GIT_TRACE? If not, could it be?  While SLOG can't 
be smashed into GIT_TRACE, can the functionality of GIT_TRACE be 
subsumed by SLOG so that we can converge on a single tracing system?

I'd like to see a design goal for this effort to be that we come up with 
a single tracing mechanism that meets _all_ the requirements (including 
those currently met by GIT_TRACE).

> +
> +[1] http://json.org/
> +[2] http://www.ietf.org/rfc/rfc7159.txt
> +[3] See UTF-8 limitations described in json-writer.h
> +[4] Documentation/technical/api-trace.txt
> +[5] See "slog.*" in Documentation/config.txt
> +[6] https://public-inbox.org/git/20180313004940.GG61720@google.com/t/
> +
> +
> +SLOG Format (V0)
> +================
> +
> +SLOG writes a series of events to the log target.  Each event is a
> +self-describing JSON object.
> +
> +    <event> LF
> +    <event> LF
> +    <event> LF
> +    ...
> +
> +Each event record in the log file is an independent and complete JSON
> +object.  JSON parsers should process the file line-by-line rather than
> +trying to parse the entire file into a single object.
> +
> +    Note: It may be difficult for parsers to find record boundaries if
> +    pretty-printing is enabled, so it recommended that pretty-printing
> +    only be enabled for interactive debugging and analysis.
> +
> +Every <event> contains the following fields (F1):
> +
> +    "event"       : <event_name>
> +    "clock_us"    : <event_time>
> +    "pid"         : <os_pid>
> +    "sid"         : <session_id>
> +
> +    "command"     : <command_name>
> +    "sub_command" : <sub_command_name> (optional)
> +
> +<event_name> is one of "cmd_start", "cmd_end", or "detail".
> +
> +<event_time> is the time of the event in microseconds since the epoch.
> +
> +<os_pid> is the process-id (from getpid()).
> +
> +<session_id> is a session-id.  (Described later)
> +
> +<command_name> is a (possibly normalized) command name.  This is
> +    usually taken from the cmd_struct[] table after git parses the
> +    command line and calls the appropriate cmd_<name>() function.
> +    Having it in a top-level field saves post-processors from having
> +    to re-parse the command line to discover it.
> +
> +<sub_command_name> further qualifies the command.  This field is
> +    present for common commands that have multiple command modes.  For
> +    example, checkout can either change branches and do a full
> +    checkout or it can checkout (refresh) an individual file.  A
> +    post-processor wanting to compute percentiles for the time spent
> +    by branch-changing checkouts could easily filter out the
> +    individual file checkouts (and without having to re-parse the
> +    command line).
> +
> +    The set of sub_command values are command-specific and are not
> +    listed here.

The sub-command definition seems a little squishy but I guess since you
have the entire set of command line arguments, it's really just a hint
as you could always drop back to looking at the arguments yourself.

> +
> +"event": "cmd_start"
> +-------------------
> +
> +The "cmd_start" event is emitted when git starts when cmd_main() is
> +called.  In addition to the F1 fields, it contains the following
> +fields (F2):
> +
> +    "argv"        : <array-of-command-line-arguments>
> +
> +<argv> is an array of the original command line arguments given to the
> +    command (before git.c has a chance to remove the global options
> +    before the verb.
> +
> +
> +"event": "cmd_exit"
> +-------------------
> +
> +The "cmd_exit" event is emitted immediately before git exits (during
> +an atexit() routine).  It contains the F1 and F2 fields as described
> +above.  It also contains the the following fields (F3):
> +
> +    "result.exit_code"        : <exit_code>
> +    "result.errors"           : <arrary_of_error_messages> (optional)
> +    "result.elapsed_core_us"  : <elapsed_time_to_exit>
> +    "result.elapsed_total_us" : <elapsed_time_to_atexit>
> +    "result.signal"           : <signal_value> (optional)
> +
> +    "verion.git"              : <git_version>
> +    "version.slog"            : <slog_version>
> +
> +    "config.slog.detail"      : <slog_detail>
> +    "config.slog.timers"      : <slog_timers>
> +    "config.slog.aux"         : <slog_aux>
> +    "config.*.*"              : <other_config_settings> (optional)
> +
> +    "timers"                  : <timers> (optional)
> +    "aux"                     : <aux> (optional)
> +
> +    "child_summary"           : <child_summary> (optional)
> +
> +<exit_code> is the value passed to exit() or returned from main().
> +
> +<array_of_error_messages> is an array of messages passed to the die()
> +    and error() functions.
> +
> +<elapsed_time_to_exit> is the elapsed time from start until exit()
> +    was called or main() returned.
> +
> +<elapsed_time_to_atexit> is the elapsed time from start until the slog
> +    atexit routine was called.  This time will include any time
> +    required to shut down or wait for the pager to complete.
> +

I wonder how valuable the difference is between these two and if we 
could simply drop the <elapsed_time_to_atexit>

> +<signal_value> is present if the command was stopped by a single,

s/single/signal

> +    such as a SIGPIPE when the pager is quit.
> +
> +<git_version> is the git version number as reported by "git version".
> +
> +<slog_version> is the SLOG format version.
> +
> +<slog_{detail,timers,aux}> are the values of the corresponding
> +    "slog.{detail,timers,aux}" config setting.  Since these values
> +    control optional SLOG features and filtering, these are present
> +    to help post-processors know if an expected event did not happen
> +    or was simply filtered out.  (Described later)
> +
> +<other_config_settings> is a place for developers to add additional
> +    important config settings to the log.  This is not intended as a
> +    dumping ground for all config settings, but rather only ones that
> +    might affect performance or allow A/B testing in production.
> +
> +<timers> is a structure of any SLOG timers used during the process.
> +    (Described later)
> +
> +<aux> is a structure of any "aux data" generated during the process.
> +    (Described later)
> +
> +<child_summary> is a structure summarizing child processes by class.
> +    (Described later)
> +
> +
> +"event": "detail" and config setting "slog.detail"
> +--------------------------------------------------
> +
> +The "detail" event is used to report progress and/or debug information
> +during a command.  It is a line-by-line (rather than summary) event.
> +Like GIT_TRACE_<key>, detail events are classified by "category" and
> +may be included or omitted based on the "slog.detail" config setting.
> +
> +Here are 3 example "detail" events:
> +
> +{
> +  "event": "detail",
> +  "clock_us": 1530273485479387,
> +  "pid": 107253,
> +  "sid": "1530273485473820-107253",
> +  "command": "status",
> +  "detail": {
> +    "category": "index",
> +    "label": "lazy_init_name_hash",
> +    "data": {
> +      "cache_nr": 3269,
> +      "elapsed_us": 195,
> +      "dir_count": 0,
> +      "dir_tablesize": 4096,
> +      "name_count": 3269,
> +      "name_tablesize": 4096
> +    }
> +  }
> +}
> +{
> +  "event": "detail",
> +  "clock_us": 1530283184051338,
> +  "pid": 109679,
> +  "sid": "1530283180782876-109679",
> +  "command": "fetch",
> +  "detail": {
> +    "category": "child",
> +    "label": "child_starting",
> +    "data": {
> +      "child_id": 3,
> +      "git_cmd": true,
> +      "use_shell": false,
> +      "is_interactive": false,
> +      "child_argv": [
> +        "gc",
> +        "--auto"
> +      ]
> +    }
> +  }
> +}
> +{
> +  "event": "detail",
> +  "clock_us": 1530283184053158,
> +  "pid": 109679,
> +  "sid": "1530283180782876-109679",
> +  "command": "fetch",
> +  "detail": {
> +    "category": "child",
> +    "label": "child_ended",
> +    "data": {
> +      "child_id": 3,
> +      "git_cmd": true,
> +      "use_shell": false,
> +      "is_interactive": false,
> +      "child_argv": [
> +        "gc",
> +        "--auto"
> +      ],
> +      "child_pid": 109684,
> +      "child_exit_code": 0,
> +      "child_elapsed_us": 1819
> +    }
> +  }
> +}
> +
> +A detail event contains the common F1 described earlier.  It also
> +contains 2 fixed fields and 1 variable field:
> +
> +    "detail.category" : <detail_category>
> +    "detail.label"    : <detail_label>
> +    "detail.data"     : <detail_data>
> +
> +<detail_category> is the "category" name for the event.  This is
> +    similar to GIT_TRACE_<key>.  In the example above we have 1
> +    "index" and 2 "child" category events.
> +
> +    If the config setting "slog.detail" is true or contains this
> +    category name, the event will be generated.  If "slog.detail"
> +    is false, no detail events will be generated.
> +
> +    $ git config slog.detail true
> +    $ git config slog.detail child,index,status
> +    $ git config slog.detail false
> +
> +<detail_label> is a descriptive label for the event.  It may be the
> +    name of a function or any meaningful value.
> +
> +<detail_data> is a JSON structure containing context-specific data for
> +    the event.  This replaces the need for printf-like trace messages.

Hmm, couldn't this (a new "Trace Detail Event) be used to help replace 
the existing GIT_TRACE mechanism? I think one missing piece is a 
formatting option other than "pretty." Perhaps another field that is a 
format string that can be used to give it a richer human readable output?

Overall this looks very robust and capable.  Clearly my biggest feedback 
is that I'd like to see this be able to replace the existing GIT_TRACE 
and GIT_TRACE_PERFORMANCE support.  Having two different mechanisms 
seems unnecessarily complex and will increase the mental burden when 
adding tracing.  It also doubles the code we need to 
write/debug/document/support.  I'd hate to see callers of the tracing 
code having to double up and including calls to both tracing mechanisms.

I'm OK if this is a goal and migrating the existing calls to GIT_TRACE 
are cleaned up over time.  It may be a nice intermediate step if the 
existing macros could be re-implemented to sit on top of the new SLOG 
infrastructure. This would certainly make it easier to migrate the code 
base over time.

<snip>
