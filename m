Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAF21A454
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375080; cv=none; b=co4v/giBpjHmWqA8JqgK3nQvodbwX4EM9TWv/JLJRT9dRmyfHOzAW3kKQCIUMTx6Og2fnLsePEToQ95w7TiYSjYtdNOOXNLvuevZSLSggBcE9maJqRGZqn/2V7Nsqto9XXzxc4nB/cK/dDhBX912FsMNLbr5Nwpj3FsrjOv+osE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375080; c=relaxed/simple;
	bh=ZaZ1Kn3IfbSgCdLmbdnr78OLq8UngkQfFSzPJg6GMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNX8E//Wy1WEKUSl+G3H+7rCXXlsjTuOuMRiVfo6pJxFEGtdE6S6y+kw0HSNd/JbMBuklFPnNHEj05ofLg2ahThRbtaPXOLwCJlCRWmB8AbIgGraPJ3FRqnVB+CNxXomX0+q13qi78By3E+fLn81xs3D5PGgH5puWSOXNgi2Krw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp+EMY2o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp+EMY2o"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24286ed4505so1487235ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754375078; x=1754979878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFPoXc4loAa6pKxhV4YRwSlLoTXCHxa1n+gNymrOXcA=;
        b=kp+EMY2owVNp0D55S3n64Kj+w/c1BQhjLN54AmBS8oejg9aQWpe2rINrJ2q2DFPrSn
         BzwzNHI+Vcwe02G3Ba7Z0pdg6nU6hEosiNaP4oYZJ8i7wfEaY3DrNb4JqVP2lpgNG0fQ
         rf+UQ/xndh8sVILCaIv+qIfNZSd2gHdAZHHPtwbsy9NfiRGHlg8m0JjJq4HjmgzSPznM
         Lk5a+3Vb/ctfkfGVlHOqLHotarHBXiyGinuJRXUlWWk0RgSevzm252js4rkXVnpWC/jX
         emUN+ERmytfdPg9RRqU/LFfSXyQrCR6A81XPPKbFjGHXh4ZjfRFY8bm1+S4d+Ci8Zb/O
         9jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754375078; x=1754979878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFPoXc4loAa6pKxhV4YRwSlLoTXCHxa1n+gNymrOXcA=;
        b=XWNi5T1TjKz1oo1rW0fpTgGUUOC7SGJubDN8gHVHf/gC9MS+H/qVNsdJLq05dbX2HE
         WdSDe8Nfj4/hxyIuGc9NfAuvFeyM2zsNNW+UwwLuk7FzVXGjxztz9rZFbwx0hBkEJ/WV
         JlwENGu6yTvyOrG8mPnadHQQjZFwGzSQpqTKc1rUde4GYTCHlRn/h5fv+89wyIvpu/15
         d1R991Q51IUfbmGih0skBGy03CGLm+hJpvoqsR0U+nQZNx+dEoiMGL4LFZQGQuqwcreO
         yjji6eT8WGFO5I+j/PvPExxlZKyDhCU5Y6LDM7insnEJhzrEH5xycAGP56PRascZRNXI
         G/cg==
X-Gm-Message-State: AOJu0YzMPJgTsJvVgz+UjR68+aagTZ+Nrp7iAwZxqzYIqoJwhVpySp2j
	dtk93R/CroL474OHZVyU4CxZOVWSt/M49UQDgFUvzJSW9T4T2/L4HkbCEzuYHw==
X-Gm-Gg: ASbGnctQODViW+zUTZIVDp15xKjd5jlXczohciW42QhLprTzAD8lEZ79r87h+vQwPqe
	SixmYvoVsM2+CpObOiTWqJ1719QP9YLmUAY4KwIH/M/mYSBOzy0TMGmYXc098jLsd5XNN44A+Uw
	ktGO2hAhEh6VbUhxUKqcf7E3tj13hcfnrncEshmgjZ4+dJxOFB5SqsXrAOwj+Yyy+FbbFEGnHGa
	eBFOQHgmzwDfjMsn9eGRa68eI+Ep4VW28ZOju1BGhRlC5u8wCEaKPdTdW6xxZn2Mi/bmZa5Nk9D
	HM8sImwzXD9DyYA8FD/caZ6/8LeXaodXiOuGOhJo2A8b9t7A5yrqF78kseAtr2cw+3p2UxSF8lH
	OpTKJC3cChGZeCrZ6h9bc635oGzRMsjjHXwIksjQt
X-Google-Smtp-Source: AGHT+IE9D0AYCKb3gpPWubo1J5jr1/+DQX+3ndWnaoHVXDlYFVUXtBfgNgN6F1pu7Wr6Yz2W3HzAvg==
X-Received: by 2002:a05:6a00:4fd0:b0:76b:cb84:36a5 with SMTP id d2e1a72fcca58-76bec47b498mr7357362b3a.3.1754375077702;
        Mon, 04 Aug 2025 23:24:37 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8911asm12000639b3a.36.2025.08.04.23.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:24:37 -0700 (PDT)
Date: Mon, 4 Aug 2025 23:24:35 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] *** SUBJECT HERE ***
Message-ID: <cover.1754375026.git.liu.denton@gmail.com>
References: <cover.1754300389.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754300389.git.liu.denton@gmail.com>

*** BLURB HERE ***

Denton Liu (2):
  t5516: introduce 'push ref expression with non-existent oid src'
  remote.c: remove BUG in show_push_unqualified_ref_name_error()

 remote.c              | 3 +--
 t/t5516-fetch-push.sh | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  d26f355c19 = 1:  d26f355c19 t5516: introduce 'push ref expression with non-existent oid src'
2:  3eb95731ea ! 2:  2bd892b26c remote.c: remove BUG in show_push_unqualified_ref_name_error()
    @@ Metadata
      ## Commit message ##
         remote.c: remove BUG in show_push_unqualified_ref_name_error()
     
    -    In the case where a non-existent oid is given as the <src> for a
    -    refspec and the destination is unqualified, we end up hitting the BUG in
    -    show_push_unqualified_ref_name_error().
    +    When "git push <remote> <src>:<dst>" does not spell out the
    +    destination side of the ref fully, and when <src> is not given
    +    as a reference but an object name, the code tries to give advice
    +    messages based on the type of that object.
     
    -    This is because before hitting this advise message, the <src> is passed
    -    through repo_get_oid() which, upon receiving a fully qualified oid,
    -    doesn't actually check the existence of the object and just returns
    -    found. This means that it's actually possible for the
    -    odb_read_object_info() call to return not found under normal usage and
    -    thus, it's not actually a bug.
    +    The type is determined by calling odb_read_object_info() and
    +    signalled by its return value.  The code however reported a
    +    programming error with BUG() when this function said that there
    +    is no such object, which happens when the object name is given
    +    as a full hexadecimal (if the object name is given as a partial
    +    hexadecimal or an non-existing ref, the function would have died
    +    without returning, so this BUG() wouldn't have triggered).  This
    +    is wrong.  It is an ordinary end-user mistake to give an object
    +    name that does not exist and treated as such.
     
    -    Replace the BUG() with an advise() displaying a helpful message about
    -    the oid possibly not existing.
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## remote.c ##
     @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value,
    @@ remote.c: static void show_push_unqualified_ref_name_error(const char *dst_value
      	} else {
     -		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
     -		    matched_src_name, type);
    -+		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"
    -+			 "Please ensure that the oid '%s' is correct."),
    -+		       matched_src_name);
    ++		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"));
      	}
      }
      
-- 
2.50.1

