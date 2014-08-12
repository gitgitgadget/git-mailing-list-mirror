From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 15:58:26 -0700
Message-ID: <20140812225826.GC24621@google.com>
References: <53EA430E.8050905@web.de>
 <1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: l.s.r@web.de, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:58:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHL1V-0005lM-RW
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 00:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbaHLW6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2014 18:58:30 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50542 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbaHLW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 18:58:29 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so7466844pdi.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0UNkxCjvEnrsc1iIWakeLjor/p3mftjq4GrwXljKNLw=;
        b=AFawqGqiT5colJ1a9ubdb65TTF3bAIUwcQTWr1jbUE4ODFrUGYWLxvhdQIhDmdboZd
         VZAmQDqj9sVcaNrvko7Qt8CR9OriFcAlUhaFf1AkJsXaShcv+PNcfHhch4M8AwYJq6vP
         B1kFKtUKAgx3AERDydL+Kxr/hV+Uck8D7tpj3QX+stqh9FvE/UavrLrOn1J4RuHO0fPO
         ajz2dKC2qRLG26uPXKzTIlkzV28dDPPHsozTv0jqR7tLiwqV0mrUoYbHQax1F+d8Osjs
         qXYg8/Y2HXQsWG+XHH8S/mlnV2dOzsaamMDXQ5Tv249189X+TSx0yrtwqxD0F0N4oqgM
         1kww==
X-Received: by 10.66.237.39 with SMTP id uz7mr608541pac.144.1407884308902;
        Tue, 12 Aug 2014 15:58:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b597:b557:1d91:6675])
        by mx.google.com with ESMTPSA id za9sm314728pac.25.2014.08.12.15.58.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 15:58:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255174>

Stefan Beller wrote:

> This was found by coverity. (Id: 290001)
[...]
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> Helped-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  builtin/mailsplit.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

The idea is to simplify error handling (removing cleanup of the
'output' var) by making it more obvious that there is only one kind of
error, right?

=46or what it's worth, it looks good to me (and much clearer than the
last version).  It's always possible to reintroduce goto-based error
handling later if another kind of error is introduced, and in the
meantime this is simpler and does not change behavior.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
