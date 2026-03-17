Received: from mail.univention.de (mail.univention.de [78.138.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAC1C8634
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.138.66.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788149; cv=none; b=qoaZG8uC8w3IsnUAnH4n1krgA8H2zQR8smdCjZWXgMtJDmrWmrc3628AS6ppIa7/q1IyVI4pcYHEehEczs4ajuWB4RMTNztqN5nrBYTrOpYqmBNS6opCuzUscS2O1PBXv94ztg7GAvPROiCX8c7IKfBClqc21WLUqMK+npwm1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788149; c=relaxed/simple;
	bh=z39vZLCgzd987zKf7I0Lz2WpmRprCkxIVEcLdZQYtC4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=pDWW9GeWL4KeXzS3HVfWJEf6U7fBSL7e2XhEGnxn2eCJosHnBNpX/CjNZcDSq7XKaA7REKHP+mmGk/tabKxsZpPDwaeOxa2lrNU67Pf0b9Znf8r/zABz3bxYtFV7gamFfqyhpeRtkRcR109nUS9p3r9WnhhktqRVOQ64GbZ4Iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=univention.de; spf=pass smtp.mailfrom=univention.de; dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b=lT2K5S+V; dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b=htwKbLXQ; arc=none smtp.client-ip=78.138.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=univention.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univention.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b="lT2K5S+V";
	dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b="htwKbLXQ"
Received: from localhost (localhost [127.0.0.1])
	by lankmoj.knut.univention.de (Postfix) with ESMTP id A4CDB106C3C;
	Tue, 17 Mar 2026 23:55:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
	s=202111; t=1773788139;
	bh=z39vZLCgzd987zKf7I0Lz2WpmRprCkxIVEcLdZQYtC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lT2K5S+Vey6sUfHO69nhN4S6xfuYQcy1FAr3nsJm/3jpOgxwxGZi2N+qUIgX1k7gx
	 CmHW73iGw4qBlOqaKjyYtEZ8S8GI+YLQ5v1KazjvidFEzGDKoDR0C35YrDMgC33DaE
	 h5QZCKA6bYwxRViGyfGZFeur5ytDbVDpEVefl0e52a9wyxUQwPlV7V7+tZqxCdIEAS
	 tZcr6iBAal+X3rJlPd7MEQsGRdqU5ZQRf7DEJuoUHZyYkzgucsnneaHYy6jAg+bN4x
	 7RHf1k/JlogB6IGdl2S1UIvfCGz1IH508cgjYPLgPIISSXrnlf+vJgdq3ESLVJRobG
	 Dk1A23WA3U+Gw==
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
	knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
	by localhost (lankmoj.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MjGJd4SOd4ZO; Tue, 17 Mar 2026 23:55:38 +0100 (CET)
Received: from [192.168.178.154] (dyndsl-178-142-056-026.ewe-ip-backbone.de [178.142.56.26])
	by lankmoj.knut.univention.de (Postfix) with ESMTPSA id 28102102294;
	Tue, 17 Mar 2026 23:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
	s=202111; t=1773788138;
	bh=z39vZLCgzd987zKf7I0Lz2WpmRprCkxIVEcLdZQYtC4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=htwKbLXQQyTz2MPn1aFQ2Q/UXlgwEjmUoDVe06K4DzLC4BktR0aqp++i2+sUmbwpW
	 HE9/ZapFhOhtqjPnMWdb9L9+X3Zw2uFN70DskkRyuooJYnwkXtI8GFmcmM7sXf9Egx
	 2rKdKs1RwTx54EH7+o3tnw7eL5j6IQGtxGpBomLduevkJjV5U5Da/jqCuZARaoPW+F
	 bZT4qYMnq1/rsenKP+NqJ4Ac2QeLp4IY2QhCvWaa8K3wY1A9zmNeVypwIeWHMZ5kUl
	 e6kz8L/oRlYkTvnH++WEZjS7FHHmIme2tAgA6wmAuy+KzKki7pYvCRarOKFF+9fJA7
	 iqSaymJCiq9uw==
Content-Type: multipart/mixed; boundary="------------00ab0cu0ZCRFaPoiqu95SFK2"
Message-ID: <2420e380-d9c1-468d-8231-92e03250a120@univention.de>
Date: Tue, 17 Mar 2026 23:55:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cherry-pick: add --show-current-patch
To: phillip.wood@dunelm.org.uk
Cc: Git Mailing List <git@vger.kernel.org>
References: <43529695-5987-486a-bdff-46f573868c4c@univention.de>
 <2d818389-6456-4b75-8a29-3167fc3c885f@gmail.com>
 <f2bf231a-2b18-4f1c-9cbc-2b94f669839f@univention.de>
 <82a8a222-b18a-405f-9a9c-92c6e0c05591@gmail.com>
Content-Language: de-DE
From: Florian Best <best@univention.de>
Autocrypt: addr=best@univention.de; keydata=
 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
In-Reply-To: <82a8a222-b18a-405f-9a9c-92c6e0c05591@gmail.com>

This is a multi-part message in MIME format.
--------------00ab0cu0ZCRFaPoiqu95SFK2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Phillip,

attached is a patch suggestion, also available as Github PR: 
https://github.com/git/git/pull/2243

Best regards
Florian

Am 16.03.26 um 12:03 schrieb Phillip Wood:
> Hi Florian
>
> On 11/03/2026 19:42, Florian Best wrote:
>> Hi Phillip,
>>
>> thank you!
>> Your reasoning makes sense, and therefore --show-current-patch is 
>> probably a bad idea.
>> I simply oversaw that complex sentence in the --help/manpage:
>>
>>  >          2. The CHERRY_PICK_HEAD ref is set to point at the commit 
>> that introduced the change that is difficult to apply.
>>
>> Maybe adding "git show CHERRY_PICK_HEAD" to the Examples section of 
>> the manpage improves finding it.
>
> That sounds reasonable, are you interested in contributing a patch?
>
> Thanks
>
> Phillip
>
>> Best regards
>> Florian
>>
>> Am 11.03.26 um 20:30 schrieb Phillip Wood:
>>> Hi Florian
>>>
>>> On 11/03/2026 18:30, Florian Best wrote:
>>>> Hello,
>>>>
>>>> When running `git cherry-pick` over a range of commits, the command 
>>>> may stop due to conflicts. At that point Git reports the conflict 
>>>> but does not provide an easy way to see which commit is currently 
>>>> being cherry- picked or what patch is being applied.
>>>>
>>>> `git rebase` provides a helpful option for this situation:
>>>>
>>>> `git rebase --show-current-patch`
>>>>
>>>> This prints the patch of the commit that is currently being 
>>>> applied. I believe a similar feature would be useful for `git 
>>>> cherry-pick`.
>>>
>>> That option exists for rebase because it originally applied a series 
>>> of patches rather than performing a 3-way merge like cherry-pick and 
>>> so there was no other way of seeing which commit was being 
>>> processed. With cherry-pick you can use
>>>
>>>     git show CHERRY_PICK_HEAD
>>>
>>> which allows you to add any of the options that you'd use when 
>>> showing a commit. That is more flexible than a 
>>> "--show-current-patch" option because you can restrict the diff to 
>>> the path that you are interested in, or show a word-diff etc. When 
>>> reverting you can use REVERT_HEAD and when rebasing you can use 
>>> REBASE_HEAD to see the commit being picked. I did wonder if the 
>>> documentation could be improved but for cherry-pick it mentions 
>>> CHERRY_PICK_HEAD in the description section at the top of the page.
>>>
>>> Thanks
>>>
>>> Phillip
>>>
>>>> Currently, when a conflict occurs during a range cherry-pick (e.g. 
>>>> `git cherry-pick A..B`), there is no straightforward command to 
>>>> show the patch of the commit being applied. While it is possible to 
>>>> inspect `.git/CHERRY_PICK_HEAD`and run something like:
>>>>
>>>> `git show $(cat .git/CHERRY_PICK_HEAD)`
>>>>
>>>> this is not very discoverable and requires manual steps.
>>>>
>>>>
>>>> Proposed feature
>>>>
>>>> Add a command:
>>>>
>>>> `git cherry-pick --show-current-patch`
>>>>
>>>> which would display the patch of the commit currently being applied 
>>>> during an in-progress cherry-pick operation (similar to `git rebase 
>>>> -- show-current-patch`).
>>>>
>>>> Behavior could be:
>>>>
>>>>   * If a cherry-pick is in progress, show the patch corresponding 
>>>> to `CHERRY_PICK_HEAD`.
>>>>   * If no cherry-pick is in progress, report an appropriate error.
>>>>
>>>>
>>>> Motivation
>>>>
>>>> This would help users:
>>>>
>>>>   * understand which commit caused the conflict
>>>>   * review the exact changes being applied
>>>>   * debug large range cherry-picks more easily
>>>>
>>>> It would also provide feature parity with `git rebase`.
>>>>
>>>> Best regards
>>>> Florian
>>>>
>>>
>>
>

-- 
Florian Best
Open Source Software Engineer

Geschäftsführer: Peter H. Ganten, Stefan Gohmann
HRB 20755 Amtsgericht Bremen
Steuer-Nr.: 71-597-02876

Univention GmbH
Mary-Somerville-Str. 1
28359 Bremen
Germany / Deutschland

📞 Phone : +49 421 22232-0
🖶 Fax   : +49 421 22232-99
✉️ best@univention.de
🌐 https://www.univention.de / https://www.univention.com

Managing Directors: Peter H. Ganten, Stefan Gohmann
Local court: Amtsgericht Bremen
HRB 20755 / Steuer-Nr.: 71-597-02876

The information contained in this message is confidential or protected by law.
If you are not the intended recipient, please contact the sender and delete this message.
Any unauthorized copying of this message or unauthorized distribution of the information contained herein is prohibited.
Legally required information for business correspondence: Legal Information

Diese E-Mail enthält vertrauliche oder rechtlich geschützte Informationen.
Wenn Sie nicht der beabsichtigte Empfänger sind, informieren Sie bitte sofort den Absender und löschen Sie diese E-Mail. Das unbefugte Kopieren dieser E-Mail oder die unbefugte Weitergabe der enthaltenen Informationen ist nicht gestattet.
Gesetzliche Pflichtangaben für Geschäftskorrespondenz: Datenschutzerklärung


--------------00ab0cu0ZCRFaPoiqu95SFK2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-docs-cherry-pick-document-CHERRY_PICK_HEAD-ref.patch"
Content-Disposition: attachment;
 filename*0="0001-docs-cherry-pick-document-CHERRY_PICK_HEAD-ref.patch"
Content-Transfer-Encoding: base64

RnJvbSA4YzljMmJkOTg2YzRlMjRjMGY4NzE1YzVjMGIyYTk3YTRkNmFkOTgyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBGbG9yaWFuIEJlc3QgPGJlc3RAdW5pdmVudGlvbi5k
ZT4KRGF0ZTogVHVlLCAxNyBNYXIgMjAyNiAyMzo0OTo0NCArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGRvY3MoY2hlcnJ5LXBpY2spOiBkb2N1bWVudCBDSEVSUllfUElDS19IRUFEIHJlZgoK
U2lnbmVkLW9mZi1ieTogRmxvcmlhbiBCZXN0IDxiZXN0QHVuaXZlbnRpb24uZGU+Ci0tLQog
RG9jdW1lbnRhdGlvbi9naXQtY2hlcnJ5LXBpY2suYWRvYyB8IDYgKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IERvY3VtZW50YXRpb24vZ2l0
LWNoZXJyeS1waWNrLmFkb2MgRG9jdW1lbnRhdGlvbi9naXQtY2hlcnJ5LXBpY2suYWRvYwpp
bmRleCA0MmI0MTkyM2Q1Li4yMWRlOGJiYjBlIDEwMDY0NAotLS0gRG9jdW1lbnRhdGlvbi9n
aXQtY2hlcnJ5LXBpY2suYWRvYworKysgRG9jdW1lbnRhdGlvbi9naXQtY2hlcnJ5LXBpY2su
YWRvYwpAQCAtMjI4LDYgKzIyOCwxMiBAQCBFWEFNUExFUwogCXNvIHRoZSByZXN1bHQgY2Fu
IGJlIGluc3BlY3RlZCBhbmQgbWFkZSBpbnRvIGEgc2luZ2xlIG5ldwogCWNvbW1pdCBpZiBz
dWl0YWJsZS4KIAorYGdpdCBzaG93IENIRVJSWV9QSUNLX0hFQURgOjoKKworCVNob3cgdGhl
IGNvbW1pdCBjdXJyZW50bHkgYmVpbmcgYXBwbGllZCB3aGVuIGEgY2hlcnJ5LXBpY2sKKwlz
dG9wcyBkdWUgdG8gY29uZmxpY3RzLiBUaGUgYENIRVJSWV9QSUNLX0hFQURgIHJlZmVyZW5j
ZQorCWlkZW50aWZpZXMgdGhpcyBjb21taXQuCisKIFRoZSBmb2xsb3dpbmcgc2VxdWVuY2Ug
YXR0ZW1wdHMgdG8gYmFja3BvcnQgYSBwYXRjaCwgYmFpbHMgb3V0IGJlY2F1c2UKIHRoZSBj
b2RlIHRoZSBwYXRjaCBhcHBsaWVzIHRvIGhhcyBjaGFuZ2VkIHRvbyBtdWNoLCBhbmQgdGhl
biB0cmllcwogYWdhaW4sIHRoaXMgdGltZSBleGVyY2lzaW5nIG1vcmUgY2FyZSBhYm91dCBt
YXRjaGluZyB1cCBjb250ZXh0IGxpbmVzLgotLSAKMi4zOS41Cgo=

--------------00ab0cu0ZCRFaPoiqu95SFK2--
