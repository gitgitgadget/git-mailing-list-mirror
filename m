From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Tue, 23 Sep 2008 18:56:56 +0700
Message-ID: <20080923115655.GA7140@laptop>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <m31vzen4v5.fsf@localhost.localdomain> <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com> <200809202001.28383.jnareb@gmail.com> <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com> <7vzlm21n83.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com> <adf1fd3d0809230406r598f6d1l41cd860568de761f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/U2FudGlfQj1FOWphcl8=?= 
	<santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki6X8-0007A4-34
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 13:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYIWL5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 07:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYIWL5L
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 07:57:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:40291 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYIWL5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 07:57:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2146711wfd.4
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rM+h8VUF6JP6Ku5EMJu2tPMGYgwvDUga+9wPnIB0UsQ=;
        b=hmydfph5ztYJaInjF/3y0TFpcGF8g5WVrwP/HK0jZfxSgums6HU90FWPr9V5H6ssi5
         phnFzcXHKTBiG33xxL9nl/tmurPMdJvHqKOSAgcR1BNDZyobUs9/doYQNzwrzOZDMdgK
         Wz5HvA56ALKg5jh2MtHLuTLY/I3TXgi8SLEHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MJavNOJaRrdW4/UOqUW4ojYB5KVPkVP3HavhWSqfCkixJD2yoztYMPRaqPY6Woz+/k
         Loj37cbHGtOr7KzeefBsy/Vd1drKEkR2zj6Z4pnUIJPJWi3QplsY1tBeZQQkL8dvMW1X
         MHbUckgrwgJlhXkAUy0z/gfldhoAr8bAtWIKE=
Received: by 10.142.134.17 with SMTP id h17mr1933910wfd.346.1222171028820;
        Tue, 23 Sep 2008 04:57:08 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.60.45])
        by mx.google.com with ESMTPS id 22sm9856128wfg.13.2008.09.23.04.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 04:57:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 23 Sep 2008 18:56:56 +0700
Content-Disposition: inline
In-Reply-To: <adf1fd3d0809230406r598f6d1l41cd860568de761f@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96552>

On Tue, Sep 23, 2008 at 01:06:47PM +0200, =?ISO-8859-1?Q?Santi_B=E9jar_ wrote:
> While I agree that the checkout attr looks like an attribute (so
> reusing attr.c is a good idea) and $GIT_DIR/info/gitattributes seems a
> good place to specify them, I think it will be better in the config
> $GIT_DIR/config. There it is clear that it is a local thing and you
> have "git config" to read and write them. Additionally you could have
> different patterns in the config (sparse.default, sparse.doc,
> sparse.src,...), although maybe it is not very useful.
> 
> I think the main UI to sparse checkout should be a default sparse
> pattern that is used for "all" commands, like merge, reset, and
> checkout. Now it is too easy to escape from the sparse checkout, when
> you merge or checkout a branch with new files, when doing a "git reset
> --hard" (when you abort a failed merge), or when doing a diff
> (specially when you pull).

It should not escape that easy (except newly added files). There is a
bug in my apply_narrow_spec() that effectively disables sparse
checkkout for other unpack_trees() calls except checkout/clone. Try
the below patch.

diff --git a/unpack-trees.c b/unpack-trees.c
index 10f377c..5bbe016 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -146,8 +146,10 @@ static int apply_narrow_spec(struct unpack_trees_options *o)
 	struct index_state *index = &o->result;
 	int i;
 
+	/*
 	if (!(o->new_narrow_path | o->add_narrow_path | o->remove_narrow_path))
 		return 0;
+	*/
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
-- 
Duy
