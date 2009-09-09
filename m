From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Wed, 9 Sep 2009 20:33:50 +0800
Message-ID: <20090909203350.e3d7e5dc.rctay89@gmail.com>
References: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
	 <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
	 <0016e6470f36315b8a0472bc75a8@google.com>
	 <20090904212956.f02b0c60.rctay89@gmail.com>
	 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
	 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
	 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
	 <20090907172751.6cf38640.rctay89@gmail.com>
	 <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 14:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlMNN-0002G3-CI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 14:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbZIIMeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 08:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbZIIMeH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 08:34:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:4214 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbZIIMeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 08:34:05 -0400
Received: by qw-out-2122.google.com with SMTP id 9so348023qwb.37
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Gt6Kr2VfecdhrW6zA/1fxp8qisYrCFg8ngoCT4wOgjA=;
        b=Oy2wbf9gNRaz+EiM0k+MoeIY3WqFLLvwpKWi+l1tCC2CbR8AZ4J+ji4U6Ml+KgeDXh
         X9rBIMe928VPuRtQZFIm5meN+XNQAXpexOvb9g7yfy83dVWI+sRr9kjFM0s0OmIKqtMM
         qswzLcEtYiGNrpcRMhqxuWujBIQ1tRZ7bMRhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=DbhQgprZObyvJ09sgcfFh5ycstjZGEk96xR4rVd66O2TQyDmRfegOHxznCa4IwGTx/
         3KeAXld/LslCJHzANO3cg9Mph1aFR1Ance+1AuyfYIuAcuUEv6lXgNu89QTJDg2Uv9lw
         fjbriKKlXymTqNOw7DOkOmE1MDf3a+WmdvMtE=
Received: by 10.224.52.138 with SMTP id i10mr81981qag.38.1252499647966;
        Wed, 09 Sep 2009 05:34:07 -0700 (PDT)
Received: from your-cukc5e3z5n (cm104.zeta152.maxonline.com.sg [116.87.152.104])
        by mx.google.com with ESMTPS id 23sm418841qyk.15.2009.09.09.05.34.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Sep 2009 05:34:07 -0700 (PDT)
In-Reply-To: <be6fef0d0909080610j89c0a4bkf1cb0119b9b11db@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128065>

Hi,

On Tue, Sep 8, 2009 at 9:10 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Tue, Sep 8, 2009 at 3:06 AM, Junio C Hamano<gitster@pobox.com> wrote:
>> I am torn about this.
>>
>> On one hand, if we are going to treat such a half failure as nothing
>> conclusive, I do not see a point to keep that check to begin with.
>>
>> On the other hand, if a HEAD request to a URL results in an unauthorized,
>> what plausible excuse the server operator could give for allowing a GET
>> request to the same URL?  If we are going to keep the check if *.pack that
>> corresponds to the *.idx will be available, shouldn't we trust whatever
>> check we perform?
>
> I am in favour or removing this check, not just due to its
> unreliability, but for the sake of consistency (we very rarely send a
> HEAD request to poll data before doing a GET).

my patch below is in response to earlier deliberation.

I still think github.com should look into this issue (of differing
responses for HEAD and GET requests).

 -- >8 --

Subject: [PATCH] http.c: remove verification of remote packs

Make http.c::fetch_pack_index() no longer check for the remote pack
with a HEAD request before fetching the corresponding pack index file.

Not only does sending a HEAD request before we do a GET incur a
performance penalty, it does not offer any significant error-
prevention advantages (pack fetching in the *_http_pack_request()
methods is capable of handling any errors on its own).

This addresses an issue raised elsewhere:

  http://code.google.com/p/msysgit/issues/detail?id=323
  http://support.github.com/discussions/repos/957-cant-clone-over-http-or-git

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Junio, I'm not sure if the credits and references ("This addresses...")
should be included, since the patch doesn't look like it's fixing any
thing, even though it is a response to an acknowledged issue.

Please remove those lines if you so wish.

 http.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/http.c b/http.c
index 5926c5b..84def9f 100644
--- a/http.c
+++ b/http.c
@@ -869,17 +869,6 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	char *url;
 	struct strbuf buf = STRBUF_INIT;

-	/* Don't use the index if the pack isn't there */
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack", hex);
-	url = strbuf_detach(&buf, 0);
-
-	if (http_get_strbuf(url, NULL, 0)) {
-		ret = error("Unable to verify pack %s is available",
-			    hex);
-		goto cleanup;
-	}
-
 	if (has_pack_index(sha1)) {
 		ret = 0;
 		goto cleanup;
--
1.6.4.2
