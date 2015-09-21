From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 01/13] Sending "Fetching submodule <foo>" output to stderr
Date: Mon, 21 Sep 2015 16:47:55 -0700
Message-ID: <xmqq7fnj8hck.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeAoV-0007jW-5k
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 01:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbbIUXr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 19:47:58 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33795 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192AbbIUXr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 19:47:58 -0400
Received: by padhy16 with SMTP id hy16so129908205pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aG+4Y/kn1GOQHzZGXhUETLNfCSn1KNTw3DQ14FIyosE=;
        b=iJBfdmgxowg+XwEPJ+cpJAx7DkDww+QUEilIIEf90bpbsCBro31bQFWC0pUdhuEa2t
         0MuVHdWIXpFpU32wnEqNwkXrHJzZCbwu0Bi8+4CjS5jkfBVqLqpQ/3q5LGgo88TGVqx6
         Fo15TNqmpFtWIfHPk76IKJPPkCs0oY8nrCIX0hChxmPgVch+Tsyj83Q7CQUsKRpKXO6k
         YasBU7ZYg0Mq2M7CtHXHYMwyjC4TBbJNMSpprg4TecI2mQAYU5CvBTBcMNwMYoi2RCYj
         SS2SXB0AioavvlSCKgTd/Qs6O1zHsLHZlLIULRUnN/As/u+Jqatc+9QAlUYbPMDBlyMY
         H5BA==
X-Received: by 10.69.11.196 with SMTP id ek4mr28422547pbd.148.1442879277632;
        Mon, 21 Sep 2015 16:47:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id fx4sm26619483pbb.92.2015.09.21.16.47.55
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 16:47:56 -0700 (PDT)
In-Reply-To: <1442875159-13027-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278360>

Stefan Beller <sbeller@google.com> writes:

> Subject: Re: [PATCHv3 01/13] Sending "Fetching submodule <foo>" output to stderr

Subject: submodule: send "...." to standard error

or something?

>  		if (is_directory(git_dir)) {
>  			if (!quiet)
> -				printf("Fetching submodule %s%s\n", prefix, ce->name);
> +				fprintf(stderr, "Fetching submodule %s%s\n", prefix, ce->name);
>  			cp.dir = submodule_path.buf;
>  			argv_array_push(&argv, default_argv);
>  			argv_array_push(&argv, "--submodule-prefix");

The change itself (above) and updates to the tests (omitted) looked
sensible.

Thanks.
