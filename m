Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF3D1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbcJEU5L (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:57:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35641 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbcJEU5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:57:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so448611wmg.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Gbf9tvIRcwckCL4sxcbhT3raZ6tIt36FbcBYTxsdGI=;
        b=W7pvtdCZU3wPaCbwelgFfTl0ZdPD3KGejAYx6AiQxVIRgbrT+YjapDcKBY4ryUDfF6
         RqRf6Dk947sw3OANXEOK4PQMrJDJgNsZX4fPxusPclUgd1xze3hMZmjKWQM54StgPmOz
         3Y1IoZvCmVaf3pBxsMLl1XZnSXHjW9O3Pu6qmXpTNB8UqoSIMalIPUL0425JIBGTL74E
         K8P1NlCAcznAGsZgAGaiOxQRvebapcu59wUIjnSdOvDEVg7T9xM07iR0UcNxNe9/Cp+9
         NiDQwY7futt3ESBT/QlE8st6iN1lGICjqPf5CkjSy6JrO4fJdrVlc0sS4N3/iZjaOVLT
         bB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Gbf9tvIRcwckCL4sxcbhT3raZ6tIt36FbcBYTxsdGI=;
        b=ZaWwhyfVfNNYzQhbMCGWchlOo5GprmT+NyLsatNaQ2Tw58LnHgBJBWUgyfjOOoogNz
         PIxcX67pbibP+DocvT6QN9PVfBLVWeorGUdp11zUJcvjhGExNV9xfxDdAhW3QNB8QXWx
         nVmE4+GJqYnB2LI7V4b7hrvTICynNS2p7hObNR00pamauqqg5ThD1wtJRofPkdHY59nX
         aBmJBRLfxnFII4AdQWdhW3CqOiGdG3tmk0vbIPiGB4WpjcFH81PBfr70MQUPFUjHVVIA
         QfEMU0eCpbhMPSIr1+ermjUrxAj6fQM9HCwwT+fF+3dmHyB7rkyIpus2ySe2JIIN7Rvx
         vnMw==
X-Gm-Message-State: AA6/9Rm3Ph/NGroY/xGdC4tEv2HPsmzgtLtWADkqCOAk/+DkHmoavZvzulhIv42+1EU6sQ==
X-Received: by 10.28.163.65 with SMTP id m62mr11043421wme.62.1475701028803;
        Wed, 05 Oct 2016 13:57:08 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA355.dip0.t-ipconnect.de. [80.139.163.85])
        by smtp.gmail.com with ESMTPSA id 74sm11331414wmi.7.2016.10.05.13.57.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Oct 2016 13:57:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 5 Oct 2016 22:57:07 +0200
Cc:     git@vger.kernel.org, ramsay@ramsayjones.plus.com, jnareb@gmail.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com> <20161004125947.67104-5-larsxschneider@gmail.com> <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Oct 2016, at 21:30, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> The flag 'clean_on_exit' kills child processes spawned by Git on =
exit.
>> A hard kill like this might not be desired in all cases.
>>=20
>> Add 'wait_on_exit' which closes the child's stdin on Git exit and =
waits
>> until the child process has terminated.
>>=20
>> The flag is used in a subsequent patch.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> ...
>> static void cleanup_children(int sig, int in_signal)
>> {
>> +	int status;
>> +	struct child_to_clean *p =3D children_to_clean;
>> +
>> +	/* Close the the child's stdin as indicator that Git will exit =
soon */
>> +	while (p) {
>> +		if (p->wait)
>> +			if (p->stdin > 0)
>> +				close(p->stdin);
>> +		p =3D p->next;
>> +	}
>=20
> This part and the "stdin" field feels a bit too specific to the
> caller you are adding.  Allowing the user of the API to specify what
> clean-up cation needs to be taken in the form of a callback function
> may not be that much more effort and would be more flexible and
> useful, I would imagine?

OK. Something like the patch below would work nicely.
Does this look acceptable?

Thanks,
Lars


diff --git a/run-command.c b/run-command.c
index 3269362..a0256a6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
=20
 struct child_to_clean {
 	pid_t pid;
+	void (*clean_on_exit_handler)(pid_t, int);
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -31,6 +32,11 @@ static void cleanup_children(int sig, int in_signal)
 	while (children_to_clean) {
 		struct child_to_clean *p =3D children_to_clean;
 		children_to_clean =3D p->next;
+
+		if (p->clean_on_exit_handler) {
+			p->clean_on_exit_handler(p->pid, in_signal);
+		}
+
 		kill(p->pid, sig);
 		if (!in_signal)
 			free(p);
@@ -49,10 +55,11 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
=20
-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, void =
(*clean_on_exit_handler)(pid_t, int))
 {
 	struct child_to_clean *p =3D xmalloc(sizeof(*p));
 	p->pid =3D pid;
+	p->clean_on_exit_handler =3D clean_on_exit_handler;
 	p->next =3D children_to_clean;
 	children_to_clean =3D p;
=20
@@ -421,8 +428,8 @@ int start_command(struct child_process *cmd)
 	}
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
-	else if (cmd->clean_on_exit)
-		mark_child_for_cleanup(cmd->pid);
+	else if (cmd->clean_on_exit || cmd->clean_on_exit_handler)
+		mark_child_for_cleanup(cmd->pid, =
cmd->clean_on_exit_handler);
=20
 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -482,8 +489,8 @@ int start_command(struct child_process *cmd)
 	failed_errno =3D errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D =
ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
-	if (cmd->clean_on_exit && cmd->pid >=3D 0)
-		mark_child_for_cleanup(cmd->pid);
+	if ((cmd->clean_on_exit || cmd->clean_on_exit_handler) && =
cmd->pid >=3D 0)
+		mark_child_for_cleanup(cmd->pid, =
cmd->clean_on_exit_handler);
=20
 	argv_array_clear(&nargv);
 	cmd->argv =3D sargv;
@@ -765,7 +772,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
=20
-	mark_child_for_cleanup(async->pid);
+	mark_child_for_cleanup(async->pid, NULL);
=20
 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index cf29a31..3630733 100644
--- a/run-command.h
+++ b/run-command.h
@@ -43,6 +43,7 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
+	void (*clean_on_exit_handler)(pid_t, int);
 };
=20
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
=20
