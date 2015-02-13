From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] hex.c: reduce memory footprint of sha1_to_hex static buffers
Date: Fri, 13 Feb 2015 13:58:42 -0800
Message-ID: <CA+55aFyTcU0zjo9rTxetnRj72YS+Mo52sx85-Rk0woXEbQVfsw@mail.gmail.com>
References: <1423862329-7899-1-git-send-email-sbeller@google.com>
	<xmqq7fvlmqu8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaEun-mEQPg7cmPV7RJR8A+BxSsSpeAQgcsuJn8L4TGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:58:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOG7-0002zE-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbbBMV6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:58:43 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:54101 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbbBMV6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:58:43 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so13510733igb.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UYF7MSgkdblXFcXLiaH5u9PeDDfP64JI3UEl3ZKQ5Q4=;
        b=RSeZtDTQ91cNjTm7xfpytXJl8u+VktJTXiNwGhug2J3IRLVN2tmoFjmeuZTXlzsGIJ
         ZHO+Iu478Ak0nJlzvCRW9jfFmSH5Kvrkrw3fv/s6iTc9yE0tT1+fg0CpmbyWThcnuKbp
         1PKEZ2+coAhYBT82qC2yny/iy11oJ/5KG0ZHN3PZux5z3tyIj2DjDWmeTiCbgZTlGxRp
         lYr2N97QBo7tBESQBs7iQ2PMLoljRDvxK1mDljRgcvKKJTIlOE8g3P6kHk3qBQQXY1eF
         Iz2bkKlhjfv1kw40cbXu8djVJ9V8j2vBx8A1iYsCl8YCN/mhcuYnEBQpPwb3bomXmMKw
         An2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UYF7MSgkdblXFcXLiaH5u9PeDDfP64JI3UEl3ZKQ5Q4=;
        b=EJi8kyyufJF1ggXKCiQ/8x/DLGp7q9I4SPtnOnUZEGZkUENCyx9VsOJHw3o983H3cD
         RZOaiE981ou5LMfd0bJCw+4FJ1eXgw6WmcUuP+AFnQwYhDxddvE5h2/MLf9kexlqf8iu
         +WwH8a09ZifpXa7MmqNnstmiuBETnKlLH+osg=
X-Received: by 10.50.44.43 with SMTP id b11mr6690770igm.30.1423864722344; Fri,
 13 Feb 2015 13:58:42 -0800 (PST)
Received: by 10.36.58.135 with HTTP; Fri, 13 Feb 2015 13:58:42 -0800 (PST)
In-Reply-To: <CAGZ79kaEun-mEQPg7cmPV7RJR8A+BxSsSpeAQgcsuJn8L4TGEg@mail.gmail.com>
X-Google-Sender-Auth: j44vBZPDgAIR8uhzR3ehTT0TzsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263842>

On Fri, Feb 13, 2015 at 1:56 PM, Stefan Beller <sbeller@google.com> wrote:
>
> As I could not find any documentation on the
> magical 50 in the early days, I cc'd Linus
> in case there is something I did not think of yet.

Nothing magical, it's just "rounded up from 40 + NUL character".

                        Linus
