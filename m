From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Mon, 07 Jul 2008 22:23:02 -0400
Message-ID: <4872CF86.5050702@gmail.com>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com> <20080707063424.GB5506@jhaampe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 04:24:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG2sd-0000Z4-Bs
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbYGHCX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755403AbYGHCX1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:23:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:58706 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbYGHCXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:23:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1092493ywe.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=SKXYm9nErxBzehv4n4eLI4Y8lwRRGS6nwxakVpOoUUM=;
        b=rKO6avFYRoKaEQ6xu5AewWS863Yp/L18wJI984IZGMh7qmc3oFHZMO8xNuOvznBhif
         AoaY2XbWk7b4tI+jbGE40kg/YxINr/6yJ+V7gbdZJUG3Ie5xPZNyK8Ruc/td+OOSybKw
         0akL08jm2yrnX+s15Pr9OG5aDydqbnZv6riKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=l13Kv4YPh+LA4B5qmOOtyT+QyPwvZ03gx264AFYghTlW0K18fI7L4GEfZPC3XuoUlz
         /bE+rHxQnM3E0KHk8o4ik0CYvToHNNxnSIDW2to8so0rYMRGWUJa5ktd+nSWq3Jav/Vt
         YHgd57EfIqo8DnYCELvVLut8dvwLxMu8MllE0=
Received: by 10.150.212.14 with SMTP id k14mr9355949ybg.139.1215483793729;
        Mon, 07 Jul 2008 19:23:13 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 9sm314731ywf.2.2008.07.07.19.23.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 19:23:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080707063424.GB5506@jhaampe.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87686>

Sylvain Joyeux wrote:
>
> Redo the prep work, the clone and now
>
> git submodule add dir0/dir1/init
>
> (i.e. don't expect dir0/dir1/init to be the clone of ./init, that was just a
> shortcut for the test. Expect it to be a clone of "something, somewhere")
>
>   
Per the man-page,
    git submodule [--quiet] add [-b branch] [--] <repository> [<path>]

which means, that the *repository* url is mandatory, the path is 
optional. What you specifically asked git-submodule to do was to *clone* 
from dir0/dir1/init, and because you gave no path to put the submodule 
in, git-submodule deduced the name as "init", and cloned to there.

Mark
