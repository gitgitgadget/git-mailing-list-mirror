From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Mon, 19 May 2014 22:46:21 -0700
Message-ID: <20140520054621.GA28317@hudson.localdomain>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
 <20140517085911.GA18862@hudson.localdomain>
 <20140517100013.GA18087@sigill.intra.peff.net>
 <20140517153943.GB31912@hudson.localdomain>
 <xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 09:54:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmcsh-0000bn-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 07:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbaETFq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 01:46:27 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39049 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaETFq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 01:46:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so6734139pad.41
        for <git@vger.kernel.org>; Mon, 19 May 2014 22:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fKHp9vankrEFu0y5ygWQs4AJn10/5UMJCllXn1uyP6E=;
        b=ZGXbL0LgF+jQ1rD6IGwrJoLFzEc1MNIXTrm+lAp/lXraUdad/brLmEDWmNYY9A5sxt
         uTn5tJ4up0PTDE7AylDezGZ0Uq5p4rDwWW6MUwIMt/wGXay0IzveiLDQXwhXRBRmOjau
         mfu9NtRk324o0Wb85yuuZZ/CGYC81vuQ9r8Rs9pG83zWw5cp1MQhC8TsqC1uHPJP3bjy
         gXfHTM6MaJrL7zXBzUxmPWEV8mWNoTNCFdqeXkrRga2ndOHeW9QBDJ3MsHVsIBO9tLmW
         yV8SVql/iXnL/cDh8UpO3RlIdr+hUDtWrSTVjU74LwpRDBalLATpwK/eT0Ayz46gu9Aa
         Nz3g==
X-Received: by 10.69.17.230 with SMTP id gh6mr48172274pbd.0.1400564786138;
        Mon, 19 May 2014 22:46:26 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qw8sm977301pbb.27.2014.05.19.22.46.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 22:46:24 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 19 May 2014 22:46:21 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249639>


On Mon, May 19, 2014 at 09:54:33AM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
> > On Sat, May 17, 2014 at 06:00:14AM -0400, Jeff King wrote:
> >> 
>
> Avoiding that is easy with an indirection, no?  Something like this
> at the top:
> 
>   static const char *the_default_signature = git_version_string;
>   static const char *signature = the_default_signature;
> 
> and comparing to see if signature points at the same address as
> the_default_signature would give you what you want, I think.

I like your suggestion for a default signature variable.
Unfortunately, C doesn't like it as much.

static const char *the_default_signature = git_version_string;
static const char *signature = the_default_signature;  // ERROR
// initializer element is not constant

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
