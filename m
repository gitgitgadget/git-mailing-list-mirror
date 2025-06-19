Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593017E0
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291937; cv=none; b=OK0O2djeqgzBuJYPKtEJ+W9ZRtrJBl3v9CCzGm/9RVGibRaUiHOj1VNUxgn6qEQAws4JYZ5+2Pk0AQVEYvV1GUR+OVw65I8ZsD/kDfuTfMdQ/abMpkksc5uKy9bOTxCUcSDtL+wHiJfmg8QKbNYO8GPLeSZX+xNT6G5UkqFq3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291937; c=relaxed/simple;
	bh=zOu8JpA8xU3Kx/Ff1bTmVoVDkoNJJzLVB/985zAer2A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J569ZB4biN3Lnmm5+hOdzCorUfvLzq+8R5R0iBbxXvvACE7XpF2W1XpOJM+WWDP/qLXcqYifRCzNN1NoqwgHfsoZm8Y1nEgAuDhljCgU3LATUF9ZW1WSWOVp96yIX9LUT5H0W9y4oZPwsNzWQwybvuzmZCykN/QPuibVCoGpxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=connamara.com; spf=none smtp.mailfrom=connamara.com; dkim=pass (2048-bit key) header.d=connamara-com.20230601.gappssmtp.com header.i=@connamara-com.20230601.gappssmtp.com header.b=VPtdqcop; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=connamara.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=connamara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=connamara-com.20230601.gappssmtp.com header.i=@connamara-com.20230601.gappssmtp.com header.b="VPtdqcop"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32ade3723adso2606661fa.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connamara-com.20230601.gappssmtp.com; s=20230601; t=1750291933; x=1750896733; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bf9f2dqFwM4CW18INIlz27jSYFQzMehR3kG5xI+TPnE=;
        b=VPtdqcop0w7YLIkxHjqUlw7PAaa2dSDQwDQpKml4q6dZbLmOjm/PuLmD5sVhsb9aHE
         35DZzCP19HSkSqoJ/WxtqvE919p/Gl0NXXcnA8n+/olkzHFsDu228J7o0csIZTg2yAUl
         aADrmhQLrf5QdoxgysD+fknEgmB4yHZp+PhhZCbC2nkvKR9+f/34hcE6U5mzHHDT56v8
         brbmCDgk7KRyjui3k4RfpZXmRBQF7hPJ4PBJBLV+VEXTOJWy2iEym8I1O9mCi17unXe1
         6ym1eAliAgXWZVw8XU+5T110qp+4oQKKfce2Jt6twQfLqkTMEk/hsvoCkvPhD5sJdkiA
         fhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750291933; x=1750896733;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bf9f2dqFwM4CW18INIlz27jSYFQzMehR3kG5xI+TPnE=;
        b=EvKQJwqzZogKxwLJrtGiGJhCzk884Bc2g+XhEvqZbGsQGix1M4AblNTwEkXH1VY457
         V0DlXxrNyDz0t0akNHZ3b3aykoDccZl4a1EOZR8rPUaYsoEFFGAV/ft3n96dnzG7s2xk
         hvVB3qG2cUlzI02SR7EMv+UR8zmh99mruflOkWD6TzOLz6aJoJKx5eMQkQxTNzJNnqwg
         UhHV748+Kw0x++IlQjeN1+7SRWgDBC7L+5dHnH0vRc/NvDflfh/X6bfUSJYA5LUR/b7R
         +wc4o7WJm4SFL5Qew4piobKCILFtkOCALDHs8SaROGWPCmplo7FcoBUqhEGVO/JnNJJr
         ZgVQ==
X-Gm-Message-State: AOJu0YyZp+XCF/U45FvSxkSQQdkfw5i2H/PW4Zj/DH/oafeTNqtWyP9S
	8kqIb47fhgbqUmEietAgLX92HAcpmd1jp3A6qGQ/IocggDQHCQB0w1/G8Att7v4TFEptUo7liVH
	M8BvNikxgM7s9Q6Blfmdj2ciJsqBdNjvycwSBFyfI8BG/TzL06Ay1DAkuMiPk16xQSfGt+nfFiA
	heGiGFD9D9dzEtujh7uByr0qIgyKHFz2s=
X-Gm-Gg: ASbGncvy1OZpTLoMrOwz1hshBZvU0GJI0/FVI9NjWcTlFvbHx71MNkmcLMgTe/g06Nb
	QwzvyvxZWy5KkZsGxkSjysNObKo6vbRgiRd30KvXOC+Uyaptn/ggr3ZXjED5lnJ+rWRaB/3xhxE
	18hEqVLMnJYNj/MYoYvqN9NrpMjaiFSRmF/zMKjK2MToE=
X-Google-Smtp-Source: AGHT+IEKkxoQvRr5J6qQQeQlP+a0jPvy1A6Qywo0aaBaZBBKc0uwVBXZuFHrUbJkG3sW3t3XcUp0RnkWSTbjLdx3CcY=
X-Received: by 2002:a05:651c:31c4:b0:32b:8989:eb64 with SMTP id
 38308e7fff4ca-32b8ae4c338mr1135471fa.27.1750291932623; Wed, 18 Jun 2025
 17:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Grant Birchmeier <gbirchmeier@connamara.com>
Date: Wed, 18 Jun 2025 19:12:01 -0500
X-Gm-Features: AX0GCFtIRfRsqQf48UeTo41Nlebz0-9lU3UhhSYLcE9Q9uZ5QJyerIvrab-hb-E
Message-ID: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
Subject: bug report: I was allowed to "git checkout -b" while mid-rebase
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e5f36f0637e19856"

--000000000000e5f36f0637e19856
Content-Type: multipart/alternative; boundary="000000000000e5f36d0637e19854"

--000000000000e5f36d0637e19854
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.  I've attached my git-bugreport, but I'll copy/paste the salient
parts here.  Thanks.  Let me know if I can provide anything else.

*What did you do before the bug happened? (Steps to reproduce your issue)*

I was rebasing a branch "ilogger" on my master branch.  While this rebase
was still open, I accidentally ran `git checkout -b net5` (I meant to run
it in a different console)... and it proceeded to switch me to the new
branch even though the the rebase was still in progress.

*What did you expect to happen? (Expected behavior)*

I would expect an error message and a refusal to execute the `git checkout
-b` command.

*What happened instead? (Actual behavior)*

It created a new branch "net5" off of my "ilogger" mid-rebase branch, and
changed me to branch "net5".  I cannot change back to "ilogger" ("error:
you need to resolve your current index first"), and it appears I will need
to finish my rebase on "net5".  Even after I do that, I'm not sure what
state "ilogger" will be in.

*What's different between what you expected and what actually happened?*

I think the proper bahavior is for the "git checkout -b" command to fail
when the current branch is mid-rebase, just like it does when you run `git
checkout` without the `-b`.


--=20
<https://www.connamara.com>

Grant Birchmeier

Director of Engineering, Connamara

gbirchmeier@connamara.com

--=20
This email, along with any attachments, is confidential. If you believe you=
=20
received this message in error, please contact the sender immediately and=
=20
delete all copies of the message.=C2=A0Thank you from Connamara Systems, LL=
C.

--000000000000e5f36d0637e19854
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_default" style=3D"font-size:small=
;color:rgb(0,0,0)">Hello.=C2=A0 I&#39;ve attached my git-bugreport, but I&#=
39;ll copy/paste the salient parts here.=C2=A0 Thanks.=C2=A0 Let me know if=
 I can provide anything else.</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small;color:rgb(0,0,0)"><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small;color:rgb(0,0,0)"><b>What did you do before the bug ha=
ppened? (Steps to reproduce your issue)</b><br><br>I was rebasing a branch =
&quot;ilogger&quot; on my master branch.=C2=A0 While this rebase was still =
open, I accidentally ran `git checkout -b net5` (I meant to run it in a dif=
ferent console)... and it proceeded to switch me to the new branch even tho=
ugh the the rebase was still in progress.<br><br><b>What did you expect to =
happen? (Expected behavior)</b><br><br>I would expect an error message and =
a refusal to execute the `git checkout -b` command.<br><br><b>What happened=
 instead? (Actual behavior)</b><br><br>It created a new branch &quot;net5&q=
uot; off of my &quot;ilogger&quot; mid-rebase branch, and changed me to bra=
nch &quot;net5&quot;.=C2=A0 I cannot change back to &quot;ilogger&quot; (&q=
uot;error: you need to resolve your current index first&quot;), and it appe=
ars I will need to finish my rebase on &quot;net5&quot;.=C2=A0 Even after I=
 do that, I&#39;m not sure what state &quot;ilogger&quot; will be in.<br><b=
r><b>What&#39;s different between what you expected and what actually happe=
ned?</b><br><br>I think the proper bahavior is for the &quot;git checkout -=
b&quot; command to fail when the current branch is mid-rebase, just like it=
 does when you run `git checkout` without the `-b`.</div><br clear=3D"all">=
</div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><=
div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature=
"><div dir=3D"ltr"><div><span><div dir=3D"ltr" style=3D"margin-left:0pt" al=
ign=3D"left"><table style=3D"border:none;border-collapse:collapse"><colgrou=
p><col width=3D"122"><col width=3D"298"></colgroup><tbody><tr style=3D"heig=
ht:84.75pt"><td style=3D"vertical-align:top;padding:-45.432pt -45.432pt -45=
.432pt -45.432pt;overflow:hidden"><span style=3D"border:none;display:inline=
-block;overflow:hidden;width:105px;height:83px"><a href=3D"https://www.conn=
amara.com" target=3D"_blank"><img src=3D"https://lh4.googleusercontent.com/=
1ZKItKWIoLUepUXvEXgEeZWBlntjas7UxLPLuLLnsApbxAcRepKELA_SwZBe1BWEZ3huC6sJdz2=
ZzvUYLNgu56Zcm8bo2R_iLzXZVjDmMo67675iop6mEMOg_Y6q8Mtz7ylOW9t8RazXt-tyJtEyhE=
0" width=3D"105" height=3D"83" style=3D"margin-left:0px;margin-top:0px"></a=
></span></td><td style=3D"vertical-align:top;padding:5pt 5pt 5pt 5pt;overfl=
ow:hidden"><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-size:11pt;font-family:Archivo,sans-serif=
;color:rgb(0,65,107);background-color:transparent;vertical-align:baseline">=
Grant Birchmeier</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-=
top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Archiv=
o,sans-serif;color:rgb(0,65,107);background-color:transparent;vertical-alig=
n:baseline">Director of Engineering, Connamara</span></p><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fon=
t-size:11pt;font-family:Archivo,sans-serif;color:rgb(0,65,107);background-c=
olor:transparent;vertical-align:baseline"><a href=3D"mailto:gbirchmeier@con=
namara.com" target=3D"_blank">gbirchmeier@connamara.com</a></span></p></td>=
</tr></tbody></table></div></span></div></div></div></div>

<br>
<span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,appleLogo,sans-se=
rif;white-space:pre-wrap;background-color:white"><font size=3D"2">This emai=
l, along with any attachments, is confidential. If you believe you received=
 this message in error, please contact the sender immediately and delete al=
l copies of the message.=C2=A0Thank you from Connamara Systems, LLC.</font>=
</span>
--000000000000e5f36d0637e19854--
--000000000000e5f36f0637e19856
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2025-06-18-1843.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2025-06-18-1843.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mc2mg30i0>
X-Attachment-Id: f_mc2mg30i0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpJIHdhcyByZWJhc2luZyBhIGJyYW5jaCAiaWxvZ2dlciIgb24g
bXkgbWFzdGVyIGJyYW5jaC4gIFdoaWxlIHRoaXMgcmViYXNlIHdhcyBzdGlsbCBvcGVuLCBJIGFj
Y2lkZW50YWxseSByYW4gYGdpdCBjaGVja291dCAtYiBuZXQ1YCAoSSBtZWFudCB0byBydW4gaXQg
aW4gYSBkaWZmZXJlbnQgY29uc29sZSkuLi4gYW5kIGl0IHByb2NlZWRlZCB0byBzd2l0Y2ggbWUg
dG8gdGhlIG5ldyBicmFuY2ggZXZlbiB0aG91Z2ggdGhlIHRoZSByZWJhc2Ugd2FzIHN0aWxsIGlu
IHByb2dyZXNzLgoKV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhh
dmlvcikKCkkgd291bGQgZXhwZWN0IGFuIGVycm9yIG1lc3NhZ2UgYW5kIGEgcmVmdXNhbCB0byBl
eGVjdXRlIHRoZSBgZ2l0IGNoZWNrb3V0IC1iYCBjb21tYW5kLgoKV2hhdCBoYXBwZW5lZCBpbnN0
ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQoKSXQgY3JlYXRlZCBhIG5ldyBicmFuY2ggIm5ldDUiIG9m
ZiBvZiBteSAiaWxvZ2dlciIgbWlkLXJlYmFzZSBicmFuY2gsIGFuZCBjaGFuZ2VkIG1lIHRvIGJy
YW5jaCAibmV0NSIuICBJIGNhbm5vdCBjaGFuZ2UgYmFjayB0byAiaWxvZ2dlciIgKCJlcnJvcjog
eW91IG5lZWQgdG8gcmVzb2x2ZSB5b3VyIGN1cnJlbnQgaW5kZXggZmlyc3QiKSwgYW5kIGl0IGFw
cGVhcnMgSSB3aWxsIG5lZWQgdG8gZmluaXNoIG15IHJlYmFzZSBvbiAibmV0NSIuICBFdmVuIGFm
dGVyIEkgZG8gdGhhdCwgSSdtIG5vdCBzdXJlIHdoYXQgc3RhdGUgImlsb2dnZXIiIHdpbGwgYmUg
aW4uCgpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQg
YWN0dWFsbHkgaGFwcGVuZWQ/CgpJIHRoaW5rIHRoZSBwcm9wZXIgYmFoYXZpb3IgaXMgZm9yIHRo
ZSAiZ2l0IGNoZWNrb3V0IC1iIiBjb21tYW5kIHRvIGZhaWwgd2hlbiB0aGUgY3VycmVudCBicmFu
Y2ggaXMgbWlkLXJlYmFzZSwganVzdCBsaWtlIGl0IGRvZXMgd2hlbiB5b3UgcnVuIGBnaXQgY2hl
Y2tvdXRgIHdpdGhvdXQgdGhlIGAtYmAuCgpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoK
Cihub3RoaW5nKQoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxv
dy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLgoKCltT
eXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuNDUuMApjcHU6IHg4Nl82NApu
byBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9m
LXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9u
CnVuYW1lOiBEYXJ3aW4gMjQuNS4wIERhcndpbiBLZXJuZWwgVmVyc2lvbiAyNC41LjA6IFR1ZSBB
cHIgMjIgMTk6NTM6MjYgUERUIDIwMjU7IHJvb3Q6eG51LTExNDE3LjEyMS42fjIvUkVMRUFTRV9Y
ODZfNjQgeDg2XzY0CmNvbXBpbGVyIGluZm86IGNsYW5nOiAxNS4wLjAgKGNsYW5nLTE1MDAuMy45
LjQpCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUKJFNIRUxMICh0eXBp
Y2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNoCgoKW0VuYWJsZWQgSG9va3NdCg==
--000000000000e5f36f0637e19856--
