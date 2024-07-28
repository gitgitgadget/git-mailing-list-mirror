Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34B56B81
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181366; cv=none; b=ZyAkJuXXiILmZehYRUUGiEXTXgHkUnebEdglEEJ545Z85RnTFC68X63wBqvgsI6MZm/jEkb27g0KKn8OwiNqVVMv5qg9zGI/cWoxN0e7DDYBPuwDAvwcAKWQwwqSmePTG4NhQgA+HQkG+WtDC48lkXtsJM9iu1TEREYx75Bf3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181366; c=relaxed/simple;
	bh=ORJZgWWPlvrsYmu2xRgfadsCy232Om/fm88F7gZHeGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqbjVKhnn1J+c+wANwzjpZjZtJNBua0mAKe690Els9NI15gcf0XW7+3POZF9cojyfkMrVps+JATRt/6PLKelPikAJ9h502cTN5KR8nNnRaF4Ywm3/7pd8eturv2bh0FHlCqhfDPehIDxClrBWGjLCzIapXkaspgzvK8o7SLfGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyvPOfEQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyvPOfEQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so1884478b3a.2
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722181363; x=1722786163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfRBeEed9VvLQUr0MziJ4zbGUEVlufsJIAxkJVG0L9w=;
        b=MyvPOfEQa57jnlWUFEyuEmooc9qXFApd/0rPgXIYmp82AR0jlDGoj+TaS00xbtLoJb
         hNci3skHQjhD+ukcvnvIKan6Dfr9mC9gmxqEd8L19TGU5b4G8fHi9TkBp8pHcO59qZpD
         rDTrJLvXrxg4zyjYTWDp5+ivaVAOzNbyQOd2iLgKvro29PkRTpE1OnuA5M+Byw82jN97
         TUt0nicie8Lr46X4B4d3du4gBc0rH5/GbVtFvn3lZscA2X0fH2Zex+fP9zhxe0bbWPER
         1es+lOir3qNYeaXPXewfV/IPgB6u6FLFe/UN8rinaezg+a32by31DvWJabKjjTbld7sp
         qkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722181363; x=1722786163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfRBeEed9VvLQUr0MziJ4zbGUEVlufsJIAxkJVG0L9w=;
        b=u8E5Ats9jdhX0kv7y3hIueFuuWiOo9qcd2zO5dTzFSIrl93o0Kj0Yc6F5mhbxaNzpy
         AdbCwIeRQPQuPS4n/9easYMrokiMuxYZKabU2TYJzzFAGmVuKOf/6qLSIeGOBtNGNT3y
         hfGz+OhkmMBfPz2QuZrfMXhE6VK8u+m3ay5L0AXIJdJ8MMTbSsvKeuWZtXLQPmPwnFvC
         SJYuQm7rzH3ZRyUPu7tkgzAksv2m/Q01iLCSagPOQdhY7w3DQ0G0nCSuqFEwTRy3G3l8
         iqyskDX3SA38P8EMRcLEmTC91saghMBpLIlndKGu/BY7vgUJDHl3LkFeFTk54kJx1BXw
         fOoQ==
X-Gm-Message-State: AOJu0Yxo+7tp7vR0iYTSXPg5ql3m33BU93JTk1IZUZFb2HnxgKqthxr+
	IDf3k8unSAKKq6PlCCv+vimOxf7NEj8+9/9N3e+Cs0uN6oJMOkWB/YPndA==
X-Google-Smtp-Source: AGHT+IF16MfwS2cosZ8gdX1lDpwfbhL504dE72eSGknTaEpfRt1yOF4ifyweKSOh+IN/aomorGB+fQ==
X-Received: by 2002:a05:6a20:7fa6:b0:1c3:a55e:6199 with SMTP id adf61e73a8af0-1c4a14ded25mr7934109637.44.1722181363063;
        Sun, 28 Jul 2024 08:42:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8aa702sm5446654b3a.215.2024.07.28.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:42:42 -0700 (PDT)
Date: Sun, 28 Jul 2024 23:43:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZqZnBfQadtprPizT@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

Hi All:

This is my week 8-9 blog. Sorry for delay of one week. A little busy
with my own job.

  https://luolibrary.com/2024/07/28/GSoC-Week-8-9/

Thanks,
Jialuo

