Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9A53E1E
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179547; cv=none; b=t4s5OCc9KC32gWIUvXpbjSWBayRGi7uu7ekjVgfioNvD/oc9iZv9Ei8tVzF2i73iXoTA610adGFcv5aVtEnuGdEsSLgxfGHPQZUFoLpKQBatsp87u0daIYZroMOQVh+OniPlcrO04jhtjAf+o89Mz8InB60vQluvRYrkpL378ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179547; c=relaxed/simple;
	bh=4F0KojLgaFVp1ABiHgAZsa4lqaVAstvNHDqF7KQSnuY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c+HVIfoUBhf1Er/YrFfgrTYaZZq+N4o4TFA53E42nPlXUn97LzPSl2tHu4aXVPKX2g/eZVaXgQEXg5sqRoNy0JDu7lpqgRJjtVJjIJ+Czqu/yw76gVk+FtModUa8vrCfA+n2w70og09Sf8yX/SRoktPgvPFGk8fMmM5qoPFiODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DdoE5lce; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DdoE5lce"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710179542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pwf/FJHPMuZjEen50e5lZ228qiflOPnaCJ0TYOjg3sQ=;
	b=DdoE5lcewRJNhtJJb/BE+LBmBBDSX52nc6xHrYfHYZ9WnFD2RqW8ZnApeCPDKcbw5dzo2i
	TCFvUJABmq2YzMqn2p7w25eQE6hbNSEEibns7w8PWO+FcxbzYJ7h8rgDurqqRBpCsnc99u
	RTHPLytZ4C3VdSOHhIA1giKzvNkf1PQnbLNToXTLWThORO0EKqSin0BBcWm3asQ3EhCAvz
	41OCI+IS/rI/ihL3gMNOXvLQCJ1eGYgFP6LW2O8Ze/nV2FlscyMNK+Rn8xx4/Hs7heaz6L
	D0Sr2riHUw0b028yVX4zsAJpqD1JvaKuut6ie0HANZ7m2yNKxUpM1ZLijSMEcQ==
Date: Mon, 11 Mar 2024 18:52:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, 'Ralph Seichter via GitGitGadget'
 <gitgitgadget@gmail.com>, git@vger.kernel.org, 'Ralph Seichter'
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <e7fe2e229f0b5c76fdec1d789bfecd6e@manjaro.org>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <0b8701da73d3$fa0f2080$ee2d6180$@nexbridge.com>
 <e7fe2e229f0b5c76fdec1d789bfecd6e@manjaro.org>
Message-ID: <0f3a39ab1eeb28201b474afb7fd92c89@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 18:00, Dragan Simic wrote:
> On 2024-03-11 17:48, rsbecker@nexbridge.com wrote:
>> On Monday, March 11, 2024 12:17 PM, Dragan Simic wrote:
>>> Subject: Re: [PATCH v2] config: add --comment option to add a comment
>>> 
>>> On 2024-03-11 13:55, Junio C Hamano wrote:
>>>> "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> 
>>>>> From: Ralph Seichter <github@seichter.de>
>>>>> 
>>>>> Introduce the ability to append comments to modifications made 
>>>>> using
>>>>> git-config. Example usage:
>>>>> 
>>>>>   git config --comment "changed via script" \
>>>>>     --add safe.directory /home/alice/repo.git
>>>>> 
>>>>> based on the proposed patch, the output produced is:
>>>>> 
>>>>>   [safe]
>>>>>     directory = /home/alice/repo.git #changed via script
>>>> 
>>>> For readability, you probably would want to have a SP before the 
>>>> given
>>>> string, i.e.,
>>>> 
>>>> 	variable = "value" # message comes here
>>> 
>>> Let me interject...  Perhaps also a tab character before the "# 
>>> comment",
>> instead of a space character.  That would result in even better
>>> readability.
>> 
>> Does adding a tab following data change the parse semantics of 
>> .gitconfig?
>> My naïve understanding is that .gitconfig follows a basic rule of 
>> leading
>> tab within a section, followed by text. Is there a formal syntax 
>> description
>> of what valid input is? The value does not need to be quoted, so what 
>> does
>> the following actually resolve to:
>> 
>> (TAB)variable = value(TAB)# comment.
>> 
>> Does variable mean value or value(TAB)? Obviously TABS should be 
>> correctly
>> be interpreted as whitespace to be ignored. However, what about:
>> 
>> (TAB)variable = value(TAB)s(TAB) # comment.
>> 
>> Does that mean value(TAB)s, value(TAB)s(TAB), value s, value s(TAB), 
>> values?
> 
> It should mean "value(TAB)s", according to git-config(1).

Hmm, after having a look at config.c and doing some testing, 
git-config(1)
seems to be wrong when it says that "internal whitespaces within the 
value
are retained verbatim".

Here's an example...  I placed the following into ~/.gitconfig:

   [test]
	  blah = huh	uh

There's a tab character between "huh" and "uh".  Though, running

   git config --get test.blah

produces

   huh uh

which contains a space character, not a tab.  That's expected according 
to
config.c, but not according to git-config(1).

Should we correct the wording in git-config(1) accordingly?

>> The definition according to git-config is
>> 
>> "The syntax is fairly flexible and permissive; whitespaces are mostly
>> ignored. The # and ; characters begin comments to the end of line, 
>> blank
>> lines are ignored."
> 
> I believe these two quotations from git-config(1) should make it more 
> clear:
> 
>     A line that defines a value can be continued to the next line by 
> ending
>     it with a \; the backslash and the end-of-line are stripped. 
> Leading
>     whitespaces after name =, the remainder of the line after the first
>     comment character # or ;, and trailing whitespaces of the line are
>     discarded unless they are enclosed in double quotes.  Internal
>     whitespaces within the value are retained verbatim.
> 
>     The following escape sequences (beside \" and \\) are recognized: 
> \n
>     for newline character (NL), \t for horizontal tabulation (HT, TAB) 
> and
>     \b for backspace (BS). Other char escape sequences (including octal
>     escape sequences) are invalid.
> 
> To me, all that indicates that trailing tab characters are stripped, 
> but...

After some testing, I can confirm that any tabs (or spaces, or mixes) 
between
the value and the "#" character do get ignored.

>> "Mostly" does not make me comfortable that this is formally allowed or
>> disallowed or ignored. I would suggest that this change needs to 
>> formalize
>> the grammar on that documentation page for clarity.
> 
> ... I do agree that it should be clarified further in the man page.
