Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034F29DB9A
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422959; cv=none; b=b1IG4uNTgGHQHFGaz+zxqKWd2lAPkC0BOXwTfIeqMGs7hJ4FEnpkrUigACGSZlnXPUieWjxT1VKy/PN92R2UKSGpxX4uGuQ6M1yupzUn7ON7O6twstLdTQl4uytSsyNZfjfiLjuP9nNKdJpYc4RdZpmYK2jJQ5JM1LF/nStYPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422959; c=relaxed/simple;
	bh=pJlvpz0JHKc8Uz1YD0Wh6j7eUyoceu7o8Ipgwa+op2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKvp4GOqb6HN6HXLOVZefr7NMgSaGbX7Dq+GdpozC8lExytsrLuIs/K3M5LP++JzChke0uMTrYtyKb/JYsxweSqyo3otP61i81OLJuE7IUflvLkSIhsS+1SkNFKSOHgt0eOAkboOi3h3nK5HPh37WK5itlUwqINqWFvgEUxdNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDrLAgmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1muWyYvY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDrLAgmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1muWyYvY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37E621400288;
	Wed, 25 Mar 2026 03:15:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 03:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422958; x=1774509358; bh=gFK7pQzLu/
	/AtjRfj/R6QOxMxJeo0BbEPrDEf/iuKLA=; b=NDrLAgmBBncBdDMZ7k07N+RcVd
	OvLxJcxgjNd6+rY0Y+LqBeIlgCUGieJyiGdqhzY9ZsgMZXwyKoaskwuW5q4obpcA
	9tpHvmLD1fHOCEeJXs0Fu6+U3KeBJ21XR1TE7OZodFQpjc+135PsQ9TprRFBeKbC
	O0ycNSDrchpwFbuZf8un6j4Pog0lAsXXfE6rdRXaGG+qjSz9+BdkjMibjBcG43oT
	Ajpx5eMQ4s09BLL7Qyb4glCUAX1NGeq0Xf5WGH8Malh/iIM2UunoJ44s15PQ4Tva
	lg+IMqVnadLOVBQf0oJa8U9fafLqzv7ozztNR7zhLAedaURzTTh6719JmlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422958; x=1774509358; bh=gFK7pQzLu//AtjRfj/R6QOxMxJeo0BbEPrD
	Ef/iuKLA=; b=1muWyYvYwsnQ/zncebiWCsGFGDcLTE1/uEYtjwMA+dsGWPag1wc
	LTLzB8I0Pi0wL/2mDxP5IFSXGArEg8T8gg0UGmvWFJ0CD6+h63Q27bmast1Cqs28
	nmudbU930QZ1DCahv1431f44WAoeHzQBkYTNWvtMxv8IK/AvS7izb8CQ4+WJeTOc
	cRJY1FMCC8h6YVAUwiM5NtqHImREIF7//rozr8NPnJyyiVXyzUpl5QgeJ+p4whwn
	R7KkiLRaE8NClF4btwYcvfBBvc1i1dWOS1CmiKKzsp1yTgrPA2BWVYwlYLcb/L0W
	LiHyx2fzwVAiwcUw1mTYeOlksPnbgRbggzw==
X-ME-Sender: <xms:rovDaQ0Iu8-e5YGW3BMywtnhcFEugwBGexejflEsPorkobtC93LSKw>
    <xme:rovDaRG7bQbmwrv6k-nGsvEHQYMc6bRSF2O6kjbcAKtG3elIMLjmjiwprgdnvtjFp
    iSvq4UHBIGZUVGj8LnvUL0uSXvX0hhCEpn2Ej5ktmOAK_9H0c4>
X-ME-Received: <xmr:rovDaWjivrhuZsOc_Gzu_7aNDQ_WI12VRoy6n6-eJ16qXavWlMPyqgyd_77XynYLta_xUq9Yi5j5UjxB3lLTpiasZji6BtIWK6QoAANiaAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rovDaU8fajhgsRqd9IIpQwopOsPBcHNJgjnI81rTwbv6hyyqPpNJpA>
    <xmx:rovDaVrM6qUpUPtNb__QEmE80FSEJ952JaqNjIUsFJdDKPso-zwWqA>
    <xmx:rovDab_JIaV6vhhtakU7T70dRyvudfPnSPd6g1FmpPj0Hd56it7lhw>
    <xmx:rovDaRUzTSTpoyX2ClqJqUhkcjOX7lqtIzMmexsOUUoNETr4Gq96Xg>
    <xmx:rovDacMgPqZ2KhjlyaBM5B0rTy-XRE8V5zTVecAOWfTAMZBI5QICuDD6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:15:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f2b2f94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:15:57 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:15:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/11] tests: make svn test "set -e" clean
Message-ID: <acOLqvP1De5kYjPT@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-7-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:09PM -0700, Junio C Hamano wrote:
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 2fde2353fd..a73b997f8f 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -15,8 +15,8 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
>  SVN_TREE=$GIT_SVN_DIR/svn-tree
>  test_set_port SVNSERVE_PORT
>  
> -svn >/dev/null 2>&1
> -if test $? -ne 1
> +x=0; svn >/dev/null 2>&1 || x=$?
> +if test $x -ne 1
>  then
>  	skip_all='skipping git svn tests, svn not found'
>  	test_done

An alternative:

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 2fde2353fd..07d86ea244 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -15,8 +15,7 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
 SVN_TREE=$GIT_SVN_DIR/svn-tree
 test_set_port SVNSERVE_PORT

-svn >/dev/null 2>&1
-if test $? -ne 1
+if ! svn help >/dev/null 2>&1
 then
        skip_all='skipping git svn tests, svn not found'
        test_done

Patrick
