Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1F9454
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723930027; cv=none; b=OydV6mU3KubHmernUBYuJz3uqKzb2tHIzmrieiEeYBg9Pj5UZRkT4+uoxPN6G3y30ADVvJnZd8QJJvf+ADIbj0bUHeCkNdLF+/1knOOjnXIzlF3g9/pomW153tGeeeGQajtG7tXgWAtSggFAced+6gtX0bZzqoQTTvb/dY8YB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723930027; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=fon9jh/qIL77mLCJSK/swTaV0vkw1gGrgFEz8yY6YiUW2rxJBDhan7A3bZRz71prjPAUYnfn96SAXyFC4Zoo8E/0+IKaKvLBtee4d9YOuSsSKB4Owm4u3w33bdVKEGYyg1+88ktLueDMibcABwrBue0WPD671mxJI+mWwTGbcVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Dqy5om; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Dqy5om"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093ba310b0so1293026a34.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 14:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723930025; x=1724534825; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=V3Dqy5omn2afIIB5m7CDJFJcCD8DprFECQ8Xkb8Zcuvhj5wX8S3gKOhHkprr54LZCK
         pG2mvQjkbG6ZbKYXrN5gq8cQ79n28YTqvo0gWHxIQL/jhyu28FaBiWGEegc7PKpcnOPN
         1vDj6fbBhg/fXtnSybzRt5dbsx9/yg4q79aM1Ua7oXWaQsvA8jB6mA5w991J7PjnOctq
         mV3WoTP9o570h1ApGDsoS8wPwwLtKJ9ISr1a01cJE+HVzcNRgQ3tLohkUkps6cl9HUb/
         5ywWlR/TSiQPo1FD3kdD2M+td5gsobnHLPdxeqYpdVsmrIVp1Rd8uf86BsPRwFqGlyK0
         VzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723930025; x=1724534825;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=K6nMTDYI+qCQ3+Oy27mrG5TfhNw1kmX0I443GtVnQZezI4kZS49qFnisz+YFRZJvl6
         KRsMW1fhS0153qx0BOb1Tae3+KQY48Osxfs1+wri5Dg8aeQVOF3vOzV9efvBk3AUjx5x
         4ltYaMhx9VBcJCsUuF4YSeXv5MwuS9Asj+UVxCcOoNrOHct9hhAE0KBFZLbI4xkBGmzm
         44aQr7vG3nuG0xSgBLimvclKc3/Ul+aQqmnbB3EfmVp7wselis7/e6A7He75O+wwDHyR
         VzD+MehJ39UWwB43igI0avunC3PO4jUU+Aj4eGnqZGAVgEFLt8ANKtbfCUR+Q/CgjNyB
         fIEQ==
X-Gm-Message-State: AOJu0Yyx0R1MhjRVFdCc1pgocos5mjOVoQ3myJNTTR1cu/KC3O/3srIm
	apmL3v29WL94O5vcXouGEfB8mz9/1VrtMn+iYxB+NTcYOj8uc9S0hYc03A==
X-Google-Smtp-Source: AGHT+IFLwHeAQeObEMLFOlSWisM0gjoDcVfoCClQ0mBTrbkW03cgas3GYXYl+90muvN1OcL5SrAaRw==
X-Received: by 2002:a05:6830:3111:b0:709:50e6:489d with SMTP id 46e09a7af769-70cac83be49mr7590962a34.3.1723930024845;
        Sat, 17 Aug 2024 14:27:04 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61dc929sm5133927a12.40.2024.08.17.14.27.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 14:27:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 18 Aug 2024 04:27:01 +0700
Subject: Hi
Message-Id: <B8A7C790-7A1D-4651-8F20-891A358C9C8B@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (19H386)



Sent from my iPhone
