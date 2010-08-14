From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sat, 14 Aug 2010 03:33:18 -0700
Message-ID: <4C6670EE.3060806@gmail.com>
References: <20100801195138.GA1980@pengutronix.de> <m3lj8qozan.fsf@localhost.localdomain> <20100803210730.GA1254@pengutronix.de> <201008032350.40117.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	kernel@pengutronix.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 12:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkE3Q-0003J0-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 12:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0HNKd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 06:33:26 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59625 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab0HNKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 06:33:26 -0400
Received: by pzk26 with SMTP id 26so1130910pzk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=DCcu934jQRzF2JZh3GrVO8gdWNVTxsBVizh4yQE2iqk=;
        b=iStzWzLB3vHV+XhPNQ4iJBts2t4Oh5R1zwRpEt6AuZ9cPBIl7W7xCSO1WZtEy2xM1t
         9obxXMx5UrJTufT993TUngL7cUm3QFbgmkeIx8E1tZswyrssXLDTx1Wjv+JByeZcat2B
         qcjIE1vsCeWfIArn5pMAdU7qfNQnMew8F6dD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=i4DlXAfB+y+7allFKwx+eoW+7Z5IX3HYzOy5U/x7QEjT95Q60jbHWx8IflFLrhpoL0
         Rqs/msKBhlrC0h8DV7UAiK83Ao9aggq/kHEnR7DON5cELfO718swKbwHDIEZo64Z9lKH
         dmiC6go631/dPbFU/CRjBukOPQg2sAczyveeo=
Received: by 10.142.199.20 with SMTP id w20mr2375822wff.17.1281782005247;
        Sat, 14 Aug 2010 03:33:25 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id 33sm4514904wfg.21.2010.08.14.03.33.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 03:33:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.7) Gecko/20100805 Lightning/1.0b2pre Thunderbird/3.1.1
In-Reply-To: <201008032350.40117.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153551>

  On 08/03/2010 02:50 PM, Jakub Narebski wrote:
> +
> +	my $title = to_utf8("Search for commits $performed by $author");
> +	$title =~ s/[[:cntrl:]]/?/g;
> +
>

Isn't it possible that other data coming from git could have escape characters in them such as the commit subject line? In which case this same bug would occur?

Therefore isn't it better to strip out control characters (that's what this patch is doing right?) in esc_html?
