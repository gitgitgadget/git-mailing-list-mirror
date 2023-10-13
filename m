Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D9F33D2
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk+owSKO"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AC683
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:44:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d093265dfso13992466d6.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222681; x=1697827481; darn=vger.kernel.org;
        h=references:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:reply-to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoPd55Na+h2Mz6k45ru46cLqBU0Y8+9DHu0Jogr3gwY=;
        b=Uk+owSKO99di0WtFkek+HEGHYVurjMY08oEINCVI3PJqqD0IR74TyK491JEa4Vrzfs
         HbkjDzot1STC8LCRR2/NPef8558r/qG8GBu0miDNlAjcY+maXKUke50+aea87+2jHKfX
         OXI7ul+hMRzemRmXG56JSaqykVDcauKPXVqJheWdlkzmMKPGKyJw7wDXKXO6X+WCuWO3
         fTVHUXE3IydQ99uMJRgMe9g5nARwpaXkjSrU+25bB+buFBtHG5EVptdavLDCqQ5/T1j4
         wjrx9R1CFUBTV3JMRlRPWvmUMTZEdtF2FN0del25mKYdDzBWddMjDFfHUCIf/Al5PuI+
         QtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222681; x=1697827481;
        h=references:content-transfer-encoding:mime-version:subject
         :message-id:cc:to:reply-to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoPd55Na+h2Mz6k45ru46cLqBU0Y8+9DHu0Jogr3gwY=;
        b=i8YiWFlVL/zIcegGd1pllJEUaowOrCYhF09m6FkgbfaOLLaAHUv+OCrtAgbUq2RxuW
         yOWTueKoG9Drq2ZHKngkpt9lZj9+jIUJDir8MmUaflCilCcArO0wNQO7/JS+1VfdhBs6
         FXKytQqGGPGND2C85DQEmdqG4fKLvuXUsOWv4Xu6lL0yvlIf27jFhHw56dcoqhrznOfx
         SR1MsCc+y/NHVuvxrBGfsJ5pULShDIlPDtPoSqSYl6CXPJA+CMzPS7BgsGUL35tINAoX
         3tau07PXEN98KuO2jkf2POC3bDdfW1eCKDSxAIM/XUn/NdTo3zqXZx/woRiqb3GnGCxa
         KvoA==
X-Gm-Message-State: AOJu0Yz6zlZAvsNwft5e7IJrf9GZ9tEooGXAE1libiEQ607DTis4Q9Hp
	7Px+ZrPb1jquzMJxGp2RB+nRZXO5GTKybT+X
X-Google-Smtp-Source: AGHT+IEYsSMfcCacpcA2HfxmsCpvUZteI9FBDToQiVEof2WNA/3YUi7Ze8dGOtsi2C/yZZ8KdPANxg==
X-Received: by 2002:a05:6214:da8:b0:66d:1c3a:4a5f with SMTP id h8-20020a0562140da800b0066d1c3a4a5fmr6362390qvh.42.1697222681132;
        Fri, 13 Oct 2023 11:44:41 -0700 (PDT)
Received: from sonic311-24.consmr.mail.ne1.yahoo.com (sonic311-24.consmr.mail.ne1.yahoo.com. [66.163.188.205])
        by smtp.gmail.com with ESMTPSA id k15-20020ad4420f000000b0066d11c1f578sm872167qvp.97.2023.10.13.11.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 11:44:40 -0700 (PDT)
X-YMail-OSG: PHf0U90VM1nyLi8PGWA0RxxF__EW1hGZKYJ8uPE2eM3cuPtz.Gle0lrS9QaEp93
 YieWpaTZBPzcufEGDcQTs1g_Z2NzB.RIiLrbv8B7SiCLOJ9ylewJfKXgcdWweLEyo_qjcJC7YZFs
 7wstlIOQ0sqe8w1UujqOyVaWw.LMTSYyM5_cQst.a5Ntj2fXO_LZV1XzIZasqMrYMiSzYIwe4BH8
 mUaa7K93Sy4fs5MQ6kyHQfRI3bqokKSeXZQxIm2J_2NN8LhoNVIv8llUA29xQzMgN2AQXkDHI9wb
 Di47STCjOctzfx_p_tyi59QMs86ryUlgp1_qui_XsO5BfZMPwChTxEOX6cpQkPaQgunp8t4YFUBW
 wHm6Atf9taM9AxunDEPivID9Y1olmOWVDupGeW0pywDvRMEo9udpT6260EDaTLG1ZtoNVM6Wp2TL
 Pby5Uu21mD39bLt3jNslsuMGsKp41jgFpoLJ8Bu2URzOMmn.qiB3sd2STpUAjQ5JrEz3PV2lqImG
 S9lhQEdlRQSOuvu6sb67F6Q.MgSvyojFWGEszG9wfWMs1H5G0loKTsgZ0beDL1lALvS1.bGplu2n
 LmFscrJFjR48L.LCT8sIzECGk5.qw0tufhQ3.eqqOB11YKDAZSWoyiIi6vVehC2.T_63H0LoG.5C
 hA1hTsy1YR7fGI.gOypCwqZ1CJZlB6Lk2l_uT9Qyten.5VOskh5RuOmsw4cL4JARkSDh8uKT0VPD
 43nmUmtBuOsNfBfMEHA5PEpFR4KPB0GGkXIyIzvhLc3cUasUmYCdxcItmw17u4cdSfg6sZDXo5SK
 8J6awNN7f4Rs1YFSjflTnC4lvzRdIdOqrlXlIZTgD_T6to2zmC507GOgDgMs_ko7bgEt53oSFH_j
 QHdeDX2LrWe5I0irxQwwqearjoSkrsmW9DjUyb4a1gI9j_L1ysK0F5H4_dXEHqsDFQSsDSkReIKK
 8woyZYWgYMhNVm3LBG9P5loADmoTbpWEA1ubhyeAKIXz3CfBGuCG982yD8y_Apm4hMSSvLwCjMqm
 Wfmktk7tymt4hYGSfxOMEn9lQo3i8BG6bzdvfGZE.4GucKfzFf_gLfSOXsoH9.Qy79tYELrCMLNv
 Y2PTWMFqp5UAAq7S2wT2gN7PoQdcxw6xhVBnFCcp4VMPVp36lLKYW3SlaSoPT8TWP0be3fFQNbxP
 4Jig3xGDOJGtJJWjg5FFZCeqEbybuLZjDI675gcY_C7Li_Ol5TUfsn24jHj9Lqbxx.KVXSyQBQlj
 B5c_iHnZ_aGK7RPuPiuj2qMZHxlaQlAkbznr7Mt6AcVE_ApDCnrVzY_YzIFkuzabw9BpoqqRsm4j
 xwlUxjBYeqDeDB2.JIafuwbtpPwSWrIbhEy4KUAdQAbuQITC96l_FoRFnP4TCBXDMiXUnEglD0Fk
 OA3OVq9gV26lnr7EMEpz892qyc8iqluX71rchDys5QAi3tlaxRZ2MI_CQzxPcwULIeGg.a_Bvu1E
 8I.xizsOIANmHH6ae4m8.RkhWqAwOWtjKnuVgONLIq5d49ev6Rp.Q_NH_IGIfmzT1ku6hUSmsq20
 6oY5UB8eG5lPYoUauDi8hojQIDg9c6rAhOljgLBBDwKfKhS7pQGsXc_I3B46G3Q0z.j9_LGqlD5c
 hX7V_dAuBffXWFZUZ.zS67jFK6JxTSRAVYGNjPD1Lvuv43CBXcDu3SJkkqorfivnml5UAZOO39Cn
 QV_G9q6cStjHfl_H5lk5bSpo877Zf0e3U.eyUjmPZ5HwMMZZJTPIFFg1aX1kczn2DVFrgQPltVTr
 7rFWcTx21nwMiKVf_siQtfZtmcqzgDyTHTJxPjzkskuseGyz.O49Z5a8Zt2ep9IiVOq5u7anBaSN
 UyKkm5OJU0.LLcT5cfC8REqSwkmTD4agJbo7fnP9b.OtRz_7aAMms_XfV4y0A9yb8alSh6Uujgyc
 BqHkilNELguZ070RFaf2b8DM0MbzQBZOSQdPMfPMfsacY83bvj9TMGzdP8cHIVnuLIAet8gpHRKF
 EaeRIkRyKjuiDJXdijJwJ4ruhGgVaqZS3pps3oZAjlY6lEpDwQfFvlKHQnLN_b8ltIUqYu8qh6Yt
 7QVhQXX7wz5Hy5JOeyQSi5w4sQLCojo3sZJ7PbXL9gswWiRGuwy6N_diAQpsk66vyHOMTrzh9fFz
 UsC_r6HlrQorWr653JOmpJP.IVJg7UEHVxHikdrstZkcPMON2tiaomljzbaAXNNzCQx09_sDvFZy
 BhJ0cyX.NxqJ4mK8LNdnz1iv1ctFilATViLfkP1SZu0bd7MW9XmT8orgfNn3s7JkQegU-
X-Sonic-MF: <estherugbiedah@gmail.com>
X-Sonic-ID: c495ed5f-2e01-4fc7-b720-0b6c9dab3489
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 13 Oct 2023 18:44:40 +0000
Date: Fri, 13 Oct 2023 18:44:36 +0000 (UTC)
From: "estherugbiedah@gmail.com" <estherugbiedah@gmail.com>
Reply-To: "estherugbiedah@gmail.com" <estherugbiedah@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "christian.couder@gmail.com" <christian.couder@gmail.com>
Message-ID: <355182457.15373219.1697222676128@mail.yahoo.com>
Subject: [Outreachy Applicant]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <355182457.15373219.1697222676128.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Git Community,


=C2=A0I am an Outreachy applicant for the 2023 cohort and I am thrilled to =
contribute to the Git project.


Having reviewed the available projects, I am particularly interested in thi=
s project. I believe that contributing to this project will not only enhanc=
e my skills but also allow me to make a meaningful impact.


I am ready and excited to immerse myself in the project and make valuable c=
ontributions.


Thank you for your guidance, and I look forward to working together on this=
 exciting journey.

