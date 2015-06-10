From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] send-email: allow multiple emails using --cc, --to and --bcc
Date: Wed, 10 Jun 2015 08:18:27 -0700
Message-ID: <xmqq616voam4.fsf@gitster.dls.corp.google.com>
References: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433872587-15515-6-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hm4-0001lS-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbbFJPSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:18:32 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36560 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbFJPSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:18:30 -0400
Received: by igbpi8 with SMTP id pi8so38027261igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Zr6A8iqShPNLBI5Pisjbp6w2tnhG808gcncQmON1KeM=;
        b=XbDBbamPnp5n8sj4aX9xNCarPhWUqVpeMo+SqLlYZ0NvKoZ+Ya3Xg826SstKgHOm4R
         xt9J8LuzwffSU9wPyoYdFseztMtPBjktAYCHZ+VmJ0+/X0hfYJvfFx27Ig7Q3cxAgRIr
         htp+vxYUlWVVjIQmYmWWAGqm4RkYt27REL45AzTOnxoTcpUA46jeexAxbndwWS2DJ8NX
         /MlMajXcIwbqiF1XtWlAe1b+XCRWPsE4xBbomUZgizlcKg4kndwroLvFLjJYBAr/GuvA
         I41CxBrzM8RSOErG7urjFKSKwnIuLByY9e/1Yhv8iqd8AuCb49vwDurtc48cH4I0TBVI
         jxGg==
X-Received: by 10.107.160.141 with SMTP id j135mr5053949ioe.43.1433949509117;
        Wed, 10 Jun 2015 08:18:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id k74sm6196804iok.30.2015.06.10.08.18.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:18:28 -0700 (PDT)
In-Reply-To: <1433872587-15515-6-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 9 Jun 2015 19:56:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271300>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
>
> Accept a list of emails separated by commas in flags --cc, --to and
> --bcc.  Multiple addresses can already be given by using these options
> multiple times, but it is more convenient to allow cutting-and-pasting
> a list of addresses from the header of an existing e-mail message,
> which already lists them as comma-separated list, as a value to a
> single parameter.
>
> The following format can now be used:
>
>     $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'
>
> However format using commas in names doesn't work:
>
>     $ git send-email --to='"Jane, Doe" <jdoe@example.com>'

That should be "Doe, Jane <jdoe@example.com>", shouldn't it?  When
writing "firstname lastname", people do not put comma in between.
