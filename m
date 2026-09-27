Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12E3ECBCF
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549188; cv=none; b=GBjTLHynHbtHUSNNu8kbjo3tqqdhYANvjncJaBj/+NDyYm+y3c2WkohmemR+Jju6OD2CuhdGtW72x3Jk0DuCs/pNLRZzq8t3B4WmL1XEyWwcOtJKpFoxohLnHX9kv2voC3A1Q4N0PquIvy1SYlGJ2MgSq/nU3GORSIw3vg3xPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549188; c=relaxed/simple;
	bh=E4zKuTG+qFBfIY/1cYyb2J87pmEpry5DtIEd9y38tB4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JOWTIEb2/Sj/RQpXwbFc1rnc1z9Pxkom/wjwvifLkx5q/AW2+jfSqIJ1wOpCxk8929cWcmhHIgO0OQHnBjTdX7qEuJol6PQ+w1QHkH8cBIL4RGd1XcWYFrRI/OGSRtOkKy34ESZrL2yAy1RasHyQnICNVgWP3gJYcoDMWhKSDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjrhgJOB; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjrhgJOB"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-49386210e98so1409321fac.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549185; x=1791153985; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DR2qiIForZwhrPMJLDDpwr5Y62EqeeR0yDuydQpdMb0=;
        b=EjrhgJOBIWmbd7qlMfCrp0Bpqqm4e+7HnduHCHji+Lau9GF2P7ZofkIrgffv1T6jIm
         U12/Mv4+c7hDY34URqqgiFhn2mSIueiLjq5CfX06KPiV6Ozwbj8hpQ+bhX/gpTSB5bNs
         TEfWWVzs13AX4Nw+1UUyvXKqRrUobYwejOgVWWVuRPFNTftEEPyOxJcwTI3TTzVv7ImP
         2VJLGCQVqV+5Qr0vheaiTBMxDGZJ3ywpBt311yhQ9W1qi3nk6pklKcYG1zCLryeswm2k
         6001ttwnOKISVu8zXBrnuvlZqKO0Eg1dhJlMM7iXKgNnnj7I4idTSuBmkSORIeI97Rh9
         DNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549185; x=1791153985;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DR2qiIForZwhrPMJLDDpwr5Y62EqeeR0yDuydQpdMb0=;
        b=K735bBUkglPucGQsgGVkYatl5snOIfqeiEaOQ6RN+SYz6HCxYaIk2oBtHFSiT7ai7U
         1aIA4MYxHTKJo+qf2ipVvVpY94ERwubu0xYEGBpBvetJDSj3RPiKUiU917nBwgHepUmg
         YYuESgi/Pm2REpmcdh8OlleZs/zfMGQ+JKFy0d7tFZ6nPI44TVqCl+ptjx47TPsYCZ/Q
         x6t2SaXX1b1LSiiTr0fAYTKNr8xicTJCNEUR2dfwEbFoaOJ8O+IJ0ifuJdt4LIAZgN+t
         c5sLd2AU0aRUR+qqJrjo6pY8mDL/KjDI0jnawv5ABh4byOGRqOBg0liQB2VEMw0J18II
         KnhA==
X-Gm-Message-State: AFq9FYL8+5biatidnF1Lf7SuqAfRm1iWB8lW4VL6ZJOtDONXeetFCk91
	kT3hkQj81SXPvCuKgNc+8Q+hqo2sNxD95p7tR0JS9UOvS8YdayESRJIKfki1/9Us
X-Gm-Gg: AYBFou2T0nddxOktBy4J0E7UcSrx2a/U6ET4Tzl/8d7kqAk9iGnySIhRhMcxX1HrhPG
	XBUGSVMCpybRTbrt/gO8+1WNcWxn2rDEGNzw+82yM87hxY3AS6O4/ux32nJnxBlHJZJwxLOrJFE
	UChEK/ox35kYQ38GBlkBtnz96EqmjAZoG6EorktANX5VYek6HxzQ/lOEJWebSIyhUDpGWnOf27w
	IxKICmiIgV5Oej0a3nuYBgS1gai94RTPOJt0CKwNfIitzpN4ECcyOEatWIs1mEwccYF03SgSI5t
	RDzTG6TXPlLHd1pFDTEws8RaSPzVK9WwAAsucEHH8p0UZeeP15nfa7e27YCiyi7TjeV1SxfLPMR
	LWVWkcArLZUfSOj+rj7iy20SQ8hOlkmCwfBY/X1gNN8t5LLeLQSkCDeqVcHQK+ztbb0SBZPSDt7
	my+KRtYzT5P6TdGKzi+LKqtA08EfA+0zkEWTLOwN/6PNHC3qcJIH1uf633odPx+YtHbl9guhTJy
	HU=
X-Received: by 2002:a05:6870:a11a:b0:48f:e0e5:a1ea with SMTP id 586e51a60fabf-491eb970e22mr10781223fac.47.1790549184635;
        Sun, 27 Sep 2026 15:46:24 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.180.167])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49335011458sm9060203fac.4.2026.09.27.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:46:23 -0700 (PDT)
Message-Id: <pull.2372.v2.git.git.1790549181518.gitgitgadget@gmail.com>
In-Reply-To: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
From: "Daniel =?UTF-8?Q?Mart=C3=AD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 27 Sep 2026 22:46:21 +0000
Subject: [PATCH v2] credential/libsecret: load secrets explicitly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
    Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Daniel =?UTF-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>,
    =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>

From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>

keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
secret_item_get_secret() of the first match unchecked to
secret_value_get_text() and secret_value_unref(). As libsecret
documents, that secret can be NULL: the search does not load secrets
of locked items, such as when SECRET_SEARCH_UNLOCK fails to unlock
them, and it ignores errors from loading secrets. The GNOME keyring
daemon also silently leaves out of its reply any item which is locked
or which was deleted after the search matched it, e.g. by a concurrent
"credential erase" from another git process. We then print

    secret_value_get_text: assertion 'value' failed
    secret_value_unref: assertion 'value != NULL' failed

before git falls back to prompting for the password.

We could keep the flag and load the secret explicitly only when it is
NULL, but SECRET_SEARCH_LOAD_SECRETS is not part of the search call:
libsecret implements it as a separate GetSecrets D-Bus call after
SearchItems. Drop the flag and instead always load the one secret we
use with secret_item_load_secret_sync(), which reports errors. This
takes as many D-Bus calls as before, and leaves a single code path
that runs every time, rather than a fallback that only runs in a rare
race. libsecret's own secret-tool also loads each secret explicitly
after searching.

An inaccessible item now produces a useful error message instead of
the assertion failures, and git still falls back to prompting. The
race needs a concurrent process or a locked keyring to trigger, so
there is no test.

Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
---
    credential/libsecret: load secrets explicitly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2372%2Fmvdan%2Flibsecret-null-secret-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/mvdan/libsecret-null-secret-v2
Pull-Request: https://github.com/git/git/pull/2372

Range-diff vs v1:

 1:  89d3eee91f ! 1:  b9ddf13fa1 credential/libsecret: load secrets explicitly
     @@ Metadata
       ## Commit message ##
          credential/libsecret: load secrets explicitly
      
     -    secret_service_search_sync() can return an item whose secret is not
     -    loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
     -    silently discards secret-loading failures, and the GNOME keyring
     -    daemon silently omits from its GetSecrets reply any item that is
     -    locked or that was deleted after the search matched it, e.g. by a
     -    concurrent "credential erase" from another git process.
     -
     -    secret_item_get_secret() then returns NULL, which we pass unchecked
     -    to secret_value_get_text() and secret_value_unref(), producing
     +    keyring_get() searches with SECRET_SEARCH_LOAD_SECRETS, then passes
     +    secret_item_get_secret() of the first match unchecked to
     +    secret_value_get_text() and secret_value_unref(). As libsecret
     +    documents, that secret can be NULL: the search does not load secrets
     +    of locked items, such as when SECRET_SEARCH_UNLOCK fails to unlock
     +    them, and it ignores errors from loading secrets. The GNOME keyring
     +    daemon also silently leaves out of its reply any item which is locked
     +    or which was deleted after the search matched it, e.g. by a concurrent
     +    "credential erase" from another git process. We then print
      
              secret_value_get_text: assertion 'value' failed
              secret_value_unref: assertion 'value != NULL' failed
      
     -    and losing the password even when the secret is still retrievable.
     +    before git falls back to prompting for the password.
     +
     +    We could keep the flag and load the secret explicitly only when it is
     +    NULL, but SECRET_SEARCH_LOAD_SECRETS is not part of the search call:
     +    libsecret implements it as a separate GetSecrets D-Bus call after
     +    SearchItems. Drop the flag and instead always load the one secret we
     +    use with secret_item_load_secret_sync(), which reports errors. This
     +    takes as many D-Bus calls as before, and leaves a single code path
     +    that runs every time, rather than a fallback that only runs in a rare
     +    race. libsecret's own secret-tool also loads each secret explicitly
     +    after searching.
      
     -    Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
     -    one item we use with secret_item_load_secret_sync(), which does
     -    report errors. A secret the search would have silently dropped is
     -    now retrieved normally, and a genuinely inaccessible item produces
     -    a useful message instead of assertion spew, with git falling back
     -    to prompting either way. Merely guarding against NULL would avoid
     -    the assertions, but would forfeit a secret that is still available.
     -    The cost is unchanged: the search no longer batch-fetches the
     -    secrets of all matching items, and the explicit load fetches the
     -    one we use.
     +    An inaccessible item now produces a useful error message instead of
     +    the assertion failures, and git still falls back to prompting. The
     +    race needs a concurrent process or a locked keyring to trigger, so
     +    there is no test.
      
          Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
      
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(
      +
      +		/*
      +		 * Load the secret explicitly rather than via
     -+		 * SECRET_SEARCH_LOAD_SECRETS, which silently discards load
     -+		 * failures and returns items whose secret is NULL.
     ++		 * SECRET_SEARCH_LOAD_SECRETS, which skips locked items and
     ++		 * ignores load failures, leaving the secret NULL.
      +		 */
      +		if (!secret_item_load_secret_sync(item, NULL, &error)) {
      +			g_critical("could not load secret: %s", error->message);


 .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 941b2afd5e..ad4f60e4d7 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -126,7 +126,7 @@ static int keyring_get(struct credential *c)
 	items = secret_service_search_sync(service,
 					   &schema,
 					   attributes,
-					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
+					   SECRET_SEARCH_UNLOCK,
 					   NULL,
 					   &error);
 	g_hash_table_unref(attributes);
@@ -143,6 +143,18 @@ static int keyring_get(struct credential *c)
 		gchar **parts;
 
 		item = items->data;
+
+		/*
+		 * Load the secret explicitly rather than via
+		 * SECRET_SEARCH_LOAD_SECRETS, which skips locked items and
+		 * ignores load failures, leaving the secret NULL.
+		 */
+		if (!secret_item_load_secret_sync(item, NULL, &error)) {
+			g_critical("could not load secret: %s", error->message);
+			g_error_free(error);
+			g_list_free_full(items, g_object_unref);
+			return EXIT_FAILURE;
+		}
 		secret = secret_item_get_secret(item);
 		attributes = secret_item_get_attributes(item);
 

base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
-- 
gitgitgadget
