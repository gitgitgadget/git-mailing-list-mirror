Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13751DED4C
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771651132; cv=none; b=VSncsX6SfJ6dBRcwukkrCgk/bkWBTIzWteG67z20ZGv0++88Ca+S4+UHnCubqusnAEb8kv+9sbBiBON1wXyCvHdRT/lamRfP+OJ8idNqR8HXZ3aw6VXu251GNwwg5XYPlKS5noaV6shA5ig8B5Xai4L+9QEgCAeujMwDiLESj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771651132; c=relaxed/simple;
	bh=1gvoWntgzlDXtp6nuuD1yd50Q0qJZRENMh3YAIOEpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bczB5lbVpAaFXts1s1c7AgpLJg9uUCHRo9eYRanWxp0+3G2u/hz9bBDNiVy5/pzwLziMBRCdBG5mvyljTivfuD7baJ2HtP/BbG4kXOTpKxY7QHxj97IpOOU9dkQMAFNw9hVBC0ViXaHX++9aU3kDUg8rZVpvcScCekksN2v6kBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=jaBvSVil; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="jaBvSVil"
Date: Sat, 21 Feb 2026 06:18:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771651128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eST/LTJ4Sf0NdIKBUxUwDJLc7GpNeLuL4eNIp4a5oB0=;
	b=jaBvSVil3va/feYh3iEmeZLr/P7oopQ9hDGEEkps8HbFOpgX7k+ug7xXUB124xBX9DdwsO
	ALnTzLn00ptwAXO7sBds4icO+1lcmF0vVPoEB13uH0goajHPkeCVyQyicuhD1oBCiLUZwK
	sVoAJzmOlAeZMd57dJfT9W9Yf0VovElsorXZvu36agEk+dfeLjaSKdq8paiRTD6C91Y0Jy
	n7NfYX/oOsu2ACW1VNVTiSObaDj6Wb1dspo+dbUCyq4qS+qdIk91BxJ4r5ApUBnsLfiBAj
	vEUNkM5GD0bzRjbaCKq2M3mABgsGgsWKJBaybEBP27zYUozTVZ9jaNmka9nmrA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
Message-ID: <aZk9QlH2PDugXKrh@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=mroik@delayed.space;
 h=from:subject:message-id; bh=1gvoWntgzlDXtp6nuuD1yd50Q0qJZRENMh3YAIOEpmQ=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpmUAgeVePj1fLlAyj/j/LAIEjajUq7TywmJ745
 LsR3kwqJUOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZlAIAAKCRBIeX6hnBm+
 0T/zD/9K9NWdQ/QnycQuioXkORfgwscjR2CxbdE51lpPXW84NC0yYjNbpk5QzGXZRIyTjNYE74s
 p9yrROa/L/dsE62YzI3oPdHtGkH00K3/u3FWJ+fLqCsXbgjHi72L8Knw9K+0yGrQRGWx1eZhblX
 snop1EKyjlQZHTaWTq6wO6JYtp5tDMf/2tNk25WfvwBdbbQNpqbxlYTmc5h1nSaf4u2jbK4geRE
 UfPc74dXwa+0b0u7y8a5OPNoIaEJM5f5h91+oE+7cBqRHAeuAlUVWMmhXBy2P2MiX4zSFvIoIoV
 QJRWw4qTPDK4QMsMWpg0KX2X1fyTS6z0rdrSQWJxzi9qgAKYhosErcc+NPBEuRiciBSMkEOLvmF
 lfYCNvnWPLNUsAomrGQSxorxFVgzUT6KvjQfjBqDVUB6KC63/IaHIKu7x5kEEtDOYWbH3MqA+4d
 2xUt8MsEZUO3GNEndheBu3+hnaMybfA28wPE1lnXaIqq6OkXEPl5h0OdSMlxzMdf92w6HK/56Bp
 CObUgyaioFQ/eFmI7CnzHZkPnMThbfItRDfBUj4fQLg0c748PRpSr9WnGv54OwZkB2/vDbN3KUX
 2W1Khp1pqJ0p7pY1MuHrRGqLzPhUGWLGqfPCa4MPgnGljfkDwSjw95g2mpGBGbpr9GFeLOidsOd
 15Rm4gq5nd9IJlg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <xmqqldgmu25h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldgmu25h.fsf@gitster.g>
X-Spamd-Bar: --

On Fri, Feb 20, 2026 at 08:54:50PM -0800, Junio C Hamano wrote:
>  (1) Drop the abbreviated object name, as they are useless garbage.
>      The result of applying these patches will not have these commit
>      object names anyway, so even when people find these messages on
>      a mail archive in 6 months, they will not find the result of
>      applying the patches from the official project history with
>      these object names.

Should there be a reference to the author ident instead of the object
name then? A quick glance on who worked on what before diving into the
patches themselves might be useful.

>  (2) Do we need to make this optional, in order to allow those users
>      who do prefer the current "shortlog" style that groups patches
>      from the same person together to keep the original style?  I am
>      undecided myself.

Maybe the "--cover-letter" option can take an argument like
"--cover-letter=<shortlog | commitlist>". Although I doubt there's
anyone that actually likes the shortlog version, it gives very little
information. I'm inclined to think that most leave it there because they
think it must be somewhat since it is the default, tho this is just my
assumption.
