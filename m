Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DA8BE7
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210430; cv=none; b=Hvk4TXS1Z1rKEHkFTquPYKbBg/zJfutUrlFpv9qX47jDdZlIZ7gwqQLhWJ0I4VXzX1VQwZOXYrgeHQFedyp40hf/roV7/NZ//vLPeT/YgkquYvypm5af2e38xyPopeZQDJ4Gkxq74U0+VqeIGw9q+EiDMh/WD+DWbP1oXGIEUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210430; c=relaxed/simple;
	bh=wjEdPaLHMfNwF2Uno2azKj146AdK01i73Gk+WbpnQnI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jRT/kRenrQG6hxqdHDDwPP0HG/5KOPGpocFJYb0XSOW0pS9+3d6zG9nwHcyZtXwLtowRU5Gk6Eix0NNYZZQDuraElRNnbzXacUUP/cIgVv87Y48UKWE0odfAY9bpnX1vGSBOpUxxcyPfeGXsUFH+X/vhEtOmnFtHvbRezRJ8T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QMjh0jxz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QMjh0jxz"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710210425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6+mPs4Wsw5A10E9nCMhgZWY5lB2D9pi22UIYMIL22o=;
	b=QMjh0jxzAWsDG//lx1a1LHgEoCXyyf0h6T6SyIm/X2W09S8wBilv0t26zyjVz7BqLAza+O
	iXzoqVgdjcs3dzldnopf8OwAjgKDmzaECs3WXYGiT1Cw96NUlxR6i1s4DhXJr7PlCc5ZFG
	1BSGpD+pN0dLXsV9vnkQFZHP2zl+aWOop0V7VVB/+Ry5I2LKXzsUOrmyy0q3ij88UhvGd/
	Il82DlpK+Xbk6dq4pMJfNQYXXWJMKckVWiWmS1YtSSoRQMEa2GZ4vSIkruNVxBE7s2uRQf
	/IS+0OK8fdkl6ZW+JKbCBX6PxN8fs5ZkhzPhH3tmZs3Nol72tUN2PvtK0MAAtg==
Date: Tue, 12 Mar 2024 03:27:05 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Ralph Seichter' <github@seichter.de>, 'Junio C Hamano'
 <gitster@pobox.com>, 'Ralph Seichter via GitGitGadget'
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <0b9a01da73e8$b7cd8f80$2768ae80$@nexbridge.com>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
 <265e5b2d352c34dfe0625904b3356000@manjaro.org>
 <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
 <0b9a01da73e8$b7cd8f80$2768ae80$@nexbridge.com>
Message-ID: <41c7cfa73dc0b4e7345ba788c45beead@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 20:17, rsbecker@nexbridge.com wrote:
> My take would be that all whitespace is ignored, but if you want a tab
> or other character in a value, be explicit about it:
> 
> 	variable = "value\ts" # comment
> 
> where all whitespace and comments are dropped from the parse to be
> functionally equivalent to
> 
> variable=value(TAB)s
> 
> when processing. Implicit quoting arbitrary whitespace can be
> interpreted in an ambiguous way. That's basically what the C parser
> does.

Oh, I fully agree, but I'm afraid that would be a breaking change at 
this
point.  Perhaps numerous configuration values in the field already use 
the
current (mis)behavior of the value parser in config.c.

I think the only right thing to do at this point is to document it 
properly
and correctly in the git-config(1) manual page.  A bit later I'll 
prepare
and send a patch that does it.
