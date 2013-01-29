From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] status: show the branch name if possible in
 in-progress info
Date: Tue, 29 Jan 2013 10:44:35 -0800
Message-ID: <20130129184435.GA18266@google.com>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
 <1359471493-32531-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0GB8-0002NM-KX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 19:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3A2Soo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 13:44:44 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33383 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab3A2Son (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 13:44:43 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so560636pad.6
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 10:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7/9hTLOHXUPzwMEypbwXiImMqkegsvrgeixLTqTXT8M=;
        b=Ro7Eqpn3tVeXxZx4EFhoDR+UCyQJGYX6rC6gqyVAZvA9ySdqKpgQ557KpA0cwAwK3m
         ROTdi+s5cAiXjlpA1Act2++zqM/7cyEHZlVS7p7fw9wkpsqGQ1EILXSVlH59VnUR7glS
         3tEOxm53V1dmq1LAiJEPUUa/lGdYpNGobu0kIbG9n8A4CpMsXXJK48RY4eLqW1MzhU+B
         eRYfVHfVxXl2F9UJh0Re8C61OgM9Oc/BM53n0s4GES5axMmJPUUA/NGCgOJADYanxj5n
         hyLAuw6rPl3N7j7KeJNSYkezSM5HjMzhtVYqYD2UrpIpsxQJttzBNsSZeGXms6CD4O9j
         wapw==
X-Received: by 10.66.84.10 with SMTP id u10mr5128294pay.24.1359485083163;
        Tue, 29 Jan 2013 10:44:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id az8sm9433386pab.3.2013.01.29.10.44.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 10:44:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359471493-32531-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214955>

Hi Duy,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress=
 before resolving conflicts'
>  	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>  	cat >expected <<-\EOF &&
>  	# Not currently on any branch.
> -	# You are currently rebasing.
> +	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\'=
'000106f'\''.

SHA1-in-tests radar blinking.

Would it be possible to compute the expected output, as in

	dest=3D$(git rev-parse --short HEAD^^)
	cat >expected <<-EOF &&
	# Not currently on any branch.
	# You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$d=
est'\''.

?

I'm not sure what to think about the actual change itself yet.  Can you
give an example of when you felt the need for this, so it can be
included in the commit message or documentation?

Thanks.
Jonathan
