From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sun, 29 Apr 2012 15:07:49 -0700
Message-ID: <7vlilexkcq.fsf@alter.siamese.dyndns.org>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
 <87wr4za9mr.fsf@gmail.com> <m2pqasb8mr.fsf@linux-m68k.org>
 <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
 <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
 <20380.33897.666338.766096@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  Andreas Schwab
 <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,  Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  Eli Barzilay
 <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>,  
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  Eli
 Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>, 
 magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>, Thomas Rast <trast-oe7qfRrRQfdfcPYw/2PL0g@public.gmane.org>
X-From: magit+bncCI3_0YzZExC49_b8BBoEhg2fCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Apr 30 00:07:55 2012
Return-path: <magit+bncCI3_0YzZExC49_b8BBoEhg2fCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-iy0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCI3_0YzZExC49_b8BBoEhg2fCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SOcHZ-0003Oe-Ve
	for gcvgm-magit-3@m.gmane.org; Mon, 30 Apr 2012 00:07:54 +0200
Received: by iaae16 with SMTP id e16sf3564189iaa.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 29 Apr 2012 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=LaRFBPycLsj/ZKHMt7rHGJfMdGtRVVo3hE4DrQFiQ18=;
        b=j6zQaDZfARBumK06snWAi3FSaZY2dqc9G7hsjvY8Vn5mz5HvVTlrbwsIB939YNJDX2
         FLELFT1hJlLZa3ASoby2I6Wdz8xisRFNMYP4QDAATvv1y4hwFa/ZzjTRIToyHvUrBtVl
         iiZjl7VKQOyuQeiiBZyvtH+9AfiaI5dyLSBjY=
Received: by 10.229.136.197 with SMTP id s5mr175479qct.5.1335737272453;
        Sun, 29 Apr 2012 15:07:52 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.224.59.16 with SMTP id j16ls3558706qah.8.gmail; Sun, 29 Apr
 2012 15:07:52 -0700 (PDT)
Received: by 10.224.182.11 with SMTP id ca11mr7058852qab.1.1335737271980;
        Sun, 29 Apr 2012 15:07:51 -0700 (PDT)
Received: by 10.224.182.11 with SMTP id ca11mr7058851qab.1.1335737271967;
        Sun, 29 Apr 2012 15:07:51 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id a39si5040964qch.0.2012.04.29.15.07.51;
        Sun, 29 Apr 2012 15:07:51 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio-hrAtEEWgPAZD4dQB+ktFXD1X8v8AiJow@public.gmane.org designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9B865FD;
	Sun, 29 Apr 2012 18:07:51 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0DA265F8;
	Sun, 29 Apr 2012 18:07:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0108065F6; Sun, 29 Apr 2012
 18:07:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C30AACB4-9247-11E1-8784-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196517>

Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org> writes:

> ...  In any case,
> it is also questionable -- reading the documentation for %gd:
>
>            =C2=B7    %gD: reflog selector, e.g., refs/stash@{1}
>            =C2=B7    %gd: shortened reflog selector, e.g., stash@{1}
>
> makes it look like the problem is there -- in get_reflog_selector() --
> which has explicit code for showing the dates.  (This was done in
> 8f8f5476.)

I think the root cause of the bug is that there are three cases:

 - If we ask for "log -g ref@{0}", we should show them counted no matter =
what.

 - If we ask for "log -g ref@{now}", we should show them timed no matter =
what.

 - If we ask for "log -g ref" without specifier, we show them counted by
   default, but we try to be nice and show them timed when we can infer
   from other context that the user wanted to see them timed.

An ancient 4e244cb (log --reflog: honour --relative-date, 2007-02-08) was
what introduced the "explicit code for showing the dates", but it was don=
e
somewhat poorly---it does not differentiate the first and third case.

Once we fix *that* bug, to disable the "timed" codepath altogether when
the caller gives "ref@{0}" to explicitly ask for counted output, we can
fix it a lot easily.

And the patch to do so should look like this; I'll leave it to the reader=
s
to add whatever tests that are appropriate.

 git-stash.sh  |    2 +-
 reflog-walk.c |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fe4ab28..590c1f3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -265,7 +265,7 @@ have_stash () {
=20
 list_stash () {
 	have_stash || return 0
-	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
+	git log --format=3D"%gd: %gs" -g "$@" "$ref_stash@{0}" --
 }
=20
 show_stash () {
diff --git a/reflog-walk.c b/reflog-walk.c
index 86d1884..6fe60a8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -126,7 +126,10 @@ static void add_commit_info(struct commit *commit, v=
oid *util,
 }
=20
 struct commit_reflog {
-	int flag, recno;
+	int recno;
+#define REFLOG_COUNTED 01
+#define REFLOG_TIMED   02
+	unsigned flags;
 	struct complete_reflogs *reflogs;
 };
=20
@@ -150,6 +153,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info=
,
 	struct complete_reflogs *reflogs;
 	char *branch, *at =3D strchr(name, '@');
 	struct commit_reflog *commit_reflog;
+	unsigned flags =3D 0;
=20
 	if (commit->object.flags & UNINTERESTING)
 		die ("Cannot walk reflogs for %s", name);
@@ -162,6 +166,9 @@ int add_reflog_for_walk(struct reflog_walk_info *info=
,
 		if (*ep !=3D '}') {
 			recno =3D -1;
 			timestamp =3D approxidate(at + 2);
+			flags =3D REFLOG_TIMED;
+		} else {
+			flags =3D REFLOG_COUNTED;
 		}
 	} else
 		recno =3D 0;
@@ -199,8 +206,8 @@ int add_reflog_for_walk(struct reflog_walk_info *info=
,
 	}
=20
 	commit_reflog =3D xcalloc(sizeof(struct commit_reflog), 1);
-	if (recno < 0) {
-		commit_reflog->flag =3D 1;
+	commit_reflog->flags =3D flags;
+	if (flags & REFLOG_TIMED) {
 		commit_reflog->recno =3D get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
 			free(branch);
@@ -267,7 +274,8 @@ void get_reflog_selector(struct strbuf *sb,
 	}
=20
 	strbuf_addf(sb, "%s@{", printed_ref);
-	if (commit_reflog->flag || dmode) {
+	if ((! (commit_reflog->flags && (REFLOG_COUNTED | REFLOG_TIMED)) && dmo=
de) ||
+	    (commit_reflog->flags & REFLOG_TIMED)) {
 		info =3D &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {
