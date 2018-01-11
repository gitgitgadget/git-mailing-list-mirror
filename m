Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4228B1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965372AbeAKS6K (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:58:10 -0500
Received: from mout.web.de ([212.227.17.11]:56049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965208AbeAKS6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:58:07 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbrQm-1fGRFF2PLw-00jKol; Thu, 11
 Jan 2018 19:57:45 +0100
Subject: Re: [PATCH v2 4/9] object: add clear_commit_marks_all()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <ec45f9a8-292a-53e2-52b6-44d744cb6c36@web.de>
 <20180110075838.GD16315@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a0ca86b8-e258-2588-1c99-a30e8e60fdbd@web.de>
Date:   Thu, 11 Jan 2018 19:57:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180110075838.GD16315@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3xBTIe4H3Fo7vinwm7zrKHEG7sRltQ6zhNjdCoVE6K49BwCX71E
 u9S8jx7KSKKp5ZPJ2rtdmWTfMNnOu9Rbr+iTJ39bGdO0kXBWbmk1TdJfJPwTtyqNJZv2y0c
 93oAaHJl4KSQspSmVzjnPrlQKhH4WUxfGV/DJnRH/nfeEcg7T1m5rcnnXFncEt1xYRgQ4q8
 HFHGJMo+OzuUAAfsnBy5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:reNzE9bB1uM=:p9Mnbv72jYlaC1o81N9ed2
 6PSapKxw8NT1zdIMmQ4gmQfjqDDb5PskKAn6wxashdSRVamTmVND+Za9TIlzIRBbpbU6hL6sw
 H5vN1cuZUN+qFRkWtzUIdHkUFll8lrUzlhLqCHKAUVYmQhAV4cobSeZvCSX2GZvQkcSAMAndV
 RcnXzcHBjHLWYz8nWdGoDvXp9+hxh2mvXQALFzzFwSoRXsXH6nH+CneyMWLsUSWXkj8bt0TWS
 xzOUsC061Z/E0FnT7CenWyqgRnj4HbaKjyuVCX93tcyuY4MeNfAvWTsz5geuvhaEG9CnasbQR
 QC1rbsWganDXIJVvTonijX3O7rpg+y/8kFbsCLQEPr3K81nNYq3dXQPha6c/eHoAv8Gr4CQZD
 KMKhXDxfrZOgO1FcWr7Pt147OWuvL/CWy6j4Bj4Fo+a1AiyyemLILges5tfDsEUCMz/NdJIzO
 obnyZmRSkIN3XwwrFA2F3Dw0xP2Tx5s9xK54+KKZjUJ5Ib9l3mzPo/HQDhs05L0iIHzP5XJBg
 1nnPw+R0ugjyynfUvcMJR9ZdMSIJccDG0b9YnzW5DWbFQDAF1anvQoun+ZRnHkC2Rbids8BTf
 1iOSA/pC9Sm4r+o+wuIFGoCnfzLu+JNex+KVEA5/hIgggIGZAYhwfbsxshF7EGzH9BYcwb3X3
 QFHpYp77F/kQnuNDY0CiXePqzJz+pyTMeyEloLJ/OYMjyhQMQYUYTrCjbwDkvGa0wXY6qgKt2
 2g9K0/1wMU0GYhrGPbUhsD0bG5sr8aslkPD5JrVt2Lc1Tl8bRVz5XOWIA5iwPNskn89IN+Q0a
 pvTESq9dPUbjbmDUmG1vR00tC+yhLDQJdcqmGLrNEt6sdu+FZ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2018 um 08:58 schrieb Jeff King:
> On Mon, Dec 25, 2017 at 06:44:58PM +0100, René Scharfe wrote:
> 
>> Add a function for clearing the commit marks of all in-core commit
>> objects.  It's similar to clear_object_flags(), but more precise, since
>> it leaves the other object types alone.  It still has to iterate through
>> them, though.
> 
> Makes sense.
> 
> Is it worth having:
> 
>    void clear_object_flags_from_type(int type, unsigned flags);
> 
> rather than having two near-identical functions? I guess we'd need some
> way of saying "all types" to reimplement clear_object_flags() as a
> wrapper (OBJ_NONE, I guess?).

I don't know if there is a demand.  Perhaps the two callers of
clear_object_flags() should be switched to clear_commit_marks_all()?
They look like they only care about commits as well.  Or is it safe to
stomp over the flags of objects of other types?  Then we'd only need
to keep clear_object_flags()..

> The run-time check is maybe a little bit slower in the middle of a tight
> loop, but I'm not sure it would matter much (I'd actually be curious if
> this approach is faster than the existing traversal code, too).

I don't know how to measure this properly.  With 100 runs each I get
this for the git repo and the silly test program below, which measures
the duration of the respective function call:

   mean        stddev method
   ----------- ------ ----------------------
   5.89763e+06 613106 clear_commit_marks
   2.72572e+06 507689 clear_commit_marks_all
   1.96582e+06 494753 clear_object_flags

So these are noisy numbers, but kind of in the expected range.

René

---
 Makefile                           |  1 +
 t/helper/test-clear-commit-marks.c | 67 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 t/helper/test-clear-commit-marks.c

diff --git a/Makefile b/Makefile
index 1a9b23b679..7db2c6ca7f 100644
--- a/Makefile
+++ b/Makefile
@@ -648,6 +648,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-clear-commit-marks
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
diff --git a/t/helper/test-clear-commit-marks.c b/t/helper/test-clear-commit-marks.c
new file mode 100644
index 0000000000..296ca0286f
--- /dev/null
+++ b/t/helper/test-clear-commit-marks.c
@@ -0,0 +1,67 @@
+#include "cache.h"
+#include "commit.h"
+#include "revision.h"
+
+static void start(struct timespec *start)
+{
+	clock_gettime(CLOCK_MONOTONIC, start);
+}
+
+static void print_duration(struct timespec *start)
+{
+	struct timespec end;
+	uint64_t d;
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	d = end.tv_sec - start->tv_sec;
+	d *= 1000000000;
+	d += end.tv_nsec - start->tv_nsec;
+	printf("%lu", d);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	struct rev_info revs;
+	struct object_id oid;
+	struct commit *commit;
+	struct timespec ts;
+
+	setup_git_directory();
+
+	if (get_oid("HEAD", &oid))
+		die("No HEAD?");
+	commit = lookup_commit(&oid);
+	if (!commit)
+		die("HEAD is not a committish?");
+
+	init_revisions(&revs, NULL);
+	add_pending_object(&revs, &commit->object, "HEAD");
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	while (get_revision(&revs))
+		; /* nothing */
+
+	if (argc != 2)
+		return 0;
+
+	if (!strcmp(argv[1], "clear_commit_marks")) {
+		start(&ts);
+		clear_commit_marks(commit, ALL_REV_FLAGS);
+		print_duration(&ts);
+	}
+
+	if (!strcmp(argv[1], "clear_commit_marks_all")) {
+		start(&ts);
+		clear_commit_marks_all(ALL_REV_FLAGS);
+		print_duration(&ts);
+	}
+
+	if (!strcmp(argv[1], "clear_object_flags")) {
+		start(&ts);
+		clear_object_flags(ALL_REV_FLAGS);
+		print_duration(&ts);
+	}
+
+	printf(" %s\n", argv[1]);
+
+	return 0;
+}
-- 
2.15.1
