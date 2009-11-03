From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to rebase backwards
Date: Tue, 3 Nov 2009 17:37:16 +0800
Message-ID: <20091103093716.GD7117@debian.b2j>
References: <20091103054510.GB7117@debian.b2j>
 <7vocnkt5o4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Fpd-0002iT-RR
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 10:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbZKCJh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 04:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbZKCJh2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 04:37:28 -0500
Received: from mail-px0-f179.google.com ([209.85.216.179]:63029 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbZKCJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 04:37:27 -0500
Received: by pxi9 with SMTP id 9so3775902pxi.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DeVpGv6ffh81LKcgzkmg8Hn/wFaIHfdnAIONqifD6GE=;
        b=OiZ4QxLzKE3BbHsaZcsfEfTc+rJQBIKKKKEoCiPjSJZMa9CM7Rvqb5Vn05tyAwPJhU
         4RxIkdhMKborXcPGrY5dFrns9COfLMzY7pTmquHv+uvKLXsPGkS6so32juRU177hLkSx
         4eyLfSiA9Sev/rHXBQSQ7a6IFmB+nVkP+h2fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h1E9NX6hlKNsQ6+plSrL+c03K98P4OLzXlgJbcIA8PhgG9ve/66wP+px+KoTzZwJm4
         9Qr7WHiwfgDQ3h+/aSqqCKEUMQWmbqC5Ggimdfh95eOb59dzPAAYRjl8Hu78cbCGj+Sq
         QQNz5u9ymsrqImnlFj3L64LBfgVg8uGI8yvcE=
Received: by 10.115.101.25 with SMTP id d25mr10547951wam.46.1257241050768;
        Tue, 03 Nov 2009 01:37:30 -0800 (PST)
Received: from localhost (n218103234051.netvigator.com [218.103.234.51])
        by mx.google.com with ESMTPS id 21sm54822pzk.11.2009.11.03.01.37.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 01:37:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vocnkt5o4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131956>

Thank you for detail explanation.  From what you described, I begin
with master commit D, 
 $ git checkout -b deploy
 $ git commit --allow-empty -m deploy

 
                      E
                     /^ deploy
     ---A---B---C---D
                    ^ master
 
 $ git rebase -i A

                      v deploy
          B'--C'--D'--E'
         /
     ---A---B---C---D
                    ^ master

since E is an empty commit, I suppose content of D' E' and D are
identical at this point.  Is that correct?

If several months later, I forget which is the common ancestor for
master and deploy, how do I generate the above graph or identify
commit A as the common ancestor for these two branches?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
