From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 28/28] makes upload_pack void
Date: Tue, 15 Aug 2006 00:45:20 +0200
Message-ID: <dbfc82860608141545s3e75457eo4be1201395e24354@mail.gmail.com>
References: <Pine.LNX.4.63.0608141340060.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 00:45:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClBe-00062Q-U1
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 00:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWHNWpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 18:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWHNWpW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 18:45:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30565 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932737AbWHNWpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 18:45:21 -0400
Received: by nf-out-0910.google.com with SMTP id x30so106007nfb
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 15:45:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Kb8cATSF35EIPpkTJdc6NEbctE87ViMwQZrKKbuIEf9kMe+yQMJqte1yZWlOEJukfgdIEXzY/Xb7KmzYqXQXeNtEdEu5WWC2Hu4sv5QBUatoghZ5HZhMtNAfCiuA0mnxPoZyxTMsypGImRNNdc7BkQMDw6E/cUsclZJ3YWHVfhI=
Received: by 10.48.254.1 with SMTP id b1mr458870nfi;
        Mon, 14 Aug 2006 15:45:20 -0700 (PDT)
Received: by 10.78.178.17 with HTTP; Mon, 14 Aug 2006 15:45:20 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608141340060.19383@chino.corp.google.com>
Content-Disposition: inline
X-Google-Sender-Auth: 3aa218c1b9af1fff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25417>

On 8/14/06, David Rientjes <rientjes@google.com> wrote:
> Makes upload_pack void and removes conditional return.

> -static int upload_pack(void)
> +static void upload_pack(void)

I don't know for sure, but I'm guessing the intention was to be able
to return a failing code /if/ there ever was a condition where
upload_pack() would fail, e.g., if send_ref() would return a status
code instead of die():ing if it can't parse the given sha1.  In a
future libification, the change of return type may have to be
reverted.

  nikolai
