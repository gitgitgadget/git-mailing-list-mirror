From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Mon, 17 Nov 2008 02:02:26 +0100
Message-ID: <200811170202.27893.jnareb@gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1sWu-0005dc-Qm
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 02:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYKQBCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 20:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYKQBCh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 20:02:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:33173 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYKQBCg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 20:02:36 -0500
Received: by ug-out-1314.google.com with SMTP id 39so292004ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 17:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yYTs/8mHO7+gtpj6hR8bv8Jw7kXvbxjh7f570phG0nE=;
        b=C/2LzAstAc2qNV/PwKBjpSm5JxLINTOES/w3pz6TgV9Z9N2Taec3b3hQFxMLmi3adp
         eyxm9MrQ3YJ/Qe3iwvsyuynyKvJACW63ggBDczyR3hJGSP2/db2ze7D1FuK/wEWnmF5w
         OAW9BBxU50oZdMptImZ4RUeMfklblc6cSoLcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xB8Pv/JB+SbFSMvYTwW5IDdUFF59dG0z6gPKFhoUlHKdRhDnEfrkwVwpjvijlC8mND
         UNBkO55cz2iJ7TUGuwL93sJ+4w1vb6/Na3T7KGO6O0Zq8EmnPX0rH1RHkxB9naw/3eO8
         K8q+R/OKGoWxRiMe6YUBl79wFQNa9ogdVTqbg=
Received: by 10.67.96.1 with SMTP id y1mr1037590ugl.34.1226883754758;
        Sun, 16 Nov 2008 17:02:34 -0800 (PST)
Received: from ?192.168.1.11? (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id e1sm3244780ugf.7.2008.11.16.17.02.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 17:02:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101187>

On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:

> The gitweb_check_feature routine was being used for two different
> purposes: retrieving the actual feature value (such as the list of
> snapshot formats or the list of additional actions), and to check if a
> feature was enabled.
> 
> For the latter use, since all features return an array, it led to either
> clumsy code or subtle bugs, with disabled features appearing enabled
> because (0) evaluates to 1.
> 
> We fix these bugs, and simplify the code, by separating feature (list)
> value retrieval (gitweb_get_feature) from boolean feature check (i.e.
> retrieving the first/only item in the feature value list). Usage of
> gitweb_check_feature across gitweb is replaced by the appropriate call
> wherever needed.
> ---

First, you forgot the signoff, but you have addressed that already.


Second, I thought at first that it would be good for the patch to also
simplify %feature hash, using "'default' => 1" instead of current bit
convoluted "'default' => [1]", at the cost of bit more code for
defensive programming.  But now I think that if it is to be done,
it should be put as separate patch.

-- 
Jakub Narebski
Poland
