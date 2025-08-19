Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F32063E7
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612328; cv=pass; b=ZlWCtV0zu6OU0H0nL6j2VY9FJaAzZG2YMl3MCjo+2ULG9D2S/wHwbu8lhqY30d48VGA2BbbrcoZ0gvzTlsQWwGiemoCWGkfnfK79AQd1VIOYst2vuI0kvH0wTHBqdpzgJjKNZhUwrxRZRjdMv26X3OiLqX55ypPVD9l2H+6NEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612328; c=relaxed/simple;
	bh=2hx101D67OZr3uiSYinwRTYn1Txz50km0rm9sfHrOUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di+UZN3cfG04pZ6bWk1vE0p0xQ5HaFIkhYRNc4ilRsazdHxdeBaMWulrFNGsFxo7RylSLeuzzlzRkl73WuVRt2FNbqMXBSwZFTroI97egq6Xz+pSy3j4dbF50RQ1oraOwXEGVyBJtbyqTsUg1flJeApvs9BwyDLYh8SzAMczS8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=QZPs4Cub; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="QZPs4Cub"
ARC-Seal: i=1; a=rsa-sha256; t=1755612298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jPuWn6LH5JCPlLmSDUVnvK6zTX4V1qHsGmznU5zVCcPw6HcD3O5m4Zj7O8AkatlgLrmYELFeawmQaWcBQ50WgO96piP2kdesk9ceuFFuqzqR8R5T7TBs2YUBDEdz96Lpf6oFYx8HFMVut8IWFtedsjd5/PG4VfxzUcg/2iK1YHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755612298; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2hx101D67OZr3uiSYinwRTYn1Txz50km0rm9sfHrOUM=; 
	b=k+0equ88OGBUbivpdBdUky2p/dlqiH+2Cwc+U5uTYdF8jXywZ0+2QdXYqjjZsmCy6kexGoW9LWC/1tWqLN10JsSaWbdzPYbltHmH3bJmgvYYw9dSXvdUyaLbF5NXi7CZbbppr5T3ZnwBS/rS1LYUKHGGJBBVAUsWmv1/SIAo2Eo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755612298;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2hx101D67OZr3uiSYinwRTYn1Txz50km0rm9sfHrOUM=;
	b=QZPs4CubS6mx/sfivIbC7sfVCVc0dTfGmI52fwwM37oV6/HOG4+KsR7P6Xwr7Fmx
	Sft7geNjqu+WjzvdPIhGoIYbPrSyXfGWan5MwbWKT3mkGv4dvSsAewTJHKMnGEd+Rc0
	iYuACZTpKedhgDNJs6gihmtyGLk1IgGQ5LEs6Hsk=
Received: by mx.zohomail.com with SMTPS id 1755612294381726.147251596768;
	Tue, 19 Aug 2025 07:04:54 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: martinvonz@google.com
Cc: ekempin@google.com,
	git@vger.kernel.org,
	philipmetzger@bluewin.ch,
	remo@buenzli.dev,
	scott@gitbutler.com
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on change-id commit footer
Date: Tue, 19 Aug 2025 17:04:49 +0300
Message-ID: <20250819140449.730068-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f934ef8e29b4cf06432369f7000096278639cc9fe2e640c3db5697918b977358bd62980ff29846:zu0801122774c358d456d3e0ba5928f221000045f24f665a5360a8d41b7652ca5e921be55a158ad41ffeb676:rf0801122c765cd861b073ccb4958000980000c847083570620b68d738f5f177d76947c25c3bc6b20411a13147e6c8d168:ZohoMail
X-ZohoMailClient: External

If your change-id proposal requires some incompatible changes in git itself,
then, please, do them now! Incompatible release of git (git 3.0) is near.

--
Askar Safin
