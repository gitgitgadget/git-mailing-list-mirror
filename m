From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC] rewrite `git_default_config()` using config-set API
 functions
Date: Mon, 21 Jul 2014 19:53:47 +0530
Message-ID: <53CD2273.3000600@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>	<53CCFD02.6010704@gmail.com> <vpqha2addyn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:24:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9EVS-0008Tg-EC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 16:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbaGUOXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 10:23:54 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:56298 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbaGUOXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 10:23:53 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so9915657pab.16
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BEKaB0vQY4lMgudaJYeaOSOTdAR5UxDfhOZMxI7VTQg=;
        b=z8zDjwQ2jF30JVDKQI+l1IA24SUObbjxsTpeiqDvXTxBjBdI5/fKlf8zlijsWfjJs4
         +IfaMAnN1vfT46fwsqwNUnHNqpSylYEOSA84OSG4/RFZwOKI70OWkf2N235KqgzCw5kW
         RATR+zh/L1M448tf13Fufp9Vb3hRvJI4ibe+LDsqMy3KK5XxC+LhzzPT4U1k+uu4eU4v
         KB5hJvSPhTvf+WN325l9/h+iKSTigmowl43W1atqsxX8mqHL2qGOgcWZ66h6fU55kVXY
         eGOBLxnwyiG60nqKkiVazOh9aQLCVP0ekiCHS1btFV63QnDs9YN0MNO93DqBEHVBM0Q5
         rKYA==
X-Received: by 10.70.44.168 with SMTP id f8mr25849437pdm.97.1405952632429;
        Mon, 21 Jul 2014 07:23:52 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.202])
        by mx.google.com with ESMTPSA id oa17sm19340356pdb.46.2014.07.21.07.23.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 07:23:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqha2addyn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253969>


> 
>> +	if > +	git_config_get_string("core.notesref", (const char**)&notes_ref_name);
> 
> This cast is needed only because notes_ref_name is declared as
> non-const, but a better fix would be to make the variable const, and
> remove the cast.

Same casts had to be used in imap-send.c patch, I will have to use an
intermediate variable there to remove the cast thus destroying the one
liners or will have to update the variable declarations.
