From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed
 selectors
Date: Thu, 10 May 2012 09:39:44 -0700
Message-ID: <7vd36cng6n.fsf@alter.siamese.dyndns.org>
References: <20120504052106.GA15970@sigill.intra.peff.net>
 <20120504052725.GD16107@sigill.intra.peff.net>
 <7v7gwrc212.fsf@alter.siamese.dyndns.org>
 <20120507213752.GA19911@sigill.intra.peff.net>
 <20120510153754.GA23941@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, 
 Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Andreas Schwab
 <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>
X-From: magit+bncCI3_0YzZExDT3q_9BBoEuw4taA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 10 18:39:52 2012
Return-path: <magit+bncCI3_0YzZExDT3q_9BBoEuw4taA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCI3_0YzZExDT3q_9BBoEuw4taA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SSWP6-0005Xe-Cs
	for gcvgm-magit-3@m.gmane.org; Thu, 10 May 2012 18:39:48 +0200
Received: by yenq6 with SMTP id q6sf1905447yen.3
        for <gcvgm-magit-3@m.gmane.org>; Thu, 10 May 2012 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=Z4KbiGtS70N+8e0hScR9xKStBOnXByoeRVyumgG7i9s=;
        b=hEkt0GY0oUg0TPK1e8YaUfTyHb/29ok+h+6ZT6ljzRSng44k+IZUVN+Tway0S6bYcv
         HYz5pRHw6CgU+xZ68LVofUiix8k5D0CcxGd0YFJGshXhtkLe/toenBApFCbqKUVHe4TJ
         tzY/d7hP6iuHV4WceghRbbrJn3x+QvuxKLFus=
Received: by 10.52.34.8 with SMTP id v8mr229724vdi.5.1336667987540;
        Thu, 10 May 2012 09:39:47 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.52.173.225 with SMTP id bn1ls2762397vdc.6.gmail; Thu, 10 May
 2012 09:39:47 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr3705382vdb.6.1336667987074;
        Thu, 10 May 2012 09:39:47 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr3705381vdb.6.1336667987062;
        Thu, 10 May 2012 09:39:47 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id l12si2989883vdf.3.2012.05.10.09.39.46;
        Thu, 10 May 2012 09:39:47 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F1B47BE3;
	Thu, 10 May 2012 12:39:46 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F3887BE1;
	Thu, 10 May 2012 12:39:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 804477BDE; Thu, 10 May 2012
 12:39:45 -0400 (EDT)
In-Reply-To: <20120510153754.GA23941-bBVMEuqLR+SYVEpFpFwlB0AkDMvbqDRI@public.gmane.org> (Jeff King's
 message of "Thu, 10 May 2012 11:37:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C01FE422-9ABE-11E1-A902-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates
 208.72.237.35 as permitted sender) smtp.mail=junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197595>

Jeff King <peff-AdEPDUrAXsQ@public.gmane.org> writes:

> PS It would have been nice to see the patch on the list for review. I
>    only noticed it because it hit 'next', and had a minor conflict with
>    my patches in the area.

Heh, it was sent before I gave you this message:

        From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
        Subject: Re: [PATCH 4/4] reflog-walk: always make HEAD@{0} show indexed selectors
        To: Jeff King <peff-AdEPDUrAXsQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
        Date: Mon, 07 May 2012 14:54:24 -0700

        Jeff King <peff-AdEPDUrAXsQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:

        > I think some of the callers set dmode to DATE_NORMAL explicitly. So this
        > code would be confused into thinking that the user had asked for it
        > explicitly. Or maybe it happens before the date_mode_explicit check, and
        > it would be OK. I'd have to do audit the code.

        Yeah, that is why today's update I sent does not use DATE_DEFAULT, which
        is after all a hack to piggy-back logically a separate bit in the same
        variable.  What we are trying to tell these two functions are (1) does the
        caller prefer to use counted notation or dated notation?  and (2) if the
        output shows the timestamp, what format should be used.

The message "today's update I sent" refers to is this.

I suspect that the original thread came from a message cross-posted to
magit list whose participants somehow seem to mangle e-mail addresses when
interacting with gmane, and it ended up mangling our e-mail addresses but
the e-mail relay at gmane probably dropped the messages.

-- >8 --

Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:

    Administrivia: these gmane-mangled e-mail addresses are extremely
    annoying.  Please do not cross post with any insane list that choose
    to turn that feature on when sending message to the git list; thanks.

> Jeff King <peff-AdEPDUrAXsQ-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>
>> This patch flips the rules to:
>>
>>   1. if the user asked for ref@{0}, always show the index
>>
>>   2. if the user asked for ref@{now}, always show the date
>>
>>   3. otherwise, we have just "ref"; show them counted by
>>      default, but respect the presence of "--date" as a clue
>>      that the user wanted them date-based
>
> The revision.c parser for "git log --date=default -g master" would flip
> the "explicit" bit, revs->date_mode is set to DATE_NORMAL, and that value
> will eventually come as dmode here.
> ...
> But DATE_NORMAL happens to be zero ;-) "git log --date=default -g master"
> would still show the counted version.
>
> I personally do not care about that behaviour, but I know that I will
> later later have to deal with people who do care, which is annoying.

How about doing it this way?  After all, we are internally holding a bit
but the problem is that bit is lost near the tip of the callchain.

The two integer arguments to get_reflog_selector() and the two integer
arguments to show_reflog_message() might want to become two bits in one
"unsigned flags", but the former wants "do we want date?  do we want a
short output?" two bits, while the latter wants "do we want date?  do we
want a oneline output?", so I didn't bother squashing them into one flag
word with three-bit assigned.  Perhaps we should, but I dunno.

-- >8 --
Subject: [PATCH] reflog-walk: tell --date=default from not having --date at all

Introduction of opt->date_mode_explicit was a step in the right direction,
but lost that crucial bit at the very end of the callchain, and the callee
could not tell an explicitly specified "I want *date* but in default format"
from the built-in default value passed when there was no --date specified.

Signed-off-by: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
---
 log-tree.c             | 7 +++----
 pretty.c               | 5 ++---
 reflog-walk.c          | 8 ++++----
 reflog-walk.h          | 4 ++--
 t/t1411-reflog-show.sh | 8 ++++----
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5f9e59a..588117e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -493,10 +493,9 @@ void show_log(struct rev_info *opt)
 			 * graph info here.
 			 */
 			show_reflog_message(opt->reflog_info,
-				    opt->commit_format == CMIT_FMT_ONELINE,
-				    opt->date_mode_explicit ?
-					opt->date_mode :
-					DATE_NORMAL);
+					    opt->commit_format == CMIT_FMT_ONELINE,
+					    opt->date_mode,
+					    opt->date_mode_explicit);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/pretty.c b/pretty.c
index efd62e8..25944de 100644
--- a/pretty.c
+++ b/pretty.c
@@ -956,9 +956,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_selector(sb,
 						    c->pretty_ctx->reflog_info,
-						    c->pretty_ctx->date_mode_explicit ?
-						      c->pretty_ctx->date_mode :
-						      DATE_NORMAL,
+						    c->pretty_ctx->date_mode,
+						    c->pretty_ctx->date_mode_explicit,
 						    (placeholder[1] == 'd'));
 			return 2;
 		case 's':	/* reflog message */
diff --git a/reflog-walk.c b/reflog-walk.c
index b84e80f..0c904fb 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -252,7 +252,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 enum date_mode dmode,
+			 enum date_mode dmode, int force_date,
 			 int shorten)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
@@ -273,7 +273,7 @@ void get_reflog_selector(struct strbuf *sb,
 
 	strbuf_addf(sb, "%s@{", printed_ref);
 	if (commit_reflog->selector == SELECTOR_DATE ||
-	    (commit_reflog->selector == SELECTOR_NONE && dmode)) {
+	    (commit_reflog->selector == SELECTOR_NONE && force_date)) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {
@@ -302,7 +302,7 @@ void get_reflog_message(struct strbuf *sb,
 }
 
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
-	enum date_mode dmode)
+			 enum date_mode dmode, int force_date)
 {
 	if (reflog_info && reflog_info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
@@ -310,7 +310,7 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		struct strbuf selector = STRBUF_INIT;
 
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
-		get_reflog_selector(&selector, reflog_info, dmode, 0);
+		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
 			printf("%s: %s", selector.buf, info->message);
 		}
diff --git a/reflog-walk.h b/reflog-walk.h
index 7bd2cd4..3adccb0 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -11,12 +11,12 @@ extern int add_reflog_for_walk(struct reflog_walk_info *info,
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
-		enum date_mode);
+				enum date_mode, int force_date);
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
-		enum date_mode dmode,
+		enum date_mode dmode, int force_date,
 		int shorten);
 
 #endif
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 7d9b5e3..9a105fe 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -73,20 +73,20 @@ test_expect_success 'using @{now} syntax shows reflog date (format=%gd)' '
 '
 
 cat >expect <<'EOF'
-Reflog: HEAD@{1112911993 -0700} (C O Mitter <committer-hcDgGtZH8xNBDgjK7y7TUQ@public.gmane.org>)
+Reflog: HEAD@{Thu Apr 7 15:13:13 2005 -0700} (C O Mitter <committer-hcDgGtZH8xNBDgjK7y7TUQ@public.gmane.org>)
 Reflog message: commit (initial): one
 EOF
 test_expect_success 'using --date= shows reflog date (multiline)' '
-	git log -g -1 --date=raw >tmp &&
+	git log -g -1 --date=default >tmp &&
 	grep ^Reflog <tmp >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<'EOF'
-e46513e HEAD@{1112911993 -0700}: commit (initial): one
+e46513e HEAD@{Thu Apr 7 15:13:13 2005 -0700}: commit (initial): one
 EOF
 test_expect_success 'using --date= shows reflog date (oneline)' '
-	git log -g -1 --oneline --date=raw >actual &&
+	git log -g -1 --oneline --date=default >actual &&
 	test_cmp expect actual
 '
 
-- 
1.7.10.1.500.g37b1e9a
