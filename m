From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Tue, 26 Aug 2008 10:16:41 +0200
Message-ID: <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 10:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXtkL-0003f7-68
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbYHZIQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbYHZIQn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:16:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:26690 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYHZIQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:16:42 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2223106wfd.4
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dsnmqSdsacTMfLJ+0XRf+6P4sMUsIwx+12PH12dtvhE=;
        b=qkWyz8f3j2Ho0gKA/C6NujbByj8yLU23HPI4v+HvBM6Q+C+nqe+gyeaBVucymx9cAX
         p43r9eXRp8r/AtOZ3Oegfi63j/NRNN7KhK6eeYSYIcMA5cmdcHAK4Ci+MNaoOrQCOLpN
         Hja7pezfhGb0geamtPjB3GZYM1/PlWcXvor8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=i7c88YaMP/lRvguIHGuzE/tZZeX4XTftHAaGLTiwIZraavp/zx4z84svUDRDHdLt9b
         rlJk6g4kco9cOZroqmvLjMZdbQhVHH7Oi7xz0gVwJqRpZS0+vjC2F7xjHP7Am0xqS7Ie
         uz+GZEdysiWBnPV7NPqgzaPAf9Hn3e3leacQ0=
Received: by 10.142.139.19 with SMTP id m19mr1903417wfd.25.1219738601919;
        Tue, 26 Aug 2008 01:16:41 -0700 (PDT)
Received: by 10.142.148.17 with HTTP; Tue, 26 Aug 2008 01:16:41 -0700 (PDT)
In-Reply-To: <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93725>

On Tue, Aug 26, 2008 at 2:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> With the existing flow, I would actually suggest you not to use
> origin/master at all.  The example before you inserted your changes does
> not update origin/master.
>
>        Alice can use gitk to compare what both of them did:
>
>        $ gitk HEAD FETCH_HEAD
>
> then teach the limiting:
>
>        Notice unlike the earlier example that you used gitk to view the
>        history leading to current status, this shows both histories
>        leading to Alice's current state (HEAD) and the state you just
>        fetched from Bob (FETCH_HEAD).  You can limit what is shown by
>        using revision range notation:
>
>        $ gitk HEAD..FETCH_HEAD
>
>        Two commits written with two dots in between means "show
>        everything that is reachable from the latter but excluding
>        anything that is reachable from the former".  Alice already knows
>        what she did well, as well as what she and Bob started working on,
>        and she is only interested in what Bob did since their histories
>        forked, working independently.
>
>        By the way, the notation "git log -p ..FETCH_HEAD" you saw
>        earlier is a short-hand for "git log -p HEAD..FETCH_HEAD".  HEAD,
>        that means your current state, can be dropped on either side of
>        the two-dot range notation.
>
> It might be better to remove the last paragraph, and instead explain the
> meaning of "..FETCH_HEAD" notation immediately after "git log -p" was used
> to "fetch-review-but-not-integrate" description (i.e. before the part your
> patch touched).
>
> If you want to, you can also teach three-dot form after showing how to use
> the two-dot form.
>
>        Alice may want to view what both of them did since they forked.
>        She can use three-dot form instead of the two-dot form:
>
>        $ gitk HEAD...FETCH_HEAD
>
>        This means "show everything that is reachable from either one, but
>        exclude anything that is reachable from both of them".
>
>        Again, note that these range notation can be used with both gitk
>        and "git log".
>

Maybe something like that?
Not intended to be applied, probably manglade and with no sob.
Just for discussion:

diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
index 48d1454..4f6d4e9 100644
--- a/gittutorial.txt.txt
+++ b/gittutorial.txt.txt
@@ -321,10 +321,51 @@ pulling, like this:

 ------------------------------------------------
 alice$ git fetch /home/bob/myrepo master
-alice$ git log -p ..FETCH_HEAD
+alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------

 This operation is safe even if Alice has uncommitted local changes.
+Note that HEAD, that means your current state, can be dropped on either
+side of the two-dot range notation.
+This means that Alice can also inspect what Bod did issuing the following
+command:
+
+------------------------------------------------
+alice$ git log -p ..FETCH_HEAD
+------------------------------------------------
+
+Alice can use gitk to compare what both of them did:
+
+------------------------------------------------
+$ gitk HEAD FETCH_HEAD
+------------------------------------------------
+
+This shows both histories leading to Alice's current state (HEAD) and the
+state Alice just fetched from Bob (FETCH_HEAD).
+
+If Alice wants to visualize what Bob did since their historie forked
+she can issue the following command:
+
+------------------------------------------------
+$ gitk HEAD..FETCH_HEAD
+------------------------------------------------
+
+Two commits written with two dots in between means "show
+everything that is reachable from the latter but excluding
+anything that is reachable from the former".
+
+Alice may want to view what both of them did since they forked.
+She can use three-dot form instead of the two-dot form:
+
+------------------------------------------------
+$ gitk HEAD...FETCH_HEAD
+------------------------------------------------
+
+This means "show everything that is reachable from either one, but
+exclude anything that is reachable from both of them".
+
+Please note that these range notation can be used with both gitk
+and "git log".

 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history



Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
