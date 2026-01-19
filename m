Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427F28D8F1
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839073; cv=pass; b=pc6qyRGsEIPujNbDSa/APg2Box/NDTYEZXhiDRY6AAvStbvA7IJIdDlabaErWwvgigGlm+/5ms4cnbLhWpnt4po+pmUlfrT1TQYWto+nc0FJFTIINojzS+uQ2f//42c0RnARQTr9J/XYFmXCBsmsClzqVYXhLXsIhCCkll8sb2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839073; c=relaxed/simple;
	bh=K62Y3S4TB0Xbl4nfm9iXYxHp1e268M8KmgXEzvLKQoQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVUHPXHr04gvLv+mar6JksfHV4puXPubVnJ060BgotKzPY5LRY277puL6Xtl33V35QVJI7XtbOKyptwcZmwM478kDdooLYtpM5RFp9aDlz/F0WvH2k+jQI1TOCznZMvwiHnqxkk2FSxR/lYU3A2l5OR7ws+Yl8ndFZBUflHeTz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qaw5SlDF; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qaw5SlDF"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5eea31b5c48so3167537137.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 08:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768839071; cv=none;
        d=google.com; s=arc-20240605;
        b=VuOFMMCwVYqr7p7Ga1HdTaE0abX3SIdGGcoM3oiQr8Pgrfng8MYwe+VCfrMsgfxXxG
         TXspuoatUlRT9H8RL7IhCypISyT9HEkIlmzIgAVBcfcDBeNm4paz3ObqSqyjLnZ/6R11
         6SARQR/OZmiKqXuc1i1t7rGHqto4lvFtwLsWpEZuARjWxgNLM0yDcQuNFAawkbKfd0JW
         h3FR0dTKofmMOH3DVzR0s4yJGw5wp9cRyG7d6UKCWVlNd2tuwkcOUAw/Q/CXnwnbmevi
         I/aipo4BNLK3UseaGwGqBIr7TMErrfMbbhCLGy3ezkfZiUgXAiuAKJvbtyyqpaKJzvpH
         QjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=thEp1zXbYT1pZT+rJeF39X3e/ddrKim/sJLTwTl1A3k=;
        fh=P2oDqK19z2OFAf71RgEJLcV9IsFcPx5YlAwVKfl+a3w=;
        b=gF/4Ymo5f1cWhbnaIPWfH8FZAu+0yNQbBH990eP1Mzj2O9IFuiyONGl7WrDBEDu6BW
         CltjL/alhlRM1dCf/1iLkSXn4WcLBx7Lc2neimDvrPpcO0G3aQPNwj2RY+ac5UCaJUtR
         dJYxijzm1xLNWgZ4jRfFQ2Fta8O78yh1qdF+cCzZgnoGhwGw2cwwjVI0Sands/S5dl2w
         0B8/PY471kcSR0UtOuJHCZalgiqd73rW0Mcec10R6s+VrSwKk1Imeu3HbLe1QaFgzdDg
         D04pgCNGQnw8Ta3zw5ZubyKxnDLxBCKypbhqI/F9uy9FYtev8VU8t61pNfvCUihckEyx
         9mNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768839071; x=1769443871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=thEp1zXbYT1pZT+rJeF39X3e/ddrKim/sJLTwTl1A3k=;
        b=Qaw5SlDFLkPNHifbAmXnOSqdQRFkHdc4Hl8pJNaFVtDf3qteXifQ6P8OGQqG30ba6l
         k/wJdukBmsP9uw7JCbRLVSAbUff3N24uvik3dYAruG9aXBbBvYFqO1Y7qpnlPiPUb9XE
         YzNe0o4fdQ+df/Fga6x4ZmjVWURtl6qz4iOLQP6nLAdHsul6/lYpXYbfHJAatY6evaW3
         9R+P2XDtGDywZknmqJtGGMAijtTLiTh7xNI9I/Y9HwLXGnPKWjsLie/90LJeNbvXmG1Q
         hGralXPfrG4ZCTb3uPsHOYArGy988Hvl1xatb8pIPaUMbHMaz3e86Z6vIVOLv5VkcV8g
         nUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839071; x=1769443871;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thEp1zXbYT1pZT+rJeF39X3e/ddrKim/sJLTwTl1A3k=;
        b=lVVkIvSq4vJ+2DbpKiD+2sn63aKip/X5CLbOHs+ah9LauQpqEo8DwgdLIG6q4YjPtb
         nIFi7+MB7YSml/fpSJ4hGiCDAaIPiIS06zJ3zuJRawCZUDCW5mfon5pqYK9Z9xWDKUro
         iP7UfmNWAShXyh8cwjDAzLfkR0sVpMUrsZE00171VxT6jqQtoTQEZs57p7OGG6bSUfmk
         LSPEyV+8bbmNaWHkRbQi+Ho0o6isLjg/mQTUYhdfBkTKxlH9H7VRTWBpH5iTJpXtQsZ6
         UFeuZkdIJ0n383+lWs1yKBUFPZ6Mf6unz4jAJpuxyZNd3MTzaHAwIOiFyEVXCNEn3cXQ
         LcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoE2yvWyFKqYLE5E7kF5MSoRLDYRG7ahv5w0EewTPv2Hq4XtVZID5pnzZbc3PfoGWD5II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmt6rGyI+x5gOJi7CyCND1H6OL9l9eb2AHaIIMHK+f4FXAYLW
	nXY9Gc917fQfs8VTvc/amfvgoTkRWhkIfWC4/fYYrwp3J8tlDF1Y7Je19SdX5T/AU8LncUuB3Q8
	T6k9hmn2XzYaO1sUVIASvLm+qBgaGG1M=
X-Gm-Gg: AY/fxX4dUTxseV9lHr/8tDwr36DCiy5VLVWUAPmCkbAkOrtbX+o/AfzXQp+tqoGAl8K
	8+UrMjjp29C2UZtX4GdXse5SEeToTNXGhVx4X8kkCh+yLXqEsrj1HWsXSEYCIDQ38fuLMkIFITk
	hnvQNSzFULIFfAjRpw+7TC3gva7MgdaqN9ib8c5SbE/4qeRvGT1HfFD87YEvz4i2CKYaJH5iJps
	LYd/8bQ1568tEJDEdtaHvU1jGVxpJkJ3Pugrvs/HFwcOAQleiB4EGClKgLfboZcDZ/kYbMfjVSY
	H655Sw5ukEtIOBtIY9RNV7ru/RxuJQ==
X-Received: by 2002:a05:6102:54a6:b0:5e5:5ed7:60ae with SMTP id
 ada2fe7eead31-5f1a5590b12mr4050417137.31.1768839070925; Mon, 19 Jan 2026
 08:11:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 11:11:07 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 11:11:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <0082426c-a945-4f2e-969e-897e1aeaed66@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
 <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-7-925a0e9c7f32@gmail.com>
 <0082426c-a945-4f2e-969e-897e1aeaed66@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Jan 2026 11:11:07 -0500
X-Gm-Features: AZwV_Qianw-G9H1hODbGkqIVB0Wv5P8ymHgHgXk8R0IE3tAeVdSj2m0L2miO9o4
Message-ID: <CAOLa=ZRwErG0wBb8ia7NbfnSOmWcx2_7WS0vL2rJTtXeJaJ9kA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] fetch: delay user information post committing of transaction
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000007cf7580648bff0b2"

--0000000000007cf7580648bff0b2
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 16/01/2026 21:27, Karthik Nayak wrote:
>> In Git 2.50 and earlier, we would display failure codes and error
>> message as part of the status display:
>>
>>    $ git fetch . v1.0.0:refs/heads/foo
>>      error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
>>      From .
>>       ! [new tag]               v1.0.0     -> foo  (unable to update local ref)
>>
>> With the addition of batched updates, this information is no longer
>> shown to the user:
>>
>>    $ git fetch . v1.0.0:refs/heads/foo
>>      From .
>>       * [new tag]               v1.0.0     -> foo
>>      error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
>>
>> Since reference updates are batched and processed together at the end,
>> information around the outcome is not available during individual
>> reference parsing.
>>
>> To overcome this, collate and delay the output to the end. Introduce
>> `ref_update_display_info` which will hold individual update's
>> information and also whether the update failed or succeeded. This
>> finally allows us to iterate over all such updates and print them to the
>> user. While this brings back the functionality, it does change the order
>> of the output. Modify the tests to reflect this.
>
> It is unfortunate that a fix for a regression the the messages changes
> the order of those messages. It is doubly unfortunate that the new order
> depends on the implementation of strmap_for_each() which may change in
> the future. I think you can avoid this by appending each update to an
> array in update_local_ref() and adding the errors to a separate strmap
> in ref_transaction_rejection_handler(). Then when you come to print the
> massages, loop over the array and for each update lookup the ref in the
> strmap to see if it failed before printing the appropriate message.
>
> Thanks
>
> Phillip
>

Yes, I think there is merit in the approach you suggested, it ensures
that all messages are delayed (avoiding the split between displaying a
few at the beginning vs some at the end) and that they retain the order.
I have a version cooking locally which does this and works correctly.
I'll send it in with my next version.

Thanks,
Karthik

--0000000000007cf7580648bff0b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d934408c7ec0560b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sdVY1b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWxlQy85b3JFNnE2Nk9vS2hYb3EwMVdCd0srOEZ4Qgo3ejdUOGVDQ1Uv
eDBzQVdRait1Q1hxWmxhTDQ2N2lNZ2N0QWp3WXRjUXZKL0N0dlpaSDczMVBVdVU0TXN6bGlIClls
UCtjZzNqV0NZcHY3WGs0bWZDNkpvTWJPQlExNWVOMWx0ZFMvVk1Db0dSaXNqNnQ3VzNRa0Fzakl2
bktZa1oKV1lWZG1hZEpIS2tEQStEbWQ4NGhDNTVVR3JMRzJDWmRSYkVqVUFBVDRPVGVuRCthZjVH
eUJHdUY5UDBhTncycwpNMHhJdzd6L0U0eW9kaGlXeSthU1R4ME5tK2U0M3VKNEVWejFYVkxKMWQ3
UFdiNzBYbWFKTHo4aC96cHRQaGhKCktsb3FNN1M4QnBjSzh5aTZBN2RXekh6OXd5d1RqN3hlbTRu
dm85UEJaZGIxVkI5YWJBdER2aHBNakJQVDl5SXQKMmtVSmdENlllcEg3cWJmMjc1WDFmQ25NeFJT
SGlMVDJzNFE3dUI1SmFlUjB6eUdzd29aY0JTanVvK29MTlRwUgpCV0FoUDJNRFp3K1dJZFJzbXps
azRwRHZrdVdSb3FHelBaZ3czYTNQeGlVSVc3TGc3TkRKclZ2SFZ6MVI5WHk2Ci9VVEJ2S3k2R2dE
aFJCb2V0ZnVtTGtlNlVsMlhNZXVCQWVmT2h3UT0KPVdRVU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007cf7580648bff0b2--
