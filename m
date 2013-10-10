From: Julien Carsique <julien.carsique@gmail.com>
Subject: Re: [PATCH] git-prompt.sh: show the upstream abbrev name
Date: Thu, 10 Oct 2013 16:43:22 +0200
Message-ID: <5256BD0A.30706@gmail.com>
References: <1381411933-20600-1-git-send-email-jcarsique@nuxeo.com> <20131010135813.GF19704@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R . D'Avila" <erdavila@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 10 16:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUHTI-0006NN-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 16:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab3JJOoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Oct 2013 10:44:01 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:50183 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab3JJOoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 10:44:00 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so2644227wes.20
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2XxM9A1XuWogwU+udWF76j0iDoDUQlLUO/ILgO1ZvIY=;
        b=lpOvf63Hl8O/2EnHNEo9AYRs5dWzedMM1LcdGJcWJWvGGShp1sv+IZXTOrZBR2ceVh
         JNPw/WSBzBPKRfiHbYRkI+rm2X7lh6bFw3ZqVeDhHVFzz0hV5v46/b70BfM3tPEWonZR
         HFaKRvv8hFpTeIlHor6jeFi5Gj3IqXEs7JvgYqO7de8nEkSg4TY36UDxuyfJKfByZ7QC
         qLAM6XyrFlUyQRcexupmH7aWwBPRtpweRUi3fZFU8f7hjRFT8mu3eXqn0TaFpdTY/MeF
         76ccUiiEjWSu4NVA5qFejw3pA7OVO4R+AUGTGqTKYoo8/Lvb/JDyKqIoOc1XQxugEJml
         qBsw==
X-Received: by 10.194.9.70 with SMTP id x6mr12311718wja.22.1381416237075;
        Thu, 10 Oct 2013 07:43:57 -0700 (PDT)
Received: from [10.213.3.69] ([176.57.246.10])
        by mx.google.com with ESMTPSA id iz19sm26452910wic.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 07:43:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; fr; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <20131010135813.GF19704@goldbirke>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235866>

On 10/10/2013 15:58, SZEDER G=E1bor wrote:
> Hi,
>
> On Thu, Oct 10, 2013 at 03:32:13PM +0200, Julien Carsique wrote:
>> @@ -204,6 +206,9 @@ __git_ps1_show_upstream ()
>>  		*)	    # diverged from upstream
>>  			p=3D" u+${count#*	}-${count%	*}" ;;
>>  		esac
>> +		if [[ -n "$count" && -n "$name" ]]; then
>> +			p+=3D" $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"
> The '+=3D' operator is not supported in all Bash versions we care abo=
ut.
> Please write this as p=3D"$p $(...)".
>
> Thanks,
> G=E1bor
>

Hi,

It's fixed.

Note '+=3D' was already used line 114:

            svn_url_pattern+=3D"\\|$value"


Thank you for the review,
