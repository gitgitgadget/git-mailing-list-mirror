From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 12:54:39 +0700
Message-ID: <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 07:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3X9-0001kY-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 07:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab3D3FzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 01:55:17 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:64199 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3D3FzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 01:55:10 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so140866oag.36
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hQHTkMInjc0QuA1vwL2aZuqVouAm+QqeoSxkokTWpCY=;
        b=r27CYE5ZbfuIZKgRN3PpiPiLxr8VJxazuu/FqCYxYtxIVPC9LdL9Pa5BkkVwJMfU40
         6UBHVcjlLi7YlAjCKqECmkrtZkIWB54hTS2lm2pQNZdKDRSLTRazQV3i7mTuy3GxEePe
         P2lDhqfsZubyRvsw0tdAfkT4wKyR8ml1v72uphJq9OzN9pXRgMY8WGj0AavHVGCQ4K/E
         D9a7ijQKpCRuSZd7iKpBgcPoc1monkEnLm3ivay5+w0QBYhXvAdZBexnq5LpnTbcrz8Q
         cvueaaRa8/Oj0iUBgAdwFAanRknNO/bvF1z/WdMUTcy8MEcAHx1hewDbqCmRkkgQkO29
         +kvA==
X-Received: by 10.60.57.3 with SMTP id e3mr3390873oeq.101.1367301310152; Mon,
 29 Apr 2013 22:55:10 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 29 Apr 2013 22:54:39 -0700 (PDT)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222905>

On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
> use 'git show @~1', and all that goody goodness.

I like this. I haven't spent a lot of time on thinking about
ambiguation. But I think we're safe there. '@' is not overloaded much
like ':', '^' or '~'.

> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
> 'master@'.

I'm a bit reluctant to this. It looks like incomplete syntax to me as
'@' has always been followed by '{'. Can we have the lone '@' candy
but reject master@ and HEAD@? There's no actual gain in writing
master@ vs master@{0}.

> +'@'::
> +  '@' alone is a shortcut for 'HEAD'
> +

And this does not explain about HEAD@ or master@. But because I prefer
the candy part only. This documentation part looks good :)
--
Duy
