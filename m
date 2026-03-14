Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF6320CCF
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475176; cv=pass; b=Lst35bV0MfqUPAg0HMUZV/S5fobZuD63WAfdmC9NNPx3iig2vtmSqwW653/kZs6WjAL8x0P2PXdQmaEM8p8ft2+alErT+xQlHEl1cDGpYwzBD4w4eLeEaHnrBck7scSaVtZTDyNGeEKj4szo7HKkg5eHLcuddqaB+K8tlJG/XOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475176; c=relaxed/simple;
	bh=tivDAD70ucocJLcrn13dawdl4SDTqdTHxGGNHLQUMpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR+fBKxf9iR6SLM0F8wZfoTudYEM6LkLRiLqnInLvv8RJFrdzQlGddG/Wy8v6ioXksurPOGb50YzcuBlmyZO70IRO7M2XJOuN3qGRc2K1xvswq++YMjG9olVPIcAVXswWDtif2g7zbAD6mDtL+xs8Q9q7v4QM+IO3lUyP0qeiS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=Xr2jKkY5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="Xr2jKkY5"
ARC-Seal: i=1; a=rsa-sha256; t=1773475169; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UmWif4tUGQIEL+70q6kaQF4H2q6usjkKwjbdeuQ5DV1C+qkG+GSafjJMlWxjY0FWsVNUhVDZBcNgPcTro/Ome8cOuwqmtkCH//R37vESazf97TBmXIKbJzHZVxUMQA1NX7GzsP2tWw6cc7zvT5XW4/1JfdyKqMYAGaB3+6uG9Ds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475169; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L8bBeJ/hIuskDe5wmCCLQ2P2NGUaAIEjWnvhtB4vm3A=; 
	b=Y1zl3kRqWpLL5+uiFFkWxN4QK6zzdwZkNmhSSa7mayTvnNWxVkCa7japOcc+oGBEKQoXMGzCoWsUKornap3uvsFbbOv205GRhKkMZwGHdJa/yAUQ0Z6bDaxWLtBKHZ8OqqUdz1tx6jKe5WIK1JhWXh57Hsen3xlJpybCl5g0RAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475169;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L8bBeJ/hIuskDe5wmCCLQ2P2NGUaAIEjWnvhtB4vm3A=;
	b=Xr2jKkY52/BE1aPMjr5RXoZZ9bfhWbNeeqOsoGuYesA/XoZEAgGbTGAcPs/ihD6p
	7Ee7MLI2VBmnj53ytN+QYA+NOH0iDF5fN4UFDuNDZoaNJs58t0IJdMF2dGiYJIHPf9r
	NOxH5SbKKvOl1qPy+czda9ArKjX9UDB7NooHJEmU=
Received: by mx.zohomail.com with SMTPS id 1773475165943547.9708267294394;
	Sat, 14 Mar 2026 00:59:25 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 2/6] prevent wrapped headings from overlapping with text above it
Date: Sat, 14 Mar 2026 03:59:18 -0400
Message-ID: <20260314075922.67391-3-rito@ritovision.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260314075922.67391-1-rito@ritovision.com>
References: <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <20260314075922.67391-1-rito@ritovision.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The Oswald heading font has tall ascenders/descenders, and at the
prior line-height wrapped heading lines can visually overlap adjacent
text above, reducing legibility. This is most noticeable on mobile,
especially in the desktop banner where the title wraps and overlaps
with itself.

Apply this as a global heading rule as a consistent policy for
anywhere heading wrap can occur. Some desktop views may not show the
issue yet due to available width, but the underlying font behavior is
the same and can surface as content or layout changes.

Adjust banner heading and nav spacing to offset the line-height
change, preserving the original desktop banner visual layout.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/static/css/main.css | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/korgi/static/css/main.css b/korgi/static/css/main.css
index 7d73395..3b09d24 100644
--- a/korgi/static/css/main.css
+++ b/korgi/static/css/main.css
@@ -68,7 +68,7 @@ body {
     float: right;
 }
 #banner h1 {
-    margin: 28px 0 47px .05em;
+    margin: 12px 0 31px .05em;
     text-shadow: 3px 3px 0 #F8F4EE;
     font-size: 3em;
 }
@@ -78,7 +78,7 @@ body {
 }
 #banner ul {
     padding: 0;
-    margin: 0;
+    margin: 0 100px 0 0;
     font-size: 1.1em;
     font-weight: bold;
     list-style: none;
@@ -99,6 +99,7 @@ body {
 
 h1, h2, h3, h4, h5, h6 {
     font-family: oswald,helvetica,sans-serif;
+    line-height: 1.1;
 }
 
 a {
-- 
2.51.0

