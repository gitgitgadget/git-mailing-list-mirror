Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED8391828
	for <git@vger.kernel.org>; Sat,  9 May 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778320560; cv=none; b=UD8ZgL29daxGJDgDqwQ48IGV0Gycwi9ZBtB+TqAN56ySAooTCven/KXxih26LLEeOZiMOYF1as37D1j+7ampj9RLmmkotpLZqhTnld6x/zTQIJjTed6zXSdWMbH95dYF3N5nTjS62SzLnhmUebw9DMzzWxBj+FwMqVok466n4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778320560; c=relaxed/simple;
	bh=bTvd4XoBqDDatQnZg5zyruetSg0nLVZTbDp2V93wDLs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=F8k818PKqYUf6qUqffS8Knl7i6OZ5gym1JAJJ2wpDu/MT5mReaeHvT99TeO7StUjkEwB3H7fYpEYgW6QvI5hmTcYK/R3nXfO1c5ZW8L3t02Dhh3xfXXDZSsuSM61Hm2YVQtERmVtySRDzMQoofZFJV9gYp7NKYwoGuMawHuRvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PcQH9jxR; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PcQH9jxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778320553;
	bh=cbcCu4Q6P74/+WDhAO3KzeuzgmoEdizGwBnkSem9v2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcQH9jxRk9pc42L2SdqBOc3feH5g4MNOK2EhacBmdtHq17HZZRuWVyq8QjHHT99II
	 HPQPVnLWKjOQw6fh3QXt54/8IFr53OGhZPK6bRFhmn/BvBYRto82P/0lNEPT7H9j/4
	 X+dyzGDmWEpUlfc9iyffRP4ebGil/6BHvss0CRJo=
Received: from localhost.localdomain ([180.98.200.15])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id DF28AA60; Sat, 09 May 2026 17:55:50 +0800
X-QQ-mid: xmsmtpt1778320550tfij02buw
Message-ID: <tencent_CAC52D0829E651C1CF21A1B94AEDF00D6E07@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7NcI9TlUqTqABLIQtHBdWKR7285GH3W5DAnqUQpsbMuP3apZiJP
	 Zhn78Dg9gKEA4dZCSz4yLRKOTRwi+1YdCCA5lZrprUEzFGGfkVdsw40JosvC/seItPTrc2ix6GWv
	 DwfbIcAfA/fIiULdRBwxpA2wfG8KqpN8W4/oR+2pqewKCsqiqX7WcRaCudWPcEKT1RObpZzaCDIb
	 XfiLi0UsR0FT91FxsYRFDktzd9OYL5UYCeotRSPrl9s2qjrL2ORS2uikz6vo/icg4j8PYYOcd2IU
	 BViCzqq0LiqXG6qt9DYtcXKxRjObzQc53BrWkwSh/wtp+9Y1xegTW5OW3VR32Do524yyrMgEwQl7
	 OScwXt3sz6j8EhRBFIO2zdPs7LYbclhhI93XFedJC5BhjYEAar7w9ldLz1GLawDJPH+e+6Yz5319
	 rxQ8hdO8MZap5HpDwx/9rbgu0PLGkI71hnBr8MNxQ5S0jK040A6865Ygl6DHrBXstsb0Yhn6edDN
	 fbXpJO7gZe7xEGkG57x+MboCa5zOLqyrIZUVKmmW55BqN00LJiF7beO6xHRfLdpIGpb9MSn+SVos
	 Qn7bLTKACXbZ1o0tXZ69qOBfkEKHy2PBg5xCa451flrxUdqLPSnG/uuc9BdWoKxnmlctznrGXIKu
	 /AVX3NjLN9bJht/3+hcwudMAWQuErOTjuq2IxMk/XGSuRvDt71c5U4X1x6k7jlDL6C7o4UIfvPie
	 eANgLevqHV9NDkedZ5klCi68dCcdiNopS5ydDOgpeqT3MAMfW5MXuRkzPu2Pz/MjkvoK1y0QF0A6
	 pguFI7dhUeTzPbFhjIyWqQ4aSkHGgSv21FbmEfPZPF7Kca+A4lBcZqm9EqTV+n41FfoaJQengtmz
	 Jp2nxdUHw5hgb9/e+CcqvDlXPoPghb15qvMRuZBqbuRDKwnH50dx29LpxtYV/vVMIFKCKwMLHzWR
	 t6+T7QFhipzAMhAC5yy3M/Utb9s84FtWtwzNoeJKGke38gZDponjnrT4AhcFBHK49enzOsxdEE7G
	 fp70e4LXMIYHKef0+9tyV24HQJ8FCicNSdD2eg1CBTff6YqHWgIzauPlj/PwzjVKJraQb11Oiy0c
	 NICTJEHkxMZQpmtpk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Aina Boot <bootaina702@gmail.com>
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 3/3] git-gui: handle GIT_DIR and GIT_WORK_TREE early
Date: Sat,  9 May 2026 17:55:37 +0800
X-OQ-MSGID: <20260509095538.487-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260509084846.1694-1-bootaina702@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are functional, yet somewhat complex. Only 1 and 2 are necessary 
in this adjustment, I suppose. 

Saving and restoring old values in do_gitk and do_git_gui actually 
does not require additional encapsulation because: 
- First, GIT_DIR always exists, and directly using set and catch 
{unset} is inherently safe. 
- Second, the set/unset operations for GIT_WORK_TREE are already 
properly encapsulated. 

Since the save-restore pattern only appears in these two places, 
introducing capture_git_env / restore_git_env adds more conceptual 
overhead than what it saves. 

Shroom

