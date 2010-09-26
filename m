From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Mon, 27 Sep 2010 00:21:17 +0530
Message-ID: <20100926185115.GA14596@kytes>
References: <4C9E07B1.50600@workspacewhiz.com>
 <1285514516-5112-2-git-send-email-artagnon@gmail.com>
 <vpqmxr4piyf.fsf@bauges.imag.fr>
 <20100926173956.GA15143@kytes>
 <vpqtylcgx75.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 26 20:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzwL7-0001uY-CM
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 20:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab0IZSwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 14:52:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43253 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0IZSwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 14:52:35 -0400
Received: by pzk34 with SMTP id 34so1021937pzk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NpTxb6l8i+jes7lK9qGfftafIRIaEY7RT3fbl72LmlA=;
        b=xqlbFWiVPp75IDEmMBH4PehlSbAe6g3okb6dtdB7Fca6Na71wPt08JnqSZxmZFLnwE
         WxTFheCjUyq0yYsVR4erMvzW6eqWNK2BTV+qm8tBkIGbxXY946Wg3Mpw0Avv0Dq0wZfj
         ckWaM0OkGfPf34nxVXQ2ynHDhK4TJdz7V17sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q7w3PI6NkEPIVHrF9tDIZwaYOYTIbFx504vH6Iy/D+jPJdDmv+G1nkxvRdmbo40L5z
         rwng74Y65ExNDMfmvo5aM/TYADkopqmII7mOWwR5yFA6inh48YX0ATPWaHbM3/8O8bOp
         tPznLmnexUpOJlMkJRDJFwwdz1Q+deA2el1Ok=
Received: by 10.142.249.19 with SMTP id w19mr5375122wfh.189.1285527155454;
        Sun, 26 Sep 2010 11:52:35 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 9sm6202709wfd.0.2010.09.26.11.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 11:52:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqtylcgx75.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157251>

Hi Matthieu,

Matthieu Moy writes:
> Yes, but I find this very painfull when you
> 
> $ git do-something
> error: you need X before you can do-something
> $ do X
> $ git do-something
> error: Ah, you also need Y before you can do-something

Ah, yes. This would definitely be annoying.

> A plain commit will get rid of staged changes, not of unstaged ones.
> 
> Your patch shows unstaged changes first. If the only problem was
> unstaged changes, then "git stash --keep-index" would be a good
> solution. As a user, I prefer knowing both problems to find the right
> solution (and avoid trying to solve only unstaged changes before
> noticing I need to solve the other one too).

Good point. I'll make the error messages a little more comprehensive
and focused in the next iteration.

-- Ram
