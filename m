From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 09/10] t4213: test --function-name option
Date: Fri, 04 Apr 2014 13:21:08 +0200
Message-ID: <533E95A4.2010207@gmail.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu> <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, l.s.r@web.de,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 13:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW2BS-0005kY-VD
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 13:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbaDDLVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2014 07:21:14 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:34863 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaDDLVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 07:21:13 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so3282975wes.35
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EljEM6OgaiC9q0CCLcxRIzFm7K7BsrNuDOmEBawsdmE=;
        b=nMt6x3HdvYkdvfzKAdJyVT0NXPH2dGS0YHJwr7D62odW50yTfABnSTXtceUaQeQ+mW
         YRAmSRAIP7ZHtkuSTDADCducKQXVYnyDDZDs4pGE8nt9l3slxge4dK1KjVFMxSHGhlov
         Ionlo0iyJ/KMi1ztLNWrcm35WO71Rv4BuosEMfUnN2OoMoDlZ+/u0sC4uBlELvwveDQd
         OR7aLtyjqzxVfybrYgfQ/0nuLkTdRErp3mrrvemZ4RTU8AfpvBg+Mg+Axii0HXSeLYfS
         1D4A1A2kcCUnUfv4ZgdW1rrCKQ+3QYOPhl4jdV4JSE/0b/qZSP9OxydMycLybSCT/sL/
         2ubg==
X-Received: by 10.180.205.130 with SMTP id lg2mr3550555wic.59.1396610472736;
        Fri, 04 Apr 2014 04:21:12 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id p8sm18884366eef.26.2014.04.04.04.21.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 04:21:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245760>

W dniu 2014-03-27 19:50, David A. Dalrymple (and Bhushan G. Lodha) pisz=
e:

> +test_expect_success setup '
> +	echo "* diff=3Dcpp" > .gitattributes
> +
> +	>file &&
> +	git add file &&
> +	test_tick &&
> +	git commit -m initial &&
> +
> +	printf "int main(){\n\treturn 0;\n}\n" >> file &&
> +	test_tick &&
> +	git commit -am second

Wouldn't it be more readable to use "cat \-EOF" or separate files
instead of printf-s with embedded newlines "\n" and tabs "\t"?

--=20
Jakub Nar=C4=99bski
