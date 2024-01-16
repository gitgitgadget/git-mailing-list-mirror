Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080B134B1
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWb9DJDo"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbdb12203b4so7710437276.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705398098; x=1706002898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8lipkG+nmOPB6jSvoezclVguzFZTdXWO789jwwngrk=;
        b=BWb9DJDoQKRkN2x72QRT76UCTpZOf8SQXHDEGN+EiWgX/xkyB98YZhtsrPppf8V1RV
         8dybY9xbGg9amgyysGQlYC5Bjde84TSi0up/66nyIe3cDGxcQ6kZzc3iBJMbglkXYi0U
         UVQYv/YKMe5ghuNKl755nJwHSdx/xHaqf4lt2khrtWH8ReIau+Odxr/tSAU/QBTM31mU
         eopDlh+KdmSBX4E/UhWW98qdZrz0b3BOVv/nYW3/jdkJ41e+mn5F102uuqRKPliNtk8+
         0nQvm+KtPaQbZT3Ax4UzEKMXeehVR4QaKtMVzSJi+Ist3T9+dfw5lwV2tQ2tk+D4wsgr
         J1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705398098; x=1706002898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8lipkG+nmOPB6jSvoezclVguzFZTdXWO789jwwngrk=;
        b=evu2EE+gR25dMIuHZtFu1csCvyjV1v4nTVGKA/Erpc3UaMhx9q5CyeU14DH1lIhysz
         nfjxFdGGZ4/Uoe2ra2Sdi+J9P2sk1AHxeztxvZ8aRrv3d0H+OudlJjuoeVGqqb8BIHVQ
         MhJJIvFj3mNFtO/fo9DmbunJWFisvxrybuB4OQYxF30V1NqyLEhB/0qkJ0aR0/0ZhDnB
         eP/i5K975NGBeK9DljrnhL0tDPMZ2LstjxaOBJpVIyRxdu7gtNI5U/BAUU8ISAtEoFUj
         1NaPaq3yLCmszGifvCj2He+WjwV2WYfCaHQx7zLLPnKPyQ9SNJagwNITcIRNF+hU038I
         wlGA==
X-Gm-Message-State: AOJu0YxDdfvG011Bnu0tip1OxFURz4WBJPsfaudOzqOz/RfnzqELpSRe
	/m5YWXSn88guwvEWEhrWM9AZy5XksakkxHM8kp4=
X-Google-Smtp-Source: AGHT+IGd1CntxQVRmWWj/P9XBh+INGGHCzMqy4SYshOsNMTu/A/2RPSLpDZLw1upWuzg713BiFpjt/N9q0Q2+v27bSw=
X-Received: by 2002:a25:8e92:0:b0:dbe:a3b0:6e4d with SMTP id
 q18-20020a258e92000000b00dbea3b06e4dmr3017795ybl.100.1705398098419; Tue, 16
 Jan 2024 01:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <af8fd2a4eb8783be4a62973bfd2135da4568570e.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <owlyttnjhtmz.fsf@fine.c.googlers.com>
In-Reply-To: <owlyttnjhtmz.fsf@fine.c.googlers.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 16 Jan 2024 17:41:27 +0800
Message-ID: <CANYiYbGk6v1dUASxMGpCAC6rtumm3i=ybUC3C_43HRtvBHyc1w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] transport-helper: call do_take_over() in connect_helper
To: Linus Arver <linusa@google.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:56=E2=80=AFPM Linus Arver <linusa@google.com> wro=
te:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > After successfully connecting to the smart transport by calling
> > process_connect_service() in connect_helper(), run do_take_over() to
> > replace the old vtable with a new one which has methods ready for the
> > smart transport connection.
> >
> >
> > The connect_helper() function is used as the connect method of the
> > vtable in "transport-helper.c", and it is called by transport_connect()
> > in "transport.c" to setup a connection. The only place that we call
> > transport_connect() so far is in "builtin/archive.c". Without running
> > do_take_over(), it may fail to call transport_disconnect() in
> > run_remote_archiver() of "builtin/archive.c". This is because for a
> > stateless connection or a service like "git-upload-pack-archive", the
>
> There is "git-upload-pack" and "git-upload-archive". Which one did you
> mean here? Or did you mean both?
>

Should be "git-upload-archive".

> > remote helper may receive a SIGPIPE signal and exit early. To have a
> > graceful disconnect method by calling do_take_over() will solve this
> > issue.
>
> Are you saying that this patch fixes an existing bug? That is, is this
> patch independent of the first patch (transport-helper: no connection
> restriction in connect_helper) in this series?
>
> > The subsequent commit will introduce remote archive over a stateless-rp=
c
> > connection.
>
> Does the next commit depend on this patch? If not, I think you can drop
> this paragraph.

One test case in next commit will break without this patch. I will
move this patch to the end of this series.
