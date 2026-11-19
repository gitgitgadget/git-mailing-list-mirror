Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129159;
	b=F2IBFcu415Jrz4tag8bHy62YG4U/TJFZzfbkY0P268NsC44UnI9QvWhW8JOh1PN5eBuj
	 12YXfSmrtX6eveYKplwWKf6Wrvd5Lezv8FFXk0fwWZeokYyYflYKo7Zlsj5p7ozhaTZAS
	 nYh5oKQe5+fv1YQpI1r9YtCYOgAxWST+Ui7CzEjMPwL633JjcekOnFDNsSEOLDTSxCr5P
	 vHFcoFmQAIFt5eBeXz4/EJofxP8fd1qq/c9OqLG0FokxxM9sxhMlLDQoshZox2zJPwmez
	 oY2jk0zmaPZqwssjisOXJ9/LLI80JEJdgcsb8iJ0EIPYGyz5TfGaNkq5NIlQNseG83A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129159;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=1ulSKzXPWLaoCihlxI5/V16c0pXcZvewZt16W+MosEo=;
	b=yc8G8ic97tHGj3wy+3fuNQh+2WRA1IqaxU2CTnwxMUTfXTs7wTQ+wS8vgf17Ae5DGSSx
	 SABVL3WxHwnH8ez6up4O6ntyZz7vTm9wNb1T1mK90GlWIPyrYfs+D1OH4gjipam+r5gEC
	 ARdjNyXRalmYC8rolmeSrAdK5xv7q8jHgL0MH2b2oxiHoeF9mi162RBNzyvCAiggaqWST
	 WYwrrQ9qXwe/URmMWKwB19aB5lQYzEaNMmmPOxnVT91PrUb29dQhQJ8JG0jfQ50ES1Brk
	 YKEi6D95wfUGkKJAlifcz+aPfu8k149XKizZ2uMknWq8vYzKPDRgcxwaOd0Nhgxr1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b="J7/fH0AV";
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09A606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C09A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=J7/fH0AV
Received: from localhost (ip-109-41-51-202.web.vodafone.de [109.41.51.202])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AJMxCbI2025425
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Nov 2026 23:59:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795129153; bh=1ulSKzXPWLaoCihlxI5/V16c0pXcZvewZt16W+MosEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J7/fH0AVsRBjMQFNIm4H9LDpkPSLKE/ekpvGC6OkpQtHSqIOxDsfbKjNE4xKuWmjx
	 rfbExZfSy0QByXD5/y1X37gf0zCYvY6Mqw3tIwYa7C8y8Rr4JKBTrIP2kPQ03uaDLi
	 EbxdK+aMZrKQKRlU0XeWzoQcWjSklJvHLdLpC0ug=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <ghbj7k1mg5.fsf@gouders.net>
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
	<ghbj7k1mg5.fsf@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Nov 2026 23:59:12 +0100
Message-ID: <gh7bi81l8f.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 19 2026, Dirk Gouders wrote:

> On Thu, Nov 19 2026, Andy Koppe wrote:
>
>> Dirk Gouders wrote:
>>> +/* Same as above, but for a NUL-terminated string "s". */
>>> +size_t display_mode_esc_sequence_len(const char *s)
>>> +{
>>> +       return display_mode_esc_sequence_len_counted(s, strlen(s));
>>> +}
>>
>> This is a performance regression compared to the original function.
>> Calls that previously returned immediately because *s != '\033', or
>> after a few bytes of scanning, now scan the entire string with strlen.
>> It turns scanning a whole string for SGRs with repeated calls to the
>> function from linear to quadratic.
>
> How about creating a v3 for display_mode_esc_sequence_len() similar to
> utf8_width() to accept an optional remainder argument?
>
> If NULL is given, display_mode_esc_sequence_len() assumes a
> null-terminated string, otherwise the length is given in *remainder.
> The function can then update the remainder and return the length.
>
> Just an idea.

Something like this untested example (please ignore the _counted):

diff --git a/utf8.c b/utf8.c
index 8d4b159e1d..fe6f288179 100644
--- a/utf8.c
+++ b/utf8.c
@@ -22,18 +22,24 @@ struct interval {
  * of string "s", or 0 if the bytes do not begin with a complete
  * such sequence.  Never looks at s[len] or beyond.
  */
-size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
+size_t display_mode_esc_sequence_len_counted(const char *s, size_t *len)
 {
-	const char *p = s, *end = s + len;
+	const char *p = s, *end = NULL;
 
-	if (end <= p || *p++ != '\033')
+	if (len)
+		end = s + *len;
+
+	if ((end && end <= p) || *p++ != '\033')
 		return 0;
-	if (end <= p || *p++ != '[')
+	if ((end && end <= p) || *p++ != '[')
 		return 0;
-	while (p < end && (isdigit(*p) || *p == ';'))
+	while (((end && p < end) || (!end && *p)) && (isdigit(*p) || *p == ';'))
 		p++;
-	if (end <= p || *p++ != 'm')
+	if ((end && end <= p) || (!end && !*p) || *p++ != 'm')
 		return 0;
+
+	if (len)
+		*len -= p - s;
 	return p - s;
 }
 
