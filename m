From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 23:36:58 +0100
Message-ID: <200811292337.00380.jnareb@gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a0811291416h4c227411u61bfe7033f0d2bae@mail.gmail.com> <7viqq6yxqu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 23:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6YSO-0007D5-77
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 23:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbYK2WhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 17:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYK2WhJ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 17:37:09 -0500
Received: from ik-out-1112.google.com ([66.249.90.182]:3845 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbYK2WhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 17:37:07 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1573168ika.5
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 14:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4qvRmK7SCG0ijvyd5NsCnWG3OCC0/tDucDxb+WZs73Y=;
        b=FZaMFk7Zm1+8aX564JHSFduoc4viqdmM67ReRpiyLhL+XBtShKUW5N0zBCDsEkCNSu
         IDb2VpxYOfS9HoDoRdoFxWXIIHR6y079V4bfuaEDMTZ2Ns49wg7QZW2eBHAiL+ABOAn4
         lF7bRx+w389azcMpXBvOq7/til7BiAdyF8Dac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cKdSdFGYx7cgrIUBtEOJ8IeL8GBQPuQipTataNqZE8A7N+Lj2eX9fRUg9yMu6UkhPQ
         ns32XI+OA4WoMy6HRkKpQ2Ox7qIONiUkM2hf9x+Q61+i7UJPZpWt2XgCjqc9r67r4HVi
         5TkT9wjPsonIoi8v+Ke1dxqiNhJj9gICnm3lA=
Received: by 10.210.25.18 with SMTP id 18mr10718567eby.14.1227998224904;
        Sat, 29 Nov 2008 14:37:04 -0800 (PST)
Received: from ?192.168.1.11? (abvs96.neoplus.adsl.tpnet.pl [83.8.216.96])
        by mx.google.com with ESMTPS id 5sm7603454eyf.50.2008.11.29.14.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 14:37:03 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7viqq6yxqu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101932>

Junio C Hamano wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
> 
> > And this is precisely the reason why the first time I sent the patch I
> > did the restyling in the same go: by not touching the
> > clueless/careless callers and instead bringing gitweb_check_feature to
> > act in scalar context, it would automatically fix those broken usages,
> 
> ... which is very bad for reviewability purposes.
> 
> By explicitly fixing them before doing the "this will sweep all the
> potential bugs under the rug", you can demonstrate a lot more clearly why
> these changes are necessary.

Well, I think now that it would be best to split this series into
_two_ patches: first Junio's patch fixing (!) gitweb_check_feature()
calls, second original v1 Guiseppe's renaming gitweb_check_feature()
to gitweb_get_feature(), and adding gitweb_check_feature(), and using
gitweb_get_feature() only where needed; optionally fixing "style".

Pure rename IMVHO doesn't look that nice...
-- 
Jakub Narebski
Poland
