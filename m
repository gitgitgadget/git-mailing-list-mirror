Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3362E975E
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773475183; cv=pass; b=KZZ6MSXxbzQH6MG4SR3dpwRoav3iYJpJKmPRorhs7upYY0fNBMFsx1ZVIIlcgyNkstzEwk9tUMQ9x3L4mi7oDue8TGyuswr2vt+9Jmhfao+yC5c8omPcr2K/qQ8zefUB2cyAwcTBosTMW5BdOQhqgfkQUaJSV/ssEvBpS7wl2GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773475183; c=relaxed/simple;
	bh=WV/kkjqPi1VyPBYX+sYpOJw9ZjeYYEYFoUddaTOABcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj8HIQeu7BFtR8+yfmmA8F25nHIF+vkgy0D+qwGyAe0j3HLsTMBa77QmX6HUjtDjzRWSv0ElIUDYePDVI7FocYv2En6cnbK/PfCFRZAf3TO/q4WY+EwY01krs2M0WJyoVu3l7+1VxpIeZJ3ss2gpQnnmiLenBjChD1vEjZBKxkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=nbuHRgVz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="nbuHRgVz"
ARC-Seal: i=1; a=rsa-sha256; t=1773475173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NKri1HKZEiDhozKl7hRi2pXgeHtvVRyjOVhCW444QFoe+aLSbyxIIDM8J7Q7eY1lw4+illk5VgzHVwmXzvGif5u0RFXhtajI8Hv8FtTwGt1Lhh8nrxhRjwFzl+pVUEEU6YlDRWbTlbb8iokGh0ECTNTs7x1Dcg0ZXjuROi4Tq7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773475173; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OBTP3Pj8sI6UtJsf24pQ0byw9LE3Bqt5nSYOeNHuAi0=; 
	b=gjqllM6eAC2wTbYS3tTkYKJKNt+Ab2kwENi99jAUhFNco6kIcr2Kyq4criBg0zQA2Y/3kx4LeE9PPdhpXlerzyWy8sxOrGMm0qAo+V924+Qn/gzcIps5HIrHCqgHm6xqBnSXbJV/rZZmXp1VfYUsauOOk2VDuM5gv09n2gMCHIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773475173;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OBTP3Pj8sI6UtJsf24pQ0byw9LE3Bqt5nSYOeNHuAi0=;
	b=nbuHRgVzGDGD6LncJxX7RU2VNVNPIsVdaqz3tl8uB5AfEXUIy+VbHehKxUUpEepd
	HxVHEb9L9ugP/xQP1UdU6utHGjPa9rMdE1mPxnn7IyrHN80aFOjKTiJfomdS+mqN238
	LKq4VaI0LncfRr3j66Zvo5EwV7j64cNoDWqvOMXA=
Received: by mx.zohomail.com with SMTPS id 177347516819653.52793964256375;
	Sat, 14 Mar 2026 00:59:28 -0700 (PDT)
From: Rito Rhymes <rito@ritovision.com>
To: konstantin@linuxfoundation.org
Cc: git@vger.kernel.org,
	rito@ritovision.com
Subject: [PATCH v1 5/6] contain horizontal overflow in core content and homepage releases layout
Date: Sat, 14 Mar 2026 03:59:21 -0400
Message-ID: <20260314075922.67391-6-rito@ritovision.com>
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

On narrow viewports, fixed-width content containers, homepage release
sections, and long preformatted strings can force page-wide horizontal
overflow.

Realign #protocols and #latest for narrow screens so they do not
overflow and can wrap down as needed to fit.

Make #releases scroll within its own container, and keep release-date
cells readable on mobile with nowrap and horizontal padding.

Allow preformatted blocks to scroll horizontally within their own
region instead of expanding page width and creating page-wide
horizontal scrolling.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 korgi/static/css/main.css | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/korgi/static/css/main.css b/korgi/static/css/main.css
index d20d8b6..16d97cd 100644
--- a/korgi/static/css/main.css
+++ b/korgi/static/css/main.css
@@ -360,6 +360,33 @@ dt {
     #banner li {
         padding: 0 0.5em;
     }
+    #protocols {
+        margin: 1em 0;
+        width: auto;
+    }
+    #latest {
+        margin-right: 0;    
+    }
+    #releases {
+        display: block;
+        overflow-x: auto;
+        -webkit-overflow-scrolling: touch;
+    }
+    #releases td:nth-child(3) {
+        white-space: nowrap;
+        padding: 0 0.75em;
+    }
+    #featured,
+    #content {
+        width: auto;
+        margin: 1em;
+        padding: 1em;
+    }
+    pre,
+    .literal-block {
+        white-space: pre;
+        overflow-x: auto;
+    }
 
     #extras {
         width: auto;
-- 
2.51.0

