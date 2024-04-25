Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC14D280
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061987; cv=none; b=qZJMhq7mNPSi8FhNJ1yLKqIdkg3cgl15vwhWxwiiF50u+w0AsOsKcsRxmG8lcQ+kdRZTg/3Q37a9R+ixpxmapVJ/jnFFbZFF68rPzdAFyT9knzbwwgNV3pwlC0/7v+/5TDccPCOjo3YZnSvHqNg8jH5KTABDdy1jTLFMH5lxtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061987; c=relaxed/simple;
	bh=+KzOETslTE8cBpLUDWIx8mLu7RGaUZH8JtAqZCvSbQM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n171VIawSY8ddw8dyqXpy4WxPJS/NogXiS42vCglBBhdhxGN2RiDnRpTrjifDKNIIkOCUr7YWj24kzdS/oCqd5qMKdFjiuA/dMhkObQ6xNt+2Cxg8fEUB+wCQDbFvukdMd8IoyenP0PRPogVbEG0Eq2O29NPZrvde7ni/CD8ZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbPlbjqO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbPlbjqO"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2deecd35088so9154581fa.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714061983; x=1714666783; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLGXcJKalKIl1ahRdcadM6SPl162JnKYI62pjXXQmd4=;
        b=gbPlbjqOHRV8ywIDG1fZrOWb2rsM+w8T2b3JFsxHfyPF94I2/L1uPwrz+kS6XRgWMU
         4HFJ75gCbCNXM+FmFKs6NJ9Fg49cyhdkbW1+ANSi1Fc6ukYmPFj8khX5zsc2/72HEBN/
         rjsD4d0+dPM7sD5HidreHgTNKFNU0fp+bPWvQ+lfra6iVAQ1UFTmVlnbpWkszdQXloO0
         wpKzfg7XfNJHxJANXYmU0aZAx+txLXr1B5OPrUsTFEDmk/gckcRyuj7fU+FhUfkzJINZ
         qE2UKjNNPa4oSnfqjEGHjHeXXjzCqeQ5k8/1OpZeo0Y9xe2SB3mESqRpMYD8nTKPDpvq
         dHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061983; x=1714666783;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLGXcJKalKIl1ahRdcadM6SPl162JnKYI62pjXXQmd4=;
        b=XR+N52TWN74EKleGN8i2L2Dhx8MqFmOMP6zGLxzlgDlNsAF7u4kDAEYj7iOsWfRhsY
         Z6leHMfZTB/8ZJFxhL993v/MPOth79f+J1kbt/XiEv6Dlg4ICvUwBDGPnm/6IwFfnjvo
         DCxMrNf623Avv7Hv9qmzpUGfoyr6ZAcgsU1oDEq6Lo/6FEqrXdy9teUj6hx1BoB8RUA0
         0EICaOKBI8GW4OC+LiTLSQnBaMBQ6EKbXHuEQV/tjg0kamwFRtgq4snyl0ytfY2b1p+P
         3mQOg39HZBtZYcNYsQaCW2Hoou1BhynubHaLKE9PzMs57ufq8qL2FgPL0n85IVuUkX6T
         bwDw==
X-Gm-Message-State: AOJu0YyiOWlJuURTGXxJgrWDtNes9kmdo2Y085o9eBm2nmFeGbLg8+wX
	l+sYSr5WUWirxRp4KBegcVRCtkW7sClNvA/WW2+UfRhmNFBoS24aG5DyaQ==
X-Google-Smtp-Source: AGHT+IHqa62260Ha5JYFCIZg2ZuMaeycPzeyL5INPoHS1HLe2TDVBmUiDV/DYDIe1KgB4QIe2DbrYA==
X-Received: by 2002:a05:6512:3609:b0:518:d3f5:e6d2 with SMTP id f9-20020a056512360900b00518d3f5e6d2mr4321961lfs.51.1714061983335;
        Thu, 25 Apr 2024 09:19:43 -0700 (PDT)
Received: from FBUtveckling ([31.3.153.65])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512315400b00516c4234511sm2851977lfi.242.2024.04.25.09.19.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:19:43 -0700 (PDT)
From: "Felipe Bustamante" <fisadmaster@gmail.com>
To: <git@vger.kernel.org>
Subject: Use of Git with local folders
Date: Thu, 25 Apr 2024 18:19:43 +0200
Message-ID: <000901da972c$61efc670$25cf5350$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqXLFPmFZdyy/l9RLSHHYnoh0tGTg==
Content-Language: sv
X-Antivirus: AVG (VPS 240425-16, 25/4/2024), Outbound message
X-Antivirus-Status: Clean

Hi,

I would like to know if it is possible to combine the contents of several d=
irectories with copies of the same source code but with different changes?

The stage is:
1. There is a directory with the original source code, without changes.
2. There are several directories, ordered by the date of creation, which ar=
e a copy of the original source code, copies made every day after generatin=
g changes, that is, the original source code resides in the DIR1 directory,=
 a copy is made with name dir2, and changes are made to the source code of =
the project. The next day, a copy of the directory of name DIR2 is made and=
 renamed DIR3, we work with this directory making changes to the source cod=
e. The same process is carried out for two weeks.

The important question would be, is it possible to combine these directorie=
s in a repository with a Master branch (the first original directory (DIR1)=
 and transform the other directory into branches of the master?

It would be useful, if copies were made that were made on an original direc=
tory (dir1) that was already becoming a git repository, with the use of Vis=
ual Studio 2022?

As an observation, the work is done on an isolated computer, without intern=
et connection or to backup devices, the computer is fully isolated and it i=
s necessary to generate the version control, in the case that it is possibl=
e.

Any orientation in this regard would be very useful.

Thanks,

Felipe Bustamante
Sverige


-- 
This email has been checked for viruses by AVG antivirus software.
www.avg.com
