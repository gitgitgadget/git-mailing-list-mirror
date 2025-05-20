Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778872550A6
	for <git@vger.kernel.org>; Tue, 20 May 2025 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717634; cv=none; b=D3FQDI64oZ8vZ0RntHVveZ2gAwgPx837x5EUEJT7EwdDNff0iiPptcRKjO+FQs56UjVujF1pu84MnflvXgYU6Mbbs+W8CthjtlvL+S6DevsiMnKYemymtYeWO8tDejTMcL0do4Z1/odlIC5WF2Y+iDoI+85vMOMM7h95k8mss8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717634; c=relaxed/simple;
	bh=HwnFI64sIT96t2/m4APljiRUdVu2w0m6r9w9FN+NA/U=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5t/yE0HBPv6qfRiXgeCnhcV1ySWnuDyVLFiYsA6AmTPAsGOd8EbCZCoPtIKWTmNPt/wcPHSUDiJV7rv2s1FIp/CYm497ZEXizAHm/lfUPL9PHUlt8m+1uXuTn2fIDFfJf/0gl7dqnduZCgUPCCmFkRLaZyjbhQccUBJP2M6D3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=nF/Uq52D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="nF/Uq52D"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742caef5896so1922580b3a.3
        for <git@vger.kernel.org>; Mon, 19 May 2025 22:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747717631; x=1748322431; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgsbQ0kPdMx1ebu5BCr73DeUmAdC1DU3pOMV2WMyeeA=;
        b=nF/Uq52DqHjTk9oB5nuHhK8ECfPJfPESZc8+/mLIuT+RIeyhL7p/MNcPc0aadn89FI
         S7hA2+lAwcNx9YJq9t/0xMYNHHEsCFzUrB5LFLEiJ4FUvKa6/GlGGnbi2yb4VX0zlVPW
         zLdZItLy6tv3XdPjouWihxMw+PBgJtqA40uQPorO0VIwHH7fbWIWNc71OX6nWAPVHtFi
         60PT+KrKDRaAsne4fxEysc94dFkdMsFtNJq9hgf3Ty8yIpPpeQEUa29mjFaraWpMbfzL
         J0gFa5nDOd03Eho1LMaNxEzGLPCxlM0cs4/qUFgXeCkMgGbTztxV8fZcyRuYequlKfs5
         ZWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747717631; x=1748322431;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgsbQ0kPdMx1ebu5BCr73DeUmAdC1DU3pOMV2WMyeeA=;
        b=fLyaPuHzkWhfch3N+byvPhBSzMCEVNSzoI5OL2x9k0eZjMcis8/c6BRC7vVlFJ3znO
         SNXfbk2LPlW//XeQ9goCWgvW+OUhaFu53dR7726g/x8D0MJOwMbMeV/bYAnyX4nEN/SG
         VxyIPf5y73AZwUZFmXqnyZ2qwb8/0kiswJZmq/76Yi+kGSgak6N8DP44MTU93UsuieA2
         D8y29kJm5mVCFZIJNUsMZIyn7G8VToSZrnVEtio6dH8G0NK/NrmAu9Wp133c8YGpN0nu
         9L2Wo6PqHVy3cOlJy0IRL03YIcGKEZtS1p7j3O/tK8LuANX5fDQMuKTuhrLSR9xy05b+
         P0kw==
X-Forwarded-Encrypted: i=1; AJvYcCVSFt4iZVlo+x/Wm9d3iP0W3kmOyk+aD59sUvQuSPaK0vpqEee6iSjKIjLPc0CuQ+NGHuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPH0CKxaGuGsDdgsN+eRfLBDLdWxjRJipB1GdLUlvRC8TElrk
	+OkUgr1MS4IdbD03PfechZ0jLb1La0imVyvnyGxyZuHocXNNpeevVgM0Cufqf+sIxkfrh/mc0Eg
	2xJC5weQ=
X-Gm-Gg: ASbGnculH0kZEauFO9jy8ekAlCltxW0gXJxfgDb+HEkBoB0VEIIm7FpHiIKGDkdXlbe
	+OnAyKyfbQS+fdzbMkBnqF/WieTNOMcjvFx66d6khDO+ARiZwTk3/CmsaUP1x9+S5w7G27KcyOv
	2twzZAA3D+HM4WW+NCBg+Z8a/XK85PBmZrkrhbi5S56k6J4DntqKwTATbOE/nFFadPt9gmBHSPh
	RzOZnIygRaCB/BDMOerlt+QjCYD2T94hoxxyC0ZbiRldMinu91wZVlXk8oau2+JxBGyUvbwd+0J
	wX5HkmhVQXyNfYxGCtG6aghCHMe2dk5C7arcs+8j5TAhowaEw+qcZiOivMNd51YJnPdTPho5gUA
	mGA==
X-Google-Smtp-Source: AGHT+IFcsE+hzPErI5FdBDDb2wb91k2tnf8KVe/suug/2cQW26XF6gLm68LNxjle1WLltRqXDz2aew==
X-Received: by 2002:a05:6a20:6a10:b0:1f5:52fe:dcf8 with SMTP id adf61e73a8af0-216219b82a9mr22502163637.26.1747717631576;
        Mon, 19 May 2025 22:07:11 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:8241:ad67:5c79:1831:62bb:6d8b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6f28csm7099220a12.22.2025.05.19.22.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 22:07:09 -0700 (PDT)
Date: Tue, 20 May 2025 12:32:23 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: Small patch to add support for MPTCP on Linux
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, git@vger.kernel.org, Matthieu Baerts
	<matttbe@kernel.org>
Message-Id: <ZXLJWS.WPQLCXFNN8TH@unrealasia.net>
In-Reply-To: <xmqqo6vokvpv.fsf@gitster.g>
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
	<BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
	<aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
	<4YPEWS.J5JRNETKLXF1@unrealasia.net>
	<a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com>
	<Phillip Wood's
 message of "Sat, 17 May 2025 14:39:38 +0100">
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tpQCJgcHCttYZZU1F0K1"

--=-tpQCJgcHCttYZZU1F0K1
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, May 19 2025 at 04:49:00 PM -0700, Junio C Hamano 
<gitster@pobox.com> wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>  As brian has already said I think it would be better to have a
>>  Makefile knob to control this which defaults to being on for
>>  linux. Take a look at the various USE_xxx definitions in the 
>> Makefile
>>  and config.mak.uname for setting default compile flags for different
>>  operating systems.
>> 
>>>  Also another check if a socket is supported by looking for a return
>>>  value of
>>>  "EAI_SOCKTYPE" (not EINVAL) and fallback to regular TCP if that is
>>>  returned.
>>>  EAI_SOCKTYPE should work across different UNIX systems as this is a
>>>  posix error code.
>> 
>>  That error is not mentioned in the documentation for MCTCP on Linux
>>  [1]. Please make sure your code checks for the errno values 
>> described
>>  in the documentation.
> 
> Also according to RFC 6897, "MPTCP is designed to be totally
> backward compatible to applications".  I understand that this is
> quite unlike introducing IPv6 into IPv4-only world.  You can tell
> the system that supports MPTCP to use it in specific ways by
> updating your application, but your system's local policy may
> allow MPTCP to automatically set up multiple subflows even your
> application is not quite aware of MPTCP.
> 
> So, ... I somehow would be mildly surprised if Git were a kind of
> application that needs to take advantage of "several additional
> degrees of freedom that applications may wish to exploit" by using
> API that is "a simple extension of TCP's interface for MPTCP-aware
> applications".  Requiring a simple application like ours to tweak
> and rebuild in today's world does not sound like a winning strategy
> to promote a technology that "is designed to be totally backward
> compatible to applications", at least to me.
> 
Taking into scenario that i have WiFi access and regular Ethernet access
on my Laptop and i'm cloning or pulling a large set of code from git 
(which uses
regular ethernet as primary interface and WiFi as secondary.)

On the regular TCP, my connection will reset when disconnecting 
(plugging off) from Ethernet
and switching to WiFi but MPTCP solves that issue for me and allows 
uninterrupted
work on git cloning/pulling, especially when i have to work with huge 
codebases.

I think that's the relevant use-case for a laptop user working with git.

Apple had been using MPTCP for 12 years and their cloud services run on
Linux servers with iOS clients and for that i can say that it's pretty 
much production ready.

And it's not just Apple. Intel and RedHat had been involved and 
RedHat[1] pretty much
are into MPTCP.

Honestly, i love reading the git codebase as it is very simple and 
straightforward and
i think my previous patches were a bit too big and needs to be 
simplified so,

I have reached out to Matthieu Baerts <matttbe@kernel.org> who works on 
Linux MPTCP
on this issue and i've greatly simplified the code from his comments.
(I've also added him to the loop in this email)

The patch i am attaching is a preview (still WIP) as i need some 
feedback from the linux
mptcp developers if my implementation is correct. But it's greatly 
simplified to follow
git codebase's structure.

Changed the part for the git server daemon to enable mptcp by 
default[0] and modified
the git client to use .gitconfig (global or per repository) with:

git config --global core.mptcp true (or a single repo without --global)

which defaults to false (mptcp disabled for client) as per[0] and 
removed client-side the env var configuration.


[0] 
https://www.mptcp.dev/faq.html#why--when-should-mptcp-be-enabled-by-default 
(Thanks @matt!)
[1] 
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/getting-started-with-multipath-tcp_configuring-and-managing-networking#proc_monitoring-mptcp-sub-flows_getting-started-with-multipath-tcp


> 


--=-tpQCJgcHCttYZZU1F0K1
Content-Type: text/x-patch
Content-Disposition: attachment; filename=git-mptcp-temp.diff
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NhY2hlLmggYi9jYWNoZS5oCmluZGV4IGViYTEyNDg3YjkuLjY4MzliM2Fj
YmMgMTAwNjQ0Ci0tLSBhL2NhY2hlLmgKKysrIGIvY2FjaGUuaApAQCAtOTQ0LDYgKzk0NCw3IEBA
IGV4dGVybiBpbnQgdmVyaWZ5X2NlX29yZGVyOwogCiAvKiBFbnZpcm9ubWVudCBiaXRzIGZyb20g
Y29uZmlndXJhdGlvbiBtZWNoYW5pc20gKi8KIGV4dGVybiBpbnQgdHJ1c3RfZXhlY3V0YWJsZV9i
aXQ7CitleHRlcm4gaW50IGVuYWJsZV9tcHRjcDsKIGV4dGVybiBpbnQgdHJ1c3RfY3RpbWU7CiBl
eHRlcm4gaW50IGNoZWNrX3N0YXQ7CiBleHRlcm4gaW50IHF1b3RlX3BhdGhfZnVsbHk7CmRpZmYg
LS1naXQgYS9jb25maWcuYyBiL2NvbmZpZy5jCmluZGV4IDIzMTdhNzY2OTYuLjgzMzM5NmFhNGIg
MTAwNjQ0Ci0tLSBhL2NvbmZpZy5jCisrKyBiL2NvbmZpZy5jCkBAIC0xNDY0LDYgKzE0NjQsMTEg
QEAgc3RhdGljIGludCBnaXRfZGVmYXVsdF9jb3JlX2NvbmZpZyhjb25zdCBjaGFyICp2YXIsIGNv
bnN0IGNoYXIgKnZhbHVlLCB2b2lkICpjYikKIAlpZiAoIXN0cmNtcCh2YXIsICJjb3JlLmVkaXRv
ciIpKQogCQlyZXR1cm4gZ2l0X2NvbmZpZ19zdHJpbmcoJmVkaXRvcl9wcm9ncmFtLCB2YXIsIHZh
bHVlKTsKIAorCWlmICghc3RyY21wKHZhciwgImNvcmUubXB0Y3AiKSkgeworCQllbmFibGVfbXB0
Y3AgPSBnaXRfY29uZmlnX2Jvb2wodmFyLCB2YWx1ZSk7CisJCXJldHVybiAwOworCX0KKwogCWlm
ICghc3RyY21wKHZhciwgImNvcmUuY29tbWVudGNoYXIiKSkgewogCQlpZiAoIXZhbHVlKQogCQkJ
cmV0dXJuIGNvbmZpZ19lcnJvcl9ub25ib29sKHZhcik7CmRpZmYgLS1naXQgYS9jb25uZWN0LmMg
Yi9jb25uZWN0LmMKaW5kZXggZWFmN2Q2ZDI2MS4uZWJlYWM5OWJkNiAxMDA2NDQKLS0tIGEvY29u
bmVjdC5jCisrKyBiL2Nvbm5lY3QuYwpAQCAtNzIxLDYgKzcyMSwxNiBAQCBzdGF0aWMgdm9pZCBl
bmFibGVfa2VlcGFsaXZlKGludCBzb2NrZmQpCiAJCWVycm9yX2Vycm5vKF8oInVuYWJsZSB0byBz
ZXQgU09fS0VFUEFMSVZFIG9uIHNvY2tldCIpKTsKIH0KIAorc3RhdGljIGNvbnN0IGludCBuZWVk
c19tcHRjcCh2b2lkKQoreworCWludCBtcHRjcCA9IDA7CisKKwlpZiAoZ2l0X2NvbmZpZ19nZXRf
Ym9vbCgiY29yZS5tcHRjcCIsICZtcHRjcCkpCisJCXJldHVybiBtcHRjcDsKKworCXJldHVybiBt
cHRjcDsKK30KKwogI2lmbmRlZiBOT19JUFY2CiAKIHN0YXRpYyBjb25zdCBjaGFyICphaV9uYW1l
KGNvbnN0IHN0cnVjdCBhZGRyaW5mbyAqYWkpCkBAIC03NzAsNyArNzgwLDExIEBAIHN0YXRpYyBp
bnQgZ2l0X3RjcF9jb25uZWN0X3NvY2soY2hhciAqaG9zdCwgaW50IGZsYWdzKQogCiAJZm9yIChh
aTAgPSBhaTsgYWk7IGFpID0gYWktPmFpX25leHQsIGNudCsrKSB7CiAJCXNvY2tmZCA9IHNvY2tl
dChhaS0+YWlfZmFtaWx5LAotCQkJCWFpLT5haV9zb2NrdHlwZSwgYWktPmFpX3Byb3RvY29sKTsK
KwkJCQlhaS0+YWlfc29ja3R5cGUsCisjaWZkZWYgSVBQUk9UT19NUFRDUAorCQkJCW5lZWRzX21w
dGNwKCkgPyBJUFBST1RPX01QVENQIDoKKyNlbmRpZgorCQkJCWFpLT5haV9wcm90b2NvbCk7CiAJ
CWlmICgoc29ja2ZkIDwgMCkgfHwKIAkJICAgIChjb25uZWN0KHNvY2tmZCwgYWktPmFpX2FkZHIs
IGFpLT5haV9hZGRybGVuKSA8IDApKSB7CiAJCQlzdHJidWZfYWRkZigmZXJyb3JfbWVzc2FnZSwg
IiVzWyVkOiAlc106IGVycm5vPSVzXG4iLApAQCAtODE3LDYgKzgzMSw3IEBAIHN0YXRpYyBpbnQg
Z2l0X3RjcF9jb25uZWN0X3NvY2soY2hhciAqaG9zdCwgaW50IGZsYWdzKQogCWNoYXIgKiphcDsK
IAl1bnNpZ25lZCBpbnQgbnBvcnQ7CiAJaW50IGNudDsKKwljb25zdCBpbnQgbmVlZHNfbXB0Y3A7
CiAKIAlnZXRfaG9zdF9hbmRfcG9ydCgmaG9zdCwgJnBvcnQpOwogCmRpZmYgLS1naXQgYS9kYWVt
b24uYyBiL2RhZW1vbi5jCmluZGV4IGIxZmNiZTBkNmYuLjA4YTE2Y2NmMDMgMTAwNjQ0Ci0tLSBh
L2RhZW1vbi5jCisrKyBiL2RhZW1vbi5jCkBAIC0xNyw2ICsxNyw3IEBAIHN0YXRpYyBlbnVtIGxv
Z19kZXN0aW5hdGlvbiB7CiB9IGxvZ19kZXN0aW5hdGlvbiA9IExPR19ERVNUSU5BVElPTl9VTlNF
VDsKIHN0YXRpYyBpbnQgdmVyYm9zZTsKIHN0YXRpYyBpbnQgcmV1c2VhZGRyOworc3RhdGljIGlu
dCBtcHRjcDsKIHN0YXRpYyBpbnQgaW5mb3JtYXRpdmVfZXJyb3JzOwogCiBzdGF0aWMgY29uc3Qg
Y2hhciBkYWVtb25fdXNhZ2VbXSA9CkBAIC0xMDA3LDYgKzEwMDgsMTAgQEAgc3RhdGljIGludCBz
ZXR1cF9uYW1lZF9zb2NrKGNoYXIgKmxpc3Rlbl9hZGRyLCBpbnQgbGlzdGVuX3BvcnQsIHN0cnVj
dCBzb2NrZXRsaXMKIAlmb3IgKGFpID0gYWkwOyBhaTsgYWkgPSBhaS0+YWlfbmV4dCkgewogCQlp
bnQgc29ja2ZkOwogCisjaWYgZGVmaW5lZChfX2xpbnV4X18pICYmIGRlZmluZWQoSVBQUk9UT19N
UFRDUCkKKwkJc29ja2ZkID0gc29ja2V0KGFpLT5haV9mYW1pbHksIGFpLT5haV9zb2NrdHlwZSwg
SVBQUk9UT19NUFRDUCk7CisJCWlmIChzb2NrZmQgPCAwKQorI2VuZGlmCiAJCXNvY2tmZCA9IHNv
Y2tldChhaS0+YWlfZmFtaWx5LCBhaS0+YWlfc29ja3R5cGUsIGFpLT5haV9wcm90b2NvbCk7CiAJ
CWlmIChzb2NrZmQgPCAwKQogCQkJY29udGludWU7CkBAIC0xMzYwLDYgKzEzNjUsMTAgQEAgaW50
IGNtZF9tYWluKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKIAkJCXJldXNlYWRkciA9IDE7
CiAJCQljb250aW51ZTsKIAkJfQorCQlpZiAoIXN0cmNtcChhcmcsICItLW1wdGNwIikpIHsKKwkJ
CW1wdGNwID0gMTsKKwkJCWNvbnRpbnVlOworCQl9CiAJCWlmICghc3RyY21wKGFyZywgIi0tdXNl
ci1wYXRoIikpIHsKIAkJCXVzZXJfcGF0aCA9ICIiOwogCQkJY29udGludWU7CmRpZmYgLS1naXQg
YS9lbnZpcm9ubWVudC5jIGIvZW52aXJvbm1lbnQuYwppbmRleCA5ZGE3ZjNjMWExLi43MmYxYWRl
ZjZjIDEwMDY0NAotLS0gYS9lbnZpcm9ubWVudC5jCisrKyBiL2Vudmlyb25tZW50LmMKQEAgLTMz
LDYgKzMzLDcgQEAgaW50IHdhcm5fYW1iaWd1b3VzX3JlZnMgPSAxOwogaW50IHdhcm5fb25fb2Jq
ZWN0X3JlZm5hbWVfYW1iaWd1aXR5ID0gMTsKIGludCByZXBvc2l0b3J5X2Zvcm1hdF9wcmVjaW91
c19vYmplY3RzOwogaW50IHJlcG9zaXRvcnlfZm9ybWF0X3dvcmt0cmVlX2NvbmZpZzsKK2ludCBl
bmFibGVfbXB0Y3A7CiBjb25zdCBjaGFyICpnaXRfY29tbWl0X2VuY29kaW5nOwogY29uc3QgY2hh
ciAqZ2l0X2xvZ19vdXRwdXRfZW5jb2Rpbmc7CiBjaGFyICphcHBseV9kZWZhdWx0X3doaXRlc3Bh
Y2U7Cg==

--=-tpQCJgcHCttYZZU1F0K1--

