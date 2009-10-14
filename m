From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fix esc_param
Date: Wed, 14 Oct 2009 08:19:22 +0200
Message-ID: <cb7bb73a0910132319p27b4f362sf5bffa2afe6e5849@mail.gmail.com>
References: <1255463496-21617-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<4AD525CA.8090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxFn-0005Mv-T4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZJNGUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 02:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbZJNGUU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:20:20 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:51167 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZJNGUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 02:20:19 -0400
Received: by fxm27 with SMTP id 27so11136802fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rjkwmaObYyYTCB7ZDKh2oU+4i0+R05VUAmu9HrxWLR4=;
        b=u1y2nE0iNnkEEL+wQYgR4J+cBPi7aORoWQzfCNWx9UnzfPqZEKz4RQi4SX6aTvuDCc
         Kwo3pq6uBmO06BMUxZ5UZyfGTvQi9t9HGfhU72UvrIa4WH2FkvzoidHQDllTWwCf1NE7
         fqMNmXTPANsGdLxWtLe6MoqzxzT50BJQKv8JU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=GDu8le5H7jnslCZ64b2lleTe/1MNseieUuSZPxmb26x9sSt+no4Irj2N4LrFyFO4Q9
         26gseJU53UGp2CRhGJfetiNQq87+2SpZbgsEmhhC7Lpr6b+F9CRENnTjNwVnnvWAEAAZ
         IZnn1TYpWtOMY8SavR6zclKqfAUC/s6bG2xxc=
Received: by 10.204.2.211 with SMTP id 19mr6907784bkk.6.1255501183066; Tue, 13 
	Oct 2009 23:19:43 -0700 (PDT)
In-Reply-To: <4AD525CA.8090102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130257>

On Wed, Oct 14, 2009 at 3:13 AM, Stephen Boyd <bebarino@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>> The custom CGI escaping done in esc_param failed to escape UTF-8
>> properly. Fix by using CGI::escape on each sequence of matched
>> characters instead of sprintf()ing a custom escaping for each byte.
>>
>> Additionally, the space -> + escape was being escaped due to greedy
>> matching on the first substitution. Fix by adding space to the
>> list of characters not handled on the first substitution.
>>
>> Finally, remove an unnecessary escaping of the + sign.
>>
>
> Signoff?

Doh.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

(If this isn't enough, let me know)

> This works great for my purposes. Thanks.

Can you also check if this fixes the branch name issue you mentioned
in the other branch? (And/or do you have a repository exposing the
problem if not?)



-- 
Giuseppe "Oblomov" Bilotta
