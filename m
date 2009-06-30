From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv8 5/7] gitweb: gravatar url cache
Date: Tue, 30 Jun 2009 22:52:26 +0200
Message-ID: <cb7bb73a0906301352t123aee01naa80e8fa41011d99@mail.gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vprcl78zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLkPx-0001s9-Aa
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZF3U6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbZF3U6x
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:58:53 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57140 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbZF3U6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:58:53 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 16:58:52 EDT
Received: by bwz25 with SMTP id 25so135173bwz.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WGXzK3a4xZb5yTRWqErExiu1+jVlbnLm8WLdnAR05mU=;
        b=LHoyIs5Nvch5v8zRqehBbwrWrHBAMrywCObIbXLn6nz1O+hx03vzwb27YNTcAPqsUe
         uQgwrtALF5hA143WU0N2bJ3zaYOvcedOHIUadb/U5kaaMNKazsEXSNRttDTb8Ug2kxuv
         mWmlmYMGVZ/UIUvdwkVXeGy3Apce1vfsRfUXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vwsd3ZGjaw/hhm0kUftomPI3iWtE4pyL1Wnwp5Iu4Lew5hEKFkTLr25e/Jga6Jp/yu
         GORqXc0BReIJzPQwgFI4NT7r4oQHiECnAsvADhlVx0KIOpeihb3YFoP5FctFA8NUYSUy
         G6azNQFbRtuDKVNk3xNFZu1F4KxwT7WHpZERA=
Received: by 10.204.57.84 with SMTP id b20mr8635184bkh.180.1246395146545; Tue, 
	30 Jun 2009 13:52:26 -0700 (PDT)
In-Reply-To: <7vprcl78zm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122543>

On Tue, Jun 30, 2009 at 10:38 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> +# Rather than recomputing the url for an email multiple times, we cache it
>> +# after the first hit. This gives a visible benefit in views where the avatar
>> +# for the same email is used repeatedly (e.g. shortlog).
>> +# The cache is shared by all avatar engines (currently gravatar only), which
>> +# are free to use it as preferred. Since only one avatar engine is used for any
>> +# given page, there's no risk for cache conflicts.
>
> Is it "any given page", or "any given e-mail"?

It's 'page' as in HTML file served by the script. I couldn't find a
better way to express that.


-- 
Giuseppe "Oblomov" Bilotta
