Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398A485CFC
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206652; cv=none; b=YRmdbqAhV0asxdeDVv79B60wpiAXdkvRZd/EeyqiBAxA+sHcfUz3zauZrMK92SdHKLRN2h7vael7F7pz+O10kigmUDzOV+gkCA0WzXOdASlq5tzfK0w+yGy11RFVy6rygGdcTg/ExYEf+PH+6OAwiGUy/stdLi5qRBFVD32V7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206652; c=relaxed/simple;
	bh=zuBn4M+a7k8VaWvAernBTFV0hwucyIjdIItXpdLKgR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfWdF3cbQYZx+II2pni4WSIjseYHcyyD1dC/1G1yiJOe/8Xd5HHJcz+Z5gGegOyLLfLnwyO3aG007qZaiX4W5KDE7Wh2pmMMI2oZDqajI8IPxeoh9Z3i3qBGbVTZTiBqnhl2r1Nt5JNtfstG2+InBwYJ3korzIWzvg4K9NtXuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4QSyujo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4QSyujo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso18265655e9.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206603; x=1791811403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPUPwpzvEtS0rpTmoFMeazzmPDzoZvxULNTC+YmMUw8=;
        b=s4QSyujolkWNKNEBLGSarBew+vXU69+H+ggVqiJL87Ds5O4QuH/pdHSE/0S3xHo58s
         ooOKyWhqoeZQFn3P7znjnDkvyOxcRc+UEGeL9nKj0bEtaE5AdEPbdwihRi3OGxUzi8q4
         MmvPuQHpawkDh5FyNRTBtQOgw0YvSfwwYonHSDGVrvtt9+r+Zm/dt+PVLuMNkGqgQNbR
         lnINJlRrzUSaRLXFlgaJL8SlsoRN8brr2MrJmA/XTOVWNwX/FtO2D+pi+e/ha5+uGKYm
         8ljHapU1f1HvLJ1htFLrqgiP5BC9yU2n6KM9dZau0hGQCv3nt8fBF9RkbWyeGyuVDt3B
         XH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206603; x=1791811403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iPUPwpzvEtS0rpTmoFMeazzmPDzoZvxULNTC+YmMUw8=;
        b=l+OOIpqnvMNBvL07U0rdlR3ATmMnlVACP5YtBPJfbNVsrslytyoqPxmViMI78xZVBf
         pyNzg99AiMsk2E5tNd/ipIWo0lV4rgaJ/CCrRo9iBWkRIxGeCWYdpAAGEhpg3md9IRcs
         A75rBjunxEK1Yj1tapNpRkp/qFkaVAWRb5E9GNyQCf9ejEXJJyFHFs5bBJD6dQgdHTw8
         +sVutr1cFQUzTkIFeVwp0QRh1ZVUsbu+34g5P/Ysha5Nn49TPPhtPv7yzC8yn0xvkPM/
         2wZdDPG6AOZpaC+puptRJm1mkdw34OiKSJlm8A88Ty4VurhTTy5uHa+uu/2Pck3GOMGl
         zUPA==
X-Forwarded-Encrypted: i=1; AKwUvBwjMvoNfndNQrPrDENesvW9eriLxniP+TEZxSw3FAWMxotDWYaRQh4xscaPCfG582Q1cRo=@vger.kernel.org
X-Gm-Message-State: AFuF++lKlHKi4KohrcparFycRhLHgF/8p5RAAgo0uTuSJaaGB697f4R2
	gsXbVbMBhQEIAf6VJDZci/PATZNldJNM4jsJQhJA19Mp1IdK05RQdr4Z
X-Gm-Gg: AYBFou25+3LgY3TgWlIaUxtw4psZCIfK+GFMusR3NF9b1Zvp6Hoybh6aL6nROxulBcI
	uPZidVlTmi/842GxjjMxnShwTl9O8JhknN2DkhpHqwijC5++pNCE5IgcPrhNB3jA8TVsD0n78eh
	Y1zTYV61gx6R/uvOlSwYY2F9bDmAuFKEc/xQrnigbZyLho+vIrS6b+MoDa24qwuZmryNrk6qP9n
	49KKtYGnKnacEaorA95MJ2ikXwQQA2rn6p/7Gz2dUxem7Yyz+2EF4s01jDYDRgP/vO+YMZGk0Qm
	1u90c4O/7jwgBK1jzlOPxzuXVgoUQNZDUjappyeOA3CsLSrRsaRWCYZzxOdXqg4LcqaKLTd55qa
	SAeUgiFIpV+dSiaHyp/FHzNjpQMv1/XypOs+6qhRhqmvfY/b32erRDbn2Ph5eQCWhCDK0nqHuXB
	xbkk1PPfZ74T6Gk5QO69pSy5uA1X+jWALjny8WWe6d/OP8xlYbLiLSdY9hzD09cNRs6nyfCzaxW
	XS0bUD6SYKkEDjrsZdcC1mwtbEaRRQ9UBWJWll4llF/kLgBmYem
X-Received: by 2002:a05:600c:6208:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4a168105df5mr108779675e9.32.1791206602503;
        Mon, 05 Oct 2026 06:23:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62eda863sm3091167f8f.43.2026.10.05.06.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 06:23:22 -0700 (PDT)
Message-ID: <ea988ec0-ef3d-4250-a0d6-ffdf3794b9cf@gmail.com>
Date: Mon, 5 Oct 2026 14:23:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test
 script
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
 <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
 <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com>
 <CAHwyqnXBLiAA+aX8uLA3UvsfD4zaMTcvj96H8DX8BhMVopwcfQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnXBLiAA+aX8uLA3UvsfD4zaMTcvj96H8DX8BhMVopwcfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

On 04/10/2026 12:51, Harald Nordgren wrote:
> On Sat, Oct 3, 2026 at 9:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> If I click on the link [2] it does not take me to that test file though,
>> because it was not changed.
> 
> Yes, unfortunately GitHub won't let us link to a line that was not
> changed in that PR.
> 
>> That makes this somewhat less useful than I
>> initially thought. The current behavior is that when you click on those
>> links in the summary page it takes you to the test output for the job
>> that failed which seems more useful. For example [3] is recent test run
>> that had a leak and clicking on
>>
>>       linux-leaks:(ubuntu-rolling):
>>       failed: t1092.58 submodule handling
>>
>> Takes me to [4] which where I can click to expand the output of the
>> failing test.
>> ...
>> [1] https://github.com/git/git/actions/runs/36537917146?pr=2426
>> [2] https://github.com/git/git/pull/2426/files#annotation_82189987516
>> [3] https://github.com/benknoble/git/actions/runs/36033463504
>> [4]
>> https://github.com/benknoble/git/actions/runs/36033463504/job/107747745741#step:9:5333
> 
> Is this enough to call this a regression? Then maybe it's not worth
> doing this part at all.

Yes, I think we should drop this patch. The first step to debugging a 
test failure is to look at the test output, so the current behavior 
where clicking on the links on the summary page takes you to the test 
output is more useful than taking you to a diff that may not even show 
the test that failed. The first patch is definitely worth keeping as it 
makes it much easier to see the LSAN output.

Thanks

Phillip

