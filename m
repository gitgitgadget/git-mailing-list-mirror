Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7941F42D
	for <e@80x24.org>; Mon, 14 May 2018 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeENJqH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 05:46:07 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:39415 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeENJqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 05:46:06 -0400
Received: by mail-io0-f169.google.com with SMTP id r9-v6so14451160iod.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:from:message-id;
        bh=v92t3B7qrd1jDNeS/TMFHcBiubFJ630xCH8QLSQiqFY=;
        b=gsBWDKT5Z7AJzZiCVJ9eyrs4cTZJW/sNXfejtWAcmHZrXp9EZf9I+TGhJfsnfzFUBz
         CwjbLkYEseDujW7ovnDW6/iRru+Z8AGN8/XcKhMqUKz6Y2FcxhnUsILrwb76qcBjS8vL
         cibT0fyc+TJFPXSJ+bC+L7gYpP9nmEJWH/QGX6Vypl03zlryRsBA9nXuwUtKNnNebkiw
         SpF9zmFVkcjcD175zfY62owCPm44Lyi49HXvo9bNWavYQT1y5vxujcH8ivfeb9/5TELW
         hykbe/NmkW6uOF99dSqzApBra2Jmb0YtKc1psbvq8h6NLQKbNv9PwJwUZrjjs5DLpoa/
         LoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:from:message-id;
        bh=v92t3B7qrd1jDNeS/TMFHcBiubFJ630xCH8QLSQiqFY=;
        b=gMHnHpriGksRSeDgRCXpwOZl23Zii7cgM9QVr2QSerqY+Oz2pk3c/LEqg3gOqtAi0U
         U1dXQXlblJr09GNJL8hWOZVAXBdaO/fh/2OvF/p+jgShHMGzsOgAUMI3e3OFxPM2gQKk
         wTSm24lSRn+nCMqA492Wue6nT4rc3QomUuznJXiri7Agq0f+q6shUyF+RSVOJQV62Xk5
         LwduhlKcQoa5FDNzZwWtAsIUUfjBNkj+j4XJxPXqEuI913WjGrrQ+LQFnebTtEaLmkjT
         v+4b2E+6PQlHCrEQYvc4kDCdeUa7Fk3CkCQ/tXw5qe/tNFYAZoDg1CjFpBvDW+GxXIZY
         w+sg==
X-Gm-Message-State: ALKqPweQcByVgl13JK6P6TpFYPWs2HgK2eNpUvW1eibH7dS/QWSeSksz
        ZQBO9tcAfzpbLTE8/1w5Mes=
X-Google-Smtp-Source: AB8JxZpcXltM99XsYh3/VxKJZs5Qm3OipFmIqHUquh5b7QxzyETyGmdv2QKmH3nYO0UtO5JZJtqKFg==
X-Received: by 2002:a6b:b98a:: with SMTP id j132-v6mr9869297iof.101.1526291165818;
        Mon, 14 May 2018 02:46:05 -0700 (PDT)
Received: from lmm-notebook.localdomain (cpe-74-139-249-65.kya.res.rr.com. [74.139.249.65])
        by smtp.gmail.com with ESMTPSA id z203-v6sm4552006ioe.77.2018.05.14.02.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 02:46:04 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id C16B07F000000000EBD; Mon, 14 May 2018 05:46:01 -0400 (DST)
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Ted Zlatanov" <tzz@lifelogs.com>
Subject: Re: [PATCH 1/2] git-credential-netrc: adapt to test framework for git
In-reply-to: Your message of Thu, 10 May 2018 18:43:19 +0900
        <xmqq7eobkfrc.fsf@gitster-ct.c.googlers.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
        <20180509213634.5198-2-luis.marsano@gmail.com>
         <xmqq7eobkfrc.fsf@gitster-ct.c.googlers.com>
X-Mailer: MH-E 8.6; GNU Mailutils 3.4; GNU Emacs 25.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 14 May 2018 05:46:01 -0400
From:   "Luis Marsano" <luis.marsano@gmail.com>
Message-ID: <20180514054601.5805@lmm-notebook.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Luis Marsano <luis.marsano@gmail.com> writes:
>=20
> > until this change, git-credential-netrc did not test in a repository
> > this change reuses the main test framework, which provides such tests
> > specific changes
>=20
> Sorry, but I cannot quite parse what the above is trying to say.
>=20
[=E2=8B=AE]
>=20
> Will queue, but may need to make the log message
> readable/understandable.
>=20
> Thanks.

Thank you, the rewrite https://public-inbox.org/git/20180512091728.4931-2-l=
uis.marsano@gmail.com/ should be more intelligible.
I welcome further criticisms if any.
