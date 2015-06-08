From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Mon, 08 Jun 2015 13:30:17 -0700
Message-ID: <xmqqzj4a7xk6.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23gf-0005qP-CF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbbFHUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:30:21 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36829 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbFHUaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:30:19 -0400
Received: by ieclw1 with SMTP id lw1so1203696iec.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gE/t5D8P7N9exHTZDgtrwL0pwuR0ATXWDMLvsTaq/bU=;
        b=NOpJ8MutH4SkgIoApm/328G1Sdm6gyFnoHY7pfzm02lfjkfpCpWkRyZPNQS/1AcQDk
         goAxbd2LqH1c0NNAoV1bcnydv3gtvC0tOOrxMbA65szYjHBoY2bZNGx4AzhroKvHwda+
         bA2ixxuUYSl7EVgqAyvQ+JJo6a+Sra10hUFHjmzQ7DRdCTNdsRrrJCuVlgGlnsZ702vD
         O3BC4f6xNXnB/FYh8cJj4C+czsruVum/65sjQV0oku+lG31YKXYfFREoQM50/6IaD3Jq
         odxeioXZmtF9yMp3DS7xaFziXzKo1mmXasBz/OxPVud/vpqcNUjvYFUJcqZ9D2LoKySh
         D/kw==
X-Received: by 10.50.50.130 with SMTP id c2mr15734170igo.19.1433795418684;
        Mon, 08 Jun 2015 13:30:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id k74sm2461829iok.30.2015.06.08.13.30.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 13:30:18 -0700 (PDT)
In-Reply-To: <1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 8 Jun 2015 22:22:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271129>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> +	*,"$NAME_BAD")
> +		die "$(gettext "'git bisect $NAME_BAD' can take only one argument.")" ;;

Hmmmm, doesn't this break i18n the big way?
