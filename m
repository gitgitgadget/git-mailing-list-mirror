Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEE3C064
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300268; cv=none; b=mVS04JW6PHmtwX65ZYj1Fj9SjEhAxKy62sIbJL6ppxEEMM28UqGOHooRwjzyPrtDWashbG3nlji81e14MuzC5inswJAu/K5HyLg0w9X4Yw2CA5Vld6SMnagbPIB99LJmQHIut1Ggu2dOxtPXnmmh1qmgM0DSyKrLKerDrPokyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300268; c=relaxed/simple;
	bh=U9cjO69vEzYtHoBoW9BY6pxtwNyUdy0aiLyu9F5YhcQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zd+nCSo1iLZFyrMz+CcTfOdNzW6uhzUetvEdBj2T7EyNHyjpuUbndZIxWfO3rFyuNJXrR1Ke+XNhTyH8y0pxju0nF/oXGrUisL4k6c9Xs+QlaXBzTm5dNiec3ct6DJcXc9JEvTlEF9FpBI6woitY/PXr8PF9//170d6JddpgEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43GKiBEJ1488744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 20:44:12 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Josh Triplett'" <josh@joshtriplett.org>
Cc: <git@vger.kernel.org>
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>	<Zh7NZhB1n2o1k7jI@localhost> <xmqq7cgxdp0i.fsf@gitster.g>
In-Reply-To: <xmqq7cgxdp0i.fsf@gitster.g>
Subject: RE: [PATCH] advice: Add advice.scissors to suppress "do not modify or remove this line"
Date: Tue, 16 Apr 2024 16:44:06 -0400
Organization: Nexbridge Inc.
Message-ID: <046c01da903e$d6d97ac0$848c7040$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH15YgOsnvE2GL/LQgkW5nkEwXIMQIpP8J+AiodRQWxEhdA0A==
Content-Language: en-ca

On Tuesday, April 16, 2024 4:36 PM, Junio C Hamano wrote:
>Josh Triplett <josh@joshtriplett.org> writes:
>
>> On Sun, Feb 25, 2024 at 08:21:54PM -0800, Josh Triplett wrote:
>>> The scissors line before the diff in a verbose commit, or above all
>>> the comments when using --cleanup=scissors, has the following two
>>> lines of explanation after it:
>>>
>>> Do not modify or remove the line above.
>>> Everything below it will be ignored.
>>>
>>> This is useful advice for new users, but potentially redundant for
>>> experienced users, who might instead appreciate seeing two more lines
>>> of information in their editor.
>>>
>>> Add advice.scissors to suppress that explanation.
>>
>> Following up on this patch. Happy to rework if needed.
>
>I am not personally interested in the feature myself, and I doubt it would
help the
>end-user experience very much.  You'd need to find somebody else to cheer
for the
>topic ;-)

I am having a bit of trouble understanding the use-case for this. Is it
limited to linkgit? Under what circumstances would I need to use such
capabilities?
Thanks,
Randall

