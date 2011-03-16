From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] diff --submodule: suppress -Wuninitialized warning by
 initializing to NULL
Date: Wed, 16 Mar 2011 06:37:11 -0500
Message-ID: <20110316113711.GE15739@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
 <20110316105709.GC8277@elie>
 <20110316113540.GB15739@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzp2g-0001YZ-Qx
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab1CPLhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:37:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63164 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1CPLhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:37:16 -0400
Received: by gxk21 with SMTP id 21so610771gxk.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KKBU9vlf4PahW218kPFJaQ4P5rWp5wwOHd4dLtorges=;
        b=O207mWDlyaKlHLXAyA0RV5IcLr3VAcVadrxqGvBa82k9Bk5CdvfzE066M7IxI809AF
         wBZiEDEpLXeTMlJf8fuE7NHHrorxLv0BUE/WGSImqF1TTdrEM91jS73iNvV8JW2ywtTz
         jBmesEmuz08AjP5G2oW92WJaKR8Zys0sb61LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PU3eRUbseQfq6e9+lyaWNLGYdEhTrM2BFj1mToEC5bL2KT2a4YPR7M3rJios+JxmzO
         FPia31zO2PDAkV3DORNmck7L3FsjLd8S2Ulky1pttdNu9JG7a6RgqRPxbSKvB+YfdLdO
         ljM7pgN4WP0MOCBgnJlpoy5wIkCpU+rq/PhZw=
Received: by 10.150.72.23 with SMTP id u23mr1158897yba.343.1300275435505;
        Wed, 16 Mar 2011 04:37:15 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id f2sm687467ybh.7.2011.03.16.04.37.14
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 04:37:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316113540.GB15739@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169144>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index dcbb2d3..a7a7203 100644
--- a/submodule.c
+++ b/submodule.c
@@ -158,7 +158,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left, *right;
+	struct commit *commit, *left = NULL, *right = NULL;
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-- 
1.7.4.1
