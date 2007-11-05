From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 5 Nov 2007 23:10:13 +0100
Message-ID: <1b46aba20711051410h370072e7he9cbebb54a789dac@mail.gmail.com>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	 <11942029442710-git-send-email-shawn.bohrer@gmail.com>
	 <11942029474058-git-send-email-shawn.bohrer@gmail.com>
	 <7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn Bohrer" <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpA9Q-0000vK-EW
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXKEWKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXKEWKR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:10:17 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:42258 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKEWKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:10:15 -0500
Received: by el-out-1112.google.com with SMTP id j27so366590elf
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=odVXkY1PFhOtCudgq8b7a+orRoAlU4yDunsDxKOPW7s=;
        b=bzF0236YyAMwNuAie1jWyTplh4xZyk84lPS+yFW0eu/QrLU3PsTTHcwWymd867YaKuUX/CRHfAj0mgOQWqcFSuM9/CTter8SRr/5Hda1lmH29ooe7arBuezhy5N6sV+6O8DcXGC4g7mRs/1tdvrKpiDUB10ezymvhb/1pErsx20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZsRvvyW+TBUAg1lWKcNBAKSv7atfJcW6Hu4mZAdcNVHbslZyD2e8JhlJxzT+R2FhXtpFD8/b8xGubxeGSQpN9h6Qs6tu/u0Iha6Gq4r8ky/op4h6YkM7kB3KKBs/B//pOXIDWvTTa8/HpK0wpwjjK1H/6ECOk2EK0iqqKmWxZak=
Received: by 10.142.52.9 with SMTP id z9mr1328834wfz.1194300613866;
        Mon, 05 Nov 2007 14:10:13 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Mon, 5 Nov 2007 14:10:13 -0800 (PST)
In-Reply-To: <7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63569>

2007/11/5, Junio C Hamano <gitster@pobox.com>:
> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>
> > +static int show_only = 0;
> > +static int remove_directories = 0;
> > +static int quiet = 0;
> > +static int ignored = 0;
> > +static int ignored_only = 0;
>
> Please do not explicitly initialize static variables to zero.

Is it really needed to declare those variables outside of a function
in this case? This scheme makes difficult reusing the code from other
builtins, rewriting it for libification, calling it many times, or
even understand if they were declared that way with a purpose or not.
I just don't know why they are that way in this case, is there a
reason for it?
