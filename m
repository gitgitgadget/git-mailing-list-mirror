Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798506;
	b=um6XdS6/X8w3zqkfxcrh8WLFf7nYUr4GdMbBn06jkM0QEitOpkhlQu+0ISeDxJzbhx4s
	 ROTT8dznBmNeGK/wKpOIUiU3gyi34pww6pozkLCSSyjQybK7JE4YVCGJHcH5m+l9g+oK7
	 byY/CbyfIhjkQsr5lhEUOdW2Pb7V7nd6rU+ergZfVbGC64fvzJMsLxg+kGKIo4+S9ho1P
	 4F7/A7lC0ajVS9x51/cRSvFfvRWMNSlLcjmO522eXooRK1fQMg5dhSRZpgubFyN0RhLDo
	 k0Li7FBkoy5+q8IVsj/RqUsXj7cErTGq22Pguzmyt73JERPpUuIS6JziGE2jmb2iSpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BbxoI1u6NTuvjxEu6ln3H9+luXGOlIm+jPN6D89jWcg=;
	b=4cKl9eGGtur5EoeDj9kflgQALz5Xs7feYHcKlsl+rPGAavlXx9m2Txudf8ABVASI7Xus
	 lYA7lqMoB/8fpZ7/qZmGug11U/0eJkkhYx4qV2DkWrT6IESQSeDF3TB8TD2/gaJ5FeoHN
	 V74r5HcZVJQLMiBp/nE+lDu5CuvCVznqgUZCaYNmqJIsNtidtJMQhECqIsbru0qL5TkTJ
	 DQKZ9EohLqX5IDl9ad8IHhuCTKcgNSl7hvo8+EEO+58RFaQUR2M89lzD9tiwdhqm0T3DZ
	 pXZKHOzUfUoThb/SKfaVTcfmXJp7X0NySl/bf4szRSzEuk6H+A7qyyf64jFQiLn71GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4O8vNU2;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69604606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69604606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4O8vNU2
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49465892f7bso6101649f8f.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798505; x=1796403305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BbxoI1u6NTuvjxEu6ln3H9+luXGOlIm+jPN6D89jWcg=;
        b=E4O8vNU26GtwGCdyzjOKHbvZwsOUJzHMZ2uIyvGHD/6vYC9aNv0lYdQSTg+UUv8GI2
         s8ZOyekELpCkp2jV9J1iJ8Gm+4H4h/AhpyUgbhWpk9YUJsE7uBlb+Kc7PowAitZfdATG
         FEBhNI6DAsmPiokrCzuT1rhUMAScNGHx0gVBTObxzK18aU10SHPQluLyCv4Zr5Qh4YuD
         reWu8ia5fqp6I51fze5A1YEPcXRcT/IIlV9McC4FGvI3LDkOppRWV/JHiygj5mg2by20
         gO7SoOvI3ncaEbqMx8JFM97UUGVuopOSu7Z7vpkAnGh5QEqJsa2OFCOyWrS+6TsJ/eBd
         T++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798505; x=1796403305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BbxoI1u6NTuvjxEu6ln3H9+luXGOlIm+jPN6D89jWcg=;
        b=o0XU0NrlCqPYDvsGH8hav8vLbJc0ri1RgltuPYUK7f1P1Vd0nKNvhpzBHMDSf8Dwj5
         r3aSKvOpNbmUmHWw0lDX1U357o8Au6KRFrFj4h2DYOB6hb3sTAyfY/jeOSsbwZXWEUWH
         iq5413FM6MljZ4CvkOt+5F77i4Bu5vQRtdZxV17LTe3XLX7N6bZF+dv9+M4sZrdBWXBd
         Ysl5xge6O5QSmtv9jO8ma6UQw7wfYmqW0hTuTHZP6vuiDxgVvpHoTvfckOMCB7um2lXu
         tO7Po3CNesOJTmez47ljgQjY25jb9t1klyo3fWJjYaRzzsKGGPP+gHvoHn9sP6H50ZeD
         3xNQ==
X-Forwarded-Encrypted: i=1; AL+hErF8fMzQcuIOnvqEg0JkAbrzXFQfC+do1h6m2oAfFqFM4lKkaPdPwPARZvcWhQ0tf7svEfs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vaNFQK6KCrPp2q0QKjFdl3nj2ZUIuimjocWIcN1I17WSFGp19
	ZoxR09tPS+pYJlkLfJQjOWO3WVuL1//Ah1EYaQyiVzrXiSE3drNQ5wi9
X-Gm-Gg: AZFdTZdBrsExN8RgrQyrJ0n+GUtuOLIXNmX0SMmA4Z3FPM9ywhV9PEM7biLne+wzbS1
	MvW2+Rbwgp6ZRqzoNRV3J0jIAFXnL4haFnep1Rhi6pg0/Kam3Ggmrdwh0WG9gg0EH/LmOv5syga
	dCNS+cjWYNTHAnSq31bEvQ0XEPfylhc1PYq7kALHSBg/R9XL2/vVfSSp2c3VwCsrQG/ayF4vn5Y
	Ik11MCnI4vy6qB0Ix3POCs6JNzL7q6/+zSBzu/ZB2MYNKt1KLsvbAad6l54lgulmQ8BE/t1AAa6
	oymHXnKtdw0wYkmeEoHMtxk+FLhWTeCcZN3C2Of7vZNRf/iXVN1Wt/sdnfeTbRnmgitg7iAGE3/
	Df7GallSNBXJ16aBh0m97iPaI91w7lynZ4BYzkWsm5j5RJdGLzm6fZtksdT8lpMmH3ywtU4HX7B
	gim3qAQ+yKuKWOl3wfISIFTfIwWX5M4hG0FI5KWLgDA8manLcgisM4FKWFCZoLy010D1oXgysyk
	Aottoyx0OmtYxJiyqRJpzP7jmosuc8SP8wqZMKb/bahFMGmfwUQcfOW2X3D+DvVtuEBgOMc5kFT
	7eS1N8I3cAGGrcOBor2jlQ+xJhsXAe0JAsL262+KdV+6kra4BMjSfDvuXSTqZO9Ywm3GneSch7s
	EANyQGi4=
X-Received: by 2002:a5d:4dcc:0:b0:493:d5f0:4e68 with SMTP id ffacd0b85a97d-4abb45c819bmr39000900f8f.36.1795798504745;
        Fri, 27 Nov 2026 08:55:04 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989b3sm48155389f8f.51.2026.11.27.08.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:55:04 -0800 (PST)
Message-ID: <a112473f-32d9-4fe0-8497-782e8fab8bf7@gmail.com>
Date: Fri, 27 Nov 2026 16:55:03 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: make the suggested "set" command safe to paste
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 nahidhasan141400@gmail.com
References: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
 <02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com>
 <607d6273-14ba-4005-b038-3778ad2812fe@gmail.com> <xmqqpkvrmot8.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpkvrmot8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2026 18:26, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> sq_quote_buf_pretty() is intended for that use case, so we already have
>> a central location for that logic.
> 
> FWIW, as the inventor of the sq_quote() family of helper functions, I
> did NOT know that we were allowed to futz with what the
> sq_quote_buf_pretty() class of helpers produce without having to worry
> about machine readability and output stability.
> 
> That is even though we prominently document them like this:
> 
>    These should only be used for human-readable output, as sq_dequote()
>    is not smart enough to dequote it.
> 
> Two things that come to mind are (1) we may need to find a way to make
> it even more prominent, and (2) "smart enough" will become irrelevant
> once we start aiming to cater to the user's shell, as predictability is
> what sq_dequote() is about, and compatibility with different "faviourite
> of the year" shells directly contradicts that goal.

I hadn't realized sq_quote_buf_pretty() was used in the tracing output. 
While we might get away with tweaking the quoting in the tracing output 
slightly, I don't think we want it to depend on the user's choice of 
shell. So if we decide we want to support more shells, we should 
probably introduce a new function for that.

>> The output could be prettier though, in particular in would be nice to
>> avoid the redundant pairs of single quotes at the beginning and end of
>> ''\''hello there'\''' so that it produced \''hello there'\'
>> instead. "'hello there'" would be even prettier but would take more
>> work.
> 
> Yes, but I am not sure if going _specific_ to a single chosen shell,
> perhaps via user.shellsyntax = (sh|fish|csh|psh|ksh|...), is a good
> direction in general.  There are folks who script in one and interact in
> another shell.

The paragraph quoted above was taking about improving the readability of 
the quoted output by removing redundant quotes, not tailoring the output 
to a specific shell.

I'm one of the people who uses different interactive and scripting 
shells. Personally I'd be content with git always quoting in the style 
of my interactive shell. If the git makes a suggestion based on a bad 
input that I passed to my script then I'd want to quoted for my 
interactive shell, not the shell that the script is written in. If I'm 
debugging a script, I can always tweak the config setting if I need to.

> And no, going _generic_ to be usable by _any_ shells we care about is a
> direction I do not think we want to go.  If backslash becomes active
> even inside a pair of single quotes in some but not all shells, then we
> must avoid inter-shell ambiguity by not using backslash while inside a
> single-quoted environment, by first closing the currently active single
> quote, giving a double-backslash (assuming that it is universally
> accepted as a single backslash character by everybody), and then going
> back to another single-quoted environment, e.g., "'abc'\\'xyz'", which
> is the familiar ugliness of our sq_quote() output.  That kind of ugly
> output will be needed to be usable by everybody, but then even though it
> may be cut-and-paste-able, will it still be understandable?

I agree it is ugly and we're already doing it for '!' to accommodate 
csh. To support fish we would not need to unconditionally backslash 
escape backslashes -- our current quoting is almost always correct for 
fish -- we'd only need to do it when a backslash is followed by another 
backslash or a single quote. For the latter we're already creating ugly 
"'\''" output so I don't think that accommodating fish would change our 
current output most of the time. Having said that it is not possible to 
support shells whose quoting rules wildly differ from POSIX simply by 
tweaking the current output. If we want to support something like 
powershell we'll need a way of configuring the output.

> My pessimistic but practical side is tempted to say that it is a lost
> cause to aim for cut-and-paste-ready output.  Rather, we may be better
> off if we give output that shows clear boundaries between each
> "parameter" to "commands", and have the user express that in their
> chosen shell.

That is certainly simpler and if we abandon any pretense at shell 
compatibility we can avoid the ugly "'\''" by enclosing each argument in 
"'" and backslash escaping "'" and "\" within each quoted argument. I do 
think it is convenient to be able to cut-and-paste the output though. 
Thanks for the footnote below, that was interesting reading.

Phillip

> [Footnote]
> 
>   * 6fb737be5e ([PATCH] Make sq_expand() available as sq_quote().,
>     2005-07-07) introduced the sq- (stands for single-quote) quote
>     mechanism as an externally available API function.  1fbdab21bb
>     (trace: avoid unnecessary quoting, 2018-01-15) added _pretty() as a
>     "human readable" variant, the first target being the output from
>     tracing.
> 
>     The principles laid out there for "pretty" are worth noting:
> 
> 	Trace output doesn't necessarily need to be shell-compatible,
> 	but:
>      
>          - the shell language is a good ballpark for what humans
>            consider readable (well, humans versed in command line
>            tools)
> 
>          - the run_command bits can be cut-and-pasted to a shell,
>            and we'll keep that property
> 
>          - it covers any cases which would make the output
>            visually ambiguous (e.g., embedded whitespace or quotes)
> 
>     My reference to "clear boundaries" is about the third point.

