From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 08 Oct 2010 04:33:38 -0400
Message-ID: <4CAED762.7040708@gmail.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <20101008081509.GA2845@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 10:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P48Ok-0004bq-2b
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 10:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab0JHIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 04:33:43 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58663 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab0JHIdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 04:33:42 -0400
Received: by qyk1 with SMTP id 1so41674qyk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DBtHp4c8smPYpOz7Pmhevx60cg0yuzx2mYQ396Calcg=;
        b=sVwSk5+rXAu5Jx0J8jiiIlk4tNA/D7zeIYd80o6KaOeZBXGsuQ1BKc+JpWI1XeQRbY
         b8FmGbtKYEa8e5uhlLllfKOeT47S5nnb577dJdIl6rRSxrPlyzJXKBZLrU03aWF8c9vU
         TcXwcxmx+ID32EfpbTPyrjCEYesglDCRZ1TrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LVeHdDF3hdTIpyoBd3J/iY2lrzswMs4w8lLd5cefFYDzKy7PIRYltKWD16AwdjUwCh
         jGqe+QWT/3BYrUJvWhHVaIKtXuc177n+wl755nfYHSFjlsO6ILf1Q8ROLQPL3UgGAlQC
         6nAnFZW/sbdLLoRCnYKIwU4ST69xLhbDiLvYo=
Received: by 10.229.141.75 with SMTP id l11mr1730304qcu.154.1286526822164;
        Fri, 08 Oct 2010 01:33:42 -0700 (PDT)
Received: from [192.168.2.202] (dsl-156-187.aei.ca [66.36.156.187])
        by mx.google.com with ESMTPS id s34sm1219555qcp.8.2010.10.08.01.33.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 01:33:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Iceowl/1.0b1 Icedove/3.0.6
In-Reply-To: <20101008081509.GA2845@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158494>

Hello,

On 2010-10-08 04:15, Ramkumar Ramachandra wrote:
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 966ba4f..90a4666 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -524,6 +524,9 @@ start with double quote (`"`).
>  If an `LF` or double quote must be encoded into `<path>` shell-style
>  quoting should be used, e.g. `"path/with\n and \" in it"`.
>  
> +Additionally, in `040000` mode, `<path>` may also be an empty string
> +(`""`) to specify the root of the tree.
> +
>  The value of `<path>` must be in canonical form. That is it must not:
>  
>  * contain an empty directory component (e.g. `foo//bar` is invalid),

Thanks for keeping documentation up to date :)

Although, I think the documentation should be a bit more precise about
what "specifying the root of the tree" means for a 'filemodify' command
and its implication on performance (i.e. why there's actually this
special case in the syntax)

-- 
Gabriel Filion
