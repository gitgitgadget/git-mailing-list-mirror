Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887547F47
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156759; cv=none; b=MYywFAsUJMwkQT+M90e1XKHG17lzmTpaY2HVeFBZvkoo5jr8zVvz1kaPNKjlcO2p9zosH/c1tzvFzHL1nXxGi3cv32XDx8bkf6Gl49a+6A9jmbFjs9VvOXl50cFtaDE9Dk+CzvCgLhSWs7MUHAKcer+ZvD5T7AKQvElccXOywjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156759; c=relaxed/simple;
	bh=Tk6g2xOCRZXALSIY3uA3VGb/JW7TOWRbCRjUfPuTHE8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=a0md43uwpudoPLW89kWad9lSkybH4Fe3iiTYdkphcpGAV0oo+waVfyG+Gj/BeAhcfFyV8p0mq4BMdaAZ4yGh2er4CcOd5sK5hJ6weFExWK3NEVecuABcJW/G038n7NaIIYu8tz+whhphV577TplnHyiRyGLxOqKGIB8dirtG66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYp+Xxm9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYp+Xxm9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fdb18ffc7so11442465e9.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707156756; x=1707761556; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk6g2xOCRZXALSIY3uA3VGb/JW7TOWRbCRjUfPuTHE8=;
        b=GYp+Xxm9fJHRwntmSQu5TQiWBdr4jruX2gVWDNU+cy0XXbqIri1s2UPyTxQYlUItC6
         lPvWDatCAO4KcxrT6tYBAZQ9xABHtQIH6qDs15yWyQCopXYyUMbksfRsMB8pHaYtKZsm
         Zb0grTO/PtDBDIF051h5aUZU6tvaEmMvW+AyRjDVWc0OTlupn1wG2otbCcHT7qnYa+AI
         /XPcNBGV0jySodwfAa2rNkBiIH23pe1B68YJkO/EoslTKW+18UmkG75OrRXyRERUZR8s
         W86hAKCdlaW51yb0YkMNLykUQK81+mNABAK/dVA/OpESb3Nun8P2/YDZH0dJ6uvbmv9D
         uiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156756; x=1707761556;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tk6g2xOCRZXALSIY3uA3VGb/JW7TOWRbCRjUfPuTHE8=;
        b=DzkxYoPhDojXdohHL3Nxfa/sXOULOF+pSL1inTUtNlMpQV7NKlVmnlnXDpHj0Xi+hB
         Cb3eGcO58sOo6rs4gxdZgI0DYXGVmMjIf0YQOLNCwe2tE9K7hhIHK9nM7652GoraoJxe
         fG3evjiw0NwV48EX+f5HQYFeUdOXM0x/r+YZuxSYMAjdynbZZOFPgI9FJuMKJPxHvxdM
         7IBSWEV8esdnMh/q+js3A79kBsEFNk5s5+GRzl2EHm4LaJsbVNGR5KdLxsqyt8O62X59
         nz0xM5YDvggES3PMhvKU4SDOs7t6PFto8nYK3ZlKhqb95MpBqvcCSD4ShWfAmnmnB45t
         qxpw==
X-Gm-Message-State: AOJu0YxukJYM5fIveOWaD5anIXj71JCpfirRXBxXuHd5pmWCoxy2LOEJ
	B4Yo2uOvi0g7pjn2wQw6R9q1qoBluUQVLAZ09+I7p6QJQANfp2WjDAVEqkDR
X-Google-Smtp-Source: AGHT+IFSY3iQkRI95c/8gfa4WyR8voqiFxyI26I5aY02Wt6KDNDdB35tSi9nm9z0P+ZPtQ2vnyJ2ig==
X-Received: by 2002:a5d:4292:0:b0:33b:2ca6:5a4 with SMTP id k18-20020a5d4292000000b0033b2ca605a4mr243077wrq.4.1707156756408;
        Mon, 05 Feb 2024 10:12:36 -0800 (PST)
Received: from DESKTOP-MB1G5MF ([39.62.25.99])
        by smtp.gmail.com with ESMTPSA id m10-20020adff38a000000b0033b43a5f53csm153289wro.103.2024.02.05.10.12.35
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 05 Feb 2024 10:12:36 -0800 (PST)
Message-ID: <65c12514.df0a0220.d6294.1234@mx.google.com>
Date: Mon, 05 Feb 2024 10:12:36 -0800 (PST)
X-Google-Original-Date: 5 Feb 2024 14:11:46 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: arnoldroberts123@gmail.com
To: git@vger.kernel.org
Subject: Project Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

=0D=0AHello,=0D=0A=0D=0AEstimating is required in all constructio=
n projects whether you are bidding or executing the plans! Our co=
mpany is here to help with this process and save your TIME!=0D=0A=
=0D=0AClassic Estimation LLC provides detailed construction estim=
ating/take-offs services as well as Scheduling (Gantt Chart) and =
Architectural (2D/3D drawings) services.=0D=0A=0D=0AWe can send y=
ou some samples according to your trade! Let us know whether you =
are a general contractor or subcontractor. =0D=0A=0D=0ALooking fo=
rward to hearing from you!=0D=0AThanks.=0D=0A=0D=0ARegards,=0D=0A=
Arnold Roberts=0D=0AMarketing Manager=0D=0AClassic Estimation LLC

