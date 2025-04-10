Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E628150C
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284183; cv=none; b=Dmi+qPaw4nEQoMflW9q6/tS/bb4eLz4yiKLHoJm62KBNSG34jQPITmD/6wyxXolxYTIc1/mwQIn0+sZhotzX66QRmPxRDz/4ReBFSnz56WA/n6gmG2EgDulO3pr+rCcoMYOBOZsdovl0qqTDpqQmTHxwPDYCvgIz9HoQS58ARAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284183; c=relaxed/simple;
	bh=ADEUNep8kMEGj5VvYUMqdGu6RuCR684IR7+sx6Qb4ho=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbOrMqW/TOY7WI5XwJQfJ+eGpas6+dfZ/k2Ve4w6uP371kXpKBjeHByOWMBQ9OGpv5SpAlT3fTMlocoUlqdJhEOd4FOKl/CKB2msmJ8BgZpPGnYf5Ki0RJEJ2/82FgxjoOb4QrsygUXCNi9obFvn2b1sFl9K8JAgBppC7+BC3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD/o9oCx; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD/o9oCx"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so286223241.0
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284181; x=1744888981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLVk0bgFPu5939A+0C7XnPomWj3zmaaTUYfQZREe2lo=;
        b=dD/o9oCxyKan/6jyLloiKCDkf7Uzxg6+bm5UzxMbDlTd0jij3NpvlmXoeAzyr9LTTE
         fwgKl+HUYs/Sz7q7ddMVgB8uG1NuyxG6LrkO6Hzq2AfamfJWDIf+sstK+ZZ6i476XH61
         7E+d2iwv26WmkFPdYnn4PxUU0T+Ds1Ab3rUsC2yVTLmM5dTyhdu8m756n40JGsSCszhj
         VehpjHZ+6UOSvhSM1792HkfntX8ymvsSMvnI93MN+mlT8fVUoDu8jTSSvBrSrYWRqwpd
         +mNjcWTIOtX4ysu8n3wQ2fBQ1+GpWJV5KFkviMNKJAK5xtTG7T2txSDhEbwQPM3CuEST
         sjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284181; x=1744888981;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLVk0bgFPu5939A+0C7XnPomWj3zmaaTUYfQZREe2lo=;
        b=t11bAyyZPQoilB4T+2nuMEOfbUvtNGoRefxcvv2BPGr4+ARhBkh0c85AYvRFsyAerY
         Yj+TSLfCPvDt9zbqyQe5MqAfXoNvF4jy3xJLHnz1HV2nUR34nf9uErnKvJeemZMlrZpa
         ND9yb4pVAEefzuQXI0LVe3j37VSg4SpslMiff+YqOjAKphi+kr1CrwI4Ng409FQIvnu+
         EnGTYm0AOvgE4XqFWIY4XkpmcsiqnO4Qbhg78flEvWqGXHrx09aeC4BRl2zr0kLZkZ5T
         3cmffTBsqlGV0wAI8KEV2iJKeb6VC9nvaAhbZw1RP55k6uun3O+FUAlXTQT5E+wR2I5D
         rUnw==
X-Gm-Message-State: AOJu0YwjAKMUCy9vXc/gqdQEpmIwzGsGjSCeDmt4f65v0b+7NnexPsQm
	DXRFanDqqa6pTBSudR2n0IyS9T14Okr+/oJ/VUvrEfsII5w5kIS7pSALCIMEAvzhPaJUDZ5j+nm
	CwYzaoalvBb3jG2CjnDFWiS4Cfvw=
X-Gm-Gg: ASbGncvOvhH7USHwB55or5vxM9MDUBriXN+qurnxb+xNWgYRFdZYnE2RMVCs8seLZRp
	/1MAJl5r9bQem7Qh3F03reuH+bZt9mgiASUsHYAZoDmOJreN1FdR/LQi4H8WSjBBWjCNbc9tUG6
	hkKv7tq7m00P8GfTxxFCj/h6ulSdK3e9t0dSLPbqqRcoymetHWEFCfQooRoaQaHDlaFQ==
X-Google-Smtp-Source: AGHT+IHnFLdxWauRdqBxgmXmKpXPGiBGb5f/hXAefOZJWBgM7iKV+yzWb79K4z3rkq+jeRGY35NrurBp5zXyUuaM3U0=
X-Received: by 2002:a05:6102:511f:b0:4bb:d062:447 with SMTP id
 ada2fe7eead31-4c9d34801b2mr1419276137.5.1744284180919; Thu, 10 Apr 2025
 04:23:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 04:23:00 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 04:23:00 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7c3uy2ps.fsf@gitster.g>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com> <20250408085120.614893-9-karthik.188@gmail.com>
 <xmqqfriiy9vh.fsf@gitster.g> <CAOLa=ZT4fOz1sd31EhyLGeyQzS6GO0aSYN0L4fdPALRixkD6xQ@mail.gmail.com>
 <xmqq7c3uy2ps.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 04:23:00 -0700
X-Gm-Features: ATxdqUF1HEMyt6CwdaroGTWv8HzPj79AqWMBTM2AufzRyWP5kvhk7qSMxAF3Q4g
Message-ID: <CAOLa=ZQ2eTWbj18+QPp=pTAovPVAQVYwJC6_ZTuMvCU-oQOToA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] update-ref: add --batch-updates flag for stdin mode
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, jn.avila@free.fr
Content-Type: multipart/mixed; boundary="000000000000fe193606326acef8"

--000000000000fe193606326acef8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> Content-Type: text/plain; charset=y
>>>
>>> Please don't ;-).
>>>
>>> More practically, is there something we can do to avoid this
>>> happening in send-email?  It may be a not-so-uncommon end user
>>> mistake that we would rather help our users avoid.
>>>
>>
>> This seems like this was in response to the following question:
>>      Which 8bit encoding should I declare [UTF-8]?
>>
>> Which I should have just clicked 'Enter' on, but typed 'y' as 'yes
>> please pick UTF-8'. Which again confirms the encoding, which I
>> presumably didn't read. So I guess the problem Exists Between Keyboard
>> and Chair.
>
> OK, we have seen enough people got burned by 'y', and made 852a15d7
> (send-email: ask confirmation if given encoding name is very short,
> 2015-02-13) as a response exactly for that problem, but it is not
> effective as we wished X-<.
>

I see.

> If there were a better validation method than "4 bytes or longer" we
> currently use for valid values for "charset=$auto_8bit_encoding", we
> could lose confirm_only from the call to ask() that asks the
> question, but I do not know if that is feasible.
>
> Another more obvious alternative is to do something ugly like this
> patch, I suppose?  Just like <ENTER> is taken as "I take the default
> value presented", this makes yes<ENTER> mean the same thing.
>
> There is one question that asks yes/no question with default set to
> 'n', which would be broken by the patch below, so it needs a bit
> more thought, though.
>

Yes, this would be an issue. I think what would be nice is perhaps an
option like $yes_default.

>  git-send-email.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git c/git-send-email.perl w/git-send-email.perl
> index 798d59b84f..8b942e5bcf 100755
> --- c/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -986,7 +986,8 @@ sub ask {
>  			print "\n";
>  			return defined $default ? $default : undef;
>  		}
> -		if ($resp eq '' and defined $default) {
> +		if (defined $default &&
> +		    ($resp eq '' || $resp =~ /^y(?:es)$/i)) {
>  			return $default;
>  		}
>  		if (!defined $valid_re or $resp =~ /$valid_re/) {

Going on top of your patch, something like:

-->8--

diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..318699d26c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -974,6 +974,7 @@ sub ask {
 	my $valid_re = $arg{valid_re};
 	my $default = $arg{default};
 	my $confirm_only = $arg{confirm_only};
+	my $yes_is_default = $arg{yes_is_default};
 	my $resp;
 	my $i = 0;
 	my $term = term();
@@ -989,6 +990,10 @@ sub ask {
 		if ($resp eq '' and defined $default) {
 			return $default;
 		}
+		if (defined $default and defined $yes_is_default
+		    and $resp =~ /^y(?:es)$/i) {
+			return $default;
+		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {
 			return $resp;
 		}
@@ -1031,7 +1036,7 @@ sub file_declares_8bit_cte {
 	}
 	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare
[UTF-8]? "),
 				  valid_re => qr/.{4}/, confirm_only => 1,
-				  default => "UTF-8");
+				  default => "UTF-8", yes_is_default => true);
 }

 if (!$force) {

--000000000000fe193606326acef8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 967bd1746c93289f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mM3FoQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1NoQy85ODlnbTRUdlRFN3VlYThEVlJ6T1orUGtJSwplSmNyb2xhV1M4
OXlvZ2pHYWt3NE1GOXZVandIM3RWM1F4SWNFQzhVSWdlbzBCalY2RVo4ZHI1ZHpmRjF2ZHFECk43
NDloZGgwQnQ5MDJoODA0OVQvZUJHRzA0dmtSNUh5RjlKYUZDTklxUnFtblNGVCtLZDQ1eHIvYjBM
Z0Y5Sm0KcjhhY21xalo0TXpsQ1M4dGI3aGNQNWNlU3pUNmJ4dENobzZTaUs4a3ZQc3F3ZnpLUjBk
NXd0T3FmZEJ5U1VZYQpkUnFHOXJvZGIyZXoyZnhXUFIyN0t3UDU0cTAxWHVTMzdMOXVvaWI5V1B0
aFM0Q0Y0R1p3NmhScHRReUFyOWhiCkZxcWZ2bEV5YlB6Mkx1S1NFSkYwQ09CblNkR1ZNNzNyRlRJ
Zjh0RlIxRWxZeExmSzBqZnJXcm1mS3BMREcyK1kKaWhyN0l6a0Jlc1VORVVsZFBqUU5TcEtvS0RW
ajRTOTMyWHBJcWtNcmNKVlZQUlBncEU2aE8ybWkyZXN3Q09WMwpGM2MwR29rVFhwR2xoRGtnMXNC
dkR4N3h2VGZJQUN0OU01WG11Q0M1OEk1R0NwQVEyTDhicFBlT2YyWEtKMGJ1CjZtMTN6YW9nVlNV
NFNmRzRycUxTR3dPUlVQQmw0SEF3TW40bS9mZz0KPWw3RzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fe193606326acef8--
