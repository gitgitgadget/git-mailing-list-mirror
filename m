From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http-push.c: get_remote_object_url() is only used under 
	USE_CURL_MULTI
Date: Tue, 3 Feb 2009 18:40:16 +0800
Message-ID: <be6fef0d0902030240g13672ef4uda2f70443ecfabf7@mail.gmail.com>
References: <7v8woodnmj.fsf@gitster.siamese.dyndns.org>
	 <20090203065457.GA8466@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 11:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUIiv-0003Rz-Um
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 11:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZBCKkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 05:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZBCKkT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 05:40:19 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:40339 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBCKkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 05:40:17 -0500
Received: by wa-out-1112.google.com with SMTP id v33so948829wah.21
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vBy1aPKqRGEuQDeuFO5DwjDWz7UzfdMAWiJyNQiM4bs=;
        b=FQJiCkPQ4knNPO5bsHqyFNvMuHGjiNsbo6NsBour2Ubcvr+2Y0W+ZqCk5qxtRvB5MU
         BCrC6X+VZbDHogRYNgH9TJMiwb5CViNlYrlxkljCd+5I0GWFoqkTnj0ZdB6EQbmTqLBZ
         //MhIFPAmDJpGZ1kIfHg/+P2SrpejB9r7XjjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WZUfDDtiBK2WzmF66Af7GP4GJ4boY94whNBQBy2M7KvPyM1QFaGzEJG79s4/NbzD3x
         Qj1gWi2IeOZOUCQKNExkdi3MJfDFRsPYt4PqODy0jhgUU8vk2FptA1q/XpxE8m6eXi6I
         hb7axJ+pCedDPP0AQpHXbyOUoc1o9THMlTdsc=
Received: by 10.114.182.1 with SMTP id e1mr3071007waf.22.1233657616518; Tue, 
	03 Feb 2009 02:40:16 -0800 (PST)
In-Reply-To: <20090203065457.GA8466@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108176>

On Tue, Feb 3, 2009 at 2:54 PM, Mike Hommey <mh@glandium.org> wrote:
> If I recall correctly, http-push just doesn't work without curl-multi,
> so the correct fix would be to just disable http-push when
> USE_CURL_MULTI is undefined.

Indeed, it dies on line 2253 (18d81a).

2252 #ifndef USE_CURL_MULTI
2253         die("git-push is not available for http/https repository
when not compiled with USE_CURL_MULTI");
2254 #endif

-- 
Cheers,
Ray Chuan
