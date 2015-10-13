From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Tue, 13 Oct 2015 12:32:26 +0200
Message-ID: <561CDDBA.609@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
 <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 12:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlwsl-0002om-AD
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 12:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbJMKca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2015 06:32:30 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33550 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbJMKca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 06:32:30 -0400
Received: by wicge5 with SMTP id ge5so51183770wic.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=rwJcAkvWL3o1kfjN2RLcB4IxjoFdJvcLGcb2yyZx/p8=;
        b=gXhvVaEIyf7xBA5k4Gv2kfIoVSQuWUEGYdp3jwzRoE4hpi6nSeRRKuQ/fRq2t1Zbzd
         pHvp1BebTwH3AoSTH3YsHRJesKTpLhjIqpV26+ub1vO6Qqlxz9Qi2kYyCzw3sI7BtaXx
         JWkS2HbqbHQUGzkofS72lSlek5A2cyqO48KzNcO5nln6C5IttbbwtzQ464wonR8S9H/u
         wU8W0Evsbpkv7nrRV2nxWF0Bjt72RmvayyyILos6nDQJ6tOi6+qMeFn2gxshr0d/+4rv
         wGvPkjXekyslGY9e5ou078zoGxJxMfaVyG4LgaCCSz7wE/ZxHP6hTZyVinos0YI4ze5z
         6WXg==
X-Received: by 10.180.187.141 with SMTP id fs13mr21575147wic.13.1444732348466;
        Tue, 13 Oct 2015 03:32:28 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id o10sm2325666wia.4.2015.10.13.03.32.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 03:32:27 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279495>

Le 11/10/2015 19:55, larsxschneider@gmail.com a =E9crit :
> +
> +before_script: make
> +
> +script: make --quiet test

Travis can be used in container mode but that would need getting rid of
"sudo" command and only installing from white-listed sources
(https://github.com/travis-ci/apt-source-whitelist/blob/master/ubuntu.j=
son)

Anyway, even within the present VM mode, 1.5 cores are available, so it
makes sense to add "-j2" to every make commands.

=20
