From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Mon, 25 Apr 2016 17:05:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604251704300.2896@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 17:05:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aui4x-0007og-LU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbcDYPFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:05:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51479 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbcDYPFc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:05:32 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MB1C4-1b2NZN0zLQ-009xG0; Mon, 25 Apr 2016 17:05:13
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Gm19eWaPL/eu7Dq9ZO5vpSRVxZ7pxWJgcvCGxziDzAQDna/LcMu
 iEPxgDAmRu2caAgy/HaQUSsmRrmxee2ZCB8lT0j2O70g1MQHiACBm8+UkA0H7jx56Md1efO
 alFvdxTweqOxUqQBNeUj9+ozKXGCmf/nrAS+EzisDhG3bIIJaRdhYQOrcW9MnOxDAeaypVn
 t4yfrCaVgY/EZzU2OPDDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YrwsTuKeqlo=:eu2Vo6p3kp5w5L+OWYPzXB
 fu53WhsoMm/eDK7wnuGao/miOSH1hi8Gt9jtqgjyiKMO0LNtAOz9yqzIOL0tfzOoEwds8PXH1
 uDs/fV73g5/p1O0FnxSdukHRgvRiIXyktbE3F7ck1bHo+ZiAwqGb6LAP+a+BH5DUzdw48fPBt
 RVFPaR6fpPQBfard6+7w81ZSLdPwJoU8HqLbH2to16VhR8//rEvTNzd/RFVC5KZd/F6vmutAY
 yEm0u+i1QUdQAU/NirUuSu/1fxB5KbsVLrZZYsLMV1bJxxVrqGxAJ/RVOdTtbwAAP2EDTSEsY
 1ervu6gjLJxxx2EgdyBP1ytxz+621S4nH0bOMVcWMQ5q2U8SeDCGy7Ml/6Yyt3O0K94E8+wpx
 IATT4CAFUc5M5yN45uUQHcJlLcG4ZLsZOm6L/hQ0pP6ViMdROxNB8itySsLqIqx/UzXCfW2YE
 dpKa4qDNP3S+xDleAZ2XAkNxLVvPv+LAzsJuO/2SWsbX9uDADq7OGAnlZ6wwNBFlWUvqWQB4P
 ypzIxv7/reGiSa0N9KAFixvaDl+JVFuQsECuSzAAR1klfgs5IoNK3pASYFfsRSNDPrzq/XzEa
 fQTVvph74WNVuNIazdE6x50eajJX+TPWHZg+N3eqENSUM1KYN0wDWOdOwprdAbGj7zX/dDjNa
 SNW7krUz1tIUiOGrpTnE8k3wiopOFd/PPUDWSZv82X7/r1hdezvoc6g08N/nRiILZuJ1dCmx8
 JAJDZZYdQKiX75JJqBSOvqedUejTc/AKiZ2or/JgzyDPFQ0NG9fA3Bt29uL/sKLzASfAlsmG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292488>

Hi Chris,

On Sun, 24 Apr 2016, Christian Couder wrote:

> diff --git a/run-command.c b/run-command.c
> index 8c7115a..29d2bda 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>  }
>  
>  #ifndef GIT_WINDOWS_NATIVE
> -static inline void dup_devnull(int to)
> +void dup_devnull(int to)
>  {

The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.

Ciao,
Dscho
