From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Fri, 6 Sep 2013 14:41:38 -0700
Message-ID: <20130906214138.GA7470@google.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
 <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
 <20130905080606.GE2582@serenity.lan>
 <xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
 <20130905192646.GG2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3mp-0007fe-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab3IFVlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:41:47 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33961 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3IFVlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:41:47 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3768900pdj.6
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6rKWnxCLUbYUj01MXyGBk47esRaRZVqoXhJn5tQXYCQ=;
        b=jpP8NhMPF7eCJkoeINCKfx5Pfvv+HHr3D/PCUAy+QYI/SUr2jWW9XVZfle0P8JVeQ8
         mxMvLpKI/lU0SGt6ll0plfa6UUpDRSKkxYrbhb3v5qRBsk5IF9IvE5trsP3N7DTIkyZ7
         NQVe4lslwuRQIYDTEXVFj3F+b389P1diWBYIM1Hp2MtZ2gQuEsklKuaOE+XKQlRxpQB9
         cSZKjmz1C8H1vgpAUa4CRjIK1r8zZz+gRMwGdp9UTqT03Dr3K/aTmhspUntcBMd9F+Y5
         F1tZbAp5n9G2OGkgEJVhjPFS/951QfzhQpf4L9pKpWq+/Yowb76g4VXFeKNu48Qcsz+V
         gSqA==
X-Received: by 10.66.188.203 with SMTP id gc11mr6065304pac.63.1378503706495;
        Fri, 06 Sep 2013 14:41:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp8sm5985376pbc.26.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 14:41:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130905192646.GG2582@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234100>

John Keeping wrote:
> On Thu, Sep 05, 2013 at 12:18:45PM -0700, Junio C Hamano wrote:

>> I somehow thought that rebase by default looked in the reflog to do
>> exactly that. Perhaps I am not remembering correctly.
>
> It just does @{upstream} by default, which tends to get messy if the
> upstream has been rewritten.

Maybe Junio is thinking of 'git pull --rebase', which walks the reflog
until it finds an ancestor of the current branch and uses that as the
<upstream> parameter to rebase.
