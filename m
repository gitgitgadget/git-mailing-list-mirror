Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E317B05D
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546201; cv=none; b=QXDzrf89TkDskITyH5/l4ggGB8kxCtALMc0uALfA4tJAjPtoP5N2w5WqlGZixe9y5SfSzOOVDuTp7rXYtuxMGQ4pI+WcFbAIHaJ5vKyyTmKg8yLKs5iO8/mloTgc0TDZBozA71JWJNT8uRitKMJhJ+SLafvs66kBt2JSTap4hWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546201; c=relaxed/simple;
	bh=MR4z21oLVVErjmX1nM5f0YXZF3yZ4fUwrPHOccDtS64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fzPxbthxh5pg5PqrKz44xR3KBwkLmU+u/jkhW/d//b+d2PiK7h84WwAgpJwsFKlwJQV/GvulIcybrC2vnbrdOuC7A+a1NBiSO3GFPwMD5nGwLvSYVVwAjruUyRGeh2vZG+QSVpQomLdaEbKnV4p1dskYeLUlG1qy5i0tgKzJtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=H0LItlk1; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="H0LItlk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1720546197; x=1721150997; i=antonin@delpeuch.eu;
	bh=MR4z21oLVVErjmX1nM5f0YXZF3yZ4fUwrPHOccDtS64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H0LItlk1uQcvx77eKS1M3MnFYJh4/Vam6qoOUZOGGlUoUb2WP5WcvhmMN+T33WkM
	 /Tp0fp+IJj08zotDbBTSP9J0T2QRyGrEkqwK8OfwxW01+yPWRhfOe4HwOsxUphJnK
	 Pt/c3XSL0fGARdIEArUj/hUcgo9CibEsqjy8p1lV0uOKYCziYjSdOxfuFzi5PSb9C
	 DaYLHrmnFsmt4Is++LG0YmpHRrcKfRxIDBZrr3R5UtKFUCOjrSf1a0HrDCa24q6Yl
	 9YwPZupo8sHZqHf6A7TMeeLX/9rXdA5UgOlMEQa0prFHcychA4Q7fRGWcGlltZUp3
	 whgiiUay/84NXXPmFQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.203]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWzXd-1stRfG0UOn-00Rckh for <git@vger.kernel.org>; Tue, 09 Jul 2024 19:16:59
 +0200
Message-ID: <198a4c00-291f-456d-84ac-082e142bd4fe@delpeuch.eu>
Date: Tue, 9 Jul 2024 19:16:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-recursive: honor diff.algorithm
To: git@vger.kernel.org
References: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <pull.1743.git.git.1720431288496.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UiaPV/wm1fg0Dn4dNw6MrH7xJmR6aenNZ0r6t62Wq6H2a9JdTcv
 tqX3/IhyxQ33VII3DSNGjf6+9MjBbFt2T1OelmOPvQcABUk/QaKGIm7NrgPMEnRXrHkhaIG
 d+nev9ZpLiw8oztH4pSbVN6+SGOA5bxEXs6+5tq6mqVeIS1qpRCQk9RgTz4YFazLf8suSuD
 qQIl5WwiRAO4PIw3jq1oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J/fjs65wqaI=;n+MAGPcUE0Jl4DaN7VEmPZTvjXM
 rxRp5rK0vek9kCYE4DEGjac0DIi2iThjCTcIGihbFnMnnsYNGitwuMLTrpe7eSdn5Zm2u0Xb8
 6JKtv0iOmgJmVeEKsGP4zBlvi5sQ3LvmVjbPN3yqxbc2154siDb7BCnSyIOh1kYtdlM0P5O3V
 Lkex3KKSuH+ss6iGk9boBKlGm2Zg26PqzETkP2nFT7+46CezPIN4KbnfclocKW2ZLsR2B+V6Y
 86bZDzgUMYM8IaREeL2XEYp42aUQTIjcQsYXB8KX57/d9kokSC+312QNmsRbMjbv5oA1kK4pW
 QuWRy4pzKtnSfLdRD02QF39iyiCAWd5hM6AuVjgyuInARbwDDUvqUNNLl1qVn1WL5RRqCh0KG
 vSYGwAIudYBN3AaF8Jb+jMb3ms7F5e4IXM/XzA4tYZWCK0CT/R3Fhh638PThhZl7zy9zebNm9
 2bVjbsD7rIHJNZFeUt0IrsXUQm5e3F9dA/j09/IS9XhGUT5wu7RyxPmRJrqofHzQdlwmkk1Al
 dDDYkt0G37ImwWsSqfI1hdXcVDsMrQ5fqErRoMcVAZDu1xYSf9LKsXhxPH31751M98TIwYxwI
 F3ne2v+k26FIsZlolBWPKBhz82yk4nA1hNs3MUCtN5QKBXNQg85wf1Xcf7mW0dNcnb0vb/vZR
 8AP4Kip4rWepN0qhFcjAapfLZhYRSk0V1sPAdtiS37yNLGJJosYzXQfVuV6ppxgajtzTAiBER
 NsV6jTsV+AZTFtFo0aYd3UkY7WzGU8M8w==

On 08/07/2024 11:34, Antonin Delpeuch via GitGitGadget wrote:
> introducing an argument to 'merge_recursive_config' to
> prevent only the newly added diff.algorithm to be read by plumbing
> commands feels like muddying the architecture, as this function
> should likely not be called at all by plumbing commands.

I have second thoughts about this, perhaps it is possible to refactor
things a bit further, imitating diff.c which has "git_diff_ui_config"
and "git_diff_basic_config". In a similar way, we could have
"init_merge_ui_options" and "init_merge_basic_options" which the
commands could call depending on whether they are porcelain or plumbing.
This would make it easier to remove the current dependencies of plumbing
commands on some config variables classified as UI. I'll have a try.

Best,

Antonin

