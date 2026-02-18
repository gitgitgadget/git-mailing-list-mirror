Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4E2EBB99
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389000; cv=none; b=c3Vi+vQsuwzc3UFF6E+RgmXoPjOl+RtJmpb98cHmV0dIC4REThjGCsZ1ISSNYHHTrgmpK2ptzrbcw5mbWLeMeoyIpLWlUtYXJULwJ+B58ULHCDxwIsIC9PH+W81XMj/cVV5Yg9F80+fQ1xBFCsDEHR7hJcUpKs/SQ39LO4oh6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389000; c=relaxed/simple;
	bh=upc+oBNuJSxk7jNPADPmp8sQFOe/pQYaQ/A1zlagLnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=godc5VgzGt+gQbIOrob0Qf8wwCuAh6nON1DVxUjalu2uFBzkQO3bhhSQ//Ec1rHoomrlm9hHDPQ+ZYdlBxSxZjOnbSM0Srp5E6e72hU1OQv3xa1OynsdhVenhyFARZy2OW6JE+qXsPHlViAPwf2W/w+xkC+IoHf7ncZUy82ooZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub; spf=pass smtp.mailfrom=mail.dietrich.pub; dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b=LTmv64jY; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b="LTmv64jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.dietrich.pub;
	s=protonmail; t=1771388980; x=1771648180;
	bh=upc+oBNuJSxk7jNPADPmp8sQFOe/pQYaQ/A1zlagLnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LTmv64jY1vjTJ1sW9FN5l7BznALXxLH2dI2htd8BAMlmGLjYWiAN/109Tdo/moyd6
	 QB45aGYR9jNAPRHCd/+w422jXIUxoFzHCuxnJGsZZlmY93CSOLUYy16ha/oOe1gVU+
	 iAMHX0DEuVHUfc9v/5ZF4K/ZG5ceS2dnvVqvSPhKa7b+6BVp4RfohkgyKjWzq22zZc
	 JL8qb5oEG+aO5Ndqmb6mpbKEGPupn3U4B7gETgyVm46+0g1+pafGnX1Yl9kvfypM8V
	 SXJLmaW/g5IZH8wUN+Jdp0q+AJKH3LmBzfmGr7v1IbfZq0aJ+iaQjZlRzCjkirulAe
	 gSGEBB8H9BzWA==
X-Pm-Submission-Id: 4fG3Sf6ywDz1DDr3
From: george@mail.dietrich.pub
To: ask+git@howdoi.land
Cc: george@mail.dietrich.pub,
	git@vger.kernel.org
Subject: Re: [Bug] Git subtree regression
Date: Tue, 17 Feb 2026 23:29:18 -0500
Message-ID: <20260218042918.330374-1-george@mail.dietrich.pub>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8d5212b5-3088-4b73-a849-f1c297e06157@howdoi.land>
References: <8d5212b5-3088-4b73-a849-f1c297e06157@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ahh bummer, thanks for the follow up. I'm on arch and don't seem to suffer from the same recursion limitation as debian/ubuntu do. Because of that I'll defer checking out that set of patches to someone else.

I did however checkout the other and can confirm it looks good! I went thru each of the components and asserted the split hash matches the latest commit on each of the related repos. Also asserted `subtree push` results in an `Everything up to date` message. Thanks again for all your work on this.
